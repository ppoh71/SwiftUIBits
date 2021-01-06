//
//  ScrollSlider.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 06.01.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ScrollSlider: View {
  @State private var elementsCount: Int = 2000
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
        self.isDragging = true
      }
  }
  
  /// Set values on scrolling
  /// Also check when scrolling stopped
  /// - Parameter value: scroll position
  func valueByScrolling(value: CGFloat) {
    guard isDragging && value != position else {
      return
    }
    
    /// only when scrolled and position changed
    /// gcd b/c Modifying state during view update
    DispatchQueue.main.async {
      /// get value for left/right scrolling 1/-1
      let newValue: CGFloat = value > position ? 5 : -5
      scrollExecute(value: Double(newValue))
      
      /// set position value for next execution
      position = value
      
      /// when need call a function on stopped scrolling
      checkForStoppedScrolling(checkPosition: value)
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
  
  // MARK: Execute on scrolling
  
  /// Execute on scrolling by type
  /// - Parameter value: value form scrolling
  func scrollExecute(value: Double) {
    rotationValue += value
    firstExecution = false
  }
  
  // MARK: Stop on scrolling
  
  /// Execute when scrolling stopped by type
  func stoppedScrollingExecute() {
  }
  
  var body: some View {
    VStack{
      
      Image("arreaLogo")
        .resizable()
        .frame(width: 200, height: 200, alignment: .center)
        .rotation3DEffect(.degrees(rotationValue), axis: (x: 1, y: 1, z: 0))
      
      Spacer().frame(height: 20)
      
      ZStack{
        ScrollView(Axis.Set.horizontal, showsIndicators: false) {
          ScrollViewReader { scrollValue in
            HStack(alignment: .bottom, spacing: 15) {
              GeometryReader { innerGeo -> Text in
                valueByScrolling(value: innerGeo.frame(in: .global).minX)
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
          }
        }
        
        Rectangle()
          .fill(Color.white)
          .frame(width: 2, height: 100, alignment: .bottom)
        
      }.frame(height: 100, alignment: .center)
      
      .gesture(drag)
      .onDisappear{
        self.isDragging = false
      }
    }
  }
}


struct ScrollSlider_Previews: PreviewProvider {
  static var previews: some View {
    ScrollSlider()
      .background(Color.black)
    
  }
}
