# Pipeline CI/CD para Iniciantes em DevOps

Projeto para o artigo: linkedin.com/posts/jafsilva_devops-cicd-gitlab-activity-7299777211274792960-LfXT

Este projeto tem como objetivo ajudar profissionais iniciantes em DevOps a entender e implementar pipelines de CI/CD (Integração Contínua e Entrega Contínua) utilizando três ferramentas populares: **GitLab CI**, **GitHub Actions** e **Azure DevOps**. O deploy será realizado no **Azure Container Apps**, um serviço gerenciado para executar contêineres no Azure.

---

## Sumário

1. [Visão Geral](#visão-geral)
2. [Pré-requisitos](#pré-requisitos)
3. [Estrutura do Projeto](#estrutura-do-projeto)
4. [Versões Disponíveis](#versões-disponíveis)
   - [GitLab CI](#gitlab-ci)
   - [GitHub Actions](#github-actions)
   - [Azure DevOps](#azure-devops)
5. [Como Executar](#como-executar)
6. [Contribuição](#contribuição)
7. [Licença](#licença)

---

## Visão Geral

Este projeto é um guia prático para criar pipelines de CI/CD utilizando três ferramentas diferentes:
- **GitLab CI**: Pipeline integrado ao GitLab.
- **GitHub Actions**: Automação de workflows no GitHub.
- **Azure DevOps**: Pipeline completo no Azure DevOps.

O objetivo é implantar uma aplicação simples Java Springboot no **Azure Container Apps**, um serviço que facilita a execução de contêineres no Azure. O projeto é voltado para iniciantes em DevOps, com explicações detalhadas e exemplos práticos.

---

## Pré-requisitos

Antes de começar, certifique-se de ter o seguinte:

1. **Conta no Azure**: [Crie uma conta gratuita](https://azure.microsoft.com/free/).
2. **Configurar Conta Azure** com a criação desses itens.
   - App registrations
   - Resource Group
   - Container Registry
3. **GitLab, GitHub e Azure DevOps**:
   - [GitLab](https://gitlab.com/)
   - [GitHub](https://github.com/)
   - [Azure DevOps](https://dev.azure.com/)
4. **Azure CLI**: Instale a CLI do Azure para gerenciar recursos no Azure. [Guia de instalação](https://docs.microsoft.com/cli/azure/install-azure-cli).
5. **Conhecimento Básico**:
   - Git e repositórios.
   - Conceitos de CI/CD.
   - Contêineres e Docker.

Segue script para configurar o ambiente Azure(Necessário Azure CLI instalado):

```bash
export AZURE_RESOURCE_GROUP="zelabs"

# Login na Azure com user root
az login 

# Cria o Resource Group
az group create --name $AZURE_RESOURCE_GROUP --location "brazilsouth"

# Cria o App Registration
az ad app create --display-name "zelabs"

# Obtém o Client ID
AZURE_CLIENT_ID=$(az ad app list --display-name "zelabs" --query "[].appId" -o tsv)

# Gera a Client Secret e armazena na variável AZURE_CLIENT_SECRET
AZURE_CLIENT_SECRET=$(az ad app credential reset --id $AZURE_CLIENT_ID --query "password" -o tsv)

# Obtém o Tenant ID
AZURE_TENANT_ID=$(az account show --query "tenantId" -o tsv)

# Obtém o Subscription ID
AZURE_SUBSCRIPTION_ID=$(az account show --query "id" -o tsv)

#Cria o Service Principal
az ad sp create --id $AZURE_CLIENT_ID

# Atribui a permissão de Contributor ao App Registration no Resource Group
az role assignment create --assignee $AZURE_CLIENT_ID --role "Contributor" --scope /subscriptions/$AZURE_SUBSCRIPTION_ID/resourceGroups/$AZURE_RESOURCE_GROUP

# Exibe os valores
echo "Resource Group: $AZURE_RESOURCE_GROUP"
echo "Client ID: $AZURE_CLIENT_ID"
echo "Client Secret: $AZURE_CLIENT_SECRET"
echo "Tenant ID: $AZURE_TENANT_ID"
echo "Subscription ID: $AZURE_SUBSCRIPTION_ID"
```
---

### **Configuração das Variáveis de Ambiente**

Necessário configurar essas variáveis de ambiente diretamente nas ferramentas(**GitLab CI**, **GitHub Actions**, **Azure DevOps**):

#### **GitLab CI**
- **AZURE_TENANT_ID** - Obtido no script anterior
- **AZURE_CLIENT_SECRET** - Obtido no script anterior
- **AZURE_CLIENT_ID** - Obtido no script anterior

#### **GitHub Actions**
- Laboratório em andamento...

#### **Azure DevOps**
- Laboratório em andamento...

---

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
├── .github/ # Configurações do GitHub Actions
├── .gitlab-ci.yml # Pipeline do GitLab CI
├── azure-pipelines.yml # Pipeline do Azure DevOps
├── src/ # Código-fonte da aplicação
├── Dockerfile # Arquivo Docker para construir a imagem
└── README.md # Este arquivo
```

---

## Versões Disponíveis

### GitLab CI

O pipeline do GitLab CI está configurado no arquivo `.gitlab-ci.yml`. Ele realiza as seguintes etapas:
1. **Config_Azure**: Cria o ACR e o Ambiente containers caso necessário.
2. **Package**: Constrói o pacote java.
3. **Image_Build**: Cria imagem Docker e envia para o ACR.
4. **Deploy**: Faz o deploy no Azure Container Apps.
5. **Cleanup**: Remove todos os recursos criados manualmente para evitar exclusão acidental.

[Clique aqui para ver o pipeline do GitLab CI](.gitlab-ci.yml).

---

### GitHub Actions
- Laboratório em andamento...

[Clique aqui para ver o pipeline do GitHub Actions](.github/workflows/).

---

### Azure DevOps
- Laboratório em andamento...

[Clique aqui para ver o pipeline do Azure DevOps](azure-pipelines.yml).

---

## Como Executar

Siga todos os passos anteriores e suba o código no seu repositório remoto. Para executar o projeto:

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/ci-cd-para-iniciantes.git
   cd ci-cd-para-iniciantes
   ```
2. Configure as variáveis de ambiente nas ferramentas de CI/CD.
3. Siga as instruções específicas para cada ferramenta:
   - [GitLab CI](.gitlab-ci.yml)
   - [GitHub Actions](.github/workflows/)
   - [Azure DevOps](azure-pipelines.yml)

---

## Contribuição

Contribuições são bem-vindas! Siga os passos abaixo:

1. Faça um fork do projeto [ci-cd-para-iniciantes](https://github.com/jafsilva/ci-cd-para-iniciantes.git) 
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`).
4. Faça push para a branch (`git push origin feature/nova-feature`).
5. Abra um Pull Request.

---

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---