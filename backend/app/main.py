from fastapi import FastAPI

from .routers import health, saves


app = FastAPI(
    title="MIGHTYCorgi API",
    version="0.1.0",
)


app.include_router(
    health.router,
    prefix="/api",
)

app.include_router(
    saves.router,
    prefix="/api",
)
