//
//  AvailableFilterValue.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import Foundation

// MARK: - AvailableFilterValue
class AvailableFilterValue: Codable {
    let id, name: String
    let results: Int

    init(id: String, name: String, results: Int) {
        self.id = id
        self.name = name
        self.results = results
    }
}

// MARK: AvailableFilterValue convenience initializers and mutators

extension AvailableFilterValue {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AvailableFilterValue.self, from: data)
        self.init(id: me.id, name: me.name, results: me.results)
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
        results: Int? = nil
    ) -> AvailableFilterValue {
        return AvailableFilterValue(
            id: id ?? self.id,
            name: name ?? self.name,
            results: results ?? self.results
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
