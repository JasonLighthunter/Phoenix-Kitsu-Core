//
//  KitsuObject.swift
//  Phoenix-Kitsu-Core
//
//  Created by Job Cuppen on 15/11/17.

import Requestable

public protocol KitsuObject: Decodable, Requestable {
  var objectID: String {get}
  var type: String {get}
  var links: Links {get}
}
