# README
<h1 align="center"> Auction App - LeGal - Leilão & Galpão :blush:</h1>

DESCRIÇÃO DO PROJETO:

<p align="justify"> Aplicação web desenvolvida com Ruby on Rails.

Trata-se do APP ludicamente apelidado de "LeGal - Leilão e Galpão". Ele conecta o público em geral com o estoque de itens abandonados em um galpão. Usuários admin podem configurar lotes e aprovar os mesmos, assim como fazer o gerenciamento de mensagens com os usuários coumuns (users). </p>

DIAGRAMA VISUAL, POR CLASSES, DE TODAS AS TELAS JÁ IMPLEMENTADAS DO APP:

:arrow_forward: [Diagrama de telas por classe](https://encurtador.com.br/elqT1)


:arrow_forward: COMO TESTAR O PROJETO:

    Após baixar e rodar o arquivo seeds.rb, 

    Faça login com os dados de admin:
        - Email: deia@leilaodogalpao.com.br
        - Senha: 111111

    Para fazer login como usuário comum:
        - Email: roberval@algumacoisa.com
        - Senha: 111111

:arrow_forward: GEMS UTILIZADAS:

    Timecop - Para viajar no tempo no arquivo seeds. 


CLASSES:

:raising_hand: USER (user + admin):

    atributos:

    + nome 
    + email 
    + senha
    + CPF 
    + foto
    + admin: boolean

        Atribuições do usuário user (admin = false):

        - Criar uma conta na plataforma
        - Buscar por produtos
        - Ver detalhes de produtos
        - Fazer uma oferta (lance, ou bid), caso ainda seja possível

        Atribuições do usuário admin (admin = true):

        - Cadastro de produtos que estão disponíveis para venda
        - Gestão do leilão 
            - Configuração de lotes, datas e lances mínimos
            - Configuração de datas e lances mínimos
            - Configuração de lances mínimos
        - Bloqueio de CPF's
        - Moderar perguntas de usuários
            - Responder 
            - Ocultar / tornar visível
            
            TELA DE CADASTRO DE USER (NEW, CREATE)
            TELA DE DETALHES - PERFIL (SHOW) - Ainda não implementada
            TELA DE EDIÇÃO DE USER (EDIT, UPDATE) - Ainda não implementada

:ballot_box_with_check: PRODUCT_CATEGORY 

    atributos:

    + Name 

    TELA DE CADASTRO DE PRODUCT-CATEGORY (NEW, CREATE)

:computer: ITEM:

    atributos:

    + nome
    + descrição
    + foto
    + peso
    + largura
    + altura
    + largura
    + profundidade
    + categoria
    + código - alphanumérico - gerado automaticamente 

    TELA DE CADASTRO DE ITEM (NEW, CREATE)
    TELA DE DETALHES (SHOW)
    TELA DE ITENS (INDEX)
    TELA DE EDIÇÃO DE ITEM (EDIT, UPDATE)

:hammer: LOT:

    atributos:

    + código - único - cadastrado manualmente - 3 letras e 6 caracteres
    + data de início
    + data limite (para receber lances)
    + valor mínimo de lance 
    + diferença mínima entre os lances
    + nome do admin que criou o lote
    + nome do admin que aprovou o lote
    + status (ativo / aguardando aprovação)

    ações:

    - Adicionar e remover itens (enquanto em status "Aguardando aprovação")
    - Cada item adicionado deve ser indisponibilizado no estoque (para estar em apenas em um lote)
    - Aprovação deve ser feita por um admin diferente daquele que fez o cadastro
    - Usuários podem fazer lances se o lote estiver ativo (por data e aprovação)
    - Usuários podem fazer perguntas na página show do lote
    - Admins podem responder mensagens na página do lote.

    - Lotes ativos e futuros são exibidos na página 'Home'
    - Lotes pendentes de aprovação são exibidos na página 'Lotes pendentes'
    - Lotes expirados, por data limite atingida, são exibidos na página 'Lotes expirados'

    TELA DE CADASTRO DE LOTE (NEW, CREATE)
    TELA DE DETALHES (SHOW)
    TELA DE LOTES (INDEX)
    TELA DE EDIÇÃO DE LOTE (EDIT, UPDATE)
    TELA DE LOTES PENDENTES (PENDING)
    TELA DE LOTES EXPIRADOS (EXPIRED)
    TELA DE LANCES VENCEDORES (SUCCESSFUL_BIDS)

:iphone: LOT_ITEM:

    atributos:

    + lot_id 
    + item_id

    Todos os atributos de items e lots, por associação.

:moneybag: BID:

    atributos:
    
    + valor (maior que lance mínimo e maior que no lance anterior, 
             obedecendo a diferença mínima cadastrada)

    Por associação aos models user e lot:
    + email (user)
    + senha (user)
    + cpf (user)
    + dentro do intervalo de data estipulado no lote (lot)

    TELA DE CADASTRO DE LANCE (NEW, CREATE)

:question: QUESTION:

    atributos:

    + body (corpo da mensagem)
    + created_at

    Por associação aos models lot e user:
    + Name (user)
    + Email(user)
    + Foto (user)
    + Code (lot)

    Quaisquer outros atributos de lot e user. 

    NÃO TEM VIEW PRÓPRIA. USA A TELA SHOW DE LOT.

:mega: ANSWER: 

    atributos:

    + reply (corpo da resposta)
    + created_at

    Por associação aos models question e user:
    + Name (admin)
    + Email (admin)
    + Foto (admin)

    Quaisquer outros atributos de question e user. 

    NÃO TEM VIEW PRÓPRIA. USA A TELA SHOW DE LOT.

:lock: BLOCKED_CPF: 

    atributos:

    + cpf 
    + blocked: bollean

    TELA DE BLOQUEIO DE CPF (NEW, CREATE)

    Usado para bloquear: 
        - Cadastro de novos usuários com o CPF bloqueado
        - Lances
        - Mensagens nos lotes

