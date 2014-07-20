
sunlight_get(auth::String, api::URI, path, args; options...) = sunlight_get(auth, URI(api; path = path), args; options...)

function sunlight_get(auth::String, route::URI, args; query = Dict(), options...)
    query["apikey"] = auth
    merge!(query, args)

    r = get(route; query = query, options...)

    handle_error(r)

    JSON.parse(r.data)
end

# -------

function handle_error(resp::Response)

end
