
using Sunlight
using Base.Test

function sunlight_test(fn, args...; auth = "", named_args...)
    print("Testing $fn ... ")

    # test different ways of passing in api key
    auth_first = fn(auth, args...)
    auth_named = fn(args...; auth = auth)
    @test auth_first != nothing
    @test auth_named != nothing
    @test auth_first == auth_named

    # test each of the named args
    for arg in named_args
        w_arg = fn(auth, args...; [arg]...)
        @test w_arg != nothing
        @test w_arg != auth_first || isempty(w_arg) # if thre's no data we can use to check, let's assume the named arg is working
    end

    # test a silly named arg that should error
    @test_throws ErrorException fn(auth, args...; this_arg_doesnt_work = "I hope...")

    println("Success!")
end

# -------

function runtests(api_key; pol_id = "597e02e7d1b04d83976913da1b8e2998",
                           ind_id = "a03df5d9b20e467fa0ceaefa94c4491e",
                           limit = 2,
                           cycle = 2012)

    sunlight_test(top_contributors, pol_id; limit = limit, cycle = cycle, auth = api_key)
    sunlight_test(top_industries, pol_id; limit = limit, cycle = cycle, auth = api_key)
    sunlight_test(unknown_industries, pol_id; cycle = cycle, auth = api_key)
    sunlight_test(top_sectors, pol_id; limit = limit, cycle = cycle, auth = api_key)
    sunlight_test(local_breakdown, pol_id; cycle = cycle, auth = api_key)
    sunlight_test(contributor_breakdown, pol_id; cycle = cycle, auth = api_key)
    sunlight_test(fec_summary, pol_id; auth = api_key)
    sunlight_test(fec_independent_expenditures, pol_id; auth = api_key)
    sunlight_test(top_recipient_organizations, ind_id; limit = limit, cycle = cycle, auth = api_key)
    sunlight_test(top_recipient_politicians, ind_id; limit = limit, cycle = cycle, auth = api_key)
    sunlight_test(party_breakdown, ind_id; cycle = cycle, auth = api_key)
    sunlight_test(lobbying_registrants, ind_id; limit = limit, cycle = cycle, auth = api_key)
    sunlight_test(lobbying_clients, ind_id; limit = limit, cycle = cycle, auth = api_key)
    sunlight_test(lobbying_issues, ind_id; limit = limit, cycle = cycle, auth = api_key)

end

# -------
# Run these tests automatically when an api-key is passed as the first arg on startup

!isempty(ARGS) && runtests(ARGS[1])
