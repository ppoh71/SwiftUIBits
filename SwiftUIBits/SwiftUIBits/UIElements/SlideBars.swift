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
  
  /// Based on the touch position we can figure out a delta
  /// to add/substract from the curretn value to get the sliding value effect.
  ///
  /// We know the height of the bars, the touch position so we can
  /// calculate all needed values based on that.
  ///
  /// We also set a previous value to find out if we scroll up or down.
  ///
  /// - Parameter value: y position on drag
  func slideProcess(value: Double){
    guard let _previousValue = previousValue else {
      self.previousValue = value
      return
    }
    
    /// Defines the delta to add/substract from sliderValue per touch.
    /// Sets also the slide speed per drag distance.
    ///
    /// Devide by 100 to match the maxVale 1. So the range goes from 0-1
    /// for opacity or scale modifiers.
    ///
    /// More specific: the drag y postion is based on the bar height which id 10.
    /// 10 bars = 100. We want the returning binding value to be from 0 - 1
    /// so we devide by 100.
    ///
    /// This could be made more dymanic to match any desired return value.
    deltaValue = (abs(value - _previousValue)/100)
    
    /// Sets the sliderValue by the delta value depending on touch position and
    /// direction up/down by previous value
    if value > _previousValue {
      self.slideValue = slideValue >= maxValue ? maxValue : slideValue + deltaValue
    } else {
      self.slideValue = slideValue >= 0 ? slideValue - deltaValue : 0
    }
    
    /// Set as previous to get delta on next cycle
    /// and scroll direction.
    previousValue = value
    
    /// assign to back binding valuie
    initValue = CGFloat(self.slideValue)
  }
  
  /// Set the color based the current sliderValue.
  /// The amount of bars (10) is correponding to the maxValue 1 .
  ///
  /// We get the right bar by the id number of the bar divided by 100
  /// to match the sliderValue ( 0 -1)
  ///
  /// - Parameters:
  ///   - index: bar index id
  ///   - slideValue: current sliderValue / touch position
  ///
  /// - Returns: Bar color
  func valueColor(index: Double, slideValue: Double) -> Color{
    var color: Color = Constants.yellow
    color = slideValue >= Double(index/10) ? Color.yellow : Constants.yellow.opacity(0.2)
    return color
  }
  
  var body: some View {
      HStack(spacing: 3){
        
        /// Array Id' are used to set bar color
        ForEach((1...10), id:\.self) { index in
          RoundedRectangle(cornerRadius: 2)
            .fill(valueColor(index: Double(index), slideValue: slideValue))
            .frame(width: 10, height: 20, alignment: .center)
        }
      }
      .highPriorityGesture(
        DragGesture(minimumDistance: 10)
          .onChanged { value in
            slideProcess(value: Double(value.location.x))
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

struct SlideBars_Previews: PreviewProvider {
    static var previews: some View {
      ZStack{
        Color.black
        SlideBars(initValue: .constant(1))
      
      }
    }
}
