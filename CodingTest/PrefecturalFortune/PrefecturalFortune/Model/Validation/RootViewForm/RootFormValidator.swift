//
//  RootFormValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol RootFormValidator: CompositeValidator where SourceField == RootFormItems.FormField, Value == String {
}

