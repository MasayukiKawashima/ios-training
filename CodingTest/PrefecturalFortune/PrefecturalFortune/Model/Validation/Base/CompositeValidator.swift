//
//  CompositeValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol CompositeValidator: Validator {
  var validators: [Validator] { get }
  func validate(_ value: String) -> ValidationResult
}

extension CompositeValidator {
  func validate(_ value: String) -> [ValidationResult] {
    return validators.map { $0.validate(value) }
  }

  func validate(_ value: String) -> ValidationResult {
    let results: [ValidationResult] = validate(value)

    let errors = results.filter { result -> Bool in
      switch result {
      case .valid: return false
      case .invalid: return true
      }
    }
    return errors.first ?? .valid
  }
}
