# ✈️ Aeroporto

API para gerenciamento de uma companhia aérea, construída com **FastAPI**, **PostgreSQL** e **RabbitMQ**. O sistema permite gerenciar aeroportos, aviões, voos e reservas, além de contar com autenticação de usuários via **JWT**.

> Projeto desenvolvido para a disciplina de **Arquitetura de Software Aplicada**, do curso de **Engenharia de Computação**.

## 📋 Funcionalidades

- **Autenticação e usuários**: registro, login, logout, troca de senha e validação de token, com autenticação baseada em JWT (access token + refresh token).
- **Aeroportos**: cadastro e consulta de aeroportos.
- **Aviões**: cadastro e consulta de aeronaves.
- **Voos**: cadastro e consulta de voos.
- **Reservas**: criação e gerenciamento de reservas de passagens.
- **Mensageria**: integração com RabbitMQ para comunicação assíncrona entre serviços.

## 🛠️ Tecnologias utilizadas

- [FastAPI](https://fastapi.tiangolo.com/) — framework web
- [SQLAlchemy](https://www.sqlalchemy.org/) — ORM
- [PostgreSQL](https://www.postgresql.org/) — banco de dados
- [RabbitMQ](https://www.rabbitmq.com/) (via `pika`) — mensageria
- [PyJWT](https://pyjwt.readthedocs.io/) / `python-jose` — geração e validação de tokens JWT
- [Passlib](https://passlib.readthedocs.io/) / `bcrypt` — hash de senhas
- [Uvicorn](https://www.uvicorn.org/) — servidor ASGI
- Docker & Docker Compose

## 📁 Estrutura do projeto

```
aeroporto/
├── app/            # Utilitários e autenticação (JWT bearer, helpers)
├── mensageria/      # Publicação/consumo de mensagens via RabbitMQ
├── models/          # Modelos do banco de dados (SQLAlchemy)
├── routers/         # Rotas da API (aeroportos, aviões, voos, reservas)
├── schemas/         # Schemas Pydantic (validação de entrada/saída)
├── Dockerfile
├── docker-compose.yaml
├── Makefile
├── main.py          # Ponto de entrada da aplicação
└── requirements.txt
```

## 🚀 Como executar

### Pré-requisitos

- [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/) instalados

### Passo a passo

1. Clone o repositório:
   ```bash
   git clone https://github.com/matheusf2003/aeroporto.git
   cd aeroporto
   ```

2. Suba os containers (API, PostgreSQL e RabbitMQ):
   ```bash
   docker-compose up --build
   ```

3. A API estará disponível em `http://localhost:5000` e a documentação interativa (Swagger) em `http://localhost:5000/docs`.

O RabbitMQ Management estará disponível em `http://localhost:15672`.

### Rodando localmente sem Docker

1. Crie um ambiente virtual e instale as dependências:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

2. Configure um banco PostgreSQL e um servidor RabbitMQ localmente (ou use apenas os serviços via `docker-compose up postgres rabbitmq`).

3. Inicie a aplicação:
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 5000 --reload
   ```

## 🔑 Principais endpoints

| Método | Rota                  | Descrição                          |
|--------|-----------------------|-------------------------------------|
| POST   | `/registrar_usuario`  | Cria um novo usuário                |
| POST   | `/login`              | Autentica e retorna tokens JWT      |
| POST   | `/logout`             | Invalida o token do usuário         |
| GET    | `/verifica_token`     | Verifica validade do token          |
| PUT    | `/mudar-senha`        | Altera a senha do usuário           |
| GET    | `/usuarios`           | Lista usuários (rota autenticada)   |

Além dessas, os routers de **aeroportos**, **aviões**, **voos** e **reservas** expõem as operações de CRUD específicas de cada domínio.

## ⚠️ Observações

- As chaves JWT (`JWT_SECRET_KEY` e `JWT_REFRESH_SECRET_KEY`) e credenciais do banco estão hardcoded em `main.py`/`docker-compose.yaml` para fins de desenvolvimento. Para produção, mova-as para variáveis de ambiente/secrets.
- O projeto ainda não possui testes automatizados nem CI configurado.

## 📄 Licença

Este projeto não possui licença definida até o momento.
