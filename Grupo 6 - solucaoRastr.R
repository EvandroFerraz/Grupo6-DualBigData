mean(topdataset$QTD_UNIDADE_FARMACOTECNICA)
#964.8102

topdataset$COMPRA_GRANDE <- ifelse(topdataset$QTD_UNIDADE_FARMACOTECNICA < 1000, 0, 1)

#Inicialmente, ao utilizarmos o comando acima #mean(topdataset$QTD_UNIDADE_FARMACOTECNICA)o programa nos forneceu uma média que
# apresenta um valor aproximado para a definição de uma venda que pode ser considerada alta
# como a media é 964.8102, foi estabelecido que quando uma venda for realizada e corresponder a quantidade farmacotécnica  1000.00
# ou acima desse valor é uma compra grande e que possívelmente este cliente não irá realizar outra compra tão cedo.
# Sendo assim, vamos necessitar de captação de outros clientes para suprir tal demanda.
# Finalmente, como proposta de rastreabilidade iremos criar outra coluna dentro o dataset que será responsável por atribuir um valor
# númerico entre 0 (corresponde a uma compra menor do que a média, quer dizer que provavelmente o cliente irá retornar a comprar 
# em breve) e 1 para compras consideradas acima da média estabelecida (cliente provavelmente irá demorar mais tempo para comprar).
#Ainda, tais atribuições foram feitas através do comando topdataset$COMPRA_GRANDE <- ifelse(topdataset$QTD_UNIDADE_FARMACOTECNICA < 1000, 0, 1).

