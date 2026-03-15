//
//  DateOfBirthValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct DateOfBirthValidator: RootFormValidator{
  var sourceField: RootFormItems.FormField = .dateOfBirth
  var validators: [AnyValidator<Value>] = [
    AnyValidator(SlashNumberValidator())
  ]
}
