public protocol HasKitsuObjectAttributes: Decodable {
  associatedtype KitsuObjectAttributesType: KitsuObjectAttributes
  
  var attributes: KitsuObjectAttributesType? {get}
//  func getTitleWith(identifier: TitleLanguageIdentifierEnum) -> String
}

//extension HasKitsuObjectAttributes {
//
//  public required init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//  }
//}


open class KitsuObject<T : KitsuObjectAttributes>: HasKitsuObjectAttributes, Decodable {
  public typealias KitsuObjectAttributesType = T
  
  public let objectID: String
  public let type: String
  public let links: Links
  public let attributes: KitsuObjectAttributesType?
  
  private enum CodingKeys: String, CodingKey {
    case objectID = "id"
    case type
    case links
    case attributes
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    objectID = try container.decode(String.self, forKey: .objectID)
    type = try container.decode(String.self, forKey: .type)
    links = try container.decode(Links.self, forKey: .links)
    attributes = try? container.decode(KitsuObjectAttributesType.self, forKey: .attributes)
  }
}
