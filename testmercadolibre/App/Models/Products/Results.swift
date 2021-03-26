

import Foundation
struct Results : Codable {
	let id : String?
	let site_id : String?
	let title : String?
	let seller : Seller?
	let price : Double?
	let prices : Prices?
	let sale_price : String?
	let currency_id : String?
	let available_quantity : Int?
	let sold_quantity : Int?
	let buying_mode : String?
	let listing_type_id : String?
	let stop_time : String?
	let condition : String?
	let permalink : String?
	let thumbnail : String?
	let thumbnail_id : String?
	let accepts_mercadopago : Bool?
	let installments : String?
	let address : Address?
	let shipping : Shipping?
	let seller_address : Seller_address?
	let attributes : [Attributes]?
	let original_price : String?
	let category_id : String?
	let official_store_id : String?
	let domain_id : String?
	let catalog_product_id : String?
	let tags : [String]?
	let order_backend : Int?
	let use_thumbnail_id : Bool?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case site_id = "site_id"
		case title = "title"
		case seller = "seller"
		case price = "price"
		case prices = "prices"
		case sale_price = "sale_price"
		case currency_id = "currency_id"
		case available_quantity = "available_quantity"
		case sold_quantity = "sold_quantity"
		case buying_mode = "buying_mode"
		case listing_type_id = "listing_type_id"
		case stop_time = "stop_time"
		case condition = "condition"
		case permalink = "permalink"
		case thumbnail = "thumbnail"
		case thumbnail_id = "thumbnail_id"
		case accepts_mercadopago = "accepts_mercadopago"
		case installments = "installments"
		case address = "address"
		case shipping = "shipping"
		case seller_address = "seller_address"
		case attributes = "attributes"
		case original_price = "original_price"
		case category_id = "category_id"
		case official_store_id = "official_store_id"
		case domain_id = "domain_id"
		case catalog_product_id = "catalog_product_id"
		case tags = "tags"
		case order_backend = "order_backend"
		case use_thumbnail_id = "use_thumbnail_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		site_id = try values.decodeIfPresent(String.self, forKey: .site_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		seller = try values.decodeIfPresent(Seller.self, forKey: .seller)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		prices = try values.decodeIfPresent(Prices.self, forKey: .prices)
		sale_price = try values.decodeIfPresent(String.self, forKey: .sale_price)
		currency_id = try values.decodeIfPresent(String.self, forKey: .currency_id)
		available_quantity = try values.decodeIfPresent(Int.self, forKey: .available_quantity)
		sold_quantity = try values.decodeIfPresent(Int.self, forKey: .sold_quantity)
		buying_mode = try values.decodeIfPresent(String.self, forKey: .buying_mode)
		listing_type_id = try values.decodeIfPresent(String.self, forKey: .listing_type_id)
		stop_time = try values.decodeIfPresent(String.self, forKey: .stop_time)
		condition = try values.decodeIfPresent(String.self, forKey: .condition)
		permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
		thumbnail_id = try values.decodeIfPresent(String.self, forKey: .thumbnail_id)
		accepts_mercadopago = try values.decodeIfPresent(Bool.self, forKey: .accepts_mercadopago)
		installments = try values.decodeIfPresent(String.self, forKey: .installments)
		address = try values.decodeIfPresent(Address.self, forKey: .address)
		shipping = try values.decodeIfPresent(Shipping.self, forKey: .shipping)
		seller_address = try values.decodeIfPresent(Seller_address.self, forKey: .seller_address)
		attributes = try values.decodeIfPresent([Attributes].self, forKey: .attributes)
		original_price = try values.decodeIfPresent(String.self, forKey: .original_price)
		category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
		official_store_id = try values.decodeIfPresent(String.self, forKey: .official_store_id)
		domain_id = try values.decodeIfPresent(String.self, forKey: .domain_id)
		catalog_product_id = try values.decodeIfPresent(String.self, forKey: .catalog_product_id)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		order_backend = try values.decodeIfPresent(Int.self, forKey: .order_backend)
		use_thumbnail_id = try values.decodeIfPresent(Bool.self, forKey: .use_thumbnail_id)
	}

}
