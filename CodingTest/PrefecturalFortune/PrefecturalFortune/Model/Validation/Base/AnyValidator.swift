//
//  AnyValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/15.
//

import Foundation

struct AnyValidator<Value>: Validator {

  private let _validate: (Value) -> ValidationState

  init<V: Validator>(_ validator: V) where V.Value == Value {
    self._validate = validator.validate
  }

  func validate(_ value: Value) -> ValidationState {
    _validate(value)
  }
}
