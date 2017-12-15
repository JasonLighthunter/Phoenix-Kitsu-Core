public protocol KitsuObjectAttributes: Decodable {
  var createdAt: String? {get}
  var updatedAt: String? {get}
}

public protocol KitsuObjectAttributesWithUpdatedAt: Decodable {
  var updatedAt: String {get}
}

public protocol KitsuObjectAttributesWithCreatedAt: Decodable {
  var createdAt: String {get}
}

public protocol KitsuObjectAttributesWithTimestamp :
KitsuObjectAttributesWithUpdatedAt, KitsuObjectAttributesWithCreatedAt {
  
}
