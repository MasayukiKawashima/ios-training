//
//  FormCompositeValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol CompositeFormValidator {
  associatedtype SourceField
  associatedtype Value

  var sourceField: SourceField { get }
  var validators: [AnyValidator<Value>] { get }
  func validate(_ value: String) -> FormValidationResult<SourceField>
}

extension CompositeFormValidator {
  private func validateAll(_ value: Value) -> [FormValidationState] {
    return validators.map { $0.validate(value) }
  }

  func validate(_ value: Value) -> FormValidationResult<SourceField> {
    let states = validateAll(value)

    return FormValidationResult(
      allValidatorResults: states,
      sourceField: sourceField
    )
  }
}
