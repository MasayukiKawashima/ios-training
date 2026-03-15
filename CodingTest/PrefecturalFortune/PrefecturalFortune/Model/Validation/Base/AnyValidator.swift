//
//  AnyValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/15.
//

import Foundation

struct AnyValidator<Value>: FormValidator {

  private let _validate: (Value) -> FormValidationState

  init<V: FormValidator>(_ validator: V) where V.Value == Value {
    self._validate = validator.validate
  }

  func validate(_ value: Value) -> FormValidationState {
    _validate(value)
  }
}
