//
//  FortuneRequestBody.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/28.
//

import Foundation

import Foundation

struct FortuneRequestBody: Encodable {
  var name: String
  var birthday: YearMonthDay
  var bloodType: String
  var today: YearMonthDay

  enum CodingKeys: String, CodingKey {
    case name
    case birthday
    case bloodType = "blood_type"
    case today
  }
}
