CREATE TABLE ahgora.cadastros_md (
  COD_REF varchar(255) NOT NULL,
  TIPO varchar(255) DEFAULT NULL,
  USUARIO text DEFAULT NULL,
  CNPJ varchar(255) DEFAULT NULL,
  COD_REF_AD varchar(255) DEFAULT NULL,
  PERFIL varchar(255) DEFAULT NULL,
  CLASSIFICACAO varchar(255) DEFAULT NULL,
  EMAIL varchar(255) DEFAULT NULL,
  TIPO_DO_CONTATO text DEFAULT NULL,
  CEP varchar(255) DEFAULT NULL,
  ESTADO varchar(255) DEFAULT NULL,
  CIDADE varchar(255) DEFAULT NULL,
  BAIRRO varchar(255) DEFAULT NULL,
  PRIMENTO_END varchar(255) DEFAULT NULL,
  NUMERO varchar(255) DEFAULT NULL,
  SEG_END varchar(255) DEFAULT NULL,
  NOTE varchar(255) DEFAULT NULL,
  ORGANIZACOES text DEFAULT NULL,
  CONTRATOS_DE_SLA varchar(255) DEFAULT NULL,
  ATIVOS varchar(255) DEFAULT NULL,
  OBSERVACOES varchar(255) DEFAULT NULL,
  CADASTRADO_EM varchar(255) DEFAULT NULL,
  ALTERADO_EM varchar(255) DEFAULT NULL,
  FUSO_HORARIO varchar(255) DEFAULT NULL,
  IDIOMA varchar(255) DEFAULT NULL,
  ATIVO varchar(255) DEFAULT NULL,
  NUMERO_DO_CONTRATO varchar(255) DEFAULT NULL,
  TIPO_DO_CONTRATO varchar(255) DEFAULT NULL,
  CLIENTE_REVENDA varchar(255) DEFAULT NULL,
  COD_PW text DEFAULT NULL,
  MRR varchar(255) DEFAULT NULL,
  SEGMENTACAO varchar(255) DEFAULT NULL,
  CSM varchar(255) DEFAULT NULL,
  FILIAIS varchar(255) DEFAULT NULL,
  BILLING varchar(255) DEFAULT NULL,
  PRIMARY KEY (COD_REF)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 264
CHARACTER SET latin1
COLLATE latin1_swedish_ci
ROW_FORMAT = DYNAMIC;



CREATE TABLE ahgora.cadastros_t (
  CODT varchar(14) NOT NULL,
  CODIGO_DA_EMPRESA_PW varchar(106) DEFAULT NULL,
  CARTEIRA varchar(14) DEFAULT NULL,
  NOME varchar(90) DEFAULT NULL,
  NOME_FANTASIA varchar(80) DEFAULT NULL,
  CNPJ varchar(18) DEFAULT NULL,
  UF varchar(14) DEFAULT NULL,
  MRR_CONTRATADO_REAL decimal(15, 2) DEFAULT NULL,
  MRR_PAGANTE_REAL decimal(15, 2) DEFAULT NULL,
  PRIMEIRA_ASSINATURA date DEFAULT NULL,
  ULTIMA_ASSINATURA date DEFAULT NULL,
  SEGMENTO varchar(21) DEFAULT NULL,
  HEALTHSCORE decimal(15, 2) DEFAULT NULL,
  PREDICAO_DE_CHURN varchar(20) DEFAULT NULL,
  MOMENTO varchar(35) DEFAULT NULL,
  INSERCAO_EMPODERA date DEFAULT NULL,
  AGENTES varchar(83) DEFAULT NULL,
  EMAIL_DO_AGENTE varchar(91) DEFAULT NULL,
  ESN_NOME varchar(40) DEFAULT NULL,
  ESN_TELEFONE varchar(15) DEFAULT NULL,
  ESN_EMAIL varchar(40) DEFAULT NULL,
  GSN_NOME varchar(37) DEFAULT NULL,
  GSN_TELEFONE varchar(15) DEFAULT NULL,
  GSN_EMAIL varchar(35) DEFAULT NULL,
  GESN_NOME varchar(39) DEFAULT NULL,
  GESN_TELEFONE varchar(14) DEFAULT NULL,
  GESN_EMAIL varchar(32) DEFAULT NULL,
  MONITORADO varchar(14) DEFAULT NULL,
  UNIDADE_DE_VENDA varchar(99) DEFAULT NULL,
  FAIXA_DE_FUNCIONARIOS varchar(21) DEFAULT NULL,
  TIPO_DE_CLIENTE varchar(15) DEFAULT NULL,
  HEALTHSCORE_IMP decimal(15, 2) DEFAULT NULL,
  EMAIL_IMP varchar(49) DEFAULT NULL,
  TIPO_CLIENTE varchar(14) DEFAULT NULL,
  GRUPO_ECONOMICO varchar(17) DEFAULT NULL,
  ELEGIVEL_AO_CANCELAMENTO varchar(24) DEFAULT NULL,
  INADIMPLENTE varchar(14) DEFAULT NULL,
  MRR_AHGORA decimal(15, 2) DEFAULT NULL,
  MRR_PAGANTES_AHGORA decimal(15, 2) DEFAULT NULL,
  PRIMARY KEY (CODT)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 589
CHARACTER SET latin1
COLLATE latin1_swedish_ci
ROW_FORMAT = DYNAMIC;


CREATE TABLE ahgora.empresa_pw (
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  razao_social varchar(255) DEFAULT NULL,
  company_identifies text DEFAULT NULL,
  created_date datetime DEFAULT NULL,
  test varchar(255) DEFAULT NULL,
  pendencies_name varchar(255) DEFAULT NULL,
  plan_id varchar(255) DEFAULT NULL,
  plan_name varchar(255) DEFAULT NULL,
  customer_type_name varchar(255) DEFAULT NULL,
  service_level varchar(255) DEFAULT NULL,
  blocked varchar(255) DEFAULT NULL,
  blocked_description text DEFAULT NULL,
  blocked_responsible varchar(255) DEFAULT NULL,
  blocked_date datetime DEFAULT NULL,
  address varchar(255) DEFAULT NULL,
  address_complement varchar(255) DEFAULT NULL,
  address_district varchar(255) DEFAULT NULL,
  address_country_id varchar(255) DEFAULT NULL,
  address_country_name varchar(255) DEFAULT NULL,
  address_federation_state_id varchar(255) DEFAULT NULL,
  address_federation_state_name varchar(255) DEFAULT NULL,
  address_city varchar(255) DEFAULT NULL,
  address_cep varchar(255) DEFAULT NULL,
  telephone_ddd varchar(255) DEFAULT NULL,
  telephone varchar(255) DEFAULT NULL,
  finance_id text DEFAULT NULL,
  contact_points text DEFAULT NULL,
  module_ahfin_seguro_acidentes_pessoais_88i_enabled varchar(255) DEFAULT NULL,
  module_pwlite_enabled varchar(255) DEFAULT NULL,
  module_pwlite_done varchar(255) DEFAULT NULL,
  module_pwlite_finished_at varchar(255) DEFAULT NULL,
  csm varchar(255) DEFAULT NULL,
  segmento varchar(255) DEFAULT NULL,
  revenda varchar(255) DEFAULT NULL,
  module_reports_habilita_novo_fluxo_relatorios varchar(255) DEFAULT NULL,
  module_reports_desabilita_relatorios_antigos varchar(255) DEFAULT NULL,
  module_reports_agendamento_relatorios varchar(255) DEFAULT NULL,
  module_reports_usa_mes_atual varchar(255) DEFAULT NULL,
  module_ahpi_usa_nova_apuracao varchar(255) DEFAULT NULL,
  module_pwlite_enabled_hourslite varchar(255) DEFAULT NULL,
  contract_integration varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 504
CHARACTER SET latin1
COLLATE latin1_swedish_ci
ROW_FORMAT = DYNAMIC;



CREATE TABLE ahgora.ponto_contato (
  COD_PW varchar(255) DEFAULT NULL,
  EMPRESA varchar(255) DEFAULT NULL,
  CONTATO varchar(255) DEFAULT NULL,
  CNPJ varchar(255) DEFAULT NULL,
  MYAHGORA varchar(255) DEFAULT NULL,
  ACESSOWEB varchar(255) DEFAULT NULL,
  TIMESHEET varchar(255) DEFAULT NULL,
  FERIAS varchar(255) DEFAULT NULL,
  ROSTERING varchar(255) DEFAULT NULL,
  ANALYTICS varchar(255) DEFAULT NULL,
  SMARTGATE varchar(255) DEFAULT NULL
)
ENGINE = INNODB
AVG_ROW_LENGTH = 247
CHARACTER SET latin1
COLLATE latin1_swedish_ci
ROW_FORMAT = DYNAMIC;



CREATE TABLE ahgora.pontos_contato_pw (
  BASE varchar(255) DEFAULT NULL,
  EMAIL varchar(255) DEFAULT NULL,
  NOME varchar(255) DEFAULT NULL,
  PERFIL varchar(255) DEFAULT NULL,
  ORGANIZACAO varchar(255) DEFAULT NULL,
  CLASSIFICA varchar(255) DEFAULT NULL,
  CNPJ varchar(255) DEFAULT NULL
)
ENGINE = INNODB
AVG_ROW_LENGTH = 222
CHARACTER SET latin1
COLLATE latin1_swedish_ci
ROW_FORMAT = DYNAMIC;




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



-- Montado sql para atender os criteios de atualização de cadastro da MOVIDESK: https://atendimento.movidesk.com/kb/article/4694/importacao-de-pessoas?menuId=4-66-4694&ticketId= 


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
  cm.TIPO_DO_CONTATO,
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
    AND TIPO = '1'
    AND COD_PW REGEXP '[aA]'
    AND COD_PW REGEXP '([0-9].*){5,}'
    AND CNPJ IS NULL
    AND ATIVO IS NOT NULL
    AND ATIVO != 'Não'
) cm ON cm.COD_PW LIKE CONCAT('%', ep.id, '%')
LEFT JOIN cadastros_t ct ON ep.company_identifies LIKE CONCAT('%', ct.CNPJ, '%')
WHERE ep.plan_name LIKE 'PW Lite - não habilitar'
