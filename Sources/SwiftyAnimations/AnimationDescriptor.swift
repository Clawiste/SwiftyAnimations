//
//  AnimationDescriptor.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public struct AnimationDescriptor<AABD: AnyAnimationBlockDescriptor>: Identifiable {
    public let id: Animation.ID
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let easingFunction: EasingFunction
    public let repeating: Animation.Repeat
    public let autoreverse: Bool
    public let autoremove: Bool
    public let blockDescriptors: [AABD]
    
    public init(
        id: Animation.ID = UUID(),
        duration: TimeInterval,
        delay: TimeInterval = 0,
        easingFunction: EasingFunction,
        repeating: Animation.Repeat = .finite(0),
        autoreverse: Bool = false,
        autoremove: Bool = true,
        blockDescriptors: [AABD]
    ) {
        self.id = id
        self.duration = duration
        self.delay = delay
        self.easingFunction = easingFunction
        self.repeating = repeating
        self.autoreverse = autoreverse
        self.autoremove = autoremove
        self.blockDescriptors = blockDescriptors
    }
}

public extension AnimationDescriptor {
    func animation(target: AABD.A) -> Animation {
        return Animation(
            id: id,
            duration: duration,
            delay: delay,
            easingFunction: easingFunction,
            repeating: repeating,
            autoreverse: autoreverse,
            autoremove: autoremove,
            blocks: blockDescriptors.map { $0.block(target: target) }
        )
    }
}
