sample_lot_1 = Lot.create!(code: 'ZZZ000000', start_date: '2090-10-10', limit_date: '2090-10-20', 
                        minimum_bid_value: 100, minimum_bid_difference: 10)
sample_lot_2 = Lot.create!(code: 'YYY999999', start_date: '2090-10-20', limit_date: '2090-10-30', 
                         minimum_bid_value: 200, minimum_bid_difference: 20) 