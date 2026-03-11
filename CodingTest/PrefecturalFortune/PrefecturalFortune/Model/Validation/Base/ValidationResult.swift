//
//  ValidationResult.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct ValidationResult<T> {
  var isValid: Bool
  var validatorStates: [ValidationState]
  var sourceField: T
}
