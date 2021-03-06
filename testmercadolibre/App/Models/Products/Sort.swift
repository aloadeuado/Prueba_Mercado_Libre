//
//  Sort.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import Foundation
// MARK: - Sort
class Sort: Codable {
    let id, name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: Sort convenience initializers and mutators

extension Sort {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Sort.self, from: data)
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
        name: String? = nil
    ) -> Sort {
        return Sort(
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
