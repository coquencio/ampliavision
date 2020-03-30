import json
import datetime


def __json_defaults(o):
    if isinstance(o, (datetime.datetime, datetime.date)):
        return o.strftime("%Y-%m-%d")


def serialize_data_set(data_set, key=None):
    if key is None:
        return json.dumps(data_set, default=__json_defaults)

    to_serialize = {key: data_set}
    return json.dumps(to_serialize, default=__json_defaults)

