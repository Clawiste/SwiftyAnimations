//
//  AnimationBlockDescriptor.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public struct AnimationBlockDescriptor<A>: AnyAnimationBlockDescriptor {
    let closure: (A) -> AnyAnimationBlock

    public init(interpolator: @escaping (A, Float) -> Void) {
        self.closure = { target in
            return AnimationBlock { progress in
                interpolator(target, progress)
            }
        }
    }
    
    public func block(target: A) -> AnyAnimationBlock {
        return closure(target)
    }
}
