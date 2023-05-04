Lot.create!(code: 'ZZZ000000', start_date: '05-06-2090', limit_date: '04-07-2090', 
                        minimum_bid_value: 100, minimum_bid_difference: 10)
Lot.create!(code: 'YYY999999', start_date: '20-10-2090', limit_date: '24-12-2090', 
                         minimum_bid_value: 200, minimum_bid_difference: 20) 


user = User.create!(name: 'Roberval', email: 'roberval@algumacoisa.com', registration_number: 70535075642, password: 'password')
