public class Links: Decodable, Equatable {
  public let selfLink: String?

  private enum CodingKeys: String, CodingKey {
    case selfLink = "self"
  }

  public static func == (lhs: Links, rhs: Links) -> Bool {
    return lhs.selfLink == rhs.selfLink
  }
}
