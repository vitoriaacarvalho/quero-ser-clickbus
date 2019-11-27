# Case ClickBus Data Science

## Descrição

A ClickBus quer ajudar as viações a entender como o desconto dado por elas contribuiu para o aumento nas vendas, bem como solicitar descontos assertivos para o próximo feriado.

### Como são feitas as vendas

As viações definem o preço do ticket e este é cobrado do cliente final. Parte desse valor cobrado fica com a ClickBus (comissão) e outra parte é devolvido para a empresa de ônibus.
A ClickBus provê soluções de inteligência que diz para as viações qual é o preço a ser cobrado na viagem, mas após o período de descontos dados as viações pedem análises do retorno destes. 

### O que deverá ser entregue

Algumas perguntas deverão ser respondidas:
- Qual o volume de descontos dado por viação ? E por mês ?

- Os descontos mais utilizados (ou seja, os tickets com desconto mais vendidos) têm alguma relação com o fato de serem [e-tickets](https://www.spedbrasil.com.br/bpe/) ? E tem relação com a disposição do assento entre janela / corredor ?

- Há alguma relação entre variação de preço na rota e variação de vendas na mesma acima do "normal" ?

- Pensando no crescimento de vendas através do desconto, para quais viações você pediria descontos no final de ano e em quais rotas ?



## Dados

O arquivo [tickets_dataset.csv](https://s3-sa-east-1.amazonaws.com/static2.clickbus.com.br/data-science/case-desconto/tickets_dataset.csv) contém uma lista de tickets vendidos pela ClickBus. Cada linha representa um ticket e tem suas principais informações.

A descrição de cada coluna está abaixo:

| Coluna  | Explicação |
| ------------- | ------------- |
| datetime_booking  | Dia e hora que o ticket foi vendido |
| kiosk_printed_flag  | Flag se o ticket foi impresso em um dos quiosques ClickBus  |
| eticket_flag  | Flag se o ticket é do modelo e-ticket (que não necessita ser impresso) |
| dd_seat_number  | Número do assento |
| travel_company  | Viação (ou empresa de ônibus) |
| travel_company_commission  | % de comissão que a ClickBus cobrou da Viação nesse ticket |
| route | Rota (ou viagem, conjunto de origem e destino) |
| unit_ticket_price_success  | Preço do ticket |
| service_class_id  | ID do tipo (classe) do assento |




## Dicas

Para calcular o desconto, obtenha primeiro o valor inteiro do ticket. Ele pode ser obtido calculando o valor de ticket mais comum por mês, rota, viação e classe de serviço. 
O que estiver abaixo de 80% desse valor inteiro é um ticket com desconto.

Considere os assentos ímpares como lugares na janela e os pares como lugares no corredor dos ônibus.
