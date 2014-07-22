
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

@sunlight_method__id_limit_cycle "top_contributors" "contributors.json"

@sunlight_method__id_limit_cycle "top_industries" "contributors/industries.json"

@sunlight_method__id_cycle "unknown_industries" "contributors/industries_unknown.json"

@sunlight_method__id_limit_cycle "top_sectors" "contributors/sectors.json"

@sunlight_method__id_cycle "local_breakdown" "contributors/local_breakdown.json"

@sunlight_method__id_limit_cycle "contributor_breakdown" "contributors/type_breakdown.json"

@sunlight_method__id_limit_cycle "fec_summary" "fec_summary.json"

@sunlight_method__id "fec_independent_expenditures" "fec_indexp.json"

# -------
