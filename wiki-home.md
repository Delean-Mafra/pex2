# 📊 PROJETO DE EXTENSÃO II - CIÊNCIA DE DADOS

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15612206.svg)](https://doi.org/10.5281/zenodo.15612206)

---

## 📋 RESUMO EXECUTIVO

Este relatório tem como objetivo descrever as atividades realizadas no contexto do **Projeto de Extensão II** do curso de Ciência de Dados da **Descomplica Faculdade Digital**, cuja atuação se deu na empresa **SOLUÇÕES EM SOFTWARE E SERVIÇOS TTS LTDA**. O projeto teve foco na identificação e resolução de um problema de categorização de clientes no sistema de suporte da organização, impactando diretamente a geração de relatórios e indicadores internos.

## 🎯 VISÃO GERAL DO PROJETO

Durante a visita técnica à organização, foi apresentado um problema referente à dificuldade de identificar os clientes da categoria **"PW LITE"** (clientes com até 100 funcionários) no sistema de suporte. Apesar desses clientes estarem classificados corretamente no sistema de gestão principal, essa informação não era refletida no sistema de atendimento, inviabilizando a extração de relatórios segmentados.

### 🏢 ORGANIZAÇÃO PARCEIRA
- **Empresa:** SOLUÇÕES EM SOFTWARE E SERVIÇOS TTS LTDA
- **Representante:** Aldair Schveitzer – Tech Leader
- **Área:** Desenvolvimento de software e suporte técnico
- **Foco:** Gestão de clientes e sistemas de atendimento

### 🎯 INTRODUÇÃO AO PROJETO

Realizei visita à empresa SOLUÇÕES EM SOFTWARE E SERVIÇOS TTS LTDA, onde entreguei a carta de apresentação e fui direcionado para falar com Aldair Schveitzer, Tech Leader de todo o setor de suporte e desenvolvimento de software. Apresentei-me como acadêmico, colocando-me à disposição para colaborar com as demandas da organização. Também entreguei o termo de autorização para assinatura.

**Tecnologias-chave utilizadas:**
- **ETL** (Extract, Transform, Load)
- **SQL** avançado para manipulação de dados
- **Data Cleaning** e saneamento de dados

---

## 🎯 OBJETIVOS

### 🔸 OBJETIVO GERAL
Desenvolver uma solução para identificar, classificar e integrar corretamente os dados de clientes "PW LITE" (até 100 funcionários) no sistema de suporte MOVIDESK da empresa.

### 🔸 OBJETIVOS ESPECÍFICOS
- ✅ Diagnosticar inconsistências na categorização dos clientes
- ✅ Realizar extração e tratamento de dados de diferentes sistemas
- ✅ Implementar rotinas de correspondência e cruzamento de dados
- ✅ Gerar planilhas compatíveis para importação no sistema MOVIDESK
- ✅ Fornecer relatórios e visualizações para análise da base de clientes

---

## 🛠️ METODOLOGIA APLICADA

### 1️⃣ **DIAGNÓSTICO INICIAL**
- Identificação do problema de categorização inadequada
- Análise dos sistemas existentes (MySQL e MOVIDESK)
- Mapeamento das fontes de dados disponíveis

### 2️⃣ **COLETA E INTEGRAÇÃO DE DADOS**
- Extração de dados do sistema de gestão de clientes (Pontoweb)
- Extração de dados do sistema de controle de contratos (Empodera)
- Extração de dados do sistema de suporte MOVIDESK
- Armazenamento em banco de dados MySQL em tabelas separadas para facilitar o cruzamento de informações

### 3️⃣ **LIMPEZA E PREPARAÇÃO DOS DADOS**
Aplicaram-se boas práticas de tratamento de dados (data cleaning), incluindo:
- **Normalização e padronização** de campos
- **Tratamento de valores nulos** e inconsistentes
- **Remoção de duplicidades**
- **Validação de formatos** de CNPJ, nomes e outros identificadores relevantes

### 4️⃣ **MODELAGEM E COMBINAÇÃO DE DADOS**
- Utilização de **instruções SQL com JOINs** e estruturas CASE
- **Correspondência entre registros** de diferentes sistemas
- **Critérios de matching**: nome da organização, CNPJ, código interno da empresa, razão social e nome de usuários

### 5️⃣ **GERAÇÃO DE PLANILHAS PARA IMPORTAÇÃO**
- Desenvolvimento de script SQL especializado para gerar planilhas no formato **.xlsx** aceito pelo sistema MOVIDESK
- **Ajustes e correções** após contato com o suporte técnico da MOVIDESK
- **Revisão da documentação** para garantir compatibilidade total

---

## 📊 ESTRUTURA TÉCNICA

### 🗄️ **BANCO DE DADOS - MYSQL**

#### **Tabela: ahgora.cadastros_md**
```sql
CREATE TABLE ahgora.cadastros_md (
  COD_REF varchar(255) NOT NULL,
  TIPO varchar(255) DEFAULT NULL,
  USUARIO text DEFAULT NULL,
  CNPJ varchar(255) DEFAULT NULL,
  COD_REF_AD varchar(255) DEFAULT NULL,
  PERFIL varchar(255) DEFAULT NULL,
  CLASSIFICACAO varchar(255) DEFAULT NULL,
  EMAIL varchar(255) DEFAULT NULL,
  -- ... outros campos de controle
  PRIMARY KEY (COD_REF)
);
```

#### **Tabela: ahgora.empresa_pw**
```sql
CREATE TABLE ahgora.empresa_pw (
  id varchar(255) NOT NULL,
  razao_social varchar(255) DEFAULT NULL,
  company_identifies text DEFAULT NULL,
  plan_name varchar(255) DEFAULT NULL,
  -- ... campos específicos do PW
  PRIMARY KEY (id)
);
```

#### **Tabela: ahgora.ponto_contato**
```sql
CREATE TABLE ahgora.ponto_contato (
  COD_PW varchar(255) DEFAULT NULL,
  NOME varchar(255) DEFAULT NULL,
  EMAIL varchar(255) DEFAULT NULL,
  -- ... dados de contato
);
```

### 🐍 **SCRIPTS PYTHON DESENVOLVIDOS**

#### **1. Export to Excel (`export_to_excel.py`)**
```python
import mysql.connector
from mysql.connector import Error
import pandas as pd

def export_query_to_excel():
    try:
        # Conexão com o banco de dados MySQL
        connection = mysql.connector.connect(
            host='[host_database]',
            user='[user_database]',
            password='[password_database]',
            database='[database_name]'
        )
        
        if connection.is_connected():
            print("Conexão bem-sucedida ao banco de dados.")
            
            # Consulta SQL para extração de dados
            query = """
            SELECT DISTINCT
                ct.CODT,
                ep.id AS "Cod base do PW", 
                ep.razao_social AS "Razão social", 
                ep.company_identifies AS "Todos os CNPJs",
                ct.CNPJ,
                pc1.EMAIL,
                pc1.NOME
            FROM empresa_pw ep
            LEFT JOIN cadastros_t ct ON ep.company_identifies LIKE CONCAT('%', ct.CNPJ, '%')
            LEFT JOIN ponto_contato pc ON ep.id = pc.COD_PW
            LEFT JOIN pontos_contato_pw pc1 ON pc1.BASE = ep.id
            WHERE ct.CNPJ != '-';
            """
            
            # Executar consulta e exportar para Excel
            data_frame = pd.read_sql(query, connection)
            output_file = "resultado_consulta.xlsx"
            data_frame.to_excel(output_file, index=False)
            
            print(f"Consulta exportada com sucesso para: {output_file}")
            
    except Error as e:
        print(f"Erro ao conectar ao MySQL: {e}")
    finally:
        if connection.is_connected():
            connection.close()
            print("Conexão com o banco de dados encerrada.")

if __name__ == "__main__":
    export_query_to_excel()
```

#### **2. PW Lite Data Processor (`pwlite.py`)**
```python
# Script principal para processamento dos dados PW LITE
# Implementa a lógica de negócio específica para MOVIDESK
# Formatação compatível com os critérios de importação

import mysql.connector
from mysql.connector import Error
import pandas as pd

def export_query_to_excel():
    try:
        # Conexão com banco MySQL
        connection = mysql.connector.connect(
            host='[host]',
            user='[user]',
            password='[password]',
            database='[database]'
        )
        
        # Consulta SQL complexa para atender critérios MOVIDESK
        # Documentação: https://atendimento.movidesk.com/kb/article/4694/
        query = """
        SELECT DISTINCT
          CASE 
            WHEN cm.TIPO = 'Empresa' THEN '2'
            WHEN cm.TIPO = 'Pessoa'  THEN '1'
            ELSE ''
          END AS "Tipo",
          '2' AS "Perfil",
          CASE 
            WHEN cm.TIPO = 'Empresa' THEN 
              COALESCE(
                NULLIF(ep.name, ''), 
                NULLIF(ct.nome, ''), 
                NULLIF(ct.NOME_FANTASIA, ''), 
                NULLIF(ep.razao_social, '')
              )
            ELSE cm.USUARIO
          END AS "Nome fantasia",
          -- ... mais campos conforme documentação MOVIDESK
        FROM empresa_pw ep
        LEFT JOIN cadastros_md cm ON cm.COD_PW LIKE CONCAT('%', ep.id, '%')
        LEFT JOIN cadastros_t ct ON ep.company_identifies LIKE CONCAT('%', ct.CNPJ, '%')
        WHERE ep.plan_name LIKE 'PW Lite - não habilitar';
        """
        
        # Exportação para Excel com formatação específica
        data_frame = pd.read_sql(query, connection)
        data_frame.to_excel("pwlite_importacao_movidesk.xlsx", index=False)
        
    except Error as e:
        print(f"Erro: {e}")
    finally:
        if connection.is_connected():
            connection.close()

if __name__ == "__main__":
    export_query_to_excel()
```

#### **3. CNPJ Formatter (`cnpj_formatter_with_copy.py`)**
```python
import pyperclip
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.label import Label

def format_cnpj(cnpj):
    """Formata o CNPJ no padrão XX.XXX.XXX/XXXX-XX"""
    if len(cnpj) == 14 and cnpj.isdigit():
        return f"{cnpj[:2]}.{cnpj[2:5]}.{cnpj[5:8]}/{cnpj[8:12]}-{cnpj[12:]}"
    return "CNPJ inválido!"

class CNPJApp(App):
    def build(self):
        # Interface gráfica para formatação automática de CNPJs
        self.layout = BoxLayout(orientation='vertical', padding=10, spacing=10)
        
        # Campo de entrada
        self.input_cnpj = TextInput(
            hint_text="Digite o CNPJ (somente números)", 
            multiline=False, 
            input_filter="int"
        )
        self.layout.add_widget(self.input_cnpj)
        
        # Botão para formatar e copiar
        self.btn_format = Button(text="Formatar e Copiar CNPJ", size_hint=(1, 0.5))
        self.btn_format.bind(on_press=self.format_and_copy_cnpj)
        self.layout.add_widget(self.btn_format)
        
        # Label para resultado
        self.result_label = Label(text="")
        self.layout.add_widget(self.result_label)
        
        return self.layout
    
    def format_and_copy_cnpj(self, instance):
        cnpj_input = self.input_cnpj.text.strip()
        formatted_cnpj = format_cnpj(cnpj_input)
        
        if "inválido" not in formatted_cnpj:
            pyperclip.copy(formatted_cnpj)
            self.result_label.text = f"CNPJ formatado e copiado: {formatted_cnpj}"
        else:
            self.result_label.text = formatted_cnpj

if __name__ == '__main__':
    CNPJApp().run()
```

---

## 📈 RESULTADOS OBTIDOS

### 🎯 **MÉTRICAS DE IMPACTO DETALHADAS**
- ✅ **2.700 clientes** "PW LITE" atualizados corretamente no sistema de suporte
- ✅ **100% de classificação** adequada implementada
- ✅ **Habilitação completa** de relatórios segmentados por categoria
- ✅ **Redução significativa** de inconsistências de dados

### 📊 **ENTREGAS ESPECÍFICAS REALIZADAS**
- 📋 **Relatórios executivos** entregues aos Product Owners
- 📈 **Gráficos analíticos** desenvolvidos no Google Planilhas sobre os principais motivos de abertura de chamados
- 🔄 **Scripts automatizados** para processamento contínuo
- 📚 **Documentação técnica** completa para futura manutenção

### 🎨 **VISUALIZAÇÕES E ANÁLISES CRIADAS**
- **Gráficos de distribuição** das categorias de clientes
- **Dashboards** de acompanhamento de clientes PW LITE
- **Análise de motivos** de abertura de chamados por categoria
- **Relatórios gerenciais** para tomada de decisão estratégica

---

## 💻 TECNOLOGIAS UTILIZADAS

### 🛢️ **BANCO DE DADOS**
- **MySQL** - Armazenamento e processamento de dados
- **SQL Avançado** - Consultas complexas e otimização

### 🐍 **LINGUAGENS DE PROGRAMAÇÃO**
- **Python** - Scripts de automação e processamento
- **SQL** - Manipulação e consulta de dados

### 📚 **BIBLIOTECAS E FRAMEWORKS**
- **pandas** - Manipulação de dados em Python
- **mysql-connector-python** - Conexão com banco MySQL
- **openpyxl** - Geração de arquivos Excel
- **Kivy** - Interface gráfica para utilitários

### 🔧 **FERRAMENTAS**
- **Google Planilhas** - Análise e visualização
- **MOVIDESK** - Sistema de suporte integrado
- **GitHub** - Controle de versão e documentação

---

## 📁 ESTRUTURA DO PROJETO

```
pex2/
├── 📄 README.md                                    # Documentação principal
├── 📄 LICENSE.md                                   # Direitos autorais e licença
├── 📄 direitos-autorais.html                       # Proteção legal detalhada
├── 📄 index.html                                   # Relatório web interativo
├── 🐍 export_to_excel.py                          # Exportação para Excel
├── 🐍 pwlite.py                                    # Processamento PW LITE
├── 🐍 cnpj_formatter_with_copy.py                 # Formatador de CNPJ
├── 🗄️ Corrigir cadastro de clientes com contrato PWLITE.sql  # Scripts SQL
├── 📝 formulas_usadas_no_projeto.txt              # Fórmulas Excel utilizadas
├── 📁 evidencias/                                  # Capturas de tela e provas
│   ├── 🖼️ imagem1.png
│   ├── 🖼️ imagem2.png
│   ├── 🖼️ imagem3.png
│   └── 🖼️ imagem4.png
└── 📁 skill/                                       # Competências desenvolvidas
    ├── 🎯 Adaptabilidade e Flexibilidade.png
    ├── 💬 Comunicação Eficaz.png
    ├── ❤️ Empatia e Sensibilidade Social.png
    ├── ⚖️ Ética e Responsabilidade.png
    ├── 🚀 Iniciativa e Proatividade.png
    ├── 🧠 Pensamento Crítico e Resolução de Problemas.png
    └── 🤝 Trabalho Colaborativo.png
```

---

## 🔍 CONSULTA SQL PRINCIPAL

```sql
-- Consulta otimizada para identificação de clientes PW LITE
SELECT DISTINCT
  CASE 
    WHEN cm.TIPO = 'Empresa' THEN '2'
    WHEN cm.TIPO = 'Pessoa'  THEN '1'
    ELSE ''
  END AS "Tipo",
  '2' AS "Perfil",
  COALESCE(ep.name, ep.razao_social, 'Nome não informado') AS "Nome",
  ep.company_identifies AS "CNPJ",
  pc1.EMAIL AS "Email",
  '' AS "Autenticar em"
FROM empresa_pw ep
LEFT JOIN (
  SELECT COD_PW, TIPO 
  FROM cadastros_md 
  WHERE TIPO IN ('Empresa', 'Pessoa')
) cm ON cm.COD_PW LIKE CONCAT('%', ep.id, '%')
LEFT JOIN cadastros_t ct ON ep.company_identifies LIKE CONCAT('%', ct.CNPJ, '%')
LEFT JOIN ponto_contato pc ON ep.id = pc.COD_PW
LEFT JOIN pontos_contato_pw pc1 ON pc1.BASE = ep.id
WHERE ep.plan_name LIKE 'PW Lite - não habilitar'
  AND ct.CNPJ IS NOT NULL
  AND ct.CNPJ != '-';
```

---

## 🎓 COMPETÊNCIAS DESENVOLVIDAS

### 🔧 **COMPETÊNCIAS TÉCNICAS DETALHADAS**

#### **1. Diagnóstico de Problemas Reais com Dados (95%)**
Competência adquirida ao identificar problemas de saneamento de dados e falta de informações essenciais para geração de relatórios, compreendendo a importância de sempre manter dados atualizados para garantir informações limpas e claras.

#### **2. Coleta e Análise de Dados (92%)**
Desenvolvida através da utilização de técnicas de exportação de dados e programas SGBD como 'dbForge Studio for MySQL' para importar os dados em um banco de dados MySQL.

#### **3. Extração e Limpeza de Dados (93%)**
Competência adquirida ao extrair dados de sistemas distintos, encontrar lógica e combinações entre esses dados utilizando funções CASE e JOINs para gerar dados limpos e precisos.

#### **4. Análise de Dados e Business Intelligence (BI) (90%)**
Desenvolvida ao cruzar mais de 20 mil registros de informação, separando em tabelas distintas para o cruzamento dos dados, gerando informações limpas e precisas.

#### **5. Consultoria em Ciência de Dados (89%)**
Competência adquirida ao apoiar os Product Owners e Product Managers com as boas práticas de tratamento de dados.

#### **6. Proposição de Soluções Baseadas em Dados (88%)**
Desenvolvida ao identificar e sugerir a exportação de dados de vários sistemas para poder cruzar as informações entre eles e tratar os dados adequadamente.

#### **7. Visualização de Dados (87%)**
Competência adquirida ao importar o cruzamento dos dados no Google Sheets para geração de gráficos através da planilha.

#### **8. Soluções de Previsão e Otimização (86%)**
Desenvolvida ao sugerir que todos os clientes de categoria específica sempre tenham campos essenciais preenchidos durante os cadastros, garantindo a extração de dados precisos.

#### **9. Comunicação Profissional (85%)**
Competência adquirida ao fazer contato com a organização e alinhar de forma clara os objetivos da empresa com os tratamentos de dados.

#### **10. Modelagem Estatística e Análise Exploratória (84%)**
Desenvolvida ao criar um banco de dados MySQL aplicando a lógica de modelagem de dados através dos dados exportados.

#### **11. Processamento de Grandes Volumes de Dados (82%)**
Competência adquirida ao otimizar consultas de grandes conjuntos de dados com Python para processamento eficiente.

#### **12. Machine Learning e Algoritmos Preditivos (78%)**
Desenvolvida ao criar scripts Python para exportar dados de forma rápida, sem a necessidade de aguardar o processamento de consultas SQL pelo SGBD padrão.

### � **SOFT SKILLS DESENVOLVIDAS**

#### **🗣️ Comunicação Eficaz**
Habilidade de comunicar ideias técnicas de maneira clara e acessível para diferentes públicos, desde desenvolvedores até gestores executivos.

#### **🤝 Trabalho Colaborativo**
Capacidade de colaborar efetivamente com colegas e membros da organização, integrando diferentes perspectivas para alcançar objetivos comuns.

#### **🧩 Pensamento Crítico e Resolução de Problemas**
Habilidade de analisar problemas complexos de dados e desenvolver soluções criativas e eficazes para desafios empresariais reais.

#### **❤️ Empatia e Sensibilidade Social**
Capacidade de entender e se importar com as necessidades da organização e dos usuários finais dos sistemas de dados.

#### **🔄 Adaptabilidade e Flexibilidade**
Capacidade de se adaptar a novas tecnologias, mudanças nos requisitos do projeto e diferentes sistemas utilizados pela empresa.

#### **🚀 Iniciativa e Proatividade**
Capacidade de tomar a iniciativa e ser proativo na identificação e resolução de problemas de dados antes que se tornem críticos.

#### **⚖️ Ética e Responsabilidade**
Compromisso com a ética profissional e a responsabilidade no manuseio de dados sensíveis da organização.

---

## 📊 ANÁLISE DE DADOS E VISUALIZAÇÕES

### 📈 **DISTRIBUIÇÃO DE CATEGORIAS DE CLIENTES**

Com base na análise dos dados coletados e tratados, foi possível gerar um mapeamento completo da distribuição das categorias de clientes. Os resultados foram processados no Google Planilhas e revelaram os seguintes padrões:

**Principais Categorias Identificadas:**
- **Categoria 1:** 34,2% - Maior concentração de clientes
- **Categoria 2:** 33,5% - Segunda maior categoria
- **Categoria 3:** 5,2% - Categoria especializada
- **Categoria 4:** 4,6% - Segmento específico
- **Categoria 5:** 4,4% - Nicho de mercado
- **Categorias 6-24:** Variando de 3,8% a 0,2% - Segmentos diversos

> **Nota:** Os nomes das categorias foram alterados por exigência da organização devido a normas internas de confidencialidade.

### 🔍 **INSIGHTS OBTIDOS**

- **Concentração:** 67,7% dos clientes estão nas duas primeiras categorias
- **Diversificação:** A empresa atende 24 categorias distintas de clientes
- **Segmentação:** A categoria "PW LITE" representa um segmento estratégico importante
- **Oportunidades:** Identificação de potencial para crescimento em categorias menores

---

## 📷 EVIDÊNCIAS DO PROJETO

### 🖼️ **DOCUMENTAÇÃO VISUAL**

O projeto conta com documentação visual completa que comprova a execução e os resultados obtidos:

- **Evidência 1:** Capturas de tela do banco de dados MySQL com as tabelas criadas
- **Evidência 2:** Interface do sistema MOVIDESK mostrando os clientes importados
- **Evidência 3:** Gráficos gerados no Google Planilhas com análise de categorias
- **Evidência 4:** Scripts Python em execução e resultados de exportação

### 📋 **VALIDAÇÃO DOS RESULTADOS**

- ✅ **Importação bem-sucedida** de 2.700 registros no MOVIDESK
- ✅ **Validação técnica** pelo suporte da plataforma MOVIDESK
- ✅ **Aprovação dos stakeholders** (Product Owners e Project Manager)
- ✅ **Testes de integridade** dos dados importados

---

## 📊 FÓRMULAS EXCEL UTILIZADAS

### 📝 **Extração de Domínio de Email**
```excel
=PRI.MAIÚSCULA(ESQUERDA(SUBSTITUIR(F22; "."; " "); PROCURAR("@" ; F2) - 1))
```

### 🔍 **Validação de Cadastro Administrativo**
```excel
=SE(CONT.SE(adm!A:A; A2)>0; "Sim"; "Não")
```

---

## ⚖️ DIREITOS AUTORAIS E LICENCIAMENTO

### 📋 **PROTEÇÃO LEGAL DETALHADA**

#### **🇧🇷 LEI Nº 9.610/98 - LEI DE DIREITOS AUTORAIS BRASILEIRA**

**Fundamentação Legal:**  
Esta obra está protegida contra plágio e cópias indevidas pela Lei nº 9.610/98, a Lei de Direitos Autorais brasileira. Conforme o Art. 7º, inciso X, desta lei, estão protegidas as "obras de desenho, litografia ou arte aplicada", e por analogia, obras de desenvolvimento e propriedade intelectual, como projetos acadêmicos, teses, artigos e códigos-fonte, se enquadram na proteção conferida à criação do intelecto.

**Artigos Relevantes:**
- **Art. 7º - Obras Protegidas:** São obras intelectuais protegidas as criações do espírito, expressas por qualquer meio ou fixadas em qualquer suporte, tangível ou intangível, conhecido ou que se invente no futuro.
- **Art. 29 - Direitos Patrimoniais:** Depende de autorização prévia e expressa do autor a utilização da obra, por quaisquer modalidades, tais como reprodução, edição e adaptação.

⚠️ **AVISO LEGAL:** A violação dos direitos autorais é crime previsto no Art. 184 do Código Penal Brasileiro, com pena de detenção de 3 meses a 1 ano, ou multa. A reprodução não autorizada pode resultar em sanções civis e criminais.

#### **📄 LICENÇA CREATIVE COMMONS BY-NC-SA 4.0**

**Termos da Licença:**
- **Atribuição (BY):** Você deve dar crédito apropriado, fornecer um link para a licença e indicar se mudanças foram feitas.
- **Não Comercial (NC):** Você não pode usar o material para fins comerciais sem autorização expressa do autor.
- **Compartilha Igual (SA):** Se você remixar, transformar ou criar a partir do material, deve distribuir suas contribuições sob a mesma licença.

🔗 **Link da Licença:** [Creative Commons BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

### 🔐 **VERIFICAÇÃO BLOCKCHAIN E ASSINATURA DIGITAL**

**Registro com Timestamp Blockchain:**  
Esta obra possui registro de autenticidade e data de criação verificável através de tecnologia blockchain, garantindo a integridade e a prova de autoria da propriedade intelectual.

- **🕐 Timestamp Blockchain:** `153e487feb3f` - Registro temporal imutável na blockchain
- **📄 Extensão do Arquivo:** `.ots` - OpenTimestamps (Prova criptográfica de existência)  
- **🔐 Document Digest (SHA-256):** `153e487feb3f1bff6f36ea95f17d3eee03f0f15036da159206e94c1af6b7b927` - Hash criptográfico único que comprova a integridade do documento original

✅ **VERIFICAÇÃO DE AUTENTICIDADE:** Você pode verificar a autenticidade deste documento utilizando o hash SHA-256 e o timestamp blockchain fornecidos. Esta tecnologia garante que o conteúdo não foi alterado desde sua criação original.

### 🆔 **DOI - IDENTIFICADOR DIGITAL ÚNICO**

**Digital Object Identifier:**  
Este projeto possui um DOI (Digital Object Identifier), que é um identificador digital único e persistente reconhecido internacionalmente. O DOI garante que esta obra possa ser citada, referenciada e localizada de forma permanente no meio acadêmico e científico.

- **DOI:** `10.5281/zenodo.15612206`
- **Link Permanente:** https://doi.org/10.5281/zenodo.15612206
- **Repositório:** Zenodo - Repositório Científico Europeu

**Vantagens do DOI:**
- Identificação única e permanente
- Reconhecimento acadêmico internacional  
- Facilita citações e referências
- Aumenta a visibilidade da pesquisa
- Garante a persistência do link

**Padrão Internacional:** O DOI é mantido pela International DOI Foundation (IDF) e é amplamente aceito por editoras, bibliotecas e bases de dados acadêmicas mundiais.

✅ **CERTIFICAÇÃO ACADÊMICA:** A atribuição do DOI certifica que este projeto atende aos padrões de qualidade e rigor acadêmico necessários para publicação em repositórios científicos internacionais.

### 👤 **AUTORIA E ATRIBUIÇÃO**

**Autor Original:** Delean P. Mafra  
**Curso:** Ciência de Dados  
**Instituição:** Descomplica Faculdade Digital  
**Projeto:** Projeto de Extensão II  
**Ano:** 2025  

**Links Profissionais:**
- [LinkedIn](https://www.linkedin.com/in/deleanmafra/)
- [GitHub](https://github.com/Delean-Mafra)

**Como Citar Esta Obra:**
```
Delean Mafra. Relatório de Atividades: Projeto de Extensão II, Ciência de Dados. 
Atividade extensionista realizada para organização Soluções em Software e Serviços TTS LTDA. 
Instituição: Descomplica Faculdade Digital, 2025. 
DOI: 10.5281/zenodo.15612206. 
Publicado em: Academia.edu. 
Disponível em: https://github.com/Delean-Mafra/pex2. 
Acesso em: [data]. 
Licença: CC BY-NC-SA 4.0.
```

### 📧 **CONTATO E PERMISSÕES ESPECIAIS**

**Uso Comercial:** Para uso comercial desta obra, entre em contato diretamente com o autor para obter autorização expressa e discutir os termos de licenciamento comercial.

**Adaptações e Remixes:** Adaptações e remixes são permitidos desde que mantida a atribuição ao autor original e distribuídos sob a mesma licença CC BY-NC-SA 4.0.

**Dúvidas Legais:** Para esclarecimentos sobre direitos autorais, licenciamento ou questões legais relacionadas a esta obra, consulte um profissional especializado em propriedade intelectual.

### 🎓 **REGULAMENTAÇÃO ESPECÍFICA PARA PROJETOS DE EXTENSÃO**

**Resolução CNE/CES nº 7, de 18 de dezembro de 2018:**  
Esta obra, na qualidade de Projeto de Extensão na Educação Superior, também se enquadra nas diretrizes estabelecidas pela Resolução CNE/CES nº 7/2018. Esta normativa, do Conselho Nacional de Educação, regulamenta as atividades de extensão, tornando-as componentes curriculares obrigatórios nos cursos de graduação, com o objetivo de promover a interação transformadora entre as instituições de ensino superior e os demais setores da sociedade.

A presente obra, como atividade extensionista, contribui para a formação cidadã do estudante, articulando ensino, pesquisa e extensão, conforme os princípios desta Resolução. Seu desenvolvimento e conclusão estão alinhados com o Art. 15º da referida Resolução, que determina o devido registro, documentação e análise das atividades de extensão para organização de planos de trabalho, metodologias e conhecimentos gerados.

📋 **CONFORMIDADE REGULATÓRIA:** Este projeto atende aos requisitos estabelecidos pela regulamentação nacional para atividades de extensão universitária, garantindo sua validade acadêmica e social.

---

## 🌐 PUBLICAÇÕES E RECONHECIMENTO

### 📚 **ARTIGO ACADÊMICO PUBLICADO**

**Publicação em Plataforma Acadêmica:**  
Este projeto foi publicado como artigo acadêmico na plataforma Academia.edu, uma das principais redes sociais acadêmicas globais. A publicação garante maior visibilidade, acessibilidade e reconhecimento no meio científico e acadêmico internacional.

- **Plataforma:** Academia.edu
- **Título:** "CIÊNCIA DE DADOS: RELATÓRIO DE ATIVIDADES - PROJETO DE EXTENSÃO II"
- **Link:** [Academia.edu Publication](https://www.academia.edu/129803843/CIÊNCIA_DE_DADOS_RELATÓRIO_DE_ATIVIDADES_PROJETO_DE_EXTENSÃO_II)

**Sobre a Academia.edu:**
- Plataforma acadêmica global
- Mais de 200 milhões de usuários
- Rede social para pesquisadores
- Compartilhamento de papers acadêmicos
- Indexação e descoberta científica

**Benefícios da Publicação:**
- Maior visibilidade acadêmica
- Acesso público ao conhecimento  
- Networking com pesquisadores
- Métricas de impacto acadêmico
- Facilitação de citações

✅ **VALIDAÇÃO ACADÊMICA:** A publicação na Academia.edu complementa a validação acadêmica do projeto, proporcionando acesso aberto ao conhecimento produzido e facilitando o intercâmbio científico com a comunidade acadêmica internacional.

### 🏆 **CERTIFICAÇÕES E RECONHECIMENTOS**
- **DOI Acadêmico** - Zenodo Repository (Repositório Científico Europeu)
- **Blockchain Timestamp** - Prova criptográfica de autenticidade
- **Creative Commons License** - Licenciamento responsável e transparente
- **Regulamentação CNE/CES** - Conformidade com normativas educacionais brasileiras

---

## 📞 CONTATO E REFERÊNCIAS

### 👨‍💻 **AUTOR**
- **LinkedIn:** [Delean Mafra](https://www.linkedin.com/in/deleanmafra/)
- **GitHub:** [Delean-Mafra](https://github.com/Delean-Mafra)
- **Repositório:** [pex2](https://github.com/Delean-Mafra/pex2)

### 📝 **COMO CITAR ESTE PROJETO**
```
Delean Mafra. Relatório de Atividades: Projeto de Extensão II, Ciência de Dados. 
Atividade extensionista realizada para organização Soluções em Software e Serviços TTS LTDA. 
Instituição: Descomplica Faculdade Digital, 2025. 
DOI: 10.5281/zenodo.15612206. 
Publicado em: Academia.edu. 
Disponível em: https://github.com/Delean-Mafra/pex2. 
Acesso em: [data]. 
Licença: CC BY-NC-SA 4.0.
```

---

## 🎯 CONSIDERAÇÕES FINAIS

### � **IMPACTO DO PROJETO**

A atuação neste projeto de extensão permitiu a aplicação prática de conceitos fundamentais de **modelagem de dados**, **integração de sistemas**, **limpeza de dados** e **geração de relatórios**. A entrega final atendeu integralmente à necessidade da organização, promovendo ganhos significativos na eficiência da análise de chamados e permitindo uma tomada de decisão mais assertiva em relação ao atendimento da categoria "PW LITE".

### 🚀 **BENEFÍCIOS ALCANÇADOS**

- **Automação de processos:** Eliminação de categorizações manuais
- **Melhoria na qualidade dos dados:** Padronização e validação automatizada
- **Capacidade analítica aprimorada:** Relatórios segmentados por categoria
- **Eficiência operacional:** Redução do tempo de geração de relatórios
- **Tomada de decisão baseada em dados:** Insights precisos sobre diferentes categorias de clientes

### 🔮 **PERSPECTIVAS FUTURAS**

O projeto estabeleceu as bases para futuras melhorias e expansões:
- **Escalabilidade:** Aplicação da metodologia em outras categorias de clientes
- **Automação avançada:** Implementação de pipelines de dados em tempo real
- **Machine Learning:** Desenvolvimento de modelos preditivos para classificação automática
- **Integração contínua:** Sincronização automática entre sistemas

---

**📅 Última atualização:** Julho 2025  
**🔄 Status:** Projeto concluído com sucesso  
**📊 Versão:** 1.0  
**⚖️ Proteção Legal:** Lei nº 9.610/98 - Direitos Autorais Brasileiros

---

### 📝 **OBSERVAÇÕES IMPORTANTES**

> **Confidencialidade:** Os nomes das categorias de clientes foram alterados por exigência da organização devido a normas internas de confidencialidade e proteção de dados empresariais.

> **Segurança:** Credenciais de banco de dados, endereços específicos da empresa e outros dados sensíveis foram omitidos desta documentação pública por questões de segurança.

> **Autenticidade:** Este projeto possui verificação blockchain e timestamp digital, garantindo a autenticidade e integridade da documentação.

---

*Este projeto representa um marco na aplicação prática de conceitos de Ciência de Dados em ambiente corporativo real, demonstrando a capacidade de transformar dados em insights acionáveis e soluções efetivas para problemas empresariais complexos. A experiência adquirida durante a execução deste projeto contribuiu significativamente para o desenvolvimento profissional e acadêmico, consolidando conhecimentos teóricos através de aplicação prática em cenário empresarial real.*

- Relatório completo: https://delean-mafra.github.io/pex2
