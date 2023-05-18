class Lot < ApplicationRecord
  before_save :expired?
  validates :start_date, :limit_date, :minimum_bid_value, :minimum_bid_difference, presence: true

  validates :code, presence: true, 
                   uniqueness: true,
                   length: { is: 9 }

  validates :start_date, comparison: { greater_than: :min_date }
  validates :limit_date, comparison: { greater_than: :start_date}

  validate :code_format_validation
  validate :bid_value_validation
  validate :bid_value_to_beat
  validate :date_range_validation

  enum status: { pending_approval: 0, approved: 5, ended: 10 }

  # ================ QUESTION ASSOCIATIONS ===========

  has_many :questions
  has_many :users, through: :questions

  # ================ BID ASSOCIATIONS ================

  has_many :bids
  has_many :users, through: :bids

  # ================ LOT_ITEM ASSOCIATIONS ===========

  has_many :lot_items
  has_many :items, through: :lot_items
 
  # ================ DATES SCOPES ===================== 

  scope :current, -> { where('start_date <= ? AND limit_date >= ?', Date.today, Date.today) }
  scope :future,  -> { where('start_date > ? AND limit_date > ?', Date.today, Date.today ) }
  scope :expired, -> { where('start_date < ? AND limit_date < ?', Date.today, Date.today) }

  after_find :check_expired_status

  def check_expired_status
    if expired?
      self.status = :ended unless ended?
    end
  end
  
  def expired? 
    Date.today > limit_date
    
  end

  def current?
    start_date <= Date.today && limit_date >= Date.today
  end

  def future?
    start_date > Date.today
  end

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
    Item.where.not(id: LotItem.pluck(:item_id)) 
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

  def date_range_validation  
    errors.add(:start_date, 'deve ser anterior à data limite') if start_date.present? && limit_date.present? && start_date >= limit_date
  end

  def successful_bidder
    bl = bids.last
    if bl
      "#{bl.user.name} | #{bl.user.email} | R$#{bl.value},00"
    else
      "Nenhum arrematante para este lote"
    end
  end

  def successful_bidder_name 
    bids.last.user.name
  end

  def successful_bidder_email 
    bids.last.user.email
  end

  def successful_bidder_value 
    "R$#{bids.last.value},00"
  end

  def successful_bidder_lot 
    code.upcase
  end

  def successful_bidder_lot_expired_date
    I18n.l(limit_date, format: '%d de %B de %Y')
  end

  def successful_bid_data
    bl = bids.last
    if bl
      "#{bl.user.name} | #{bl.user.email} | R$#{bl.value},00 | Lote #{code.upcase} | Lote expirado em #{I18n.l(limit_date, format: '%d de %B de %Y')}"
    else
      "Nenhum lance para o Lote #{code}"
    end
  end

  def min_date
    Time.current
  end
end
