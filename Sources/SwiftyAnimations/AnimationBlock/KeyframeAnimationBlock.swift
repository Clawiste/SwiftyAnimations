//
//  KeyframeAnimationBlock.swift
//  
//
//  Created by Jan Prokes on 27.10.2023.
//

import Foundation

public class KeyframeAnimationBlock<A, I: Interpolatable>: AnyAnimationBlock {
    public struct Keyframe {
        let position: Float
        let endValue: I
        let interpolator: (Float, I) -> I

        public init(
            position: Float,
            value: I
        ) {
            self.position = position
            self.endValue = value
            
            interpolator = { position, start in
                I.interpolate(
                    start: start,
                    end: value,
                    position: position
                )
            }
        }
        
        public func interpolate(position: Float, start: I) -> I {
            interpolator(position, start)
        }
    }
    
    let keyPath: ReferenceWritableKeyPath<A, I>
    let target: A
    let keyframes: [Keyframe]
    
    private var initialValue: I?
    
    init(
        keyPath: ReferenceWritableKeyPath<A, I>,
        target: A,
        keyframes: [Keyframe]
    ) {
        self.keyPath = keyPath
        self.target = target
        self.keyframes = keyframes
            .sorted(by: { $0.position < $1.position })
    }
    
    public func interpolate(position: Float) {
        if keyframes.count > 1 {
            guard let currentKeyframeIndex = keyframes.enumerated()
                .first(where: { index, keyframe in
                    let nextKeyframeIndex = index + 1
                                        
                    if keyframes.count > nextKeyframeIndex {
                        let nextKeyframe = keyframes[index + 1]
                        
                        return keyframe.position <= position && nextKeyframe.position >= position
                    } else {
                        return false
                    }
                })?
                .offset
            else {
                return
            }
            
            let currentKeyframe = keyframes[currentKeyframeIndex]
            let nextKeyframe = keyframes[currentKeyframeIndex + 1]

            let mappedPosition = (position - currentKeyframe.position) / (nextKeyframe.position - currentKeyframe.position)
            
            target[keyPath: keyPath] = nextKeyframe.interpolate(position: mappedPosition, start: currentKeyframe.endValue)
        }
    }
}
