//
//  RegisterForm.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 04.02.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI

enum ValidateType {
  case validateCurrentPassword
  case validateNewPassword
  case validateComparePassword
  case validateEmail
}

struct RegisterNewUser: View {
  @EnvironmentObject var observerModel: ObserverModel
  @State private var email = ""
  @State private var password1 = ""
  @State private var password2 = ""
  @State private var emaiValidationText: String = "E-Mai is not valid"
  @State private var registerSuccess: Bool = false
  @State private var isValid: Bool = false
  
  // MARK: Validation Function
  
  /// Validation for input data is done also upfront before sending data
  /// and to bind textinput for direct feedback.
  ///
  /// Return Tuple with binding and bool for multiple validation cases.
  func validationBinding(type: ValidateType) -> (Binding<Bool>, Bool) {
    var typeIsValid = false
    
    switch type {
    case .validateEmail:
      typeIsValid = self.validateEmail() ? true : false
    case .validateNewPassword:
      typeIsValid = self.validatePassword(password: self.password1) != .failed || self.password1 == "" ? true : false
    case .validateComparePassword:
      typeIsValid = self.comparePasswords() || self.password2 == "" ? true : false
    default:
      break
    }
    return  (.constant(typeIsValid), typeIsValid)
  }
  
  func validateEmail() -> Bool {
    return Utilities.validateEmailForAuthForm(email: self.email, returnValidWhenEmpty: true )
  }
  
  func validatePassword(password: String) -> PasswordStrengthValidator{
    let passwordStrength = Utilities.isValidPassword(password: password)
    return passwordStrength
  }
  
  func comparePasswords() -> Bool {
    return password1 == password2 ? true : false
  }
  
  func validateAllInputs() -> Bool {
    let validEmail = self.email.isValidEmail()
    let validStrongPassword = Utilities.isValidPassword(password: self.password1)
    let _isValid = validEmail && validStrongPassword != .failed && comparePasswords() ? true : false
    
    /// let the ui know for feedback animation
    DispatchQueue.main.async { self.isValid = _isValid }
    
    /// hide keyboard when alll is valid
    if _isValid {
      DispatchQueue.main.async {
        UIApplication.shared.endEditing()
      }
    }
    return _isValid
  }
  
  var body: some View {

      VStack{
  //      Spacer().frame(height: 10)
       
//        Text("Registration Form")
//          .font(Font.system(size: 18, weight: .bold))
//          .foregroundColor(Constants.yellow)
//          .frame(maxWidth: .infinity, alignment: .center)
//          .padding(20)
        
        Spacer().frame(height: 20)
        
        VStack{
          
          // MARK: Email
          TextField(Constants.authTextEmail, text: self.$email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .textFieldStyle(FormTextStyle())
            .overlay(
              TextFieldValidOverlay(valid: self.validationBinding(type: .validateEmail).0, lineForTextfield: false)
            )
          
          Spacer()
            .frame(height: Constants.formSpaceing)
          
          VStack {
            // MARK: Passwords
            SecureField(Constants.authTextPasswordAsterisk, text: self.$password1)
              .textContentType(.newPassword)
              .textFieldStyle(FormTextStyle())
              .keyboardType(.default)
              .overlay(
                TextFieldValidOverlay(valid: self.validationBinding(type: .validateNewPassword).0, lineForTextfield: false)
              )
            
            Spacer()
              .frame(height: Constants.formSpaceing)
            
            SecureField(Constants.authTextPasswordRepeat, text: self.$password2)
              .textContentType(.newPassword)
              .textFieldStyle(FormTextStyle())
              .keyboardType(.default)
              .overlay(
                TextFieldValidOverlay(valid: self.validationBinding(type: .validateComparePassword).0, lineForTextfield: false)
              )
            
            Spacer().frame(height: 20)
            
            Text(Constants.authTextPasswordRequirements)
              .font(Font.system(size: 11 , weight: .regular))
              .foregroundColor( Constants.darkFormColor)
              .opacity(1)
          }
          
        }
        
        Spacer()
          .frame(height: 20)
        
        VStack{
          Button(action: {
            UIApplication.shared.endEditing()
            
            if self.validateAllInputs() {
              
            }
          }) {
            
          SubmitButtonShape(title:"Register", valid: self.$isValid)
          Spacer()
          }.disabled(!self.validateAllInputs())

        }
      
        Spacer()
      }.padding(30)
      .navigationBarTitle("Registration Form")


  }
}

struct AddNewUser_Previews: PreviewProvider {
  static var previews: some View {
    RegisterNewUser().environmentObject(ObserverModel())
      .background(Color.black)
  }
}
