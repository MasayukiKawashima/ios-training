//
//  LengthValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct LengthValidator: Validator {
  let min: Int
  let max: Int

  func validate(_ value: String) -> ValidationState {
    if value.count >= min && value.count <= max {
      return .valid
    } else {
      return .invalid(.length(min: min, max: max))
    }
  }
}
