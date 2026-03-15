//
//  FormCompositeValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol CompositeValidator {
  associatedtype SourceField
  associatedtype Value

  var sourceField: SourceField { get }
  var validators: [AnyValidator<Value>] { get }
  func validate(_ value: String) -> ValidationResult<SourceField>
}

extension CompositeValidator {
  private func validateAll(_ value: Value) -> [ValidationState] {
    return validators.map { $0.validate(value) }
  }

  func validate(_ value: Value) -> ValidationResult<SourceField> {
    let states = validateAll(value)

    return ValidationResult(
      allValidatorResults: states,
      sourceField: sourceField
    )
  }
}
