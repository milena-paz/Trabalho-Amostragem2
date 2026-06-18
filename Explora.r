library(dplyr)
x<-read.csv2("Leitos_2026.csv",encoding="Latin1")%>%
  filter(UF=="MG")
x$DESC_NATUREZA_JURIDICA[x$DESC_NATUREZA_JURIDICA=="HOSPITAL_FILANTR\xd3PICO"] <- "HOSPITAL_FILANTROPICO"
x$DESC_NATUREZA_JURIDICA[x$DESC_NATUREZA_JURIDICA=="HOSPITAL_P\xdaBLICO"] <- "HOSPITAL_PUBLICO"

x <- x %>%
  select(!c("REGIAO","UF","MOTIVO_DESABILITACAO","NO_EMAIL","CO_CEP","NO_COMPLEMENTO")) %>% 
  filter(COMP==202601) #referente ao mes de janeiro

# populacao de estudo: leitos dos hospitais do estado de minas gerais vinculados ao SUS referentes ao mes de janeiro
# amostra: total de leitos dentro dos hospitais do estado de minas gerais vinculados ao SUS (informados pelo DataSUS) referentes ao mês de JANEIRO
# variável de interesse: número de leitos
# unidade amostral: leito SUS
set.seed(65)
s <- sample(1:nrow(x),size=200,replace=T)
amostra <- x[s,]
amostra <- amostra %>%
  select(c("MUNICIPIO","CNES","NOME_ESTABELECIMENTO","DESC_NATUREZA_JURIDICA","LEITOS_SUS","LEITOS_EXISTENTES"))
