//
//  FilterValue.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import Foundation

// MARK: - FilterValue
class FilterValue: Codable {
    let id, name: String
    //let pathFromRoot: [Sort]

    enum CodingKeys: String, CodingKey {
        case id, name
        //case pathFromRoot = "path_from_root"
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
        //self.pathFromRoot = pathFromRoot
    }
}

// MARK: FilterValue convenience initializers and mutators

extension FilterValue {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FilterValue.self, from: data)
        self.init(id: me.id, name: me.name)
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
        name: String? = nil,
        pathFromRoot: [Sort]? = nil
    ) -> FilterValue {
        return FilterValue(
            id: id ?? self.id,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
