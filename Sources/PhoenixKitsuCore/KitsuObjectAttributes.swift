//
//  KitsuObjectAttributes.swift
//  Phoenix-Kitsu-Core
//
//  Created by Job Cuppen on 15/11/17.

public protocol KitsuObjectAttributes: Decodable {
  var createdAt: String? {get}
  var updatedAt: String? {get}
}

public protocol KitsuObjectAttributesWithTimestamp: Decodable {
  var createdAt: String {get}
  var updatedAt: String {get}
}
