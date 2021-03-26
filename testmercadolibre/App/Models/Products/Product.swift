

import Foundation
struct Product : Codable {
	let site_id : String?
	let paging : Paging?
	let results : [Results]?
	let secondary_results : [String]?
	let related_results : [String]?
	let sort : Sort?
	let available_sorts : [Available_sorts]?
	let filters : [Filters]?
	let available_filters : [Available_filters]?

	enum CodingKeys: String, CodingKey {

		case site_id = "site_id"
		case paging = "paging"
		case results = "results"
		case secondary_results = "secondary_results"
		case related_results = "related_results"
		case sort = "sort"
		case available_sorts = "available_sorts"
		case filters = "filters"
		case available_filters = "available_filters"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		site_id = try values.decodeIfPresent(String.self, forKey: .site_id)
		paging = try values.decodeIfPresent(Paging.self, forKey: .paging)
		results = try values.decodeIfPresent([Results].self, forKey: .results)
		secondary_results = try values.decodeIfPresent([String].self, forKey: .secondary_results)
		related_results = try values.decodeIfPresent([String].self, forKey: .related_results)
		sort = try values.decodeIfPresent(Sort.self, forKey: .sort)
		available_sorts = try values.decodeIfPresent([Available_sorts].self, forKey: .available_sorts)
		filters = try values.decodeIfPresent([Filters].self, forKey: .filters)
		available_filters = try values.decodeIfPresent([Available_filters].self, forKey: .available_filters)
	}

}
