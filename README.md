# Sunlight.jl

##### A Julia package for interfacing with the Sunlight Foundation's APIs

## Quick start

```julia

```


## Influence Explorer API

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
- `entity_id`: The transparencydata ID of the entity that you'd like to look up.
- `cycle`: Limit contribution totals to the given election cycle(s).


### Top Politicians
By contributions received, in dollars.

```julia
top_politicians(auth::String; limit = 16, cycle = nothing)

top_politicians(; auth = "", limit = 16, cycle = nothing)
```
- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `limit`: The number of top-politicians you'd like to get.
- `cycle`: Filter to get top-politicians by cycle(s).


### Top Contributors
The top contributing organizations to a given candidate. Giving is broken down into money given directly (by the organization's PAC), versus money given by individuals employed by or associated with the organization.

```julia
top_contributors(auth::String, entity_id; limit = nothing, cycle = nothing)

top_contributors(entity_id; auth = "", limit = nothing, cycle = nothing)
```
- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `entity_id`: The transparencydata ID of the entity that you'd like to look up.
- `limit`: The max number to return.
- `cycle`: Filter results by cycle(s).


### Top Industries
Top contributing industries, ranked by dollars given.

```julia
top_industries(auth::String, entity_id; limit = nothing, cycle = nothing, options...)

top_industries(entity_id; auth = "", limit = nothing, cycle = nothing)
```
- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `entity_id`: The transparencydata ID of the entity that you'd like to look up.
- `limit`: The max number to return.
- `cycle`: Filter results by cycle(s).


### Unknown Industries
Contribution count and total for a politician from unknown industries.

```julia
unknown_industries(auth::String, entity_id; cycle = nothing, options...)

unknown_industries(entity_id; auth = "", cycle = nothing)
```
- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `entity_id`: The transparencydata ID of the entity that you'd like to look up.
- `cycle`: Filter results by cycle(s).


### Top Sectors
Contribution totals by sector to a given politician. Sectors are codified by letter:
- `A`: Agribusiness
- `B`: Communications/Electronics
- `C`: Construction
- `D`: Defense
- `E`: Energy/Natural Resources
- `F`: Finance/Insurance/Real Estate
- `H`: Health
- `K`: Lawyers and Lobbyists
- `M`: Transportation
- `N`: Misc. Business
- `Q`: Ideology/Single Issue
- `P`: Labor
- `W`: Other
- `Y`: Unknown
- `Z`: Administrative Use

```julia
top_sectors(auth::String, entity_id; limit = nothing, cycle = nothing, options...)

top_sectors(entity_id; auth = "", limit = nothing, cycle = nothing)
```
- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `entity_id`: The transparencydata ID of the entity that you'd like to look up.
- `limit`: The max number to return.
- `cycle`: Filter results by cycle(s).









