library(dplyr)
x<-read.csv2("Leitos_2026.csv",encoding="Latin1")%>%
  filter(UF=="MG")
x$DESC_NATUREZA_JURIDICA[x$DESC_NATUREZA_JURIDICA=="HOSPITAL_FILANTR\xd3PICO"] <- "HOSPITAL_FILANTROPICO"
x$DESC_NATUREZA_JURIDICA[x$DESC_NATUREZA_JURIDICA=="HOSPITAL_P\xdaBLICO"] <- "HOSPITAL_PUBLICO"

x <- x %>%
  select(c("MUNICIPIO","COMP","CNES","NOME_ESTABELECIMENTO","DESC_NATUREZA_JURIDICA","LEITOS_SUS","LEITOS_EXISTENTES")) %>% 
  filter(COMP==202601) #referente ao mes de janeiro
(x$DESC_NATUREZA_JURIDICA <- as.factor(x$DESC_NATUREZA_JURIDICA))
levels(x$DESC_NATUREZA_JURIDICA)<- c("FILANTROPICO","PRIVADO","PUBLICO")
png(filename="boxplot.png")
boxplot((LEITOS_SUS/LEITOS_EXISTENTES)~DESC_NATUREZA_JURIDICA,
        data=x, pch=4,col=RColorBrewer::brewer.pal(3,"Set3"),
        xlab="Natureza Jurídica",ylab="Leitos SUS/ Leitos Totais")
dev.off()
# populacao de estudo: leitos dos hospitais do estado de minas gerais vinculados ao SUS referentes ao mes de janeiro
# amostra: total de leitos dentro dos hospitais do estado de minas gerais vinculados ao SUS (informados pelo DataSUS) referentes ao mês de JANEIRO
# variável de interesse: número de leitos
# unidade amostral: leito SUS
set.seed(2026)
s <- sample(1:nrow(x),size=197,replace=T)
amostra <- x[s,]
amostra <- amostra %>%
   select(c("MUNICIPIO","CNES","NOME_ESTABELECIMENTO","DESC_NATUREZA_JURIDICA","LEITOS_SUS","LEITOS_EXISTENTES"))

#####ESTIMATIVAS####
#TOTAL LEITOS
ybar <- mean(amostra$LEITOS_EXISTENTES)
ybar*662

# erro
ybar*662-sum(x$LEITOS_EXISTENTES)

#PROPORCAO LEITOS SUS/LEITOS TOTAIS

y <- amostra$LEITOS_SUS
M <-  x$LEITOS_EXISTENTES
pn <- 662/197*sum(y)/sum(M)
pn
