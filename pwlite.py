import mysql.connector
from mysql.connector import Error
import pandas as pd

def export_query_to_excel():
    try:
        # Conexão com o banco de dados MySQL
        connection = mysql.connector.connect(
            host='',
            user='',
            password='',
            database=''  # Nome do banco de dados
        )

        if connection.is_connected():
            print("Conexão bem-sucedida ao banco de dados.")
# -- Montado sql para atender os criteios de atualização de cadastro da MOVIDESK: https://atendimento.movidesk.com/kb/article/4694/importacao-de-pessoas?menuId=4-66-4694&ticketId= 
            # Consulta SQL
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
              '' AS "Razão social",
              cm.USUARIO AS "Usuário",
              '# Senha removida para preservar integridade' AS "Senha",
              CASE 
                WHEN cm.TIPO = 'Empresa' THEN ct.CNPJ
                ELSE ''
              END AS "CPF / CNPJ",
              cm.COD_REF AS "Cod. Ref.",
              '' AS "Cod. Ref. Adicional",
              cm.PERFIL AS "Perfil de acesso",
              'PW LITE' AS "Classificação",
              '' AS "Cargo",
              '' AS "Superior hierárquico",
              CASE
                WHEN cm.EMAIL IS NOT NULL AND cm.EMAIL <> '' THEN 'Profissional'
                ELSE ''
              END AS "Tipo do e-mail",
              cm.EMAIL AS "E-mail",
              cm.TIPO_DO_CONTATO AS "Tipo do contato", -- Corrigido para corresponder à coluna original
              '' AS "Contato",
              '' AS "Tipo do endereço",
              '' AS "País",
              '' AS "CEP",
              '' AS "Estado",
              '' AS "Cidade",
              '' AS "Bairro",
              '' AS "Rua",
              '' AS "Número",
              '' AS "Complemento",
              '' AS "Referência",
              '' AS "Equipe",
              cm.ORGANIZACOES AS "Organização",
              'SLA - Padrão' AS "Contrato de SLA",
              cm.COD_PW AS "Observações",
              cm.ATIVO AS "Ativo",
              cm.FUSO_HORARIO AS "Fuso horário",
              cm.IDIOMA AS "Idioma",
              '' AS "Autenticar em"
            FROM empresa_pw ep
            LEFT JOIN (
              SELECT * FROM cadastros_md
              WHERE LENGTH(COD_PW) >= 6
                AND TIPO = '1' -- No contexto original, parecia ser 'Empresa', mas TIPO='1' geralmente é Pessoa. Ajustar se necessário.
                             -- Se TIPO='1' for Pessoa e o objetivo é atualizar EMPRESAS "PW LITE",
                             -- esta subquery pode precisar de revisão ou o join cm.COD_PW LIKE CONCAT('%', ep.id, '%')
                             -- pode estar buscando contatos associados à empresa.
                AND COD_PW REGEXP '[aA]'
                AND COD_PW REGEXP '([0-9].*){5,}'
                AND CNPJ IS NULL -- Se são empresas, CNPJ não deveria ser nulo. Isso reforça que 'cm' pode ser contatos.
                AND ATIVO IS NOT NULL
                AND ATIVO != 'Não'
            ) cm ON cm.COD_PW LIKE CONCAT('%', ep.id, '%') -- Assumindo que ep.id é um código da empresa presente em COD_PW dos contatos.
            LEFT JOIN cadastros_t ct ON ep.company_identifies LIKE CONCAT('%', ct.CNPJ, '%') -- Usando CNPJ para ligar empresa_pw com cadastros_t
            WHERE ep.plan_name LIKE 'PW Lite - não habilitar';        
            """

            # Executar a consulta e carregar os dados em um DataFrame do pandas
            data_frame = pd.read_sql(query, connection)

            # Exportar para um arquivo Excel
            output_file = "resultado_consulta.xlsx"
            data_frame.to_excel(output_file, index=False)

            print(f"Consulta exportada com sucesso para o arquivo: {output_file}")

    except Error as e:
        print(f"Erro ao conectar ao MySQL: {e}")
    finally:
        if connection.is_connected():
            connection.close()
            print("Conexão com o banco de dados encerrada.")

if __name__ == "__main__":
    export_query_to_excel()
