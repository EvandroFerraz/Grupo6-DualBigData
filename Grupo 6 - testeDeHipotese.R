# Leitura do dataset

# 1 - Explicar o conjunto de dados
#O dataset utilizado é o do topiramato, com as variáveis: Princípio ativo, DCB, Ano da Venda, Sexo, Idade,
#UF da venda, Municipio da Venda, Quantidade Farmacotécnica, Tipo do Receituário
topdataset <- read.table("C:/Users/Pichau/Desktop/Pastas/USJT/analiseDados/r/projetoUC/topdataset.csv", quote="\"", comment.char="")
library(ggplot2)

#2 - Explicar as variáveis + #3 - Descrever cada variável:
#Princípio ativo - Qualitativa nominal
table(topdataset$PRINCIPIO_ATIVO)
#DCB - Qualitativa Nominal - DCB é a sigla para Denominação Comum Brasileira 
table(topdataset$DCB)
#Ano da Venda - Qualitativa Nominal 
table(topdataset$ANO_VENDA)
#Sexo - Qualitativa Nominal
table(topdataset$SEXO)
#Idade - Quantitativa Contínua
summary(topdataset$IDADE)
var(topdataset$IDADE)
sd(topdataset$IDADE)
#UF da venda - Qualitativa Nominal
table(topdataset$UF_VENDA)
#Municipio da Venda - Qualitativa Nominal
table(topdataset$MUNICIPIO_VENDA)
#Quantidade Farmacotécnica - Quantitativa Discreta
summary(topdataset$QTD_UNIDADE_FARMACOTECNICA)
var(topdataset$QTD_UNIDADE_FARMACOTECNICA)
sd(topdataset$QTD_UNIDADE_FARMACOTECNICA)
#Tipo do Receituário - Qualitativa Nominal
table(topdataset$TIPO_RECEITUARIO)

#4 - Verificar as Relações entre as Variáveis
#Fazer a matriz de correlação
cor(topdataset$IDADE, topdataset$QTD_UNIDADE_FARMACOTECNICA)
#A Correlação entre as duas variáveis é fraca e elas tendem a se mover em direções diferentes [1] -0.1614262

# Divisão dos dados por sexo
dados_homem <- subset(topdataset, SEXO == "1")$IDADE
dados_mulher <- subset(topdataset, SEXO == "2")$IDADE

# Teste de hipótese para diferença de médias
resultado_teste <- t.test(dados_homem, dados_mulher)

# Exibição dos resultados
cat("Estatística de teste:", resultado_teste$statistic, "\n")
cat("Valor-p:", resultado_teste$p.value, "\n")
cat("Intervalo de confiança: (95%):", resultado_teste$conf.int, "\n")

# Media por sexo
#SEXO    IDADE
#1    1 10.30963    ou xA
#2    2 28.75315    ou xB
#F - hipotese nula = não há diferença entre a media de idades por sexo dos usuarios do topiramato
#V - hipotese alternativa = há diferença entre a media de idades por sexo dos usuarios do topiramato

media <- aggregate(IDADE ~ SEXO, data = topdataset, FUN = mean)

# Desvio padrao
dp <-aggregate(IDADE ~ SEXO, data = topdataset, FUN = sd)
#SEXO   IDADE
#1      1 18.97067    sA
#2      2 23.37076    sB

# Tamanho da amostra
tamanhoColHomem <- table(topdataset$SEXO)["1"] # É IGUAL A 31283    nA
tamanhoColMulher <- table(topdataset$SEXO)["2"] # É IGUAL A 44748   nB

#Grau de liberdade
gl = 76029

#Região critica
rc <- qt(0.025, gl)
#[1] -1.959995

t = (10.30963 - 28.75315)/sqrt(((18.97067^2/31283)+(23.37076^2/44748)))

#construção dos gráficos:

x <- seq(-130, 130, by = 1)

y <- dt(x, gl)

data <- data.frame(x = x, y = y)

ggplot(data, aes(x = x, y = y)) +
  geom_line() +
  geom_vline(xintercept = c(-critical_value, critical_value), linetype = "dashed", color = "red") +
  annotate("text", x = c(-critical_value-10, critical_value+10), y = 0.1, label = "RC", color = "red", vjust = -1.5) +
  geom_vline(xintercept = t_value, linetype = "dotted", color = "blue") +
  annotate("text", x = t_value, y = 0.05, label = "T", color = "blue", vjust = -2.5) +
  labs(
    title = "Teste Bilateral t de student",
    x = "", y = ""
  ) +
  theme_bw()

data <- data.frame(
  Sexo = c("Homens", "Mulheres"),
  MediaIdade = c(media$IDADE[1], media$IDADE[2])
)

# Create the column plot
ggplot(data, aes(x = Sexo, y = MediaIdade, fill = Sexo)) +
  geom_col() +
  labs(
    title = "Média das idades de usuários de topiramato (por Gênero)",
    x = "Gênero", y = "Média de Idade"
  ) +
  theme_bw()

