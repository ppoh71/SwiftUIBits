//
//  Constants.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 05.02.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import UIKit
import SwiftUI

struct Constants {
  static let formFontSizeDefault: CGFloat = 22
  static var yellow = Color(UIColor.hexColor(hex: "#FBA700"))
  static var darkFormColor = Color(UIColor(red:0.51, green:0.51, blue:0.54, alpha:1.0))
  static let formSpaceing: CGFloat = 50
  
  /// Texts
  static let authTextButtonRegister = "Register"
  static let authTextButtonSignIn = "Log In"
  static let authTextEmail = "E-Mail"
  static let authTextPasswordAsterisk = "Password*"
  static let authTextPasswordRepeat = "Repeat Password"
  static let authTextPasswordRequirements = "*Minimum 8 characters, 1 Alphabet and 1 Number"
}
