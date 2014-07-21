# Sunlight.jl

##### A Julia package for interfacing with the Sunlight Foundation's APIs

## Quick start

```julia

```


## API

### Entity Search

Search for politicians, individuals, organizations or industries with a given name.

```julia
entity_search(auth::String, search_str; entity_type = nothing)

entity_search(search_str; auth = "", entity_type = nothing)
```

- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `search`: The name to search for. Spaces should be URL encoded or represented as a plus sign (+). There are no logical operators and no grouping.
- `type`:   Filter results to a particular type of entity.
    * `"politician"`
    * `"organization"`
    * `"individual"`
    * `"industry"`


### Entity Info

Get general information about the given entity.

```julia
entity_info(auth::String, entity_id; cycle = nothing)

entity_info(entity_id; auth = "", cycle = nothing)
```

- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `entity_id`: The unique ID of the entity that you'd like to look up.
- `cycle`: Limit contribution totals to the given election cycle(s).
