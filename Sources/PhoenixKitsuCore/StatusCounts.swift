public struct StatusCounts: Decodable {
  public let current: Int
  public let planned: Int
  public let completed: Int
  public let onHold: Int
  public let dropped: Int
}
