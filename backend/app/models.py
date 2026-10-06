from datetime import datetime, timezone

from sqlalchemy import DateTime, String
from sqlalchemy.orm import Mapped, mapped_column

from .database import Base


class GameSave(Base):
    __tablename__ = "game_saves"

    id: Mapped[int] = mapped_column(primary_key=True)

    player_name: Mapped[str] = mapped_column(
        String(40),
        index=True,
    )

    floor: Mapped[int] = mapped_column(default=1)

    hp: Mapped[int] = mapped_column(default=100)

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
    )
