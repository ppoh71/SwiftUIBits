//
//  Components.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 11.08.20.
//  Copyright © 2020 Peter Pohlmann. All rights reserved.
//

import SwiftUI

public struct ButtonWithoutDefaultAnimation: ButtonStyle {
  public func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
  }
}

struct Components: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Components_Previews: PreviewProvider {
    static var previews: some View {
        Components()
    }
}
