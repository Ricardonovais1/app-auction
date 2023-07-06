# frozen_string_literal: true

# ==== USUÁRIOS:

user = User.create!(name: 'Roberval', email: 'roberval@algumacoisa.com', registration_number: '70535074670',
                    password: '111111')

user.image.attach(io: File.open('app/assets/images/homem_1.jpeg'),
                  filename: 'homem_1.jpeg', content_type: 'image/jpeg')

admin = User.create!(name: 'Sílvia', email: 'silvia@leilaodogalpao.com.br', registration_number: '70535075642',
                     password: '111111')

admin.image.attach(io: File.open('app/assets/images/mulher_1.jpeg'),
                   filename: 'mulher_1.jpeg', content_type: 'image/jpeg')

user2 = User.create!(name: 'Carlos', email: 'carlos@company.com', registration_number: '43687476235',
                     password: '111111')

user2.image.attach(io: File.open('app/assets/images/homem_2.jpeg'),
                   filename: 'homem_2.jpeg', content_type: 'image/jpeg')

admin2 = User.create!(name: 'Deia', email: 'deia@leilaodogalpao.com.br', registration_number: '63160693244',
                      password: '111111')

admin2.image.attach(io: File.open('app/assets/images/mulher_2.jpeg'),
                    filename: 'mulher_2.jpeg', content_type: 'image/jpeg')

# ==== LOTES EXPIRADOS:

expired_lot_time = Time.new(2022, 5, 1, 10, 30, 0)

Timecop.travel(expired_lot_time)

lot_expired_a = Lot.create!(code: 'ZZZ090909', start_date: 1.month.from_now, limit_date: 3.months.from_now,
                            minimum_bid_value: 100, minimum_bid_difference: 10,
                            by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br')
Lot.create!(code: 'YYY090909', start_date: 1.month.from_now, limit_date: 3.months.from_now,
            minimum_bid_value: 200, minimum_bid_difference: 20,
            by: 'Déia', by_email: 'deia@leilaodogalpao.com.br')
Lot.create!(code: 'XXX090909', start_date: 1.month.from_now, limit_date: 3.months.from_now,
            minimum_bid_value: 300, minimum_bid_difference: 30,
            by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br')
lot_expired_d = Lot.create!(code: 'ABC123987', start_date: 1.month.from_now, limit_date: 4.months.from_now,
                            minimum_bid_value: 100, minimum_bid_difference: 10,
                            by: 'Déia', by_email: 'deia@leilaodogalpao.com.br')

Bid.create!(value: 140, user_id: user.id, lot_id: lot_expired_d.id, created_at: 3.months.from_now)
Bid.create!(value: 140, user_id: user2.id, lot_id: lot_expired_a.id, created_at: 2.months.from_now)

Timecop.return

# ==== LOTES ATIVOS:

active_lot_time = Time.new(2023, 5, 1, 10, 30, 0)

Timecop.travel(active_lot_time)

Lot.create!(code: 'ZRT763421', start_date: 2.days.from_now, limit_date: 1.year.from_now,
            minimum_bid_value: 100, minimum_bid_difference: 10,
            by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br', status: :approved)
Lot.create!(code: 'YHJ986745', start_date: 3.days.from_now, limit_date: 1.year.from_now,
            minimum_bid_value: 200, minimum_bid_difference: 20,
            by: 'Déia', by_email: 'deia@leilaodogalpao.com.br', status: :approved)
Lot.create!(code: 'XJK093462', start_date: 4.days.from_now, limit_date: 1.year.from_now,
            minimum_bid_value: 300, minimum_bid_difference: 30,
            by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br', status: :approved)
Lot.create!(code: 'LPD908978', start_date: 5.days.from_now, limit_date: 1.year.from_now,
            minimum_bid_value: 400, minimum_bid_difference: 40,
            by: 'Déia', by_email: 'deia@leilaodogalpao.com.br', status: :approved)

Timecop.return

# ==== LOTES FUTUROS:

Lot.create!(code: 'ZZZ000600', start_date: '05-06-2090', limit_date: '04-07-2090',
            minimum_bid_value: 100, minimum_bid_difference: 10,
            by: 'Déia', by_email: 'deia@leilaodogalpao.com.br')
Lot.create!(code: 'YYY999399', start_date: '20-10-2090', limit_date: '24-12-2090',
            minimum_bid_value: 200, minimum_bid_difference: 20,
            by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br')
Lot.create!(code: 'XXX929090', start_date: '31-01-2090', limit_date: '10-02-2090',
            minimum_bid_value: 300, minimum_bid_difference: 30,
            by: 'Déia', by_email: 'deia@leilaodogalpao.com.br')
Lot.create!(code: 'YYY999499', start_date: '24-12-2090', limit_date: '11-01-2091',
            minimum_bid_value: 400, minimum_bid_difference: 40,
            by: 'Sílvia', by_email: 'silvia@leilaodogalpao.com.br')

# ==== PRODUCT_CATEGORIES

ProductCategory.create!(name: 'Computadores')
ace = ProductCategory.create!(name: 'Acessórios')
ProductCategory.create!(name: 'Tablets')
ProductCategory.create!(name: 'Celulares')

# ==== ITEMS (PRODUTOS)

item_a = Item.create!(name: 'Teclado Logitech',
                      description: 'Lindo teclado preto Logitech',
                      weight: 200, height: 3, width: 60, depth: 15, product_category_id: ace.id)

item_a.image.attach(io: File.open('app/assets/images/Teclado_logitech_1.jpg'),
                    filename: 'Teclado_logitech_1.jpg', content_type: 'image/jpeg')

item_b = Item.create!(name: 'Webcam HD 1080p',
                      description: 'Segunda melhor câmera da Logitech',
                      weight: 150, height: 10, width: 10, depth: 10, product_category_id: ace.id)

item_b.image.attach(io: File.open('app/assets/images/Webcam-LT-920.jpg'),
                    filename: 'Webcam-LT-920.jpg', content_type: 'image/jpeg')

item_c = Item.create!(name: 'Camera digital',
                      description: 'AVI JPEG infravermelho operado por bateria filmadora de viagem',
                      weight: 200, height: 3, width: 60, depth: 15, product_category_id: ace.id)

item_c.image.attach(io: File.open('app/assets/images/camera1.jpg'),
                    filename: 'camera1.jpg', content_type: 'image/jpeg')

item_c = Item.create!(name: 'Monitor Gamer LG',
                      description: 'UltraWide LG 26WQ500-B 25,7” - Full HD 75Hz IPS 1ms HDMI FreeSync',
                      weight: 150, height: 10, width: 10, depth: 10, product_category_id: ace.id)

item_c.image.attach(io: File.open('app/assets/images/monitor-lg.webp'),
                    filename: 'monitor-lg.webp', content_type: 'image/webp')

# ==== CPF's bloqueados

BlockedCpf.create!(cpf: '97598637075', blocked: true)
BlockedCpf.create!(cpf: '01828038059', blocked: true)
