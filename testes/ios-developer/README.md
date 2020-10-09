## ClickBus - Desafio iOS

### Objetivo

Criar um app que lista os filmes mais populares do momento, contendo filtros por gênero e uma tela mostrando os detalhes do filme selecionado.

### Descrição

1. Faça um fork desse repositório.

2. Cadastre-se na API do https://www.themoviedb.org/. É necessário que você obtenha uma chave da API.

3. No projeto, você encontrará classes de apoio que já acessam e retornam os resultados da API, no arquivo `ViewController.swift` possui alguns exemplos.
A chave da API deve ser colocada na variável `key` que está no arquivo `MovieAPI.swift`. Se preferir criar a sua própria comunicação pode ficar a vontade também =)

4. O app deve conter:
  * Uma lista dos filmes mais populares no momento.
  * Uma maneira de filtrar os filmes por gênero. Mais de um genêro pode ser selecionado, e se o filme possui qualquer um dos selecionados deve aparecer na lista (Ex.: Filme A é uma comédia, Filme B é um romance e Filme C é de ação. Ao selecionar os filtros comédia e romance, a lista deve conter A e B apenas).
  * Cada item da lista deve conter uma foto do filme, o título, a média e a contagem de votos.
  * O item da lista deve levar para uma tela de detalhes do filme, com uma imagem de fundo, diretor, atores, informações de lançamento, tempo, orçamento, quanto foi arrecadado com bilheteria... 
  
5. O código deve ser feito todo em Swift

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
![Referência de layout](https://github.com/RocketBus/quero-ser-clickbus/blob/master/testes/android-developer/Layout%20referencia.png)
Fonte: https://www.behance.net/gallery/97840987/FILMINGO-Online-Cinema-Mobile-UX-UI?tracking_source=search_projects_recommended%7Cmovie%20mobile%20app
