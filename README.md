# README

## Como Rodar
Sugiro que rode o projeto na porta `4000`, pelo fato do front rodar na porta `3000`:

`rails s - p 4000`

## Arquitetura

Dentro do framework Rails, optei por usar uma arquitetura de **Service Objects**, onde a regra de negócio
fica dentro de classes denominada como Services. 

Nesse contexto, o **Controller** fica com a responsabilidade de lidar apenas com a requisição e não com
regras de negócio ou validações concretas.

A **Model** se limita a representar a entidade do banco de dados e no máximo, cálculos que sejam do seu domínio
ou *scopes* que façam parte de consultas ao banco.

O **Service** como dito anteriormente será usado de acordo com o contexto do fluxo, como por exemplo:
- O endpoint post /v1/invoices irá redirecionar para um controller, que por sua vez direcionará para a classe 
`Invoices::Create`, esta tem a responsabilidade de validar os parâmetros e regra de negócio dentro daquele contexto específico,
e lhe conferindo a responsabilida de inserir o registro ou retornar o erro, para que possa ser tratado pelo **Controller**.
- Auxiliar a isso, usamos os `dry-validations`, para criar *contratos* entre o **controller** e o **service**.

### Gems utilizadas:
- `dry-validation`
- `jsonapi-serializer`

## Testes
Testes são imprescindíveis para o bom funcionamento da aplicação, pois se bem usado, auxilia no controle de qualidade de software, mesmo quando novos recursos são implementados, modificados ou excluídos.

Neste projeto, fiz testes de integração, mas são desejáveis testes para os **services** e **models**, a fim de garantir a separação de responsabilidades e identificação de problemas invisíveis aos testes de integração.

### Gems utilizadas:
- `rspec`
- `factory_bot_rails`