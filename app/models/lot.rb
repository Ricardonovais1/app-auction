class Lot < ApplicationRecord
  validates :start_date, :limit_date, :minimum_bid_value, :minimum_bid_difference, presence: true

  validates :code, presence: true, 
                   uniqueness: true,
                   length: { is: 9 }

  validate :code_format_validation

  enum status: { pending_approval: 0, approved: 5 }

  has_many :lot_items
  has_many :items, through: :lot_items
 
  # ================ DATES SCOPES ===================== 

  scope :current,  -> { where('start_date <= ? AND limit_date >= ?', Date.today, Date.today) }
  scope :future,  -> { where('start_date > ?', Date.today) }
  scope :expired, -> { where('limit_date < ?', Date.today) }

  # ================ CUSTOM METHODS =================== 

  def validate_characters(str)
    str.match?(/\A[a-zA-Z]+\z/)
  end

  def validate_numbers(num)
    num.match?(/\A\d+\z/)
  end

  def code_format_validation
    return if code.empty?

    characters = code.slice(0, 3)
    numbers = code.slice(3, 9)
   
    if !validate_characters(characters) || !validate_numbers(numbers) 
      errors.add(:code, message: 'deve ter 3 letras e 6 números')
    end
  end

  def available_items 
    Item.where.not(id: items.pluck(:id)) 
  end
end
