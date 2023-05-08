Lot.create!(code: 'ZZZ000000', start_date: '05-06-2090', limit_date: '04-07-2090', 
                        minimum_bid_value: 100, minimum_bid_difference: 10)
Lot.create!(code: 'YYY999999', start_date: '20-10-2090', limit_date: '24-12-2090', 
                         minimum_bid_value: 200, minimum_bid_difference: 20) 
Lot.create!(code: 'XXX909090', start_date: '31-01-2090', limit_date: '10-02-2090', 
                          minimum_bid_value: 300, minimum_bid_difference: 30)
Lot.create!(code: 'YYY999999', start_date: '24-12-2090', limit_date: '11-01-2091', 
                           minimum_bid_value: 400, minimum_bid_difference: 40) 
  


user = User.create!(name: 'Roberval', email: 'roberval@algumacoisa.com', registration_number: '70535074670', password: '111111')
admin = User.create!(name: 'Sílvia', email: 'silvia@leilaodogalpao.com.br', registration_number: '70535075642', password: '111111')

user2 = User.create!(name: 'Carlos', email: 'c@c.com', registration_number: '43687476235', password: '111111')
admin2 = User.create!(name: 'Deia', email: 'd@leilaodogalpao.com.br', registration_number: '63160693244', password: '111111')


ProductCategory.create!(name: 'Computadores')
ProductCategory.create!(name: 'Acessórios')
ProductCategory.create!(name: 'Tablets')
ProductCategory.create!(name: 'Celulares')