//
//  KeypathAnimationBlockDescriptor.swift
//  
//
//  Created by Jan Prokes on 27.10.2023.
//

import Foundation

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
