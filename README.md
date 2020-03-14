# Monitoramento de issues do Github

### Descrição
O objetivo dessa API é monitorar todos os eventos de issues em um repositório do Github,
como por exemplo quando uma issue é criada, alterada etc.

## Instalação

### Clonar o projeto
```sh
$ git clonegit@github.com:dfingolo/finhub.git
$ cd finhub
```
### Instalar dependências do projeto
```sh
$ bundle install
$ rails db:create
$ rails db:migrate
```
### Iniciar o serviço
```sh
$ rails server
```
### Configurar webhook no Github
Para configurar o monitoramento de um repositório, é só fazer a seguinte requisição:
```sh
POST /api/v1/webhook

{
  "username": "github_username",
  "password": "github_password",
  "repository": "github_repository_name"
}
```

Retornando com sucesso, guarde o `token` do retorno da API vai precisar dele para
posteriormente buscar os eventos de uma issue

**Importante:** o token é diferente para cada configuração requisitada.

```sh
{
  "message": "Webhook successfully configured",
  "token": "699d3361-4baf-42db-92fc-fd8eeb443b80"
}
```

### Buscando eventos de uma issue
Para buscar os eventos de uma issue é só fazer uma requisição **GET** no caminho
`/api/v1/issues/:number` e enviar no header `x-api-token: token_da_configuracao`
