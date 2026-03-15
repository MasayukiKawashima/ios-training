//
//  RootFormItemsMissingValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/15.
//

import Foundation

struct RootFormItemsMissingValidator: Validator {
  func validate(_ value: RootFormItems) -> ValidationState {
    var missingFields: [RootFormItems.FormField] = []

    if value.name == nil {
      missingFields.append(.name)
    }

    if value.dateOfBirth == nil {
      missingFields.append(.dateOfBirth)
    }

    if value.bloodType == nil {
      missingFields.append(.bloodType)
    }

    if missingFields.isEmpty {
      return .valid
    } else {
      return .invalid(FormItemsValidationError.missingField(missingFields))
    }
  }
}

