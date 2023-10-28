//
//  AnyAnimationBlock.swift
//  
//
//  Created by Jan Prokes on 27.10.2023.
//

import Foundation

public protocol AnyAnimationBlock {
    func interpolate(position: Float)
}
