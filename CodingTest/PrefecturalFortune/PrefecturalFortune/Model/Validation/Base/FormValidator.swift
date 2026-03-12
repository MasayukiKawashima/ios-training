//
//  FormValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol FormValidator {
    func validate(_ value: String) -> FormValidationState
}
