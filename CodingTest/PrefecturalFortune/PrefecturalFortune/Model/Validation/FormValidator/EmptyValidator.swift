//
//  EmptyValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct EmptyValidator: FormValidator {
  func validate(_ value: String) -> FormValidationState {
    if value.isEmpty == true {
      return .invalid(.empty)
    } else {
      return .valid
    }
  }
}
