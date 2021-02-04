//
//  ScrollSlider.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 06.01.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ScrollSlider: View {
  @State private var elementsCount: Int = 1000
  @State private var firstExecution: Bool = true
  @State private var position: CGFloat = 0
  @State private var deltaMoved: CGFloat = 0
  @State private var rotationValue: Double = 0
  @State private var isDragging = false
  
  /// prevent from glitches when view is loaded
  /// execute rotation only when dragging
  var drag: some Gesture {
    DragGesture()
      .onChanged { _ in
        isDragging = true
      }
  }
  
  /// Set values on scrolling
  /// Also check when scrolling stopped
  /// - Parameter value: scroll position
  func valueByScrolling(valuePosition: CGFloat) {
    guard isDragging && valuePosition != position else {
      return
    }

    /// only when scrolled and position changed
    /// gcd b/c Modifying state during view update
    DispatchQueue.main.async {
      /// get value for left/right scrolling 1/-1
      let newValue: CGFloat = valuePosition > position ? 5 : -5
      scrollExecute(value: Double(newValue))

      /// set position value for next scroll execution
      position = valuePosition

      /// when need call a function on stopped scrolling
      checkForStoppedScrolling(checkPosition: valuePosition)
    }
  }
  
  /// If value hasn't changed in a second -> stopp
  /// - Parameter checkPosition: scroll position
  func checkForStoppedScrolling(checkPosition: CGFloat) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      if checkPosition == position {
        stoppedScrollingExecute()
      }
    }
  }
  
  /// Execute on scrolling by type
  /// - Parameter value: value form scrolling
  func scrollExecute(value: Double) {
    rotationValue += value
    firstExecution = false
  }
  
  /// Execute when scrolling stopped by type
  func stoppedScrollingExecute() {
  }
  
  var body: some View {
    VStack{
      
      Image(systemName: "cube")
        .resizable()
        .foregroundColor(.white)
        .frame(width: 30, height: 30, alignment: .center)
        .rotationEffect(.degrees(rotationValue))
      
      Spacer().frame(height: 20)
      
      ZStack{
        ScrollView(Axis.Set.horizontal, showsIndicators: false) {
          ScrollViewReader { scrollValue in
            HStack(alignment: .bottom, spacing: 15) {

              GeometryReader { innerGeo -> Text in
                valueByScrolling(valuePosition: innerGeo.frame(in: .global).minX)
                return Text("")
              }

              ForEach((1...elementsCount), id:\.self) { index in
                Rectangle()
                  .fill(Color.white.opacity(0.8))
                  .frame(width: 1, height: index % 5 == 0 ? 50 : 30, alignment: .bottom)
              }
            }.offset(x: 0, y: -10)
            .onAppear{
              scrollValue.scrollTo(Int(elementsCount/2))
            }

            .onChange(of: position, perform: { value in
              /// Snapback when beginning or end is reached
              /// (calculate  end by  elements and spacing)
              if (position > 0 && position < 50) || (Int(position) < (elementsCount * -10) ){
                scrollValue.scrollTo(Int(elementsCount/2))
              }
            })
          }.gesture(drag)
          .onDisappear{
            self.isDragging = false
          }
        }

        Rectangle()
          .fill(Color.white)
          .frame(width: 2, height: 100, alignment: .bottom)

      }.frame(height: 100, alignment: .center)
    }
  }
}

struct ScrollSlider_Previews: PreviewProvider {
  static var previews: some View {
    ScrollSlider()
     .background(Color.black)
    
  }
}
