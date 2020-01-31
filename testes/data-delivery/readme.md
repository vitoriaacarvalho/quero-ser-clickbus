# Case ClickBus Data Delivery / Analytics

## Dashboards

Os Dashboards são usados para exibir os resultados e visões para atender as necessidades de áreas clientes.

Eles entregam o resultado das ações no menor tempo possível, possibilitando análise imediata das áreas e tomada de decisões com viés de negócio.

![Exemplo de Dashboard](https://s3-sa-east-1.amazonaws.com/static2.clickbus.com.br/data-science/delivery/dashboard.png)

### Descrição

O arquivo [dados-Dashboard.csv](https://github.com/RocketBus/quero-ser-clickbus/blob/master/testes/data-delivery/dados-Dashboard.csv
) contém dados do mês de Agosto/19. Cada linha representa um dia e suas métricas, que vão desde realizado de receita por dia a número de vendas bloqueadas pelo algoritmo de anti-fraude.


### Desafios

Usar no mínimo 1 gráfico e 3 métricas para cada dashboard, no máximo 3 gráficos e 6 métricas:
* O Marketing cuida do investimento, tem meta de novos clientes para cumprir e se preocupa com a taxa de conversão dos sites. Crie um dashboard para trazer as visões mais importantes para essa área.
* O CEO te pediu uma visão pra ajudá-lo a tomar uma decisão em reunião com o conselho. As métricas seriam:
  * Receita líquida média por dia
  * Número de vendas por dia da semana
  * Atingimento das metas
  * ROAS (return on ad spend)
* OPCIONAL: (O Comercial está em contato direto com as viações e o Financeiro acompanha o resultado geral de vendas e investimento, bem como como anda a performance do algoritmo anti-fraude. Crie um único dashboard que traga as métricas mais importantes das áreas.)


## Banco de Dados

Os BD armazenam todas as informações vindas do site e também de plataformas parceiras. São usados para armazenar os dados e com eles construir análises.

![Tabela clientes do Case](https://s3-sa-east-1.amazonaws.com/static2.clickbus.com.br/data-science/delivery/banco.png)

### Descrição

Uma venda pode ter N tickets, um ticket só pode ter sido vendido em uma venda. Um cliente pode ter N compras (vendas para nós) e M tickets.

O banco a ser usado está no arquivo [case-ClickBus.db](https://github.com/RocketBus/quero-ser-clickbus/blob/master/testes/data-delivery/case-ClickBus.db) e tem 3 tabelas: vendas, clientes e tickets.

Você pode usar site https://sqliteonline.com/ para carregar o banco de dados. Abra o site, vá em File > Open DB e selecione o arquivo.


### Desafios

* O CRM está estudando os diferentes domínios de email para fazer otimizações de template baseado nos principais. Qual os 3 domínios que mais trouxeram dinheiro nas vendas confirmadas e qual o valor vendido de cada um desses domínios ?
* Nosso time de tecnologia está curioso quanto a adaptação de cada região do país ao novo site mobile. Qual o share de receita das vendas confirmadas de cada plataforma (desktop e mobile) olhando para os clientes localizados nas regiões Sudeste, Norte e Nordeste do país ?
* OPCIONAL: (Os assentos ímpares são de janela e os pares de corredor. Pensando em uma campanha nas TOP5 rotas em número de vendas confirmadas e segmentada para clientes de Minas Gerais, você daria mais desconto em poltronas de janela ou corredor ? Por que ?)


## Envio 

Faça um fork com os arquivos de resposta.

As questões adicionais serão como ponto extra, dando vantagem a quem responder.

O prazo para resposta será enviado por mensagem.

Os **Dashboards** poderão ser onlines (nos envie os links) ou offlines (com .py ou .pptx). Todo o tratamento dos dados deverá ser feito com Python 3.

O **Banco de Dados** deverá ser criado usando SQL (pode ser usada a plataforma SQLiteOnline). As queries em .sql e demais scripts também deverão estar no fork.
