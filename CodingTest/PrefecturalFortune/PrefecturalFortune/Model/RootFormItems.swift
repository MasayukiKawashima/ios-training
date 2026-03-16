//
//  RootFormItems.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/26.
//

import Foundation

struct RootFormItems {

  var name: String?
  var dateOfBirth: Date?
  var bloodType: BloodType?

  enum FormField {
      case name
      case dateOfBirth
      case bloodType
  }
}
