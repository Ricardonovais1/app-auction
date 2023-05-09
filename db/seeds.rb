# ==== LOTES EXPIRADOS:

Lot.create!(code: 'ZZZ090909', start_date: 1.year.ago, limit_date: 1.month.ago, 
  minimum_bid_value: 100, minimum_bid_difference: 10)
Lot.create!(code: 'YYY090909', start_date: 1.year.ago, limit_date: 1.month.ago, 
   minimum_bid_value: 200, minimum_bid_difference: 20) 
Lot.create!(code: 'XXX090909', start_date: 1.year.ago, limit_date: 1.month.ago, 
    minimum_bid_value: 300, minimum_bid_difference: 30)


# ==== LOTES ATIVOS:

Lot.create!(code: 'ZZZ111111', start_date: 1.day.ago, limit_date: 1.year.from_now, 
  minimum_bid_value: 100, minimum_bid_difference: 10)
Lot.create!(code: 'YYY111111', start_date: 1.day.ago, limit_date: 1.year.from_now, 
   minimum_bid_value: 200, minimum_bid_difference: 20) 
Lot.create!(code: 'XXX111111', start_date: 1.day.ago, limit_date: 1.year.from_now, 
    minimum_bid_value: 300, minimum_bid_difference: 30)



# ==== LOTES FUTUROS:

Lot.create!(code: 'ZZZ000600', start_date: '05-06-2090', limit_date: '04-07-2090', 
                        minimum_bid_value: 100, minimum_bid_difference: 10)
Lot.create!(code: 'YYY999399', start_date: '20-10-2090', limit_date: '24-12-2090', 
                         minimum_bid_value: 200, minimum_bid_difference: 20) 
Lot.create!(code: 'XXX929090', start_date: '31-01-2090', limit_date: '10-02-2090', 
                          minimum_bid_value: 300, minimum_bid_difference: 30)
Lot.create!(code: 'YYY999499', start_date: '24-12-2090', limit_date: '11-01-2091', 
                           minimum_bid_value: 400, minimum_bid_difference: 40) 
  


user = User.create!(name: 'Roberval', email: 'roberval@algumacoisa.com', registration_number: '70535074670', password: '111111')
admin = User.create!(name: 'Sílvia', email: 'silvia@leilaodogalpao.com.br', registration_number: '70535075642', password: '111111')

user2 = User.create!(name: 'Carlos', email: 'c@c.com', registration_number: '43687476235', password: '111111')
admin2 = User.create!(name: 'Deia', email: 'd@leilaodogalpao.com.br', registration_number: '63160693244', password: '111111')


com = ProductCategory.create!(name: 'Computadores')
ace = ProductCategory.create!(name: 'Acessórios')
tab = ProductCategory.create!(name: 'Tablets')
cel = ProductCategory.create!(name: 'Celulares')

# Item.create!(name: 'Teclado Logitech', description: 'Lindo teclado preto Logitech', weight: 200, height: 3, width: 60, depth: 15, )
# Item.create!(name: 'Webcam HD 1080p', description: 'Segunda melhor câmera da Logitech', weight: 150, height: 10, width: 10, depth: 10)