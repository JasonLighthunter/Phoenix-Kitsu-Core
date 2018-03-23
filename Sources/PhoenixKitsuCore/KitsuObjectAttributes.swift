public protocol KitsuObjectAttributesWithOptionalTimestamp : Decodable {
  var createdAt: String? {get}
  var updatedAt: String? {get}
}

public protocol KitsuObjectAttributes: Decodable {
}

public protocol KitsuObjectAttributesWithUpdatedAt: KitsuObjectAttributes {
  var updatedAt: String {get}
}

public protocol KitsuObjectAttributesWithCreatedAt: KitsuObjectAttributes {
  var createdAt: String {get}
}

public protocol KitsuObjectAttributesWithTimestamp:
KitsuObjectAttributesWithUpdatedAt, KitsuObjectAttributesWithCreatedAt {

}
