# pylint: disable=no-member

from logging.config import fileConfig

from alembic import context

from app import models  # pylint: disable=unused-import
from app.database import Base, engine


config = context.config

if config.config_file_name is not None:
    fileConfig(config.config_file_name)


# Alembic compares the database against this metadata.
target_metadata = Base.metadata


def run_migrations_offline() -> None:
    """
    Run migrations without opening a database connection.

    Mainly useful for generating SQL scripts.
    """

    context.configure(
        url=str(engine.url),
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
        render_as_batch=True,
        compare_type=True,
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online() -> None:
    """
    Run migrations against the actual database.
    """

    with engine.connect() as connection:
        context.configure(
            connection=connection,
            target_metadata=target_metadata,
            render_as_batch=True,
            compare_type=True,
        )

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
