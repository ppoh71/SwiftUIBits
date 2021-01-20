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
  
  /// Slide Bars
  @State private var slideBarValue: CGFloat = 1
  
  var body: some View {
    VStack(spacing: 20){
      
      Spacer()
      
      Text("Custom Toggle")
        .font(Font.system(size: 12, weight: .bold))
        .foregroundColor(Color.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
      
      CustomToggle(active: $activeToggle2, knobRadius: 60, color: Color("ToggleOnGreen"))
      
      Spacer()
      
      Text("Scroll Slider")
        .font(Font.system(size: 12, weight: .bold))
        .foregroundColor(Color.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
      
      ScrollSlider()
      
      Spacer()
      
      Text("Slide Bars")
        .font(Font.system(size: 12, weight: .bold))
        .foregroundColor(Color.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
      
      HStack{
        Spacer()
        
        SlideBars(initValue: $slideBarValue)
        
        Spacer()
        
        Image(systemName: "cube")
          .resizable()
          .foregroundColor(.white)
          .frame(width: 50, height: 50, alignment: .center)
          .opacity(Double(slideBarValue))
          .scaleEffect(slideBarValue)
        
        Spacer()
      }
      
      Spacer().frame(height: 100)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .background(Color.black)
  }
}
