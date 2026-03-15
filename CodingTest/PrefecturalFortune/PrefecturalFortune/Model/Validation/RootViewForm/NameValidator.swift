//
//  NameValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct NameValidator: RootViewFormValidator {
  var sourceField: RootFormItems.FormField = .name
  var validators: [AnyValidator<Value>] = [
    AnyValidator(EmptyValidator()),
    AnyValidator(LengthValidator(min: 1, max: 127)),
  ]
}
