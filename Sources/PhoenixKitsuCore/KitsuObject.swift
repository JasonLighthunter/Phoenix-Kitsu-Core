import Requestable

public protocol KitsuObject: Decodable, Requestable {
  var objectID: String {get}
  var type: String {get}
  var links: Links {get}
}
