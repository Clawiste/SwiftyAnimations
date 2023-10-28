//
//  KeypathAnimationBlockDescriptor.swift
//  
//
//  Created by Jan Prokes on 27.10.2023.
//

import Foundation

infix operator ~
public func ~<A, I: Interpolatable>(
    lhs: ReferenceWritableKeyPath<A, I>,
    rhs: InterpolatableRange<I>
) -> KeypathAnimationBlockDescriptor<A> {
    return KeypathAnimationBlockDescriptor(keyPath: lhs, from: rhs.lowerBound, to: rhs.upperBound)
}

public struct KeypathAnimationBlockDescriptor<A>: AnyAnimationBlockDescriptor {
    let closure: (A) -> AnyAnimationBlock
    
    public init<I: Interpolatable>(keyPath: ReferenceWritableKeyPath<A, I>, from: I, to: I) {
        closure = { target in
            return KeypathAnimationBlock(keyPath: keyPath, from: from, to: to, target: target)
        }
    }
    
    public func block(target: A) -> AnyAnimationBlock {
        return closure(target)
    }
}
