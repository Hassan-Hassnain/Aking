//
//  CustomizableSeparator.swift
//  Pods
//
//  Created by Daniel van Hoesel on 01-03-16.
//
//

import UIKit

protocol CustomizableSeparator {
  var separatorColor: UIColor? { get set }
  var separatorWidth: CGFloat { get set }
  var separatorScaleCorrection: Bool { get set }
}
