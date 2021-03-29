

import Foundation
struct SiteModel : Codable {
    var default_currency_id : String = ""
    var id : String = ""
    var name : String = ""
    //no seriazable
    var state: Bool = false

    init(){
        
    }
    mutating func setState(state: Bool) {
        self.state = state
    }
	enum CodingKeys: String, CodingKey {

		case default_currency_id = "default_currency_id"
		case id = "id"
		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        default_currency_id = try values.decodeIfPresent(String.self, forKey: .default_currency_id) ?? ""
		id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
	}

}
