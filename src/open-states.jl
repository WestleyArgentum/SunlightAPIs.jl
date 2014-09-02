
# http://sunlightlabs.github.io/datacommons
global OPEN_STATES_API = URI("http://openstates.org/")


# -------

function metadata_overview(auth::String, options...)
    args = Dict()

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/metadata/", args; options...)
end

#get_metadata_overview(auth = "", options...) = get_metadata_overview(auth, options...)

# -------

function state_metadata(auth::String, state, options...)
    args = Dict()

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/metadata/$state/", args; options...)
end

#get_state_metadata(state_str; auth = "", options...) = get_state_metadata(auth, state_str; options...)

# -------

function bill_search(auth::String; state=nothing, chamber=nothing, bill_id=nothing, bill_id__in=nothing, 
                    q=nothing, search_window=nothing, updated_since=nothing, sponsor_id=nothing, 
                    subject=nothing, bill_type=nothing, sort=nothing, page=nothing, per_page=nothing, options...)
    args = Dict()
    state != nothing && (args["state"] = state)
    chamber != nothing && (args["chamber"] = chamber)
    bill_id != nothing && (args["bill_id"] = bill_id)
    bill_id__in != nothing && (args["bill_id__in"] = bill_id__in)
    q != nothing && (args["q"] = q)
    search_window != nothing && (args["search_window"] = search_window)
    updated_since != nothing && (args["updated_since"] = updated_since)
    sponsor_id != nothing && (args["sponsor_id"] = sponsor_id)
    subject != nothing && (args["subject"] = subject)
    bill_type != nothing && (args["type"] = bill_type)
    sort != nothing && (args["sort"] = sort)
    page != nothing && (args["page"] = page)
    per_page != nothing && (args["per_page"] = per_page)

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/bills/", args; options...)
end

#bill_search(; auth = "", options...) = bill_search(auth, entity_id; options...)

# -------

function bill_detail(auth::String; open_states_id=nothing, state=nothing, bill_id=nothing, cycle = nothing, options...)
    args = Dict()

    if open_states_id !=nothing
        sunlight_get(auth, OPEN_STATES_API, "/api/v1/bills/$open_states_id/", args; options...)
    else
        sunlight_get(auth, OPEN_STATES_API, "/api/v1/bills/$state/$cycle/$bill_id/", args; options...)
    end
end

#bill_search(entity_id; auth = "", options...) = bill_search(auth, entity_id; options...)


# -------

function legislator_search(auth::String; state=nothing, first_name=nothing, last_name=nothing, chamber=nothing, 
                    active=nothing, term=nothing, district=nothing, party=nothing, options...)
    args = Dict()
    state != nothing && (args["state"] = state)
    first_name != nothing && (args["first_name"] = first_name)
    last_name != nothing && (args["last_name"] = last_name)
    chamber != nothing && (args["chamber"] = chamber)
    active != nothing && (args["active"] = active)
    term != nothing && (args["term"] = term)
    district != nothing && (args["district"] = district)
    party != nothing && (args["party"] = party)

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/legislators/", args; options...)
end

# -------

function legislator_detail(auth::String, leg_id=nothing, options...)
    args = Dict()

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/legislators/$leg_id/", args; options...)
end

# -------

function geo_lookup(auth::String; lat=nothing, long=nothing, options...)
    args = Dict()
    lat != nothing && (args["lat"] = lat)
    long != nothing && (args["long"] = long)

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/legislators/geo/", args; options...)
end

# -------

function committee_search(auth::String; committee=nothing, subcommittee=nothing, chamber = nothing, state=nothing, options...)
    args = Dict()
    committee != nothing && (args["committee"] = committee)
    subcommittee != nothing && (args["subcommittee"] = subcommittee)
    chamber != nothing && (args["chamber"] = chamber)
    state != nothing && (args["state"] = state)

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/committees/", args; options...)
end

# -------

function committee_detail(auth::String, committee_id=nothing, options...)
    args = Dict()

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/committees/$committee_id/", args; options...)
end

# -------

function event_search(auth::String; state=nothing, event_type=nothing, format=nothing, options...)
    args = Dict()
    state != nothing && (args["state"] = state)
    event_type != nothing && (args["type"] = event_type)
    format != nothing && (args["format"] = format)

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/events/", args; options...)
end

# -------

function event_detail(auth::String, event_id=nothing, options...)
    args = Dict()

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/events/$event_id/", args; options...)
end

# -------

function district_search(auth::String; state=nothing, chamber=nothing, options...)
    args = Dict()
    if chamber != nothing
        sunlight_get(auth, OPEN_STATES_API, "/api/v1/districts/$state/$chamber/", args; options...)
    else
        sunlight_get(auth, OPEN_STATES_API, "/api/v1/districts/$state/", args; options...)
    end
end

# -------

function district_boundary_lookup(auth::String; boundary_id=nothing, options...)
    args = Dict()

    sunlight_get(auth, OPEN_STATES_API, "/api/v1/districts/boundary/$boundary_id/", args; options...)
end