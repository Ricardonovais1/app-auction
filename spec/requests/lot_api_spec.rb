require 'rails_helper'

describe 'LOT api' do
  context 'GET /api/v1/lots/1' do 
    it 'com sucesso' do 
      # Arrange 
      lot = Lot.create!(code: 'AAA000000', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved) 

      # Act 
      get "/api/v1/lots/#{lot.id}"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["code"]).to eq "AAA000000" 
      expect(json_response["start_date"]).to eq I18n.l(2.day.from_now, format: '%Y-%m-%d')
      expect(json_response["limit_date"]).to eq I18n.l(1.week.from_now, format: '%Y-%m-%d')
      expect(json_response["minimum_bid_value"]).to eq 100
      expect(json_response["minimum_bid_difference"]).to eq 10
      expect(json_response).not_to include 'created_at'
      expect(json_response).not_to include 'updated_at'
    end

    it 'Erro se lote não é encontrado' do 
      # Arrange 

      # Act 
      get "/api/v1/lots/9999999999"

      # Assert
      expect(response.status).to eq 404
    end
  end

  context 'GET /api/V1/lots' do 
    it 'com sucesso e ordenado por código em ordem alfabética' do 
      # Arrange 
      lot_1 = Lot.create!(code: 'CHC131313', start_date: 2.day.from_now, limit_date: 5.day.from_now, 
                          minimum_bid_value: 300, minimum_bid_difference: 30)
      lot_2 = Lot.create!(code: 'BHB131212', start_date: 2.day.from_now, limit_date: 1.month.from_now, 
                          minimum_bid_value: 200, minimum_bid_difference: 20)

      # Act 
      get '/api/v1/lots'
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["code"]).to eq 'BHB131212'
      expect(json_response[0]["start_date"]).to eq I18n.l(2.day.from_now, format: '%Y-%m-%d')
      expect(json_response[0]["limit_date"]).to eq I18n.l(1.month.from_now, format: '%Y-%m-%d')
      expect(json_response[1]["code"]).to eq 'CHC131313'
      expect(json_response[1]["start_date"]).to eq I18n.l(2.day.from_now, format: '%Y-%m-%d')
      expect(json_response[1]["limit_date"]).to eq I18n.l(5.day.from_now, format: '%Y-%m-%d')
    end

    it 'retorna vazio se não houver lotes' do 
      get '/api/v1/lots'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'retorna erro interno' do 
       # Arrange 
      allow(Lot).to receive(:all).and_raise(ActiveRecord::QueryCanceled)
      lot_1 = Lot.create!(code: 'CHC131313', start_date: 2.day.from_now, limit_date: 5.day.from_now, 
                          minimum_bid_value: 300, minimum_bid_difference: 30)
      lot_2 = Lot.create!(code: 'BHB131212', start_date: 2.day.from_now, limit_date: 1.month.from_now, 
                          minimum_bid_value: 200, minimum_bid_difference: 20)

      # Act 
      get '/api/v1/lots'

      # Assert
      expect(response.status).to eq 500 
    end
  end 

  context 'POST /api/v1/lots' do 
    it 'com sucesso' do 
      # Arrange
      lot_params = { lot: { code: 'AAA000000', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                            minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved } 
                    } 
      
      # Act 
      post "/api/v1/lots", params: lot_params

      # Assert
      expect(response.status).to eq 201
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["code"]).to eq 'AAA000000'
      expect(json_response["start_date"]).to eq I18n.l(2.day.from_now, format: '%Y-%m-%d')
      expect(json_response["limit_date"]).to eq I18n.l(1.week.from_now, format: '%Y-%m-%d')
      expect(json_response["minimum_bid_value"]).to eq 100
      expect(json_response["minimum_bid_difference"]).to eq 10
    end

    it 'Falha se parâmetros não forem completos' do 
      # Arrange
      lot_params = { lot: { code: 'AAA000000', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                            minimum_bid_value: 100} 
                    } 

      # Act 
      post "/api/v1/lots", params: lot_params

      # Assert 
      expect(response.status).to eq 412
      expect(response.body).to include 'Menor diferença entre lances não pode ficar em branco'
      expect(response.body).not_to include 'Código não pode ficar em branco'
      expect(response.body).not_to include 'Valor mínimo para lance não pode ficar em branco'
      expect(response.body).not_to include 'Data de início não pode ficar em branco'
      expect(response.body).not_to include 'Data limite para lances não pode ficar em branco'
    end

    it 'Falha se houver erro do sistema/ servidor' do 
      # Arrange
      allow(Lot).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      lot_params = { lot: { code: 'AAA000000', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                            minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved } 
                   } 

      # Act 
      post "/api/v1/lots", params: lot_params

      # Assert
      expect(response.status).to eq 500
    end
  end

  context 'PATCH /api/v1/lots/1' do
    it 'edita diferença mínima entre lances com sucesso' do 
      # Arrange 
      lot_params = { lot: { code: 'AAA000000', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved }
                    }
      post "/api/v1/lots", params: lot_params

      # Act 
      original_lot_id = JSON.parse(response.body)["id"]
      patch "/api/v1/lots/#{original_lot_id}", params: { lot: { minimum_bid_difference: 20 }}

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["minimum_bid_difference"]).to eq 20
      expect(json_response["code"]).to eq 'AAA000000'
      expect(json_response["start_date"]).to eq I18n.l(2.day.from_now, format: '%Y-%m-%d')
      expect(json_response["limit_date"]).to eq I18n.l(1.week.from_now, format: '%Y-%m-%d')
      expect(json_response["minimum_bid_value"]).to eq 100
    end

    it 'falha edição do lote quando envia valor em branco' do 
      # Arrange 
      lot_params = { lot:  {code: 'AAA000000', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                            minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved} 
                    }
      post "/api/v1/lots", params: lot_params

      # Act 
      original_lot_id = JSON.parse(response.body)["id"]
      patch "/api/v1/lots/#{original_lot_id}", params: { lot: { minimum_bid_difference: '' } }

      # Assert
      expect(response.status).to eq 412
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Menor diferença entre lances não pode ficar em branco' 
      expect(response.body).not_to include 'Código não pode ficar em branco' 
      expect(response.body).not_to include 'Código não pode ficar em branco' 
    end

    it 'Falha por erro no sistema' do 
      # Arrange
      lot = instance_double(Lot)
      allow(Lot).to receive(:find).and_return(lot)
      allow(lot).to receive(:update).and_raise(ActiveRecord::ActiveRecordError)
      lot_params = { lot:  {code: 'AAA000000', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                            minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved} 
                    }
      post "/api/v1/lots", params: lot_params

      # Act 
      original_lot_id = JSON.parse(response.body)["id"]
      patch "/api/v1/lots/#{original_lot_id}", params: { lot: { minimum_bid_difference: '' } }

      # Assert
      expect(response.status).to eq 500
    end
  end

  context 'DESTROY /api/v1/lots/1' do 
    it 'Deleta um lote com sucesso' do 
      # Arrange 
      lot_params = { lot: { code: 'AAA000000', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                            minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved } 
                   }
      post "/api/v1/lots", params: lot_params

      # Act 
      lot_id = JSON.parse(response.body)["id"]
      delete "/api/v1/lots/#{lot_id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Lote deletado com sucesso'
    end

    it 'Falha devido a erro interno do sistema/ servidor' do 
      # Arrange 
      lot = instance_double(Lot)
      allow(Lot).to receive(:find).and_return(lot)
      allow(lot).to receive(:destroy).and_raise(ActiveRecord::ActiveRecordError)
      lot_params = { lot: { code: 'AAA000000', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                            minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved } 
                    }
      post "/api/v1/lots", params: lot_params

      # Act 
      lot_id = JSON.parse(response.body)["id"]
      delete "/api/v1/lots/#{lot_id}"

      # Assert
      expect(response.status).to eq 500
    end
  end
end