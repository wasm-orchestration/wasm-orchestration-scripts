from contextlib import contextmanager
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from config import DATABASE_URI
from sqlalchemy.orm import scoped_session

engine = create_engine(DATABASE_URI)
session_factory = sessionmaker(bind=engine)
Session = scoped_session(session_factory)


@contextmanager
def session_scope():
    session = Session()
    try:
        yield session
        session.commit()
    except Exception as e:
        session.rollback()
        raise
    finally:
        session.close()
