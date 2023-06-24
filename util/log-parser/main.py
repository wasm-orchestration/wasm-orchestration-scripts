import re
import time
import iso8601
import logging
from models import K8sPodScheduleInfo

import DBSession

TEST_BATCH = 'testing01'

r_expression = re.compile(
    '.*===K3S-CUSTOM-998===.*reason="(?P<event>\w+)".*\sobject="(?P<object>.*)"\stime="(?P<timestamp>.*?)"')


def read_line_by_line(file_handle):
    while True:
        line = file_handle.readline()
        if not line or not line.endswith('\n'):
            time.sleep(0.1)
            continue
        yield line


def parse_line(line):
    contents = r_expression.search(line)
    if contents is not None:
        event = contents.group('event')
        namespace, pod_name = contents.group('object').split('/')
        timestamp = contents.group('timestamp')
        timestamp = iso8601.parse_date(timestamp)
        if event == 'SuccessfulCreate' or event == 'Started':
            logging.info(f'event={event} namespace={namespace} pod={pod_name} timestamp={timestamp}')
            with DBSession.session_scope() as s:
                entry, created = K8sPodScheduleInfo.get_or_create(s,
                                                                  namespace=namespace,
                                                                  pod_name=pod_name,
                                                                  test_batch=TEST_BATCH)
                if created:
                    entry.set_time_created(s, timestamp)
                else:
                    entry.set_time_started(s, timestamp)


if __name__ == '__main__':
    print('Hello')
    log_file = open('/var/log/syslog', 'r')
    log_lines = read_line_by_line(log_file)
    for log_line in log_lines:
        parse_line(log_line)
