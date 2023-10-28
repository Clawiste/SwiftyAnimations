//
//  AnimationBlock.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public class AnimationBlock: AnyAnimationBlock {
    let interpolator: (Float) -> Void

    init(interpolator: @escaping (Float) -> Void) {
        self.interpolator = interpolator
    }
    
    public func interpolate(position: Float) {
        interpolator(position)
    }
}
