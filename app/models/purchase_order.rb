class PurchaseOrder < ActiveRecord::Base

  before_create :generate_order_number, :set_state, :set_total

  belongs_to :supplier
  has_many :purchase_line_items

  def contains?(product)
    purchase_line_items.select { |purchase_line_item| purchase_line_item.product == product }.first
  end

  def add_product(product, attrs = {})
    unless attrs[:quantity] and attrs[:cost] and attrs[:supplier_sku]
      supplier_channel = SupplierChannel.find_by_supplier_id_and_product_id(supplier_id, product.id)
      attrs[:quantity] ||= 1
      attrs[:cost] ||= supplier_channel.cost
      attrs[:supplier_sku] ||= supplier_channel.supplier_sku
    end
    current_item = contains?(product)
    if current_item
      current_item.increment_quantity unless attrs[:quantity] > 1
      current_item.quantity = (current_item.quantity + attrs[:quantity]) if attrs[:quantity] > 1
      current_item.save
    else
      current_item = PurchaseLineItem.new(attrs)
      current_item.product = product
      self.purchase_line_items << current_item
    end

    current_item
  end
  
  def set_total
    self.total = purchase_line_items.collect {|x| x.cost}.sum || 0
  end

  def set_state
    self.state = 'in_progress'
  end
  
  def to_param
    self.number if self.number
    generate_order_number unless self.number
    self.number.parameterize.to_s.upcase
  end
  
    def generate_order_number
    record = true
    while record
      random = "S#{Array.new(9){rand(9)}.join}"
      record = PurchaseOrder.find(:first, :conditions => ["number = ?", random])
    end
    self.number = random
  end

end
