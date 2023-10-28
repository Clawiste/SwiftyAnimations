//
//  KeypathAnimationBlock.swift
//  
//
//  Created by Jan Prokes on 27.10.2023.
//

import Foundation

public class KeypathAnimationBlock<A, I>: AnyAnimationBlock {
    let interpolator: (Float) -> Void
    
    public init(
        keyPath: ReferenceWritableKeyPath<A, I>,
        from: I? = nil,
        to: I,
        target: A
    ) where I: Interpolatable {
        var initialValue: I?
        
        interpolator = { position in
            let start = from ?? initialValue ?? target[keyPath: keyPath]
            
            if initialValue == nil {
                initialValue = start
            }
            
            target[keyPath: keyPath] = I.interpolate(
                start: start,
                end: to,
                position: position
            )
        }
    }
    
    init(
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
