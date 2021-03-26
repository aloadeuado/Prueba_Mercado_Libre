/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Seller : Codable {
	let id : Int?
	let permalink : String?
	let registration_date : String?
	let car_dealer : Bool?
	let real_estate_agency : Bool?
	let tags : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case permalink = "permalink"
		case registration_date = "registration_date"
		case car_dealer = "car_dealer"
		case real_estate_agency = "real_estate_agency"
		case tags = "tags"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
		registration_date = try values.decodeIfPresent(String.self, forKey: .registration_date)
		car_dealer = try values.decodeIfPresent(Bool.self, forKey: .car_dealer)
		real_estate_agency = try values.decodeIfPresent(Bool.self, forKey: .real_estate_agency)
		tags = try values.decodeIfPresent(String.self, forKey: .tags)
	}

}