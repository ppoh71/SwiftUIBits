//
//  Extension.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 04.02.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension String {
  
  /// Check E-Mail with Regex
  func isValidEmail() -> Bool {
    let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,8}$"
    let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
}

/// force ending keyboard
extension UIApplication {
  func endEditing() {
    DispatchQueue.main.async { [weak self] in
      self?.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
  }
}
