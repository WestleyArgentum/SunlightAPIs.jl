
function handle_error(r::Response)
    r.status != 200 && throw(r)
end

# -------

sunlight_get(auth::String, api::URI, path, args; options...) = sunlight_get(auth, URI(api; path = path), args; options...)

function sunlight_get(auth::String, route::URI, args; query = Dict(), debug = false, options...)
    if auth == nothing || isempty(auth)
        error("Sunlight Foundation API key required! Get one here: http://sunlightfoundation.com/api")
    end

    query["apikey"] = auth
    args != {} && merge!(query, args)

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
