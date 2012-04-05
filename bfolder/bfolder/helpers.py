from datetime import datetime

def time_pretify(string):
    dt = datetime.utcfromtimestamp(string)
    day = '0' + str(dt.day) if dt.month < 10 else str(dt.day)
    month = '0' + str(dt.month) if dt.month < 10 else str(dt.month)
    return '%s.%s.%d %d:%d' %(day, month, dt.year, dt.hour, dt.minute)