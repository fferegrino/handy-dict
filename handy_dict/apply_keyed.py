# AUTOGENERATED! DO NOT EDIT! File to edit: 02_apply_keyed.ipynb (unless otherwise specified).

__all__ = ['apply_keyed']

# Cell
from copy import deepcopy
from .exceptions import ApplyKeyedException

# Cell
def apply_keyed(dictionary, keys, action, ignore_non_existing=True):
    dictionary_copy = deepcopy(dictionary)
    followed_path = []

    def apply_keyed_inplace(data, keys, path):
        if keys[0] not in data and ignore_non_existing:
            return

        path.append(keys[0])
        if len(keys) == 1:
            try:
                data[keys[0]] = action(data[keys[0]])
            except Exception as excp:
                raise ApplyKeyedException(
                    path=path, value=data.get(keys[0])
                ) from excp
        else:
            if isinstance(data[keys[0]], list):
                for idx, obj in enumerate(data[keys[0]]):
                    path.append(idx)
                    apply_keyed_inplace(obj, keys[1:], path)
                    path.pop()
            else:
                path.append(keys[0])
                apply_keyed_inplace(data[keys[0]], keys[1:], path)
        path.pop()

    apply_keyed_inplace(dictionary_copy, keys, followed_path)
    return dictionary_copy