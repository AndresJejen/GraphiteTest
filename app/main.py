from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .utils import execute_query

app = FastAPI()


@app.get("/tfidf")
def tfidf(url: str, limit: int):
    records = execute_query(url, limit)
    return {"terms": records}
