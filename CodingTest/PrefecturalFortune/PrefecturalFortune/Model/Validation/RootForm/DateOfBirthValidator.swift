//
//  DateOfBirthValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct DateOfBirthValidator: RootFormValidator{
  var validators: [AnyValidator<Value>] = [
    AnyValidator(SlashNumberValidator())
  ]
}
