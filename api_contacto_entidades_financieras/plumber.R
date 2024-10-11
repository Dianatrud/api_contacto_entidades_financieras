
#Librerias
library(plumber)
library(RSocrata)
library(tidyverse)
library(stringr)

#* @apiTitle Plumber Contacto Entidades Financiera
#* @apiDescription Plumber Información del nombre, teléfono y correo electrónico de la información de bancos y entidades financieras extraída del registro público mercantil que administra la Cámara de Comercio de Barranquilla, durante los años 2021 y 2020.

#* Ingresa el nombre de la entidad que servira de base para busqueda de registro
#* @get /Nombre_Entidad
function(entidad) {


  entidad <- str_to_lower(entidad)
  
  data_contacto <- read.socrata("https://www.datos.gov.co/resource/35qi-guj5.json")  %>%  as_tibble()
  
  respuesta <- data_contacto %>% 
    mutate(nombre = str_to_lower(nombre)) %>% 
    filter(str_detect(nombre, entidad)) %>% 
    collect()

  
  return(respuesta)
    
}



