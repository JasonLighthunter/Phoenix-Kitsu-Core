public protocol HasKitsuObjectAttributes: Decodable {
  associatedtype KitsuObjectAttributesType: KitsuObjectAttributes
  
  var attributes: KitsuObjectAttributesType? {get}
//  func getTitleWith(identifier: TitleLanguageIdentifierEnum) -> String
}

open class KitsuObject: Decodable {
  public let objectID: String
  public let type: String
  public let links: Links
//  public let attributes: T?
  
  private enum CodingKeys: String, CodingKey {
    case objectID = "id"
    case type
    case links
//    case attributes
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    objectID = try container.decode(String.self, forKey: .objectID)
    type = try container.decode(String.self, forKey: .type)
    links = try container.decode(Links.self, forKey: .links)
//    attributes = try? container.decode(T.self, forKey: .attributes)
  }
}
