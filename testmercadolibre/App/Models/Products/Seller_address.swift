/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Seller_address : Codable {
	let id : String?
	let comment : String?
	let address_line : String?
	let zip_code : String?
	let country : Country?
	let state : State?
	let city : City?
	let latitude : String?
	let longitude : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case comment = "comment"
		case address_line = "address_line"
		case zip_code = "zip_code"
		case country = "country"
		case state = "state"
		case city = "city"
		case latitude = "latitude"
		case longitude = "longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
		address_line = try values.decodeIfPresent(String.self, forKey: .address_line)
		zip_code = try values.decodeIfPresent(String.self, forKey: .zip_code)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
		state = try values.decodeIfPresent(State.self, forKey: .state)
		city = try values.decodeIfPresent(City.self, forKey: .city)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
	}

}