//
//  AnimationBlock.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public protocol AnyAnimationBlock {
    func interpolate(position: Float)
}

public class AnimationBlock: AnyAnimationBlock {
    let interpolator: (Float) -> Void

    init(interpolator: @escaping (Float) -> Void) {
        self.interpolator = interpolator
    }
    
    public func interpolate(position: Float) {
        self.interpolate(position: position)
    }
}

public class KeypathAnimationBlock: AnyAnimationBlock {
    let interpolator: (Float) -> Void
    
    public init<A, I: Interpolatable>(
        keyPath: ReferenceWritableKeyPath<A, I>,
        from: I,
        to: I,
        target: A
    ) {
        interpolator = { position in
            let value = I.interpolate(
                start: from,
                end: to,
                position: position
            )
            
            target[keyPath: keyPath] = value
        }
    }
    
    init<A, I>(
        keyPath: ReferenceWritableKeyPath<A, I>,
        target: A,
        block: @escaping (Float) -> I
    ) {
        interpolator = { position in
            target[keyPath: keyPath] = block(position)
        }
    }
    
    public func interpolate(position: Float) {
        interpolator(position)
    }
}
