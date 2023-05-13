class Lot < ApplicationRecord
  validates :start_date, :limit_date, :minimum_bid_value, :minimum_bid_difference, presence: true

  validates :code, presence: true, 
                   uniqueness: true,
                   length: { is: 9 }

  validate :code_format_validation
  validate :bid_value_validation
  validate :bid_value_to_beat

  enum status: { pending_approval: 0, approved: 5 }

  # ================ BID ASSOCIATIONS ================

  has_many :bids
  has_many :users, through: :bids

  # ================ LOT_ITEM ASSOCIATIONS ===========

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

  def bid_value_validation 
    bid_value = bid_value_to_beat 
    if bid_value.present? && bid_value <= minimum_bid_value.to_i
      minimum_bid_value.to_i
    else  
      bid_value.to_i 
    end
  end


  def bid_value_to_beat 
    min_value = minimum_bid_value
    last_bid = bids.last
    if last_bid && last_bid.value >= min_value 
      min_value = last_bid.value + minimum_bid_difference
    elsif last_bid && last_bid.value < min_value
      false
    end
    min_value 
  end
end
