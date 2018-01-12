public protocol KitsuObjectAttributes : Decodable {
  var createdAt: String? {get}
  var updatedAt: String? {get}
}

public protocol KitsuObjectAttributesWithoutTimeStamp: Decodable {
}

public protocol KitsuObjectAttributesWithUpdatedAt: KitsuObjectAttributesWithoutTimeStamp {
  var updatedAt: String {get}
}

public protocol KitsuObjectAttributesWithCreatedAt: KitsuObjectAttributesWithoutTimeStamp {
  var createdAt: String {get}
}

public protocol KitsuObjectAttributesWithTimestamp : KitsuObjectAttributesWithUpdatedAt,
KitsuObjectAttributesWithCreatedAt {
  
}
