# Sunlight.jl

##### A Julia package for interfacing with the Sunlight Foundation's APIs

## Quick start

```julia
```


## Influence Explorer API

### Common Parameters
Many of methods in the Influence Explorer API accept similar arguments. To reduce redundancy, these are documented once, below. Not all methods accept all common parameters - be sure to check the function signature in the docs further down.

- `auth`: Your Sunlight API key ([get one here](http://sunlightfoundation.com/api/)).
- `entity_id`: The transparencydata ID of the entity that you'd like to look up. Most methods will accept the ID as a `String`, however, sometimes this can cause ambiguity (for instance,`fec_summary` is defined for both Organizations and Politicians). For these cases the `Org` (Organization), `Ind` (Individual), and `Pol` (Politician) types are defined to wrap IDs (i.e. `Org(entity_id)`).
- `cycle`: Use to limit results by cycle(s).
- `limit`: Use to limit the number of results to be returned.

### Entity Lookup Methods

#### Entity Search
Search for politicians, individuals, organizations or industries with a given name.

```julia
entity_search(auth::String, search_str; entity_type = nothing)

entity_search(search_str; auth = "", entity_type = nothing)
```
- `search`: The name to search for. There are no logical operators and no grouping.
- `type`:   Filter results to a particular type of entity.
    * `"politician"`
    * `"organization"`
    * `"individual"`
    * `"industry"`


#### Entity Info
Get general information about the given entity.

```julia
entity_info(auth::String, entity_id; cycle = nothing)

entity_info(entity_id; auth = "", cycle = nothing)
```


### Politician Aggregates Methods

#### Top Politicians
By contributions received, in dollars.

```julia
top_politicians(auth::String; limit = 16, cycle = nothing)

top_politicians(; auth = "", limit = 16, cycle = nothing)
```


#### Top Contributors
The top contributing organizations to a given candidate. Giving is broken down into money given directly (by the organization's PAC), versus money given by individuals employed by or associated with the organization.

```julia
top_contributors(auth::String, entity_id::Union(String, Pol); limit = nothing, cycle = nothing)

top_contributors(entity_id::Union(String, Pol); auth = "", limit = nothing, cycle = nothing)
```


#### Top Industries
Top contributing industries, ranked by dollars given.

```julia
top_industries(auth::String, entity_id::Union(String, Pol); limit = nothing, cycle = nothing)

top_industries(entity_id::Union(String, Pol); auth = "", limit = nothing, cycle = nothing)
```


#### Unknown Industries
Contribution count and total for a politician from unknown industries.

```julia
unknown_industries(auth::String, entity_id::Union(String, Pol); cycle = nothing)

unknown_industries(entity_id::Union(String, Pol); auth = "", cycle = nothing)
```


#### Top Sectors
Contribution totals by sector to a given politician. Sectors are codified by letter:
- `A`: Agribusiness
- `B`: Communications/Electronics
- `C`: Construction
- `D`: Defense
- `E`: Energy/Natural Resources
- `F`: Finance/Insurance/Real Estate
- `H`: Health
- `K`: Lawyers and Lobbyists
- `M`: Transportation
- `N`: Misc. Business
- `Q`: Ideology/Single Issue
- `P`: Labor
- `W`: Other
- `Y`: Unknown
- `Z`: Administrative Use

```julia
top_sectors(auth::String, entity_id::Union(String, Pol); limit = nothing, cycle = nothing)

top_sectors(entity_id::Union(String, Pol); auth = "", limit = nothing, cycle = nothing)
```


#### Local Breakdown
A breakdown of how much of the money raised by a politician came from inside or outside their home state.

```julia
local_breakdown(auth::String, entity_id::Union(String, Pol); cycle = nothing)

local_breakdown(entity_id::Union(String, Pol); auth = "", cycle = nothing)
```


#### Contributor Type Breakdown
A breakdown of how much of the money raised came from individuals versus organzations (PACs).

```julia
contributor_breakdown(auth::String, entity_id::Union(String, Pol); cycle = nothing)

contributor_breakdown(entity_id::Union(String, Pol); auth = "", cycle = nothing)
```


#### FEC Summary
Latest figures from the FEC's summary report.

```julia
fec_summary(auth::String, entity_id::Pol)

fec_summary(entity_id::Pol; auth = "")
```


#### FEC Independent Expenditures
Top independent expenditures for and against a politician.

```julia
fec_independent_expenditures(auth::String, entity_id::Union(String, Pol))

fec_independent_expenditures(entity_id::Union(String, Pol); auth = "")
```


### Individual Aggregates

#### Top Individuals
By contributions given, in dollars.

```julia
top_individuals(auth::String; limit = 16, cycle = nothing)

top_individuals(; auth = "", limit = 16, cycle = nothing)
```


#### Top Recipient Organizations
Top organizations to which this individual has donated, by dollars given.

```julia
top_recipient_organizations(auth::String, entity_id::Union(String, Ind); limit = nothing, cycle = nothing)

top_recipient_organizations(entity_id::Union(String, Ind); auth = "", limit = nothing, cycle = nothing)
```


#### Top Recipient Politicians
Politicians to whom the individual has given the most money.

```julia
top_recipient_politicians(auth::String, entity_id::Union(String, Ind); limit = nothing, cycle = nothing)

top_recipient_politicians(entity_id::Union(String, Ind); auth = "", limit = nothing, cycle = nothing)
```


#### Party Breakdown
Details on how much an individual gave to each party.

```julia
party_breakdown(auth::String, entity_id::Ind; cycle = nothing)

party_breakdown(entity_id::Ind; auth = "", cycle = nothing)
```


#### Lobbying Registrants
A list of the lobbying firms which employed an individual.

```julia
lobbying_registrants(auth::String, entity_id::Union(String, Ind); limit = nothing, cycle = nothing)

lobbying_registrants(entity_id::Union(String, Ind); auth = "", limit = nothing, cycle = nothing)
```


#### Lobbying Clients
Clients an individual (lobbyist) was contracted to work for.

```julia
lobbying_clients(auth::String, entity_id::Union(String, Ind); limit = nothing, cycle = nothing)

lobbying_clients(entity_id::Union(String, Ind); auth = "", limit = nothing, cycle = nothing)
```


#### Lobbying Issues
Issue areas a lobbyist worked on.

```julia
lobbying_issues(auth::String, entity_id::Ind; limit = nothing, cycle = nothing)

lobbying_issues(entity_id::Ind; auth = "", limit = nothing, cycle = nothing)
```


### Organization Aggregates

#### Top Organizations
By contributions given, in dollars.

```julia
top_organizations(auth::String; limit = 16, cycle = nothing)

top_organizations(; auth = "", limit = 16, cycle = nothing)
```


#### Top Recipients
Top recipients of money from this organization, by dollars received.

```julia
top_recipients(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

top_recipients(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### PAC Recipients
Top PACs receiving money from a given organization.

```julia
pac_recipients(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

pac_recipients(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Party Breakdown
Portion of giving from an organization that went to each party.

```julia
party_breakdown(auth::String, entity_id::Org; cycle = nothing)

party_breakdown(entity_id::Org; auth = "", cycle = nothing)
```


#### State/Federal (Level) Breakdown
Portion of giving from an organization that went state candidates versus federal candidates.

```julia
state_federal_breakdown(auth::String, entity_id::Union(String, Org); cycle = nothing)

state_federal_breakdown(entity_id::Union(String, Org); auth = "", cycle = nothing)
```


#### Lobbing Registrants
Lobbying firms hired by an organization.

```julia
lobbing_registrants(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

lobbing_registrants(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Lobbying Issues
Issue areas an organization has hired lobbyists for.

```julia
lobbying_issues(auth::String, entity_id::Org; limit = nothing, cycle = nothing)

lobbying_issues(entity_id::Org; auth = "", limit = nothing, cycle = nothing)
```


#### Bills
Bills an organization has lobbied on.

```julia
bills(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

bills(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Lobbyists
Lobbyists hired by an organization.

```julia
lobbyists(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

lobbyists(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Registrant Clients
Top clients that hired an organization (lobbying firm).

```julia
registrant_clients(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

registrant_clients(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Registrant Issues
Top issue areas an organization (lobbying firm) has lobbied on.

```julia
registrant_issues(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

registrant_issues(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Registrant Bills
Top bills an organization (lobbying firm) has lobbied on.

```julia
registrant_bills(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

registrant_bills(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Registrant Lobbyists
Top lobbyists an organization (lobbying firm) employs, by registrations.

```julia
registrant_lobbyists(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

registrant_lobbyists(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Mentions in Regulations
Regulatory dockets that most frequently mention an organization

```julia
mentions_in_regulations(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

mentions_in_regulations(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### Regulatory Comment Submissions
Regulatory dockets with the most comment submissions from an organization.

```julia
regulatory_comment_submissions(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

regulatory_comment_submissions(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### FACA Memberships
Lists employees of an organization ith memberships on federal advisory committees.

```julia
faca_memberships(auth::String, entity_id::Union(String, Org); limit = nothing, cycle = nothing)

faca_memberships(entity_id::Union(String, Org); auth = "", limit = nothing, cycle = nothing)
```


#### FEC Summary
Latest figures for an organization from the FEC's summary report, current election cycle only.

```julia
fec_summary(auth::String, entity_id::Union(String, Org))

fec_summary(entity_id::Union(String, Org); auth = "")
```


### Industry Aggregates

#### Top Industries
By contributions given, in dollars.

```julia
top_industries(auth::String; limit = 16, cycle = nothing)

top_industries(; auth = "", limit = 16, cycle = nothing)
```


#### Top Industry Organizations
Top organizations in an industry by dollars contributed.

```julia
top_industry_organizations(auth::String, entity_id::String; limit = nothing, cycle = nothing)

top_industry_organizations(entity_id::String; auth = "", limit = nothing, cycle = nothing)
```
