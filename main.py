from fastapi import FastAPI
import joblib
import numpy as np

app = FastAPI()

model = joblib.load("model.pkl")  # ضع اسم نموذجك

@app.get("/")
def home():
    return {"status": "running"}

@app.post("/predict")
def predict(features: dict):
    data = np.array([list(features.values())])
    pred = model.predict(data)
    return {"prediction": float(pred[0])}
