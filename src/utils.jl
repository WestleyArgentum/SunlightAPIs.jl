
function handle_error(resp::Response)

end

# -------

sunlight_get(auth::String, api::URI, path, args; options...) = sunlight_get(auth, URI(api; path = path), args; options...)

function sunlight_get(auth::String, route::URI, args; query = Dict(), debug = false, options...)
    if auth == nothing || isempty(auth)
        error("Sunlight Foundation API key required! Get one here: http://sunlightfoundation.com/api")
    end

    query["apikey"] = auth
    merge!(query, args)

    if debug
        println("URI: ", route)
        println("Params: ", query)
    end

    r = get(route; query = query, options...)

    if debug
        println(r)
    end

    handle_error(r)

    JSON.parse(r.data)
end

# -------

macro sunlight_method__id_limit_cycle(method_name, method_route)
    quote
        function $(esc(symbol(method_name)))(auth::String, entity_id; limit = nothing, cycle = nothing, options...)
            method_route = $method_route

            args = Dict()
            limit != nothing && (args["limit"] = limit)
            cycle != nothing && (args["cycle"] = cycle)

            sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pol/$entity_id/$method_route", args; options...)
        end

        $(esc(symbol(method_name)))(entity_id; auth = "", options...) = $(esc(symbol(method_name)))(auth, entity_id; options...)
    end
end

macro sunlight_method__id_cycle(method_name, method_route)
    quote
        function $(esc(symbol(method_name)))(auth::String, entity_id; cycle = nothing, options...)
            method_route = $method_route

            args = Dict()
            cycle != nothing && (args["cycle"] = cycle)

            sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pol/$entity_id/$method_route", args; options...)
        end

        $(esc(symbol(method_name)))(entity_id; auth = "", options...) = $(esc(symbol(method_name)))(auth, entity_id; options...)
    end
end

macro sunlight_method__id(method_name, method_route)
    quote
        function $(esc(symbol(method_name)))(auth::String, entity_id; options...)
            method_route = $method_route
            sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/aggregates/pol/$entity_id/$method_route", Dict(); options...)
        end

        $(esc(symbol(method_name)))(entity_id; auth = "", options...) = $(esc(symbol(method_name)))(auth, entity_id; options...)
    end
end
