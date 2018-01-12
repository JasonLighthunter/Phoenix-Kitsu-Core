public protocol HasKitsuObjectAttributes: Decodable {
  associatedtype KitsuObjectAttributesType: KitsuObjectAttributes
  
  var attributes: KitsuObjectAttributesType? {get}
}
