//
//  ValidationResult.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct ValidationResult<T> {


  // MARK: - Properties

  var allValidatorResults: [ValidationState]
  var sourceField: T


  // MARK: - Methods

  func result() -> ValidationState {
    let state: ValidationState =
      allValidatorResults.first {
        if case .invalid = $0 { return true }
        return false
      } ?? .valid
    return state
  }
}
