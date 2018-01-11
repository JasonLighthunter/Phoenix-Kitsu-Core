import Requestable

public protocol KitsuObject: Decodable {
  associatedtype KitsuObjectAttributesType: KitsuObjectAttributes
  
  var objectID: String {get}
  var type: String {get}
  var links: Links {get}
  var attributes: KitsuObjectAttributesType? {get}
}
