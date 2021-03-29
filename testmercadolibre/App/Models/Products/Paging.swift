//
//  Paging.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import Foundation
// MARK: - Paging
class Paging: Codable {
    var total, primaryResults, offset, limit: Int

    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset, limit
    }

    init(total: Int, primaryResults: Int, offset: Int, limit: Int) {
        self.total = total
        self.primaryResults = primaryResults
        self.offset = offset
        self.limit = limit
    }
}

// MARK: Paging convenience initializers and mutators

extension Paging {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Paging.self, from: data)
        self.init(total: me.total, primaryResults: me.primaryResults, offset: me.offset, limit: me.limit)
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
        total: Int? = nil,
        primaryResults: Int? = nil,
        offset: Int? = nil,
        limit: Int? = nil
    ) -> Paging {
        return Paging(
            total: total ?? self.total,
            primaryResults: primaryResults ?? self.primaryResults,
            offset: offset ?? self.offset,
            limit: limit ?? self.limit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
