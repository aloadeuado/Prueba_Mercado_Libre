

import Foundation
struct Address : Codable {
	let state_id : String?
	let state_name : String?
	let city_id : String?
	let city_name : String?

	enum CodingKeys: String, CodingKey {

		case state_id = "state_id"
		case state_name = "state_name"
		case city_id = "city_id"
		case city_name = "city_name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
		state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
		city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
		city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
	}

}
