//
//  AnimationDescriptor.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public struct AnimationDescriptor<AABD: AnyAnimationBlockDescriptor> {
    let duration: TimeInterval
    let easingFunction: EasingFunction
    let repeating: Animation.Repeat
    let autoreverse: Bool
    let autoremove: Bool
    let blockDescriptors: [AABD]
    
    public init(
        duration: TimeInterval,
        easingFunction: EasingFunction,
        repeating: Animation.Repeat = .finite(0),
        autoreverse: Bool = false,
        autoremove: Bool = true,
        blockDescriptors: [AABD]
    ) {
        self.duration = duration
        self.easingFunction = easingFunction
        self.repeating = repeating
        self.autoreverse = autoreverse
        self.autoremove = autoremove
        self.blockDescriptors = blockDescriptors
    }
}
