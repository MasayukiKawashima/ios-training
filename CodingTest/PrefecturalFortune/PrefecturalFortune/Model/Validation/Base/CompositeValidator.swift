//
//  CompositeValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol CompositeValidator {
  associatedtype SourceField

  var sourceField: SourceField { get }
  var validators: [Validator] { get }
  func validateAll(_ value: String) -> [ValidationState]
  func validate(_ value: String) -> ValidationResult<SourceField>
}

extension CompositeValidator {
  private func validateAll(_ value: String) -> [ValidationState] {
    return validators.map { $0.validate(value) }
  }

  func validate(_ value: String) -> ValidationResult<SourceField> {
    let states = validateAll(value)

    return ValidationResult(
      allValidatorResults: states,
      sourceField: sourceField
    )
  }
}
