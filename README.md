# README
DESCRIÇÃO DO PROJETO:

Aplicação web com Ruby on Rails que conecta o público em geral com o estoque de itens abandonados em um galpão. Usuários admin podem configurar lotes e aprovar, sendo que o usuário que cria o lote não pode aprovar o mesmo, mas sim outro admin. Usuários regulares (visitor), podem fazer lances. 

DIAGRAMA VISUAL, POR CLASSES, DE TODAS AS TELAS DO APP:

[Diagrama de telas por classe](https://l1nk.dev/FUYJV)

CLASSES:

    Usuários (roles: admin / visitor):

admin:

    atributos:

    + nome
    + email (@leilaodogalpao.com.br)
    + senha
    + CPF (unico e válido)
    + foto


        - Cadastro de produtos que estão disponíveis para venda
        - Gestão do leilão 
            - Configuração de lotes, datas e lances mínimos
            - Configuração de datas e lances mínimos
            - Configuração de lances mínimos
            
            TELA DE DETALHES - PERFIL (SHOW)
            TELA DE CADASTRO DE ADMIN (NEW, CREATE)
            TELA DE EDIÇÃO DE ADMIN (EDIT, UPDATE)

visitor:

    atributos:

        + nome
        + email (não pode ser no formato @leilaodogalpao.com.br)
        + senha
        + CPF (unico e válido)
        + foto

            - Criar uma conta na plataforma
            - Buscar por produtos
            - Ver detalhes de produtos
            - Fazer uma oferta (lance, ou bid), caso ainda seja possível

            TELA DE DETALHES - PERFIL (SHOW)
            TELA DE CADASTRO DE USER (NEW, CREATE)
            TELA DE EDIÇÃO DE USER (EDIT, UPDATE)

item:

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

    TELA DE DETALHES (SHOW)
    TELA DE ITENS (INDEX)
    TELA DE CADASTRO DE ITEM (NEW, CREATE)
    TELA DE EDIÇÃO DE ITEM (EDIT, UPDATE)

lot:

    atributos:

    + código - único - cadastrado manualmente - 3 letras e 6 caracteres
    + data de início
    + data limite (para receber lances)
    + valor mínimo de lance 
    + diferença mínima entre os lances
    + nome do admin que criou o lote
    + nome do admin que aprovou o lote

    ações:

    - Adicionar e remover itens (enquanto em status "Aguardando aprovação")
    - Cada item adicionado deve ser indisponibilizado no estoque (para estar em apenas em um lote)
    - Aprovação deve ser feita por um admin diferente daquele que fez o cadastro

    TELA DE DETALHES (SHOW)
    TELA DE LOTES (INDEX)
    TELA DE CADASTRO DE LOTE (NEW, CREATE)
    TELA DE EDIÇÃO DE LOTE (EDIT, UPDATE)

bid:

    atributos:

    + email (user)
    + senha (user)
    + cpf (user - único e válido)
    + valor (maior que lance mínimo e maior que no lance anterior, obedecendo a diferença mínima cadastrada)
    + dentro do intervalo de data estipulado no lote

    TELA DE DETALHES (SHOW)
    TELA DE CADASTRO DE LANCE (NEW, CREATE)
    TELA DE EDIÇÃO DE LANCE (EDIT, UPDATE)

