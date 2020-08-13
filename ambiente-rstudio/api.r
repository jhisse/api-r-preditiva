library(plumber)
library(caret)

glm_model <- readRDS("./glm_model.rds")

#* @param pregnant:numeric quantidade de vezes que esteve grávida
#* @param glucose:numeric nível de glicose após 2 horas do teste de intolerância à glicose
#* @param pressure:numeric pressão arterial diastólica (mmHg)
#* @param triceps:numeric espessura da dobra de pele do tríceps (mm)
#* @param insulin:numeric quantidade de insulina após 2 horas do teste de intolerância à glicose
#* @param mass:numeric índice de massa corporal (IMC = peso(kg)/(altura(m)*altura(m)))
#* @param pedigree:numeric função que retorna um score com base no histórico familiar
#* @param age:numeric idade (anos)
#* @post /predict
#* @serializer unboxedJSON
function(pregnant, glucose, pressure, triceps, insulin, mass, pedigree, age)
{
  df <- data.frame(
    pregnant = as.numeric(pregnant), 
    glucose = as.numeric(glucose), 
    pressure = as.numeric(pressure), 
    triceps = as.numeric(triceps), 
    insulin = as.numeric(insulin), 
    mass = as.numeric(mass), 
    pedigree = as.numeric(pedigree), 
    age = as.numeric(age)
  )
  output <- list(prob = predict.glm(glm_model, df, type='response'))
  return(output)
}
