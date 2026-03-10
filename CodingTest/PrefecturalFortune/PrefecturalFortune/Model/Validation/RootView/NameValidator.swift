//
//  NameValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

struct NameValidator: CompositeValidator {
  var validators: [Validator] = [
          EmptyValidator(),
          LengthValidator(min: 1, max: 127),
      ]
}
