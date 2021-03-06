//
//  CustomizableHighlight.swift
//  Pods
//
//  Created by Daniel van Hoesel on 01-03-16.
//
//

import UIKit

protocol CustomizableHighlight {
  var selectedBackgroundColor: UIColor? { get set }
  var highlightBackgroundColor: UIColor? { get set }
  var normalBackgroundColor: UIColor? { get set }
}
