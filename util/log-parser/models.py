from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, DateTime, BigInteger, UniqueConstraint
from sqlalchemy.sql import func

Base = declarative_base()


class K8sPodScheduleInfo(Base):
    __tablename__ = 'k8s_pods_schedule_info'
    id = Column(BigInteger, primary_key=True, autoincrement=True)
    namespace = Column(String, index=True)
    pod_name = Column(String, nullable=False, index=True)
    time_scheduled = Column(DateTime(timezone=True))
    time_ready = Column(DateTime(timezone=True))
    test_batch = Column(String, index=True)
    date_added = Column(DateTime(timezone=True), server_default=func.now())
    __table_args__ = (UniqueConstraint('namespace', 'pod_name'),)

    @classmethod
    def get_or_create(cls, session, **kwargs):
        instance = session.query(cls).filter_by(namespace=kwargs['namespace'], pod_name=kwargs['pod_name']).first()
        if instance:
            return instance, False
        else:
            instance = cls(**kwargs)
            session.add(instance)
            # session.commit()
            return instance, True

    def set_time_created(self, session, timestamp):
        self.time_scheduled = timestamp
        session.commit()
        return self

    def set_time_started(self, session, timestamp):
        self.time_ready = timestamp
        session.commit()
        return self
