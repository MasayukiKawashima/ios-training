//
//  EmptyValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct EmptyValidator: Validator {
  func validate(_ value: String) -> ValidationResult {
    if value.isEmpty == true {
      return .invalid(.empty)
    } else {
      return .valid
    }
  }
}
