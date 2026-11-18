# Patinhas do Bem

Sistema web de cadastro de animais e doações para a ONG Patinhas do Bem.
Projeto do Projeto Integrador Extensionista, curso de ADS.

**Autor:** Miguel Reboledo Soares

## Tecnologias

- Frontend: Vite (JavaScript puro)
- Backend: Node.js + Express
- Variáveis de ambiente: dotenv

## Pré-requisitos

- Git
- Vite+ (`vp`): https://vite.plus (o `vp` já gerencia o Node.js)

## Como rodar

```bash
# 1. Clonar o repositório
git clone https://github.com/mreboledosoareslink-blip/patinhas-do-bem.git
cd patinhas-do-bem

# 2. Instalar as dependências
vp install

# 3. Criar o arquivo de variáveis de ambiente
cp .env.example .env      # no Windows: copy .env.example .env

# 4. Iniciar a API (Terminal 1)
vp run api

# 5. Iniciar o frontend (Terminal 2)
vp dev
```

Abra http://localhost:5173. A página deve mostrar **Status da API: ok**.

A API também pode ser testada direto em http://localhost:3000/api/health.