
# http://sunlightlabs.github.io/datacommons
global INFLUENCE_EXPLORER_API = URI("http://transparencydata.com/")

# -------

abstract Entity

type Org <: Entity
    id
end

type Ind <: Entity
    id
end

type Pol <: Entity
    id
end

print(io::IO, e::Entity) = print(io, e.id)

# -------

macro sunlight_method__id_limit_cycle(method_name, entity_type, route_fn)
    quote
        function $(esc(symbol(method_name)))(auth::String, entity::($entity_type); limit = nothing, cycle = nothing, options...)
            route = $route_fn(entity)

            args = Dict()
            limit != nothing && (args["limit"] = limit)
            cycle != nothing && (args["cycle"] = cycle)

            sunlight_get(auth, INFLUENCE_EXPLORER_API, route, args; options...)
        end

        $(esc(symbol(method_name)))(entity; auth = "", options...) = $(esc(symbol(method_name)))(auth, entity; options...)
    end
end

# -------

macro sunlight_method__id_cycle(method_name, entity_type, route_fn)
    quote
        function $(esc(symbol(method_name)))(auth::String, entity::($entity_type); cycle = nothing, options...)
            route = $route_fn(entity)

            args = Dict()
            cycle != nothing && (args["cycle"] = cycle)

            sunlight_get(auth, INFLUENCE_EXPLORER_API, route, args; options...)
        end

        $(esc(symbol(method_name)))(entity; auth = "", options...) = $(esc(symbol(method_name)))(auth, entity; options...)
    end
end

# -------

macro sunlight_method__id(method_name, entity_type, route_fn)
    quote
        function $(esc(symbol(method_name)))(auth::String, entity::($entity_type); options...)
            route = $route_fn(entity)
            sunlight_get(auth, INFLUENCE_EXPLORER_API, route, Dict(); options...)
        end

        $(esc(symbol(method_name)))(entity; auth = "", options...) = $(esc(symbol(method_name)))(auth, entity; options...)
    end
end

# -------

party_breakdown(::String, ::String; options...) = error("'party_breakdown(entity_id::String)' is ambiguous; the method is defined for Organizations and Individuals. Try passing in `Org(entity_id)` or `Ind(entity_id)`")
party_breakdown(::String; options...) = error("'party_breakdown(entity_id::String)' is ambiguous; the method is defined for Organizations and Individuals. Try passing in `Org(entity_id)` or `Ind(entity_id)`")

lobbying_issues(::String, ::String; options...) = error("'lobbying_issues(entity_id::String)' is ambiguous; the method is defined for Organizations and Individuals. Try passing in `Org(entity_id)` or `Ind(entity_id)`")
lobbying_issues(::String; options...) = error("'lobbying_issues(entity_id::String)' is ambiguous; the method is defined for Organizations and Individuals. Try passing in `Org(entity_id)` or `Ind(entity_id)`")

fec_summary(::String, ::String; options...) = error("'fec_summary(entity_id::String)' is ambiguous; the method is defined for Organizations and Politicians. Try passing in `Org(entity_id)` or `Pol(entity_id)`")
fec_summary(::String, options...) = error("'fec_summary(entity_id::String)' is ambiguous; the method is defined for Organizations and Politicians. Try passing in `Org(entity_id)` or `Pol(entity_id)`")

# -------

@sunlight_method__id_limit_cycle "top_contributors" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/contributors.json"

@sunlight_method__id_limit_cycle "top_industries" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/contributors/industries.json"

@sunlight_method__id_cycle "unknown_industries" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/contributors/industries_unknown.json"

@sunlight_method__id_limit_cycle "top_sectors" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/contributors/sectors.json"

@sunlight_method__id_cycle "local_breakdown" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/contributors/local_breakdown.json"

@sunlight_method__id_cycle "contributor_breakdown" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/contributors/type_breakdown.json"

@sunlight_method__id "fec_summary" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/fec_summary.json"

@sunlight_method__id "fec_independent_expenditures" Union(String, Pol) id->"/api/1.0/aggregates/pol/$id/fec_indexp.json"

@sunlight_method__id_limit_cycle "top_recipient_organizations" Union(String, Ind) id->"/api/1.0/aggregates/indiv/$id/recipient_orgs.json"

@sunlight_method__id_limit_cycle "top_recipient_politicians" Union(String, Ind) id->"/api/1.0/aggregates/indiv/$id/recipient_pols.json"

@sunlight_method__id_cycle "party_breakdown" Union(String, Ind) id->"/api/1.0/aggregates/indiv/$id/recipients/party_breakdown.json"

@sunlight_method__id_limit_cycle "lobbying_registrants" Union(String, Ind) id->"/api/1.0/aggregates/indiv/$id/registrants.json"

@sunlight_method__id_limit_cycle "lobbying_clients" Union(String, Ind) id->"/api/1.0/aggregates/indiv/$id/clients.json"

@sunlight_method__id_limit_cycle "lobbying_issues" Union(String, Ind) id->"/api/1.0/aggregates/indiv/$id/issues.json"

@sunlight_method__id_limit_cycle "top_recipients" Union(String, Org) id->"/api/1.0/aggregates/org/$id/recipients.json"

@sunlight_method__id_limit_cycle "pac_recipients" Union(String, Org) id->"/api/1.0/aggregates/org/$id/recipient_pacs.json"

@sunlight_method__id_cycle "party_breakdown" Union(String, Org) id->"/api/1.0/aggregates/org/$id/recipients/party_breakdown.json"

@sunlight_method__id_cycle "state_federal_breakdown" Union(String, Org) id->"/api/1.0/aggregates/org/$id/recipients/level_breakdown.json"

@sunlight_method__id_limit_cycle "lobbing_registrants" Union(String, Org) id->"/api/1.0/aggregates/org/$id/registrants.json"

@sunlight_method__id_limit_cycle "lobbying_issues" Union(String, Org) id->"/api/1.0/aggregates/org/$id/issues.json"

@sunlight_method__id_limit_cycle "bills" Union(String, Org) id->"/api/1.0/aggregates/org/$id/bills.json"

@sunlight_method__id_limit_cycle "lobbyists" Union(String, Org) id->"/api/1.0/aggregates/org/$id/lobbyists.json"

@sunlight_method__id_limit_cycle "registrant_clients" Union(String, Org) id->"/api/1.0/aggregates/org/$id/registrant/clients.json"

@sunlight_method__id_limit_cycle "registrant_issues" Union(String, Org) id->"/api/1.0/aggregates/org/$id/registrant/issues.json"

@sunlight_method__id_limit_cycle "registrant_bills" Union(String, Org) id->"/api/1.0/aggregates/org/$id/registrant/bills.json"

@sunlight_method__id_limit_cycle "registrant_lobbyists" Union(String, Org) id->"/api/1.0/aggregates/org/$id/registrant/lobbyists.json"

@sunlight_method__id_limit_cycle "mentions_in_regulations" Union(String, Org) id->"/api/1.0/aggregates/org/$id/regulations_text.json"

@sunlight_method__id_limit_cycle "regulatory_comment_submissions" Union(String, Org) id->"/api/1.0/aggregates/org/$id/regulations_submitter.json"

@sunlight_method__id_limit_cycle "faca_memberships" Union(String, Org) id->"/api/1.0/aggregates/org/$id/faca.json"

@sunlight_method__id "fec_summary" Union(String, Org) id->"/api/1.0/aggregates/org/$id/fec_summary.json"

@sunlight_method__id_limit_cycle "top_industry_organizations" String id->"/api/1.0/aggregates/industry/$id/orgs.json"

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

function top_individuals(auth::String; limit = 16, cycle = nothing, options...)
    args = Dict()
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/indivs/top_$limit.json", args; options...)
end

top_individuals(; auth = "", options...) = top_individuals(auth; options...)

# -------

function top_organizations(auth::String; limit = 16, cycle = nothing, options...)
    args = Dict()
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/orgs/top_$limit.json", args; options...)
end

top_organizations(; auth = "", options...) = top_organizations(auth; options...)

# -------

function top_industries(auth::String; limit = 16, cycle = nothing, options...)
    args = Dict()
    cycle != nothing && (args["cycle"] = cycle)

    sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/industries/top_$limit.json", args; options...)
end

top_industries(; auth = "", options...) = top_industries(auth; options...)
