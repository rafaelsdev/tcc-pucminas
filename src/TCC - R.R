#####
# PUC Minas - 2024
# TCC em Ciencia de Dados e Big Data
# Aluno: Rafael da Silva
####

# Definindo o diretório onde a base de arquivos da PNAD está localizado
# Alternativamente pode ser relizada uma execução online, para isso veja o passo
# a passo na guia "Importação Online" da URL abaixo:
# https://rpubs.com/gabriel-assuncao-ibge/pnadc
setwd("D:/TCC/PNAD/2022")
getwd()

# Instalar o pacote PNADcIBGE 
# Descomente o trecho abaixo apenas na primeira execução, ou faça a instalação separadamente
# install.packages("PNADcIBGE")

# Importando a biblioteca IBGE
library(PNADcIBGE)

# Importando dplyr para manipular os dados
library(dplyr)

# Importação da biblioteca utilizada para manipular dados do IBGE
library(survey)

# Seleção das variáveis
variaveis <- c(
  "V2007"  # Sexo
  ,"V2009"  # Idade do morador
  ,"V3002"  # Frequenta escola
  ,"V3008"  # Anteriormente ... frequentou escola?
  ,"V3003A" # Qual é o curso que ... frequenta?
  ,"V3006"  # Qual é o ano/série/semestre que ... frequenta?
  ,"V3006A" # Qual é a etapa do ensino fundamental que ... frequenta?
  ,"V3009A" # Qual foi o curso mais elevado que ... frequentou anteriormente?
  ,"V3014"  # ... concluiu este curso que frequentou anteriormente
  ,"V3010"  # A duração deste curso que ... frequentou anteriormente era de:
  ,"V3012"  # ... concluiu com aprovação, pelo menos a primeira série deste curso que frequentou anteriormente?
  ,"V3013B" # ... Concluiu os anos iniciais deste curso que frequentou anteriormente?
  ,"V3013A" # Qual foi a etapa de ensino fundamental que ... frequentou?
  ,"V3013"  # Qual foi o último ano/série/semestre que ... concluiu com aprovação, neste curso que frequentou anteriormente
  ,"V3005A" # Esse curso que .... frequenta é organizado em:
  ,"V3011A" # Esse curso que .... frequentou era organizado em:
  ,"V3007"  # ... já concluiu algum outro curso de graduação?
  ,"V4009"  # Quantos trabalhos ... tinha na semana de ... a ... (semana de referência ?
  ,"V4071"  # No período de ... a ... (período de referência de 30 dias), ... Tomou alguma providência para conseguir trabalho, seja um emprego ou um negócio próprio? 
  ,"V4072A" # No período de ... a ... (período de referência de 30 dias), qual foi a principal providência que ... tomou para conseguir trabalho?
  ,"V4073"  # Embora não tenha tomado providência para conseguir trabalho, gostaria de ter trabalhado na semana de ... a ... (semana de referência) ?
  ,"V4074A" # Qual foi o principal motivo de ... não ter tomado providência para conseguir trabalho no período de  ... a ... (período de referência de 30 dias)?
  ,"V4075A" # Quanto tempo depois de ... (último dia da semana de referência) irá começar esse trabalho que conseguiu?
  ,"V4075A1" # Número de meses para começar o trabalho que conseguiu
  ,"V4077"  # Se tivesse conseguido um trabalho, ... poderia ter começado a trabalhar na semana de ... a ... (semana de referência)? 
  ,"VD4002" # Condição de ocupação na semana de referência para pessoas de 14 anos ou mais de idade
  , "VD3004" # Nível de instrução mais elevado alcançado (pessoas de 5 anos ou mais de idade) padronizado para o Ensino fundamental -  SISTEMA DE 9 ANOS

)

# Tabelas com dados do PNAD por trimestre
tabelas <- c(
  'PNADC_012022.txt'
  ,'PNADC_022022.txt'
  ,'PNADC_032022.txt'
  ,'PNADC_042022.txt'
)

pnadToCSV <- function(file, variaveis){
  
  dadosPNADc <- read_pnadc(microdata=file, input_txt ="input_PNADC_trimestral.sas", vars=variaveis)
  
  # Filtragem para variaveis (Caso a leitura inicial nao faca)
  dadosPNADF <- select(dadosPNADc, all_of(variaveis))
  
  
  fileName = stringr::str_split(file, "[.]")
  
  fullPath = paste("D:/TCC/PNAD/CSV/",fileName[[1]][1],"_vd.csv", sep='' )
  
  # Grava o arquivo no caminho completo
  write.csv(dadosPNADF, fullPath, row.names = TRUE)
  
  # Remove o DF para liberar memória
  rm(dadosPNADc)
  rm(dadosPNADF)
  
}

for(tri in tabelas){
  pnadToCSV(tri, variaveis)
}