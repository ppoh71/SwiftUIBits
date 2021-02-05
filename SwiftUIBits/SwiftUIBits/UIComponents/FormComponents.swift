//
//  FormComponents.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 05.02.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct SubmitButtonShape: View {
  var title: String
  @Binding var valid: Bool
  
  var body: some View {
    ZStack{
      RoundedRectangle(cornerRadius: 30)
        .fill( valid ? Constants.yellow : Color.black)
        .opacity(valid ? 1 : 0.3)
      
      Text(title)
        .font(Font.system(size: Constants.formFontSizeDefault, weight: .regular))
        .foregroundColor(valid ? Color.black : Constants.darkFormColor.opacity(0.3))
    }.frame(height: 40)
  }
}

struct SubmitButtonShape_Previews: PreviewProvider {
  static var previews: some View {
    SubmitButtonShape(title: Constants.authTextButtonSignIn, valid: .constant(false))
  }
}

struct TextFieldValidOverlay: View {
  @Binding var valid: Bool
  var lineForTextfield: Bool

  var body: some View {
    GeometryReader{g in
    ZStack(alignment: .bottom){
      SimpleLine()
        .stroke(!self.valid ? Color.red : Constants.yellow, lineWidth: !self.valid ? 1.5 : 1)
        .frame( width: g.size.width, height: 1)
        .offset(x: 0, y: lineForTextfield ? 22 : 35)
        .opacity(1)
      }.padding(1)
       .animation(.easeInOut(duration: 0.3))
    }
  }
}


struct SimpleLine: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    return path
  }
}



struct TextFieldValidOverlay_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldValidOverlay(valid: .constant(true), lineForTextfield: true)
  }
}

struct FormElements: View {
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct FormElements_Previews: PreviewProvider {
  static var previews: some View {
    FormElements()
  }
}

