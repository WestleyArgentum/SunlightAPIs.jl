
# For more information, see:  http://sunlightlabs.github.io/datacommons

global INFLUENCE_EXPLORER_API = URI("http://transparencydata.com/")

# -------

function entity_search(auth::String, search_str; entity_type = nothing, options...)
    args = {
        "search" => search_str
    }
    entity_type != nothing && (args["type"] = entity_type)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/entities.json", args; options...)
end

entity_search(search_str; auth = "", options...) = entity_search(auth, search_str; options...)

# -------

function entity_info(auth::String, entity_id; cycle = nothing, options...)
    args = Dict()
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/entities/$entity_id.json", args; options...)
end

entity_info(entity_id; auth = "", options...) = entity_info(auth, entity_id; options...)

# -------

function top_politicians(auth::String; limit = 16, cycle = nothing, options...)
    args = Dict()
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pols/top_$limit.json", args; options...)
end

top_politicians(; auth = "", options...) = top_politicians(auth; options...)

# -------

function top_contributors(auth::String, entity_id; limit = nothing, cycle = nothing, options...)
    args = Dict()
    limit != nothing && (args["limit"] = limit)
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pol/$entity_id/contributors.json", args; options...)
end

top_contributors(entity_id; auth = "", options...) = top_contributors(auth, entity_id; options...)

# -------

function top_industries(auth::String, entity_id; limit = nothing, cycle = nothing, options...)
    args = Dict()
    limit != nothing && (args["limit"] = limit)
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pol/$entity_id/contributors/industries.json", args; options...)
end

top_industries(entity_id; auth = "", options...) = top_industries(auth, entity_id; options...)

# -------

function unknown_industries(auth::String, entity_id; cycle = nothing, options...)
    args = Dict()
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pol/$entity_id/contributors/industries_unknown.json", args; options...)
end

unknown_industries(entity_id; auth = "", options...) = unknown_industries(auth, entity_id; options...)

# -------

function top_sectors(auth::String, entity_id; limit = nothing, cycle = nothing, options...)
    args = Dict()
    limit != nothing && (args["limit"] = limit)
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pol/$entity_id/contributors/sectors.json", args; options...)
end

top_sectors(entity_id; auth = "", options...) = top_sectors(auth, entity_id; options...)

# -------












