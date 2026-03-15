//
//  FormCompositeValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol CompositeValidator {
  associatedtype Value

  var validators: [AnyValidator<Value>] { get }
  func validate(_ value: Value) -> ValidationResult
}

extension CompositeValidator {
  private func validateAll(_ value: Value) -> [ValidationState] {
    return validators.map { $0.validate(value) }
  }

  func validate(_ value: Value) -> ValidationResult {
    let states = validateAll(value)
    return ValidationResult(allValidatorResults: states)
  }
}
