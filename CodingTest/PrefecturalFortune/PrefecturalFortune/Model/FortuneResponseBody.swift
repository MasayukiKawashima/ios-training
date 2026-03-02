//
//  FortuneResponseBody.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/02.
//

import Foundation

struct FortuneResponseBody: Decodable {
  var name: String
  var capital: String
  var citizenDay: MonthDay?
  var hasCoastLine: Bool
  var logoURL: String
  var brief: String

  enum CodingKeys: String, CodingKey {
    case name
    case capital
    case citizenDay
    case hasCoastLine = "has_coast_line"
    case logoURL = "logo_url"
    case brief
  }
}
