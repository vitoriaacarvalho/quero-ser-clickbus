## ClickBus - Desafio iOS

### Objetivo

Criar um app que lista os filmes mais populares do momento, contendo filtros por gênero e uma tela mostrando os detalhes do filme selecionado.

### Descrição

1. Faça um fork desse repositório.

2. Cadastre-se na API do https://www.themoviedb.org/. É necessário que você obtenha uma chave da API.

3. No projeto, você encontrará classes de apoio que já acessam e retornam os resultados da API, o arquivo `ViewController.swift` possui alguns exemplos.
A chave da API deve ser colocada na variável `key` que está no arquivo `MovieAPI.swift`. Se preferir criar a sua própria comunicação pode ficar a vontade também =)

4. O app deve conter:
  * Uma lista dos filmes mais populares no momento.
  * Essa lista deve iniciar apresentando os 20 filmes da primeira página retornada pela API. Quando o usuário chegar ao final da lista, mais 20 filmes (próxima página da API) devem ser carregados e adicionados ao final da lista. E assim sucessivamente.
  * Cada item da lista deve conter uma foto do filme, o título, a média e a contagem de votos.
  * O item da lista deve levar para uma tela de detalhes do filme, com uma imagem de fundo, diretor, atores, informações de lançamento, tempo, orçamento, quanto foi arrecadado com bilheteria... 
  
5. O código deve ser feito todo em Swift.

**Obs.:** 
* Usamos o [Cocoapods](https://cocoapods.org/) para gerenciar nossas dependências. Portanto, você precisa rodar o comando `pod install --repo-update` na raiz do projeto antes de iniciar o desenvolvimento do desafio.
* Abra o projeto no Xcode pelo arquivo `MoviesDB.xcworkspace`.

### Critérios da avaliação
* Todos as funcionalidades descritas no item 4 da Descrição
* Criatividade: As instruções acima não limitam nenhum desejo do desenvolvedor, seja livre. 
* Organização: Deixe seu código limpo e arrumado, de uma maneira que outro desenvolvedor consiga dar continuidade ao seu trabalho sem problemas.
* Git: Queremos ver seu processo de desenvolvimento, então faça commits frequentes e com mensagens claras.
* Alterar o README para incluir APIs ou Bibliotecas que você tenha utilizado, arquitetura, e qualquer informação que você julgue relevante.

### Bônus
* A API do TheMovieDB é bem completa, dê uma olhada na documentação e tenha ideias de funcionalidades suas https://www.themoviedb.org/documentation/api
* Testes unitários
* Capriche no layout, aplicativos são mídias visuais =) Você pode usar a imagem abaixo como exemplo, ou criar o seu próprio.
![Referência de layout](https://github.com/RocketBus/quero-ser-clickbus/blob/master/testes/ios-developer/Layout.png)

Fonte: https://www.behance.net/gallery/97840987/FILMINGO-Online-Cinema-Mobile-UX-UI?tracking_source=search_projects_recommended%7Cmovie%20mobile%20app
