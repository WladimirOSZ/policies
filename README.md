# Policy Management System

## Introduction

The Policy Management System is a simplified example application designed to demonstrate the integration of various technologies commonly used in a modern application, including Docker, Rails, PostgreSQL, RabbitMQ, and GraphQL. The system allows for the creation and11 visualization of vehicle policies, with a focus on learning and understanding the mentioned technologies.

<p align="center">
  <a href="https://docs.docker.com/">
    <img src="https://img.shields.io/badge/docker-blue?style=for-the-badge&logo=docker&logoColor=white"/>
  </a>
  <a href="https://rubyonrails.org/">
    <img src="https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>
  </a>
  <a href="https://www.rabbitmq.com/">
    <img src="https://img.shields.io/badge/Rabbitmq-FF6600?style=for-the-badge&logo=rabbitmq&logoColor=white"/>
  </a>
  <a href="https://graphql.org/">
    <img src="https://img.shields.io/badge/-GraphQL-E10098?style=for-the-badge&logo=graphql&logoColor=white"/>
  </a>
  <a href="https://www.postgresql.org/docs/">
    <img src="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white">
  </a>
</p>


## Requirements

To run the application, you need to have Docker installed on your machine.

## Installation

1. Clone this repository to your local machine:

```bash
git clone https://github.com/WladimirOSZ/policies.git
```

2. Navigate to the project directory:

```bash
cd policies
```

3. Start the apps

```bash
./start.sh
```


## Usage

### API REST

The REST API endpoint allows for the retrieval of policy information using the following endpoint:

```
GET localhost:3002/policies/:policy_id
```

Example response:

```json
{
  "id": 2,
  "issue_date": "2023-08-11",
  "coverage_end_date": "2026-02-17",
  "created_at": "2024-02-27T19:18:00.526Z",
  "updated_at": "2024-02-27T19:18:00.526Z",
  "policy_id": 67255,
  "insured": {
    "id": 2,
    "name": "Dewitt Koelpin CPA",
    "cpf": "039.313.188-26",
    "policy_id": 2,
    "created_at": "2024-02-27T19:18:00.538Z",
    "updated_at": "2024-02-27T19:18:00.538Z"
  },
  "vehicle": {
    "id": 2,
    "brand": "Jaguar",
    "model": "Nissan Rogue",
    "year": 2018,
    "license_plate": "QND-6613",
    "policy_id": 2,
    "created_at": "2024-02-27T19:18:00.546Z",
    "updated_at": "2024-02-27T19:18:00.546Z"
  }
}
```

### API GraphQL

The GraphQL endpoint allows for mutation and querying of policy data. Use the following endpoint:

```
POST /graphql
```

There's a playground available at `localhost:3001/graphiql` to test the queries and mutations.

#### Mutation

To create a new policy, send a GraphQL mutation payload to the endpoint. The payload should be converted to JSON and published on RabbitMQ.

Here's an example of a mutation payload:

```graphql
mutation{
  policyCreate(input: {
    policyId: "81",
    emissionDate: "2011-10-10",
    endCoverageDate: "2030-10-19",
    insuredName: "Wladimir Oliveira Souza",
    insuredCpf: "12312212312",
    vehicleBrand: "Mitsubishi",
    vehicleModel: "Lancer Evolution X",
    vehicleYear: "2024",
    vehicleLicensePlate: "CRT-7222"
  }){
    status
  }
}

```


#### Query

To retrieve policy information, send a GraphQL query with the policy ID. The query will fetch the data from the REST API and return it in GraphQL format.

You can use the following query to retrieve policy information:

```graphql
query{
  getPolicies(policyId: 81){
    policyId,
    issueDate
  }
}
```

