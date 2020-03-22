import json


class JsonHelper:
    @staticmethod
    def serialize_data_set(data_set, key=None):
        if key is None:
            return json.dumps(data_set)

        to_serialize = {key: data_set}
        return json.dumps(to_serialize)
