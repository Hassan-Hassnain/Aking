//
//  CollectionViewEXT.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func regCell(cellName: String){
        self.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }
}
