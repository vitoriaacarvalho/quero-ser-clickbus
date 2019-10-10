## Teste Automatizado Home da Clickbus

### Descrição

1. Criar uma branch com o seu nome.

2. Completar o cenário @ClickBus para que execute preenchendo os campos da home
	2.1 Implementar o step "When I access the webpage" para que acesse o site https://clickbus.com.br/
	2.2 Implementar a função "fill_search()" no step "And I fill in search form box with my origin place and destination" (Função responsável por preencher origem e destino da viagem na home)

3. Commitar e fazer o push das alterações na branch que você criou.

Obs.: Apenas os passos "When I access the webpage" e "And I fill in search form box with my origin place and destination" devem ser implementados. O restante já está correto para que o teste funcione conforme solicitado.

Dica 1: No arquivo "StepDefinitions_auxiliarFunction.rb" você poderá encontrar a chamada para cada função do teste. Passando o cursor em cima do nome da função e clicando no caminho que aparecerá, vc será redirecionado para o arquivo onde a função deve ser implementada.

Dica 2: Para rodar o teste use o comando cucumber --tags @ClickBus SETTINGS=Clickbus chromium=true ENV=Live

### Requisitos

* Ruby
* Cucumber
* Arquivo README.md com as instruções/explicações sobre como executar e testar o projeto.

### Critérios da avaliação
* Criatividade: As instruções acima não limitam nenhum desejo do desenvolvedor, seja livre;
* Organização: estrutura do projeto, versionamento;
* Boas práticas;
* Tecnologia: uso de paradigmas, frameworks e bibliotecas.
