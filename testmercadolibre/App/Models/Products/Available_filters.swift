

import Foundation
struct Available_filters : Codable {
	let id : String?
	let name : String?
	let type : String?
	let values : [Values]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case type = "type"
		case values = "values"
	}

	init(from decoder: Decoder) throws {
		let values1 = try decoder.container(keyedBy: CodingKeys.self)
		id = try values1.decodeIfPresent(String.self, forKey: .id)
		name = try values1.decodeIfPresent(String.self, forKey: .name)
		type = try values1.decodeIfPresent(String.self, forKey: .type)
		values = try values1.decodeIfPresent([Values].self, forKey: .values)
	}

}
