public protocol KitsuObjectAttributes : Decodable {}

public protocol KitsuObjectAttributesWithoutTimeStamp: KitsuObjectAttributes {
  var createdAt: String? {get}
  var updatedAt: String? {get}
}

public protocol KitsuObjectAttributesWithUpdatedAt: KitsuObjectAttributes {
  var updatedAt: String {get}
}

public protocol KitsuObjectAttributesWithCreatedAt: KitsuObjectAttributes {
  var createdAt: String {get}
}

public protocol KitsuObjectAttributesWithTimestamp :
KitsuObjectAttributesWithUpdatedAt, KitsuObjectAttributesWithCreatedAt {}
