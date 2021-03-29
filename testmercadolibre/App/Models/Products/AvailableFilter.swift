//
//  AvailableFilter.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import Foundation
// MARK: - AvailableFilter
class AvailableFilter: Codable {
    let id, name, type: String
    let values: [AvailableFilterValue]

    init(id: String, name: String, type: String, values: [AvailableFilterValue]) {
        self.id = id
        self.name = name
        self.type = type
        self.values = values
    }
}

// MARK: AvailableFilter convenience initializers and mutators

extension AvailableFilter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AvailableFilter.self, from: data)
        self.init(id: me.id, name: me.name, type: me.type, values: me.values)
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
        type: String? = nil,
        values: [AvailableFilterValue]? = nil
    ) -> AvailableFilter {
        return AvailableFilter(
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            values: values ?? self.values
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
