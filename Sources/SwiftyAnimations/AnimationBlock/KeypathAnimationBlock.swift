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
        from: I,
        to: I,
        target: A
    ) where I: Interpolatable {        
        interpolator = { position in
            target[keyPath: keyPath] = I.interpolate(
                start: from,
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
