public class Links: Decodable, Equatable {
  public fileprivate(set) var selfLink: String?

  private enum CodingKeys: String, CodingKey {
    case selfLink = "self"
  }

  public static func == (lhs: Links, rhs: Links) -> Bool {
    return lhs.selfLink == rhs.selfLink
  }
}
