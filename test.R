
library(curl)
library(plotly)
library(dplyr)
library(corrplot)


insurance_data<-read.csv(paste0(getwd(), "/insurance.csv"))

colnames(insurance_data)<-c("kilometros", "municipio", "bono","modelo", "asegurados", "reclamaciones", "pagos")

#1.
#Histograma de cada una de las variables



plot_ly(x = ~insurance_data, type = "histogram")

plot_ly(x=~insurance_data$kilometros, type="histogram", histnorm="probability") %>%
  layout(title="Histograma de Kilometros", xaxis=list(title="Kilometros"), yaxis=list(title="observaciones"))


plot_ly(x=~insurance_data$municipio, type="histogram", histnorm="probability") %>%
  layout(title="Histograma de Municipio", xaxis=list(title="Municipio"), yaxis=list(title="observaciones"))

plot_ly(x=~insurance_data$bono, type="histogram", histnorm="probability") %>%
  layout(title="Histograma de Bono", xaxis=list(title="Bono"), yaxis=list(title="observaciones"))

plot_ly(x=~insurance_data$modelo, type="histogram", histnorm="probability")%>%
  layout(title="Histograma de Modelo", xaxis=list(title="Modelo"), yaxis=list(title="observaciones"))

plot_ly(x=~insurance_data$asegurados, type="histogram", histnorm="probability")%>%
  layout(title="Histograma de Asegurados", xaxis=list(title="Asegurados"), yaxis=list(title="observaciones"))

plot_ly(x=~insurance_data$reclamaciones, type="histogram", histnorm="probability")%>%
  layout(title="Histograma de Reclamacion", xaxis=list(title="Reclamacion"), yaxis=list(title="observaciones"))

plot_ly(x=~insurance_data$pagos, type="histogram", histnorm="probability")%>%
  layout(title="Histograma de Pagos", xaxis=list(title="Pagos"), yaxis=list(title="observaciones"))


#2. Crear categorías en función al número de reclamaciones, severidad, riesgo, etc.

## Categoria Kilometros

a) Suma asegurada por kilometros


insurance_data_kilometros<-insurance_data %>% group_by(kilometros)

insurance_data_kilometros<-insurance_data %>% group_by(kilometros) %>% 
  summarise(sum_asegurados=sum(asegurados), sum_reclamaciones=sum(reclamaciones),
            sum_pagos=sum(pagos))

insurance_data_kilometros<-data.frame(insurance_data_kilometros) 

plot_ly(insurance_data_kilometros, x=~kilometros, y=~sum_asegurados, type='bar', name='Suma Asegurados por Kilometros')
plot_ly(insurance_data_kilometros, x=~kilometros, y=~sum_reclamaciones, type='bar', name='Suma Asegurados por Kilometros')
plot_ly(insurance_data_kilometros, x=~kilometros, y=~sum_pagos, type='bar', name='Suma Asegurados por Kilometros')


b) Suma asegurada por municipio

insurance_data_municipio<-insurance_data %>% group_by(municipio) %>% 
  summarise(sum_asegurados=sum(asegurados), sum_reclamaciones=sum(reclamaciones),
            sum_pagos=sum(pagos))

insurance_data_municipio<-data.frame(insurance_data_municipio)

plot_ly(insurance_data_municipio, x=~municipio, y=~sum_asegurados, type='bar', name='Suma Asegurados por municipio')
plot_ly(insurance_data_municipio, x=~municipio, y=~sum_reclamaciones, type='bar', name='Suma Asegurados por municipio')
plot_ly(insurance_data_municipio, x=~municipio, y=~sum_pagos, type='bar', name='Suma Asegurados por municipio')

c) Suma asegurada por modelo

insurance_data_modelo<-insurance_data %>% group_by(modelo) %>% 
  summarise(sum_asegurados=sum(asegurados), sum_reclamaciones=sum(reclamaciones),
            sum_pagos=sum(pagos))

insurance_data_modelo<-data.frame(insurance_data_modelo)

plot_ly(insurance_data_modelo, x=~modelo, y=~sum_asegurados, type='bar', name='Suma Asegurados por modelo')
plot_ly(insurance_data_modelo, x=~modelo, y=~sum_reclamaciones, type='bar', name='Suma Reclamaciones por modelo')
plot_ly(insurance_data_modelo, x=~modelo, y=~sum_pagos, type='bar', name='Suma Pagos por modelo')


#3El valor total de pagos es una variable fundamental por lo que el Comité está interesados en saber
#si esta es una consecuencia de el número de reclamaciones y del número de años de la cartera

## a) corr graph all variables

M<-cor(insurance_data)
head(round(M,2))
corrplot(M, method="number")

## b) Scatterplot - reclamaciones

plot_ly(data = insurance_data, x = ~reclamaciones, y = ~pagos)


## c) Scatterplot  - asegurados
plot_ly(data = insurance_data, x = ~asegurados, y = ~pagos)



#4 El Comité quiere encontrar las variables que impactan que el pago aumenta o disminuya. 
#Por lo tanto es necesario revisar si este es consecuencia de variables como ubicación, distancia, etc.
## es necesario realizar una regresion para encontrar que variables son las mas relevantes (prueba p).

## Visualizar pagos y promedios de pago por:
## a) Zona
## b) Modelo
## c) Bono


lineModel <- lm(pagos ~ reclamaciones, data = insurance_data)
summary(lineModel) 

insurance_data %>% 
  plot_ly(x = ~reclamaciones) %>% 
  add_markers(y = ~pagos) %>% 
  add_lines(x = ~reclamaciones, y = fitted(lineModel))


lineModel <- lm(pagos ~ asegurados, data = insurance_data)
summary(lineModel) 

insurance_data %>% 
  plot_ly(x = ~asegurados) %>% 
  add_markers(y = ~pagos) %>% 
  add_lines(x = ~asegurados, y = fitted(lineModel))


lineModel <- lm(pagos ~ ., data = insurance_data)
summary(lineModel) 

#5El Comité quiere decidir si se deberían cobrar tarifas especiales dependiendo de factores
#como ubicación, cantidad asegurada, kilómetros, bonos etc.


pago_especial_municipio<-insurance_data %>% group_by(municipio) %>% 
  summarise(pago_especial=sum(pagos)/sum(asegurados))

plot_ly(pago_especial_municipio, x=~municipio, y=~pago_especial, type='bar', name='pago_especial_municipio')

pago_especial_kilometros<-insurance_data %>% group_by(kilometros) %>% 
  summarise(pago_especial=sum(pagos)/sum(asegurados))

plot_ly(pago_especial_kilometros, x=~kilometros, y=~pago_especial, type='bar', name='pago_especial_kilometros')


pago_especial_bono<-insurance_data %>% g.roup_by(bono) %>% 
  summarise(pago_especial=sum(pagos)/sum(asegurados))

plot_ly(pago_especial_bono, x=~bono, y=~pago_especial, type='bar', name='pago_especial_bono')


md <- lm(insurance_data$reclamaciones ~ insurance_data$kilometros + insurance_data$municipio + insurance_data$bono + insurance_data$modelo + insurance_data$asegurados) 

summary(md) #test