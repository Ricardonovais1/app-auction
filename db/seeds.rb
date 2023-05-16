# ==== LOTES EXPIRADOS:

lot_expired_a = Lot.create!(code: 'ZZZ090909', start_date: 1.year.ago, limit_date: 1.month.ago, 
                            minimum_bid_value: 100, minimum_bid_difference: 10)
lot_expired_b = Lot.create!(code: 'YYY090909', start_date: 1.year.ago, limit_date: 1.month.ago, 
                            minimum_bid_value: 200, minimum_bid_difference: 20) 
lot_expired_c = Lot.create!(code: 'XXX090909', start_date: 1.year.ago, limit_date: 1.month.ago, 
                            minimum_bid_value: 300, minimum_bid_difference: 30)
lot_expired_d = Lot.create!(code: 'ABC123987', start_date: 2.week.ago, limit_date: 2.day.ago, 
                            minimum_bid_value: 100, minimum_bid_difference: 10, 
                            by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br')


# ==== LOTES ATIVOS:

Lot.create!(code: 'ZRT763421', start_date: 2.day.ago, limit_date: 1.year.from_now, 
  minimum_bid_value: 100, minimum_bid_difference: 10, by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br')
Lot.create!(code: 'YHJ986745', start_date: 2.day.ago, limit_date: 1.year.from_now, 
   minimum_bid_value: 200, minimum_bid_difference: 20, by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br') 
Lot.create!(code: 'XJK093462', start_date: 2.day.ago, limit_date: 1.year.from_now, 
    minimum_bid_value: 300, minimum_bid_difference: 30, by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br')



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

Item.create!(name: 'Teclado Logitech', description: 'Lindo teclado preto Logitech', weight: 200, height: 3, width: 60, depth: 15, product_category_id: ace.id )
Item.create!(name: 'Webcam HD 1080p', description: 'Segunda melhor câmera da Logitech', weight: 150, height: 10, width: 10, depth: 10, product_category_id: ace.id )
Item.create!(name: 'Camera digita', description: 'AVI JPEG infravermelho operado por bateria filmadora de viagem com para gravação de vídeo LCD', weight: 200, height: 3, width: 60, depth: 15, product_category_id: ace.id  )
Item.create!(name: 'Monitor Gamer LG', description: 'UltraWide LG 26WQ500-B 25,7” - Full HD 75Hz IPS 1ms HDMI FreeSync', weight: 150, height: 10, width: 10, depth: 10, product_category_id: ace.id )

Bid.create!(value: 140, user_id: user.id, lot_id: lot_expired_d.id, created_at: 3.day.ago)
Bid.create!(value: 140, user_id: user2.id, lot_id: lot_expired_a.id, created_at: 2.month.ago)