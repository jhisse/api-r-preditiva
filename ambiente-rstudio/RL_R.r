#load required library
library(mlbench)
#load Pima Indian Diabetes dataset
data('PimaIndiansDiabetes')

head(PimaIndiansDiabetes,10)

dim(PimaIndiansDiabetes)

library(caret) #this package has the createDataPartition function

set.seed(123) #randomization`
#creating indices
trainIndex <- createDataPartition(PimaIndiansDiabetes$diabetes,p=0.8,list=FALSE)
#splitting data into training/testing data using the trainIndex object
trainset <- PimaIndiansDiabetes[trainIndex,] #training data (80% of data)
testset <- PimaIndiansDiabetes[-trainIndex,] #testing data (20% of data)

dim(trainset)

dim(testset)

#get column index of predicted variable in dataset
typeColNum <- grep('diabetes',names(PimaIndiansDiabetes))

typeColNum

#build model
glm_model <- glm(diabetes~.,data = trainset, family = binomial)

summary(glm_model)

#predict probabilities on testset
glm_prob <- predict.glm(glm_model,testset[,-typeColNum],type='response')

head(glm_prob, 10)

#which classes do these probabilities refer to? What are 1 and 0?
contrasts(PimaIndiansDiabetes$diabetes)

#make predictions
##…first create vector to hold predictions (we know 0 refers to neg now)
glm_predict <- rep('neg',nrow(testset))
glm_predict[glm_prob>.5] <- 'pos'

head(glm_predict, 10)

#confusion matrix
table(pred=glm_predict,true=testset$diabetes)

#accuracy
mean(glm_predict==testset$diabetes)

saveRDS(glm_model, "./glm_model.rds")

