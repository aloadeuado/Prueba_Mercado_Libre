/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct SiteDetailModel : Codable {
    var name : String = ""
    var topLevelDomain : [String] = [String]()
    var alpha2Code : String = ""
    var alpha3Code : String = ""
    var callingCodes : [String] = [String]()
    var capital : String = ""
    var altSpellings : [String] = [String]()
    var region : String = ""
    var subregion : String = ""
    var population : Int = 0
    var latlng : [Double] = [Double]()
    var demonym : String = ""
    var area : Double = 0
    var gini : Double = 0
    var timezones : [String] = [String]()
    var borders : [String] = [String]()
    var nativeName : String = ""
    var numericCode : String = ""
    var flag : String = ""
    var cioc : String = ""

    init(){
        
    }
	enum CodingKeys: String, CodingKey {

		case name = "name"
		case topLevelDomain = "topLevelDomain"
		case alpha2Code = "alpha2Code"
		case alpha3Code = "alpha3Code"
		case callingCodes = "callingCodes"
		case capital = "capital"
		case altSpellings = "altSpellings"
		case region = "region"
		case subregion = "subregion"
		case population = "population"
		case latlng = "latlng"
		case demonym = "demonym"
		case area = "area"
		case gini = "gini"
		case timezones = "timezones"
		case borders = "borders"
		case nativeName = "nativeName"
		case numericCode = "numericCode"
		case flag = "flag"
		case cioc = "cioc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
		topLevelDomain = try values.decodeIfPresent([String].self, forKey: .topLevelDomain) ?? [String]()
		alpha2Code = try values.decodeIfPresent(String.self, forKey: .alpha2Code) ?? ""
		alpha3Code = try values.decodeIfPresent(String.self, forKey: .alpha3Code) ?? ""
		callingCodes = try values.decodeIfPresent([String].self, forKey: .callingCodes) ?? [String]()
		capital = try values.decodeIfPresent(String.self, forKey: .capital) ?? ""
		altSpellings = try values.decodeIfPresent([String].self, forKey: .altSpellings) ?? [String]()
		region = try values.decodeIfPresent(String.self, forKey: .region) ?? ""
		subregion = try values.decodeIfPresent(String.self, forKey: .subregion) ?? ""
		population = try values.decodeIfPresent(Int.self, forKey: .population) ?? 0
		latlng = try values.decodeIfPresent([Double].self, forKey: .latlng) ?? [Double]()
		demonym = try values.decodeIfPresent(String.self, forKey: .demonym) ?? ""
		area = try values.decodeIfPresent(Double.self, forKey: .area) ?? 0
		gini = try values.decodeIfPresent(Double.self, forKey: .gini) ?? 0
		timezones = try values.decodeIfPresent([String].self, forKey: .timezones) ?? [String]()
		borders = try values.decodeIfPresent([String].self, forKey: .borders) ?? [String]()
		nativeName = try values.decodeIfPresent(String.self, forKey: .nativeName) ?? ""
		numericCode = try values.decodeIfPresent(String.self, forKey: .numericCode) ?? ""
		flag = try values.decodeIfPresent(String.self, forKey: .flag) ?? ""
		cioc = try values.decodeIfPresent(String.self, forKey: .cioc) ?? ""
	}

}
