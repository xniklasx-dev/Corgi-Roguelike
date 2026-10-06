from datetime import datetime

from pydantic import BaseModel, ConfigDict, Field


class GameSaveCreate(BaseModel):
    player_name: str = Field(
        min_length=1,
        max_length=40,
    )

    floor: int = Field(
        default=1,
        ge=1,
    )

    hp: int = Field(
        default=100,
        ge=0,
    )


class GameSaveRead(GameSaveCreate):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created_at: datetime
