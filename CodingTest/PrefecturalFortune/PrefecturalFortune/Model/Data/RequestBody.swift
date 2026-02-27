//
//  RequestBody.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/27.
//

import Foundation

struct RequestBody: Encodable {
  var name: String
  var birthday: YearMonthDay
  var bloodType: String
  var today: YearMonthDay

  struct YearMonthDay: Encodable {
    var year: Int
    var month: Int
    var day: Int
  }

  enum CodingKeys: String, CodingKey {
    case name
    case birthday
    case bloodType = "blood_type"
    case today
  }
}
