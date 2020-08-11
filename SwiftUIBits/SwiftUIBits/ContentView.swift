//
//  ContentView.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 11.08.20.
//  Copyright © 2020 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var activeToggle1: Bool = false
  @State private var activeToggle2: Bool = false
  @State private var activeToggle3: Bool = false
  
  var body: some View {
    VStack(spacing: 60){
      CustomToggle(active: $activeToggle1, knobRadius: 20, color: Color("ToggleOnMagenta"))
      CustomToggle(active: $activeToggle2, knobRadius: 60, color: Color("ToggleOnGreen"))
      CustomToggle(active: $activeToggle3, knobRadius: 120, color: Color("ToggleOnYellow"))
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .edgesIgnoringSafeArea(.all)
  }
}

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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .background(Color.black)
  }
}
