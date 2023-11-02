//
//  KeyframeAnimationBlockDescriptor.swift
//
//
//  Created by Jan Prokes on 27.10.2023.
//

import Foundation

public struct KeyframeAnimationBlockDescriptor<A>: AnyAnimationBlockDescriptor {
    public struct KeyframeDescriptor<I: Interpolatable> {
        let position: Float
        let value: I
    }
    
    let closure: (A) -> AnyAnimationBlock
    
    public init<I: Interpolatable>(
        keyPath: ReferenceWritableKeyPath<A, I>,
        keyframes: [KeyframeAnimationBlock<A, I>.Keyframe]
    ) {
        closure = { target in
            return KeyframeAnimationBlock(
                keyPath: keyPath,
                target: target,
                keyframes: keyframes
            )
        }
    }
    
    public func block(target: A) -> AnyAnimationBlock {
        return closure(target)
    }
}
