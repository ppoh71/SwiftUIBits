//
//  ObserverModel.swift
//  SwiftUIBits
//
//  Created by Peter Pohlmann on 06.01.21.
//  Copyright © 2021 Peter Pohlmann. All rights reserved.
//

import SwiftUI
import Combine

/// Source of Truth
class ObserverModel: ObservableObject {
  var didChange = PassthroughSubject<Void, Never>()
  
  @Published var someValue: Bool = false

}
