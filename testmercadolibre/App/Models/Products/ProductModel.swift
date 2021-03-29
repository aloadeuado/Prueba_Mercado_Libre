//
//  ProductModel.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import Foundation

// MARK: - ProductModel
class ProductModel: Codable {
    let siteID: String
    let paging: Paging
    var results: [ResultModel]
    let secondaryResults, relatedResults: [JSONAny]
    var sort: Sort
    let availableSorts: [Sort]
    var filters: [Filter]
    let availableFilters: [AvailableFilter]

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case paging, results
        case secondaryResults = "secondary_results"
        case relatedResults = "related_results"
        case sort
        case availableSorts = "available_sorts"
        case filters
        case availableFilters = "available_filters"
    }

    init(siteID: String, paging: Paging, results: [ResultModel], secondaryResults: [JSONAny], relatedResults: [JSONAny], sort: Sort, availableSorts: [Sort], filters: [Filter], availableFilters: [AvailableFilter]) {
        self.siteID = siteID
        self.paging = paging
        self.results = results
        self.secondaryResults = secondaryResults
        self.relatedResults = relatedResults
        self.sort = sort
        self.availableSorts = availableSorts
        self.filters = filters
        self.availableFilters = availableFilters
    }
}

// MARK: ProductModel convenience initializers and mutators

extension ProductModel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ProductModel.self, from: data)
        self.init(siteID: me.siteID, paging: me.paging, results: me.results, secondaryResults: me.secondaryResults, relatedResults: me.relatedResults, sort: me.sort, availableSorts: me.availableSorts, filters: me.filters, availableFilters: me.availableFilters)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        siteID: String? = nil,
        paging: Paging? = nil,
        results: [ResultModel]? = nil,
        secondaryResults: [JSONAny]? = nil,
        relatedResults: [JSONAny]? = nil,
        sort: Sort? = nil,
        availableSorts: [Sort]? = nil,
        filters: [Filter]? = nil,
        availableFilters: [AvailableFilter]? = nil
    ) -> ProductModel {
        return ProductModel(
            siteID: siteID ?? self.siteID,
            paging: paging ?? self.paging,
            results: results ?? self.results,
            secondaryResults: secondaryResults ?? self.secondaryResults,
            relatedResults: relatedResults ?? self.relatedResults,
            sort: sort ?? self.sort,
            availableSorts: availableSorts ?? self.availableSorts,
            filters: filters ?? self.filters,
            availableFilters: availableFilters ?? self.availableFilters
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}








// MARK: - Address
class Address: Codable {
    let stateID, stateName, cityID, cityName: String

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
    }

    init(stateID: String, stateName: String, cityID: String, cityName: String) {
        self.stateID = stateID
        self.stateName = stateName
        self.cityID = cityID
        self.cityName = cityName
    }
}

// MARK: Address convenience initializers and mutators

extension Address {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Address.self, from: data)
        self.init(stateID: me.stateID, stateName: me.stateName, cityID: me.cityID, cityName: me.cityName)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        stateID: String? = nil,
        stateName: String? = nil,
        cityID: String? = nil,
        cityName: String? = nil
    ) -> Address {
        return Address(
            stateID: stateID ?? self.stateID,
            stateName: stateName ?? self.stateName,
            cityID: cityID ?? self.cityID,
            cityName: cityName ?? self.cityName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Attribute
class Attribute: Codable {
    let attributeGroupID, valueID, name, valueName: String
    let valueStruct: JSONNull?
    let values: [AttributeValue]
    let attributeGroupName: String
    let source: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case attributeGroupID = "attribute_group_id"
        case valueID = "value_id"
        case name
        case valueName = "value_name"
        case valueStruct = "value_struct"
        case values
        case attributeGroupName = "attribute_group_name"
        case source, id
    }

    init(attributeGroupID: String, valueID: String, name: String, valueName: String, valueStruct: JSONNull?, values: [AttributeValue], attributeGroupName: String, source: Int, id: String) {
        self.attributeGroupID = attributeGroupID
        self.valueID = valueID
        self.name = name
        self.valueName = valueName
        self.valueStruct = valueStruct
        self.values = values
        self.attributeGroupName = attributeGroupName
        self.source = source
        self.id = id
    }
}

// MARK: Attribute convenience initializers and mutators

extension Attribute {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Attribute.self, from: data)
        self.init(attributeGroupID: me.attributeGroupID, valueID: me.valueID, name: me.name, valueName: me.valueName, valueStruct: me.valueStruct, values: me.values, attributeGroupName: me.attributeGroupName, source: me.source, id: me.id)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        attributeGroupID: String? = nil,
        valueID: String? = nil,
        name: String? = nil,
        valueName: String? = nil,
        valueStruct: JSONNull?? = nil,
        values: [AttributeValue]? = nil,
        attributeGroupName: String? = nil,
        source: Int? = nil,
        id: String? = nil
    ) -> Attribute {
        return Attribute(
            attributeGroupID: attributeGroupID ?? self.attributeGroupID,
            valueID: valueID ?? self.valueID,
            name: name ?? self.name,
            valueName: valueName ?? self.valueName,
            valueStruct: valueStruct ?? self.valueStruct,
            values: values ?? self.values,
            attributeGroupName: attributeGroupName ?? self.attributeGroupName,
            source: source ?? self.source,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AttributeValue
class AttributeValue: Codable {
    let name: String
    let valueStruct: JSONNull?
    let source: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case name
        case valueStruct = "struct"
        case source, id
    }

    init(name: String, valueStruct: JSONNull?, source: Int, id: String) {
        self.name = name
        self.valueStruct = valueStruct
        self.source = source
        self.id = id
    }
}

// MARK: AttributeValue convenience initializers and mutators

extension AttributeValue {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AttributeValue.self, from: data)
        self.init(name: me.name, valueStruct: me.valueStruct, source: me.source, id: me.id)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        name: String? = nil,
        valueStruct: JSONNull?? = nil,
        source: Int? = nil,
        id: String? = nil
    ) -> AttributeValue {
        return AttributeValue(
            name: name ?? self.name,
            valueStruct: valueStruct ?? self.valueStruct,
            source: source ?? self.source,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Prices
class Prices: Codable {

    init() {
    }
}

// MARK: Prices convenience initializers and mutators

extension Prices {
    convenience init(data: Data) throws {
        let _ = try newJSONDecoder().decode(Prices.self, from: data)
        self.init()
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Prices {
        return Prices(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Seller
class Seller: Codable {
    let id: Int
    let permalink, registrationDate: JSONNull?
    let carDealer, realEstateAgency: Bool
    let tags: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, permalink
        case registrationDate = "registration_date"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
        case tags
    }

    init(id: Int, permalink: JSONNull?, registrationDate: JSONNull?, carDealer: Bool, realEstateAgency: Bool, tags: JSONNull?) {
        self.id = id
        self.permalink = permalink
        self.registrationDate = registrationDate
        self.carDealer = carDealer
        self.realEstateAgency = realEstateAgency
        self.tags = tags
    }
}

// MARK: Seller convenience initializers and mutators

extension Seller {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Seller.self, from: data)
        self.init(id: me.id, permalink: me.permalink, registrationDate: me.registrationDate, carDealer: me.carDealer, realEstateAgency: me.realEstateAgency, tags: me.tags)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        permalink: JSONNull?? = nil,
        registrationDate: JSONNull?? = nil,
        carDealer: Bool? = nil,
        realEstateAgency: Bool? = nil,
        tags: JSONNull?? = nil
    ) -> Seller {
        return Seller(
            id: id ?? self.id,
            permalink: permalink ?? self.permalink,
            registrationDate: registrationDate ?? self.registrationDate,
            carDealer: carDealer ?? self.carDealer,
            realEstateAgency: realEstateAgency ?? self.realEstateAgency,
            tags: tags ?? self.tags
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SellerAddress
class SellerAddress: Codable {
    let id, comment, addressLine, zipCode: String
    let country, state, city: Sort?
    let latitude, longitude: String

    enum CodingKeys: String, CodingKey {
        case id, comment
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case country, state, city, latitude, longitude
    }

    init(id: String, comment: String, addressLine: String, zipCode: String, country: Sort?, state: Sort?, city: Sort?, latitude: String, longitude: String) {
        self.id = id
        self.comment = comment
        self.addressLine = addressLine
        self.zipCode = zipCode
        self.country = country
        self.state = state
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: SellerAddress convenience initializers and mutators

extension SellerAddress {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SellerAddress.self, from: data)
        self.init(id: me.id, comment: me.comment, addressLine: me.addressLine, zipCode: me.zipCode, country: me.country, state: me.state, city: me.city, latitude: me.latitude, longitude: me.longitude)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        comment: String? = nil,
        addressLine: String? = nil,
        zipCode: String? = nil,
        country: Sort?? = nil,
        state: Sort?? = nil,
        city: Sort?? = nil,
        latitude: String? = nil,
        longitude: String? = nil
    ) -> SellerAddress {
        return SellerAddress(
            id: id ?? self.id,
            comment: comment ?? self.comment,
            addressLine: addressLine ?? self.addressLine,
            zipCode: zipCode ?? self.zipCode,
            country: country ?? self.country,
            state: state ?? self.state,
            city: city ?? self.city,
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Shipping
class Shipping: Codable {
    let freeShipping: Bool
    let mode: String
    let tags: [JSONAny]
    let logisticType: String
    let storePickUp: Bool

    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case mode, tags
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }

    init(freeShipping: Bool, mode: String, tags: [JSONAny], logisticType: String, storePickUp: Bool) {
        self.freeShipping = freeShipping
        self.mode = mode
        self.tags = tags
        self.logisticType = logisticType
        self.storePickUp = storePickUp
    }
}

// MARK: Shipping convenience initializers and mutators

extension Shipping {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Shipping.self, from: data)
        self.init(freeShipping: me.freeShipping, mode: me.mode, tags: me.tags, logisticType: me.logisticType, storePickUp: me.storePickUp)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        freeShipping: Bool? = nil,
        mode: String? = nil,
        tags: [JSONAny]? = nil,
        logisticType: String? = nil,
        storePickUp: Bool? = nil
    ) -> Shipping {
        return Shipping(
            freeShipping: freeShipping ?? self.freeShipping,
            mode: mode ?? self.mode,
            tags: tags ?? self.tags,
            logisticType: logisticType ?? self.logisticType,
            storePickUp: storePickUp ?? self.storePickUp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
