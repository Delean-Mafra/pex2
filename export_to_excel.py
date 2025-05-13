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

            # Consulta SQL
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
