//import Requestable

//public protocol KitsuObject: Decodable {
//  associatedtype KitsuObjectAttributesType: KitsuObjectAttributes
//
//  var objectID: String {get}
//  var type: String {get}
//  var links: Links {get}
//  var attributes: KitsuObjectAttributesType? {get}
//}

public protocol HasAttributes: Decodable {
  associatedtype KitsuObjectAttributesType: KitsuObjectAttributes
  
  var attributes: KitsuObjectAttributesType? {get}
}

open public class KitsuObject: Decodable {
  public let objectID: String
  public let type: String
  public let links: Links
  
  private enum CodingKeys: String, CodingKey {
    case objectID = "id"
    case type
    case links
  }
}
