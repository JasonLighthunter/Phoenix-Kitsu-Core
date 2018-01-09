public class SearchResult<T: KitsuObject>: Decodable {
  public let data: [T]?
  public let meta: KitsuMetaObject?
  public let pagingLinks: PagingLinks?

  private enum CodingKeys: String, CodingKey {
    case data
    case meta
    case pagingLinks = "links"
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
    self.data = try? container.decode([T].self, forKey: .data) // extracting the data
    self.meta = try? container.decode(KitsuMetaObject.self, forKey: .meta) // extracting the data
    self.pagingLinks = try? container.decode(PagingLinks.self, forKey: .pagingLinks) // extracting the data
  }
}
