//
//  FormCompositeValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol CompositeFormValidator {
  associatedtype SourceField

  var sourceField: SourceField { get }
  var validators: [FormValidator] { get }
  func validate(_ value: String) -> FormValidationResult<SourceField>
}

extension CompositeFormValidator {
  private func validateAll(_ value: String) -> [FormValidationState] {
    return validators.map { $0.validate(value) }
  }

  func validate(_ value: String) -> FormValidationResult<SourceField> {
    let states = validateAll(value)

    return FormValidationResult(
      allValidatorResults: states,
      sourceField: sourceField
    )
  }
}
