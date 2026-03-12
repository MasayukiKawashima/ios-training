//
//  SlashNumberValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct SlashNumberValidator: FormValidator {
  func validate(_ value: String) -> ValidationState {
    let pattern = "^[0-9/]+$"
    if value.range(of: pattern, options: .regularExpression) != nil {
      return .valid
    } else {
      return .invalid(.inValidCharacter)
    }
  }
}
