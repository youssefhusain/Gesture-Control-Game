from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_predict():
    test_landmarks = [[0.1, 0.2, 0.3]] * 21  
    response = client.post("/predict", json={"landmarks": test_landmarks})
    assert response.status_code == 200
    assert response.json()["direction"] in ["up", "down", "left", "right"]