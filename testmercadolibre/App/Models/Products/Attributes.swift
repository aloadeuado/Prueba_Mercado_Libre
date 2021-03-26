

import Foundation
struct Attributes : Codable {
	let name : String?
	let attribute_group_id : String?
	let source : Int?
	let values : [Values]?
	let attribute_group_name : String?
	let id : String?
	let value_id : String?
	let value_name : String?
	let value_struct : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case attribute_group_id = "attribute_group_id"
		case source = "source"
		case values = "values"
		case attribute_group_name = "attribute_group_name"
		case id = "id"
		case value_id = "value_id"
		case value_name = "value_name"
		case value_struct = "value_struct"
	}

	init(from decoder: Decoder) throws {
        var values1 = try decoder.container(keyedBy: CodingKeys.self)
		name = try values1.decodeIfPresent(String.self, forKey: .name)
		attribute_group_id = try values1.decodeIfPresent(String.self, forKey: .attribute_group_id)
		source = try values1.decodeIfPresent(Int.self, forKey: .source)
		values = try values1.decodeIfPresent([Values].self, forKey: .values)
		attribute_group_name = try values1.decodeIfPresent(String.self, forKey: .attribute_group_name)
		id = try values1.decodeIfPresent(String.self, forKey: .id)
		value_id = try values1.decodeIfPresent(String.self, forKey: .value_id)
		value_name = try values1.decodeIfPresent(String.self, forKey: .value_name)
		value_struct = try values1.decodeIfPresent(String.self, forKey: .value_struct)
	}

}
