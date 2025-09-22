# RELATÓRIO DE ATIVIDADES – PROJETO DE EXTENSÃO II

## Autoria

Este projeto foi idealizado, desenvolvido e documentado por **Delean P Mafra**. Todas as etapas, decisões técnicas e entregas descritas neste relatório são de minha responsabilidade, salvo menção explícita de contribuições externas. O reconhecimento da autoria é obrigatório em qualquer reprodução, adaptação ou redistribuição deste material.

---
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15612206.svg)](https://doi.org/10.5281/zenodo.15612206)

---

## Descrição

Este repositório contém o projeto desenvolvido no contexto do **Projeto de Extensão II** do curso de Ciência de Dados, realizado na empresa **TOTVS**. O objetivo principal do projeto foi identificar, classificar e integrar corretamente os dados de clientes com até 100 funcionários ("PW LITE") no sistema de suporte da empresa, garantindo a consistência das informações para geração de relatórios e indicadores internos.

---

## Organização Parceira

- **Nome:** TOTVS
- **Representante:** Tech Leader
- **Área de atuação:** Desenvolvimento de software e suporte técnico  

---

## Objetivos

### Objetivo Geral

Desenvolver uma solução para identificar, classificar e integrar corretamente os dados de clientes "PW LITE" no sistema de suporte da empresa.

### Objetivos Específicos

- Diagnosticar inconsistências na categorização dos clientes;
- Realizar extração e tratamento de dados de diferentes sistemas;
- Implementar rotinas de correspondência e cruzamento de dados;
- Gerar planilhas para importação adequada ao sistema MOVIDESK;
- Fornecer relatórios e visualizações para melhor compreensão da base de clientes.

---

## Metodologia

O projeto foi desenvolvido utilizando métodos práticos de Ciência de Dados, nas seguintes etapas:

1. **Diagnóstico Inicial:**  
   Identificação do problema de categorização dos clientes "PW LITE" no sistema de suporte.

2. **Coleta e Integração de Dados:**  
   Extração de dados de duas fontes principais (sistema de gestão de clientes e sistema de suporte - MOVIDESK), armazenando-os em tabelas separadas em um banco de dados MySQL.

3. **Limpeza e Preparação dos Dados:**  
   Foram aplicadas práticas de data cleaning: normalização, padronização de campos, tratamento de valores nulos, remoção de duplicidades e validação de formatos (CNPJ, nomes).

4. **Modelagem e Combinação de Dados:**  
   Utilização de SQL (JOINs, CASE) para correspondência de registros entre sistemas, usando critérios como nome, CNPJ, razão social e código interno.

5. **Geração de Planilhas para Importação:**  
   Desenvolvimento de script SQL para gerar planilhas `.xlsx` compatíveis com o MOVIDESK. Ajustes foram feitos após contato com o suporte técnico e revisão da documentação.

---

## Resultados Obtidos

- Atualização de 2.700 clientes "PW LITE" no sistema de suporte, com correta classificação.
- Habilitação da geração de relatórios segmentados por categoria.
- Elaboração de gráficos no Google Planilhas sobre motivos de abertura de chamados.
- Relatórios e gráficos entregues aos Product Owners e ao Project Manager da empresa.

---

## Considerações Finais

A execução deste projeto permitiu a aplicação prática de conceitos de modelagem de dados, integração de sistemas, limpeza e geração de relatórios. A entrega atendeu às necessidades da organização, promovendo maior eficiência na análise de chamados e melhor tomada de decisão no atendimento à categoria “PW LITE”.

---

## Apêndice: Estruturas das Tabelas e Código

As principais tabelas criadas no banco de dados MySQL:

<details>
<summary>ahgora.cadastros_md</summary>

```sql
CREATE TABLE ahgora.cadastros_md (
  COD_REF varchar(255) NOT NULL,
  TIPO varchar(255) DEFAULT NULL,
  USUARIO text DEFAULT NULL,
  CNPJ varchar(255) DEFAULT NULL,
  ...
  PRIMARY KEY (COD_REF)
);
```
</details>

<details>
<summary>ahgora.cadastros_t</summary>

```sql
CREATE TABLE ahgora.cadastros_t (
  CODT varchar(14) NOT NULL,
  ...
  PRIMARY KEY (CODT)
);
```
</details>

<details>
<summary>ahgora.empresa_pw</summary>

```sql
CREATE TABLE ahgora.empresa_pw (
  id varchar(255) NOT NULL,
  ...
  PRIMARY KEY (id)
);
```
</details>

<details>
<summary>ahgora.ponto_contato</summary>

```sql
CREATE TABLE ahgora.ponto_contato (
  COD_PW varchar(255) DEFAULT NULL,
  ...
);
```
</details>

<details>
<summary>ahgora.pontos_contato_pw</summary>

```sql
CREATE TABLE ahgora.pontos_contato_pw (
  BASE varchar(255) DEFAULT NULL,
  ...
);
```
</details>

---

## Script de Exportação de Dados

O principal script Python utilizado para gerar a planilha de importação no MOVIDESK está disponível na seção de evidências/código do projeto. O script conecta ao banco MySQL, executa a consulta SQL definida conforme os critérios da organização e exporta os dados para um arquivo Excel.

---

## Evidências

- Relatórios e gráficos entregues à equipe técnica e aos Product Owners.
- Código-fonte disponível neste repositório.
- Scripts SQL e Python documentados no apêndice acima.
- Imagens e evidências visuais disponíveis na pasta [`evidencias`](https://github.com/Delean-Mafra/pex2/tree/main/evidencias).

---

Este relatório e todo o conteúdo associado são de autoria original de Delean Mafra. É obrigatório o devido crédito à autoria em qualquer uso ou adaptação do presente material.

---

**Nota:**  
Os detalhes sensíveis como credenciais, endereço da empresa e outros dados foram omitidos deste resumo público.
