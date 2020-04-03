# Handy Dict
> Summary description here.


This file will become your README and also the index of your documentation.

## Install

`pip install handy-dict`

## How to use

### Let's start with a dictionary

```python
pikachu = {
  "name": "pikachu",
  "moves": [
    {
      "move": {
        "name": "mega-punch",
        "url": "https://pokeapi.co/api/v2/move/5/"
      }
    },
    {
      "move": {
        "name": "pay-day",
        "url": "https://pokeapi.co/api/v2/move/6/"
      }
    },
    {
      "move": {
        "name": "thunder-punch",
        "url": "https://pokeapi.co/api/v2/move/9/"
      }
    }
  ],
  "stats": [
    {
      "base_stat": 90,
      "effort": 2,
      "stat": {
        "name": "speed",
        "url": "https://pokeapi.co/api/v2/stat/6/"
      }
    },
    {
      "base_stat": 50,
      "effort": 0,
      "stat": {
        "name": "special-defense",
        "url": "https://pokeapi.co/api/v2/stat/5/"
      }
    }
  ]
}
```

With *handy-dict* you can apply a function to the keys inside a dictionary, say you want to take `name` out of `stat`,  go from something like this:

```json
{
  "base_stat": 50,
  "effort": 0,
  "stat": {
    "name": "special-defense",
    "url": "https://pokeapi.co/api/v2/stat/5/"
  }
}
```

to this:

```json
{
  "base_stat": 50,
  "name": "special-defense"
}
```

```python
from handy_dict import apply_keyed
```

```python
def transform_stat(stat_array):
    return [{
        "base_stat": stat["base_stat"],
        "name": stat["stat"]["name"]
    } for stat in stat_array]
```

```python
modified_pikachu = apply_keyed(pikachu,["stats"], transform_stat)
modified_pikachu["stats"]
```




    [{'base_stat': 90, 'name': 'speed'},
     {'base_stat': 50, 'name': 'special-defense'},
     {'base_stat': 50, 'name': 'special-attack'},
     {'base_stat': 40, 'name': 'defense'}]


