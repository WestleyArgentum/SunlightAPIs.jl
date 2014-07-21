
sunlight_get(auth::String, api::URI, path, args; options...) = sunlight_get(auth, URI(api; path = path), args; options...)

function sunlight_get(auth::String, route::URI, args; query = Dict(), options...)
    if auth == nothing || isempty(auth)
        error("Sunlight Foundation API key required! Get one here: http://sunlightfoundation.com/api")
    end

    query["apikey"] = auth
    merge!(query, args)

    r = get(route; query = query, options...)

    handle_error(r)

    JSON.parse(r.data)
end

# -------

function handle_error(resp::Response)

end
