//
//  SwiftUIModifier.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 05.02.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI
import Combine

struct FormTextStyle: TextFieldStyle {
  func _body(configuration: TextField<_Label>) -> some View {
    configuration
      .foregroundColor(Color.white)
      .font(Font.system(size: Constants.formFontSizeDefault, weight: .regular))
      .colorScheme(.dark)
      .multilineTextAlignment(.center)
  }
}


struct FormTextBigFont: TextFieldStyle {
  func _body(configuration: TextField<_Label>) -> some View {
    configuration
      .padding(10)
      .foregroundColor(Constants.darkFormColor)
      .font(Font.system(size: 22 , weight: .regular))
      .colorScheme(.dark)
  }
}

public struct ButtonWithoutAnimation: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

public struct ContexTextMoidifier: ViewModifier {
 public func body(content: Content) -> some View {
    content
      .font(Font.system(size: 12 , weight: .regular))
      .foregroundColor(Color.white)

  }
}
