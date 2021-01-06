//
//  CustomToggle.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 06.01.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct CustomToggle: View {
  @Binding var active: Bool
  var knobRadius: CGFloat
  var color: Color
  
  var body: some View {
    Button(action: {
      self.active.toggle()
    }) {
      ZStack(alignment: self.active ? .trailing : .leading){
        RoundedRectangle(cornerRadius: knobRadius/2)
          .fill(Color.gray.opacity(0.3))
          .frame(width: self.knobRadius*2, height: knobRadius)
        
        ZStack{
          Circle()
            .fill(self.active ? color : Color.gray)
            .frame(width: knobRadius, height: knobRadius)

          Circle()
            .fill(self.active ? Color.white.opacity(0.7) : Color.white.opacity(0.5))
            .blur(radius: knobRadius/10)
            .frame(width: knobRadius/3, height: knobRadius/3)
            .offset(x: knobRadius/4, y: -knobRadius/4)
        }
        .rotationEffect(.degrees(self.active ? 0 : -150))
      }.animation(Animation.easeInOut(duration: 0.3))
    }.buttonStyle(ButtonWithoutDefaultAnimation())
  }
}

struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
      CustomToggle(active: .constant(false), knobRadius: 20, color: Color.red)
    }
}
