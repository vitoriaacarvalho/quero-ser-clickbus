## Analista de Marketing de Performance - Automação 

Abaixo estão as questões relativas ao requisito técnico, Python. Para esse teste por favor use Python 3.

Para entregar, crie um fork com os arquivos resultantes e envie o link pelo Kenoby.


### Questão 1

O arquivo countries_info.p contém um dicionário em Python que pode ser atribuído a uma variável. Para isso, primeiramente, importe a biblioteca pickle e execute a linha countries_info = pickle.load(open('countries_info.p', 'rb')) (o arquivo countries_info.p deve estar no mesmo diretório que o este código Python). Com isso, a variável countries_info conterá o dicionário que será usado nessa questão. Esse dicionário está estruturado da seguinte forma:
```
	{
    	coluna1 -> [valor11, valor21, valor13, ...]
    	coluna2 -> [valor12, valor22, valor23, ...]
    	coluna3 -> [valor13, valor23, valor33, ...]
    	...
 	}
```

Assim, um elemento corresponde à combinação (valor11, valor12, valor13, ...) ou (valor21, valor22, valor23, ...) ou (valor31, valor32, valor33, ...).


1. Quantos elementos desse dicionário contêm Country Code = 'BR'?

2. Quantos elementos desse dicionário contêm Country Code = 'AT' e Target Type = 'Municipality'?

* Transforme countries_info em um DataFrame da biblioteca pandas.
* Separe a coluna Criteria ID,Parent ID criando 2 novas colunas: Criteria ID e Parent ID.
* Separe a coluna City,State/Province,Country criando 3 novas colunas: City, State/Province e Country.
* Exporte para o arquivo df_countries_info.csv o DataFrame resultante (não incluir a coluna de índice do DataFrame no csv).


### Questão 2

* Leia o arquivo house_infos.csv para um DataFrame da biblioteca pandas.

1. Neste DataFrame, qual a quantidade de casas que possuem LotArea > 5000 e CentralAir = N?

* Filtre DataFrame para conter apenas as linhas que tenham GrLivArea > 2000.
* Crie duas novas colunas:
(Trate casos em que há NaN nos dados do cálculo do SalePrice, preenchendo-os com 0, e arredondar SalePrice para duas casas decimais.)
	* SalePrice = (LotFrontage + log(LotArea) + TotalBsmtSF + GrLivArea) * OverallQual
	* AvgOverallQual que recebe a média de OverallQual para cada YearBuilt

* Leia o arquvio year_condition.csv para um DataFrame do pandas.
* Faça um merge entre o DataFrame do house_infos.csv e do year_condition.csv com base na coluna YearBuilt para que o DataFrame resultante contenha a nova coluna YearCondition.
* Agrupe por YearBuilt, AvgOverallQual e YearCondition e ordenar por YearBuilt de forma crescente.
* Exporte para o arquivo processed_data.csv o DataFrame resultante (não incluir a coluna de índice do DataFrame no csv).



### Questão 3

* Com o DataFrame resultante da questão anterior, plote um gráfico de barras para SalePrice x YearBuilt, utilizando as bibliotecas matplotlib.pyplot ou seaborn.
* Utilizando um eixo y secundário no mesmo gráfico, plote um gráfico de linha para AvgOverallQual x YearBuilt.
* Salve o gráfico em um arquivo house_analysis.png.



