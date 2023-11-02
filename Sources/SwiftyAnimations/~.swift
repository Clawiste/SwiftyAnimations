//
//  ~.swift
//
//
//  Created by Jan Prokes on 02.11.2023.
//

import Foundation

infix operator ~

public func ~<A, I: Interpolatable>(
    lhs: ReferenceWritableKeyPath<A, I>,
    rhs: [KeyframeAnimationBlock<A, I>.Keyframe]
) -> KeyframeAnimationBlockDescriptor<A> {
    return KeyframeAnimationBlockDescriptor(keyPath: lhs, keyframes: rhs)
}

public func ~<A, I: Interpolatable>(
    lhs: ReferenceWritableKeyPath<A, I>,
    rhs: InterpolatableRange<I>
) -> KeypathAnimationBlockDescriptor<A> {
    return KeypathAnimationBlockDescriptor(keyPath: lhs, from: rhs.lowerBound, to: rhs.upperBound)
}
