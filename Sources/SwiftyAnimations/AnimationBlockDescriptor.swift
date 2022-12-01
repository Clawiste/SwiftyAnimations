//
//  AnimationBlockDescriptor.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public protocol AnyAnimationBlockDescriptor {
    associatedtype A
    
    func block(target: A) -> AnyAnimationBlock
}

infix operator ~
func ~<A, I: Interpolatable>(
    lhs: ReferenceWritableKeyPath<A, I>,
    rhs: InterpolatableRange<I>
) -> KeypathAnimationBlockDescriptor<A> {
    return KeypathAnimationBlockDescriptor(keyPath: lhs, from: rhs.lowerBound, to: rhs.upperBound)
}

struct KeypathAnimationBlockDescriptor<A>: AnyAnimationBlockDescriptor {
    let closure: (A) -> AnyAnimationBlock
    
    public init<I: Interpolatable>(keyPath: ReferenceWritableKeyPath<A, I>, from: I, to: I) {
        closure = { target in
            return KeypathAnimationBlock(keyPath: keyPath, from: from, to: to, target: target)
        }
    }
    
    func block(target: A) -> AnyAnimationBlock {
        return closure(target)
    }
}

struct AnimationBlockDescriptor<A>: AnyAnimationBlockDescriptor {
    let closure: (A) -> AnyAnimationBlock

    init(interpolator: @escaping (A, Float) -> Void) {
        self.closure = { target in
            return AnimationBlock { progress in
                interpolator(target, progress)
            }
        }
    }
    
    func block(target: A) -> AnyAnimationBlock {
        return closure(target)
    }
}
