import keras.layers as Layers
import keras.optimizers as Optimizers
from keras import Sequential
import numpy as np
import random
from tensorflow import keras
from tensorflow.keras import layers


def createNewSeqModel():
    model = Sequential()
    weights = 'random_uniform'
    model.add(Layers.Dense(50, input_shape=(1,),
    activation='relu', kernel_initializer=weights))
    model.add(Layers.Dense(50, activation='relu',
    kernel_initializer=weights))
    model.add(Layers.Dense(1, activation='linear',
    kernel_initializer=weights))
    opt = keras.optimizers.Adam(learning_rate=0.01)
    model.compile(optimizer=opt, loss='mse')
    return model
    
def createTrainingData(amount, maxNum, func):
    inData = [random.randint(0, maxNum) for i in range(amount)]
    results = [func(d) for d in inData]
    return inData, results
    
def predictWithModel(model, samples):
    return model.predict(np.array(samples))

def trainModel(model, samples, labels, epochs, batchSize):
    model.fit(np.array(samples), np.array(labels),
        epochs=epochs, batch_size=batchSize)
        
func = lambda x: x*3
samples, labels = createTrainingData(10000, 1000, func)
evalSamples, evalLabels = createTrainingData(5, 100, func)
print(evalSamples)
print(evalLabels)


myNet = createNewSeqModel()
#Test model on evaluation data
evalPredictions = predictWithModel(myNet, evalSamples)
print("Predictions:\n", evalPredictions)
print("Labels:\n", evalLabels)

#Fit the model to our training data
trainModel(myNet, samples, labels, 100, 100)
#Test model on evaluation data
evalPredictions = predictWithModel(myNet, evalSamples)
print("Predictions:\n", evalPredictions)
print("Labels:\n", evalLabels)

