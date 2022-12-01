//
//  EasingFunction.swift
//  
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public protocol EasingFunction {
    func interpolate(position: Float) -> Float
}
