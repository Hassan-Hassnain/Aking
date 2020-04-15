//
//  CustomizableStatusBar.swift
//  Pods
//
//  Created by Daniel van Hoesel on 02-03-16.
//
//

import Foundation

public protocol CustomizableStatusBar {
  var statusBarLight: Bool { get set }
  var statusBarHidden: Bool { get set }
}
