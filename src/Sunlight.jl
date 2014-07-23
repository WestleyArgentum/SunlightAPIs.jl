
module Sunlight

import Base.print

using JSON
using HttpCommon
using Requests

# entity types (organization, individual, politician)
export Entity, Org, Ind, Pol

# Influence Explorer API
export entity_search,
       entity_info,
       top_politicians,
       top_contributors,
       top_industries,
       unknown_industries,
       top_sectors,
       local_breakdown,
       contributor_breakdown,
       fec_summary,
       fec_independent_expenditures,
       top_individuals,
       top_recipient_organizations,
       top_recipient_politicians,
       party_breakdown,
       lobbying_registrants,
       lobbying_clients,
       lobbying_issues

include("utils.jl")
include("influence-explorer.jl")

end
