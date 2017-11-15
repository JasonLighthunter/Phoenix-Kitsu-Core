//
//  Links.swift
//  Phoenix-Kitsu-Core
//
//  Created by Job Cuppen on 15/11/17.

public class Links: Decodable, Equatable {
  public fileprivate(set) var selfLink: String?

  private enum CodingKeys: String, CodingKey {
    case selfLink = "self"
  }

  public static func == (lhs: Links, rhs: Links) -> Bool {
    return lhs.selfLink == rhs.selfLink
  }
}
