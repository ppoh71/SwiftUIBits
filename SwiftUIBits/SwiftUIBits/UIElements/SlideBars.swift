//
//  SlideBars.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 08.01.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct SlideBars: View {
  @Binding var initValue: CGFloat
  @State private var slideValue: Double = 1
  @State private var maxValue: Double = 1
  @State private var previousValue: Double?
  @State private var deltaValue: Double = 0
  
  /// Called on drag
  ///
  /// - Parameter value: y position on drag
  func slideProcess(value: Double){
    guard let _previousValue = previousValue else {
      self.previousValue = value
      return
    }
    
    /// sets also the slide speed per drag distance
    deltaValue = (abs(value - _previousValue)/100)
    
    /// sets the color for the bars
    /// depending on touch direction
    if value < _previousValue {
      self.slideValue = slideValue >= maxValue ? maxValue : slideValue + deltaValue
    } else {
      self.slideValue = slideValue >= 0 ? slideValue - deltaValue : 0
    }
    
    /// set  as previous to get delta
    /// on next cycle
    previousValue = value
    
    /// assign to back binding valuie
    initValue = CGFloat(self.slideValue)
  }
  
  func valueColor(index: Double, slideValue: Double) -> Color{
    var color: Color = Color.yellow
    color = slideValue >= Double(index/10) ?Color.yellow : Color.black.opacity(0.4)
    return color
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 3) {
      VStack(alignment: .leading, spacing: 3){
        ForEach((1...10).reversed(), id:\.self) { index in
          RoundedRectangle(cornerRadius: 2)
            .fill(valueColor(index: Double(index), slideValue: slideValue))
            .frame(width: 50, height: 10, alignment: .center)
        }
      }.gesture(
        DragGesture(minimumDistance: 10)
          .onChanged { value in
            slideProcess(value: Double(value.location.y))
          }
          .onEnded { _ in
            self.previousValue = nil
          }
      )
      .onChange(of: initValue, perform: { value in
        self.slideValue = Double(value)
      })
      .onAppear{
        self.slideValue = Double(initValue)
      }
    }
  }
}

struct SlideBars_Previews: PreviewProvider {
    static var previews: some View {
      ZStack{
        Color.black
        SlideBars(initValue: .constant(1))
      
      }
    }
}
