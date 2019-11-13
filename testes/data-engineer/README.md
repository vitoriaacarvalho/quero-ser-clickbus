# Desafio Engenharia de Dados

Olá,
Estamos muito felizes em saber que você tem o interesse em fazer parte do nosso time de Engenheiros de dados da ClickBus.

Com isso gostaríamos de fazer um pequeno desafio para testar suas habilidades para  sugerir uma solução profissional, onde serão testados seus conhecimentos em modelagem de dados, conhecimento teórico de melhores práticas de arquitetura de dados, Cloud Computing e SQL.

**Para entregar, crie um fork com os arquivos resultantes e envie o link pelo Kenoby.**

Contexto:

Customer Experience é Conjunto de interações que ocorrem entre uma empresa e o seu cliente, construindo uma memória e sentimentos entre ambos. Sabendo que essas interações podem ocorrer através de **Ura telefônica, Chat Online, Whatsapp e e-mail**. E as informações possuem datasets diferentes, precisamos integrar todos para conseguir extrair as melhores informações referente ao cliente.

#### Dataset - Ura telefônica

(Formato: .json - Linha de exemplo)

```
{
    "data": "01/08/2019",
    "Semana": "Tuesday",
    "Horário": "08:15:27",
    "fila_descricao": "Dúvidas Gerais",
    "Agente": "Antônia",
    "Status": "Atendida",
    "DDD": 71,
    "telefone": 7199999999,
    "Estado": "Bahia",
    "cliente_nome": "Paulo Rodrigues",
    "email": "paulorodrigues@email.com",
    "fila_de_atendimento": "Sim",
    "duracao_espera_fila": "00:00:09",
    "duracao_atendimento": "00:01:44",
    "duracao_total_da_chamada": "00:02:31",
    "classificacao": "Dúvida",
    "sub_classificacao": "Embarque|Desembarque fora rodoviária"
  }

```

#### Dataset - Chat Online

(Formato: .json - Linha de exemplo)

```
  {
    "Data da conversa (Inicio)": "10/06/2019 14:18",
    "Data da conversa (Fim)": "10/06/2019 14:18",
    "Semana": 1,
    "Agente": "Antônia",
    "Visitor_Email": "paulorodrigues@email.com",
    "Feedback_Response_Additional": "atendimento pessimo",
    "Feedback_Average": 1,
    "Atendido": "Sim"
  }


```

#### Dataset - Whatsapp

(Formato: .csv - Linha de exemplo)


| Início da conversa  | Fim da conversa (duração)| Fim da conversa (finalizado?)|Tempo duração atendimento|Semana|Finalizado?|E-mail|
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
|9/30/19 0:08 | 10/01/2019 14:08 |10/01/2019 14:08|38:00:00|1|Sim|paulorodrigues@email.com|


#### Dataset - E-mail

(Formato: .csv - Linha de exemplo)

|Origem do caso  |Loja| Semana|Data/Hora de abertura|Data/Hora de fechamento|Sub Classificação|Classificação|Email do cliente|
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
|Site| ClickBus |1|9/30/19 0:28|9/30/19 16:41|Dúvida|Falha na finalizacao da compra|paulorodrigues@email.com


#### Queremos que você como Engenheiro de Dados

1) Construa uma modelagem de dados para consulta, integrando todos datasets, visando a melhor forma de padronizá-los(pequena explicação). Crie um script de criação do schema e das tabelas que serão utilizadas para o contexto descrito anteriormente. Informando como e com quais tecnologias você efetuaria a integração desses dados.

2) Crie um script para efetuar extração, transformação e carregamento desses dados no banco de dados que você modelou acima. (python)

3) A partir da sua modelagem, construa três querys para responder: 
3.1) A quantidade de contatos nas últimas 24h por cliente.
3.2) Todas a interações de cada plataforma por cliente
3.3) Última interação e qual plataforma por cliente.

4) Caso tenha conhecimento em AWS/GCP(Google Cloud Platform), quais serviços você utilizaria para garantir a performance da sua arquitetura de dados.

#### O que utilizamos atualmente, apenas para auxiliar no desenvolvimento do desafio.

- Aquitetura DW Kimball;
- Python;
- AWS;
- MySQL
- Airflow;
- Docker;

## Questão extra

Não faz parte do desafio, mas se você quiser responder:

- Informe como seria possvel efetuar atualizações em tempo real (tecnologias que podem ser utilizadas).

