//
//  Result.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import Foundation
// MARK: - ResultModel
class ResultModel: Codable {
    let id, siteID, title: String
    let price: Double?
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title, price, thumbnail
    }

    init(id: String, siteID: String, title: String, price: Double, thumbnail: String) {
        self.id = id
        self.siteID = siteID
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }
}

// MARK: ResultModel convenience initializers and mutators

extension ResultModel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ResultModel.self, from: data)
        self.init(id: me.id, siteID: me.siteID, title: me.title, price: me.price ?? 0, thumbnail: me.thumbnail)
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
        siteID: String? = nil,
        title: String? = nil,
        price: Double? = nil,
        thumbnail: String? = nil
    ) -> ResultModel {
        return ResultModel(
            id: id ?? self.id,
            siteID: siteID ?? self.siteID,
            title: title ?? self.title,
            price: price ?? 0,
            thumbnail: thumbnail ?? self.thumbnail
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
