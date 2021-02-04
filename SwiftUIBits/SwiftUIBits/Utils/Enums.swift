//
//  Enums.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 04.02.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import Foundation

enum PasswordStrengthValidator {
  case failed
  case average
  case strong
  case stronger

  var stringValue: String {
    switch self {
    case .failed:
      return "Minimum 8 characters at least 1 Alphabet and 1 Number"
    case .average:
      return "Average Password"
    case .strong:
      return "Strong Password"
    case .stronger:
      return "Very Strong Password"
    }
  }
}
