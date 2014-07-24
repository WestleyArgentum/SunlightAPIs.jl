# SunlightAPIs.jl

##### A Julia package for interfacing with the Sunlight Foundation's APIs

## Quick start

```julia
julia> Pkg.add("SunlightAPIs")

julia> using SunlightAPIs

julia> my_auth = "your-api-key"
"*******************"

julia> entity_search(my_auth, "obama"; entity_type = "politician")
2-element Array{Any,1}:
 ["is_superpac"=>nothing,"total_given"=>0.0,"firm_income"=>0.0,"state"=>"","name"=>"Barack Obama (D)","id"=>"4148b26f6f1c437cb50ea9ca4699417a","total_received"=>7.14694967e8,"count_given"=>0,"count_lobbied"=>0,"count_received"=>1335528,"seat"=>"federal:president","lobbying_firm"=>nothing,"party"=>"D","type"=>"politician","non_firm_spending"=>0.0]
 ["is_superpac"=>nothing,"total_given"=>0.0,"firm_income"=>0.0,"state"=>"IL","name"=>"OBAMA, BARACK","id"=>"97737bb56b6a4211bcc57a837368b1a4","total_received"=>445595.36,"count_given"=>0,"count_lobbied"=>0,"count_received"=>892,"seat"=>"state:upper","lobbying_firm"=>nothing,"party"=>"D","type"=>"politician","non_firm_spending"=>0.0]

julia> entity_info(my_auth, "4148b26f6f1c437cb50ea9ca4699417a")
Dict{String,Any} with 6 entries:
  "name"         => "Barack Obama (D)"
  "totals"       => ["2014"=>["fec_total_raised"=>0.0,"faca_committee_count"=>0,"firm_income"=>0.0…
  "external_ids" => {["namespace"=>"urn:crp:recipient","id"=>"N00009638"],["namespace"=>"urn:fec:c…
  "id"           => "4148b26f6f1c437cb50ea9ca4699417a"
  "metadata"     => ["2014"=>["district"=>"","state_held"=>"","seat_held"=>"federal:president","se…
  "type"         => "politician"

julia> top_contributors(my_auth, "4148b26f6f1c437cb50ea9ca4699417a"; limit = 3, cycle = 2008)
3-element Array{Any,1}:
 ["name"=>"University of California","direct_count"=>"0","total_count"=>"3356","total_amount"=>"1638228.00","employee_amount"=>"1638228.00","id"=>"0e85264c0c0e4dfb9a4b38cfc181f030","direct_amount"=>"0","employee_count"=>"3356"]
 ["name"=>"Goldman Sachs","direct_count"=>"0","total_count"=>"879","total_amount"=>"1001195.00","employee_amount"=>"1001195.00","id"=>"597eccfe48784677a437569ff6293097","direct_amount"=>"0","employee_count"=>"879"]
 ["name"=>"Harvard University","direct_count"=>"0","total_count"=>"1398","total_amount"=>"859747.00","employee_amount"=>"859747.00","id"=>"74a1dca1259b4f60bca481d4c76e2a1f","direct_amount"=>"0","employee_count"=>"1398"]

julia> top_organizations(my_auth; limit = 12)
12-element Array{Any,1}:
 ["amount"=>"384272261.37","name"=>"National Education Assn","id"=>"1b8fea7e453d4e75841eac48ff9df550","count"=>"57835"]
 ["amount"=>"275880888.86","name"=>"Service Employees International Union","id"=>"e31bfef434e9470b9e473d6182f2d021","count"=>"35011"]
 ["amount"=>"181691570.75","name"=>"American Fedn of St/Cnty/Munic Employees","id"=>"fb702029157e4c7c887172eba71c66c5","count"=>"43635"]
 ["amount"=>"174018345.66","name"=>"National Assn of Realtors","id"=>"bb98402bd4d3471cad392a671ecd733a","count"=>"92925"]
 ["amount"=>"112448960.46","name"=>"Altria Group","id"=>"0785a40a08df4dada2f083631efecb34","count"=>"21199"]
 ["amount"=>"110349716.14","name"=>"American Federation of Teachers","id"=>"73a89c3b554945cd8228fa82fc53b73a","count"=>"32445"]
 ["amount"=>"108195067.94","name"=>"Intl Brotherhood of Electrical Workers","id"=>"b53b4ad137d743a996f4d7467700fc88","count"=>"53828"]
 ["amount"=>"99742982.84","name"=>"Republican Governors Assn","id"=>"bdfd0d138c4c474d842a6e4d85aa8b0a","count"=>"481"]
 ["amount"=>"99131444.53","name"=>"Philip Morris","id"=>"f3b0421dc8204f048a9b358376df8131","count"=>"23570"]
 ["amount"=>"94524750.12","name"=>"Laborers Union","id"=>"6f6d63baaa6c4f5c9c739596e65b020e","count"=>"34531"]
 ["amount"=>"94172506.40","name"=>"Penn National Gaming","id"=>"24cab44f502f415dbfd32f8e7b1b7c5b","count"=>"1964"]
 ["amount"=>"93127912.28","name"=>"AT&T Inc","id"=>"d473e580c5684a658b754eb97566cb05","count"=>"73320"]

julia> registrant_bills(my_auth, "d473e580c5684a658b754eb97566cb05"; limit = 3)
3-element Array{Any,1}:
 ["cycle"=>-1,"bill_no"=>1447,"count"=>12,"title"=>"Connecting America Act of 2009","bill_name"=>"S.1447","congress_no"=>111,"bill_type"=>"s"]
 ["cycle"=>-1,"bill_no"=>422,"count"=>8,"title"=>"","bill_name"=>"H.R.422","congress_no"=>111,"bill_type"=>"h"]
 ["cycle"=>-1,"bill_no"=>400,"count"=>8,"title"=>"Protecting Consumers through Proper Forbearance Procedures Act","bill_name"=>"H.R.400","congress_no"=>111,"bill_type"=>"h"]
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
