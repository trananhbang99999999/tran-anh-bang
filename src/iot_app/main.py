from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="IoT Ingestion Service", version="0.1.0")

class SensorData(BaseModel):
    device_id: str
    temperature: float
    humidity: float
    timestamp: str

@app.get("/health")
def health_check():
    return {"status": "healthy", "version": "0.1.0"}

@app.post("/ingest")
def ingest_data(data: SensorData):
    return {"status": "success", "message": "Data received", "device_id": data.device_id}