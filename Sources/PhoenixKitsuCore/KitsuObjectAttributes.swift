public protocol KitsuObjectAttributes: Decodable {
  var createdAt: String? {get}
  var updatedAt: String? {get}
}

public protocol KitsuObjectAttributesWithTimestamp: Decodable {
  var createdAt: String {get}
  var updatedAt: String {get}
}
