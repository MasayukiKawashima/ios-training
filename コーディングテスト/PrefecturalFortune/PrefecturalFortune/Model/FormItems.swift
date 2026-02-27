//
//  FormItems.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/26.
//

import Foundation

struct FormItems {

  var name: String?
  var dateOfBirth: Date?
  var bloodType: BloodType?

  enum FormField {
      case name
      case dateOfBirth
      case bloodType
  }
}

extension FormItems {

  func missingFields() -> [FormField] {

    var fields: [FormField] = []
    
    if name == nil {
      fields.append(.name)
    }

    if dateOfBirth == nil {
      fields.append(.dateOfBirth)
    }

    if bloodType == nil {
      fields.append(.bloodType)
    }

    return fields
  }
}
