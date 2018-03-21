import Foundation

public protocol KitsuObjectAttributesWithOptionalTimestamp : Decodable {
  var createdAt: Date? {get}
  var updatedAt: Date? {get}
}

public protocol KitsuObjectAttributes: Decodable {
}

public protocol KitsuObjectAttributesWithUpdatedAt: KitsuObjectAttributes {
  var updatedAt: Date {get}
}

public protocol KitsuObjectAttributesWithCreatedAt: KitsuObjectAttributes {
  var createdAt: Date {get}
}

public protocol KitsuObjectAttributesWithTimestamp:
KitsuObjectAttributesWithUpdatedAt, KitsuObjectAttributesWithCreatedAt {

}
