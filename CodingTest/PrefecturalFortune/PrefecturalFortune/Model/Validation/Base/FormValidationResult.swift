//
//  FormValidationResult.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct FormValidationResult<T> {


  // MARK: - Properties

  var allValidatorResults: [FormValidationState]
  var sourceField: T


  // MARK: - Methods

  func result() -> FormValidationState {
    let state: FormValidationState =
      allValidatorResults.first {
        if case .invalid = $0 { return true }
        return false
      } ?? .valid
    return state
  }
}
