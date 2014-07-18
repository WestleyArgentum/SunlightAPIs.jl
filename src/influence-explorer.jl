
# For more information, see:  http://sunlightlabs.github.io/datacommons

global INFLUENCE_EXPLORER_API = URI("http://transparencydata.com/")

# -------

function entity_search(auth::String, search_str; entity_type = nothing, options...)
	args = {
		"search" => search_str
	}
	entity_type != nothing && (args["type"] = entity_type)

	sunlight_get(auth, INFLUENCE_EXPLORER_API, "/api/1.0/entities.json", args; options...)
end

entity_search(search_str; auth = "", options...) = entity_search(auth, search_str; options...)
