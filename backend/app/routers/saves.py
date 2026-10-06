from fastapi import APIRouter, Depends, status
from sqlalchemy import select
from sqlalchemy.orm import Session

from ..database import get_db
from ..models import GameSave
from ..schemas import GameSaveCreate, GameSaveRead


router = APIRouter(
    prefix="/saves",
    tags=["saves"],
)


@router.post(
    "",
    response_model=GameSaveRead,
    status_code=status.HTTP_201_CREATED,
)
def create_save(
    payload: GameSaveCreate,
    db: Session = Depends(get_db),
) -> GameSave:
    save = GameSave(
        player_name=payload.player_name,
        floor=payload.floor,
        hp=payload.hp,
    )

    db.add(save)
    db.commit()
    db.refresh(save)

    return save


@router.get(
    "",
    response_model=list[GameSaveRead],
)
def get_saves(
    db: Session = Depends(get_db),
) -> list[GameSave]:
    statement = (
        select(GameSave)
        .order_by(GameSave.id.desc())
    )

    return list(
        db.scalars(statement).all()
    )
