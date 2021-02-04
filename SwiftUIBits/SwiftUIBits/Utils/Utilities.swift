//
//  Utilities.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 04.02.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import Foundation

class Utilities {
  
  /// Check the emal a user has provided in auth forms.
  ///  For ui resons is sometimes important to return true
  ///  even when email is empty
  ///
  /// - Parameters:
  ///   - email: email string
  ///   - returnTrueWhenEmpty: bool for ui form settings
  /// - Returns: emails is valid true/false
  class func validateEmailForAuthForm(email: String, returnValidWhenEmpty: Bool) -> Bool {
    if !email.isEmpty {
      return email.isValidEmail()
    } else {
      return returnValidWhenEmpty ? true : false
    }
  }
  
  
  /// Reg Ex Password Checker
  /// - Parameter password: password string
  /// - Returns: valid password and stength
  class func isValidPassword(password : String) -> PasswordStrengthValidator {
    
    // 8 min, with $,./:;()@$!%*#?&-
    let passwordReg1 =  ("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$,./:;()@$!%*#?&-])[A-Za-z\\d$$,./:;()@$!%*#?&-]{8,}$")
    let predicate1 = NSPredicate(format: "SELF MATCHES %@", passwordReg1)
    let checkStronger = predicate1.evaluate(with: password)
    
    // Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:
    let passwordReg2 =  ("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
    let predicate2 = NSPredicate(format: "SELF MATCHES %@", passwordReg2)
    let checkStrong = predicate2.evaluate(with: password)
    
    // Minimum 8 characters at least 1 Alphabet and 1 Number
    let passwordReg3 =  ("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$") // Minimum 8 characters at least 1 Alphabet and 1 Number
    let predicate3 = NSPredicate(format: "SELF MATCHES %@", passwordReg3)
    let checkAverage = predicate3.evaluate(with: password)
    
    if checkStronger {
      return PasswordStrengthValidator.stronger
    } else if checkStrong {
      return PasswordStrengthValidator.strong
    } else if checkAverage {
      return PasswordStrengthValidator.average
    } else {
      return PasswordStrengthValidator.failed
    }
  }
}


