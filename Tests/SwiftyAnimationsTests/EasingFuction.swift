//
//  EasingFunctions.swift
//  SpaceWanderer
//
//  Created by Jan Prokes on 16.07.2022.
//

import Foundation
import simd
import SwiftyAnimations

public enum EasingFunction: SwiftyAnimations.EasingFunction {
    case linear
    
    public func interpolate(position: Float) -> Float {
        switch self {
        case .linear:
            return simd_mix(0, 1, position)
        }
    }
}
