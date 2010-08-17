class PurchaseOrder < ActiveRecord::Base

  before_create :generate_order_number, :set_state

  belongs_to :supplier
  has_many :purchase_line_items
  make_permalink :field => :number
  
  accepts_nested_attributes_for :purchase_line_items

  def contains?(product)
    purchase_line_items.select { |purchase_line_item| purchase_line_item.product == product }.first
  end

  def add_variant(variant, quantity=1)
    current_item = contains?(variant)
    if current_item
      current_item.increment_quantity unless quantity > 1
      current_item.quantity = (current_item.quantity + quantity) if quantity > 1
      current_item.save
    else
      current_item = PurchaseLineItem.new(:qty => quantity)
      current_item.variant = variant
      current_item.cost   = variant.price
      self.purchase_line_items << current_item
    end

    # populate line_items attributes for additional_fields entries
    # that have populate => [:line_item]
    Variant.additional_fields.select{|f| !f[:populate].nil? && f[:populate].include?(:line_item) }.each do |field|
      value = ""

      if field[:only].nil? || field[:only].include?(:variant)
        value = variant.send(field[:name].gsub(" ", "_").downcase)
      elsif field[:only].include?(:product)
        value = variant.product.send(field[:name].gsub(" ", "_").downcase)
      end
      current_item.update_attribute(field[:name].gsub(" ", "_").downcase, value)
    end

    current_item
  end
  
  def set_total
    self.total = purchase_line_items.collect {|x| x.cost * x.qty}.sum || 0
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
