import requests
import json

url = "https://diabetes-classification-app-wew1.onrender.com/predict"

features = {
    "HighBP": 1,
    "HighChol": 1,
    "CholCheck": 1,
    "BMI": 30,
    "Smoker": 0,
    "Stroke": 0,
    "HeartDiseaseorAttack": 1,
    "PhysActivity": 0,
    "Fruits": 1,
    "Veggies": 1,
    "HvyAlcoholConsump": 0,
    "AnyHealthcare": 1,
    "NoDocbcCost": 0,
    "GenHlth": 5,
    "MentHlth": 30,
    "PhysHlth": 30,
    "DiffWalk": 1,
    "Sex": 0,
    "Age": 9,
    "Education": 5,
    "Income": 1
}

try:
    response = requests.post(url, json=features)
    print(f"Status Code: {response.status_code}")
    print(f"Response Body: {response.text}")
except Exception as e:
    print(f"Error: {e}")
