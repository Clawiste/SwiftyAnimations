//
//  Animation.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public class Animation {
    public enum Repeat {
        case infinite
        case finite(Int)
    }
    
    let id: UUID
    let duration: TimeInterval
    let easingFunction: EasingFunction
    let repeating: Repeat
    let autoreverse: Bool
    let autoremove: Bool
    let blocks: [AnyAnimationBlock]

    private var currentDuration: TimeInterval = 0
    private var iteration: Int = 0

    public init(
        id: UUID = UUID(),
        duration: TimeInterval,
        easingFunction: EasingFunction,
        repeating: Repeat = .finite(0),
        autoreverse: Bool = false,
        autoremove: Bool = true,
        blocks: [AnimationBlock]
    ) {
        self.id = id
        self.duration = duration
        self.easingFunction = easingFunction
        self.repeating = repeating
        self.autoreverse = autoreverse
        self.autoremove = autoremove
        self.blocks = blocks
    }
    
    public init(
        id: UUID = UUID(),
        duration: TimeInterval,
        easingFunction: EasingFunction,
        repeating: Repeat = .finite(0),
        autoreverse: Bool = false,
        autoremove: Bool = true,
        block: @escaping (Float) -> Void
    ) {
        self.id = id
        self.duration = duration
        self.easingFunction = easingFunction
        self.repeating = repeating
        self.autoreverse = autoreverse
        self.autoremove = autoremove
        self.blocks = [AnimationBlock(interpolator: block)]
    }
    
    public init(
        id: UUID = UUID(),
        duration: TimeInterval,
        easingFunction: EasingFunction,
        repeating: Repeat = .finite(0),
        autoreverse: Bool = false,
        autoremove: Bool = true,
        blocks: [AnyAnimationBlock]
    ) {
        self.id = id
        self.duration = duration
        self.easingFunction = easingFunction
        self.repeating = repeating
        self.autoreverse = autoreverse
        self.autoremove = autoremove
        self.blocks = blocks
    }

    
    /// Advances animation
    /// - Parameter deltaTime: deltaTime passed since last call to this method
    /// - Returns: `true` when animation finished, `false` when animation is still running
    public func advanceAnimation(deltaTime: TimeInterval) -> Bool {
        currentDuration += deltaTime

        let isReversing = autoreverse ? iteration % 2 == 1 : false
        let currentPosition = easingFunction.interpolate(position: Float(currentDuration / duration))
        
        blocks.forEach { block in
            block.interpolate(position: isReversing ? 1 - currentPosition : currentPosition)
        }

        if currentPosition >= 1 {
            var shouldRepeat: Bool

            switch repeating {
            case .infinite:
                shouldRepeat = true
            case let .finite(amount):
                if autoreverse {
                    shouldRepeat = Float(iteration) * 0.5 <= Float(amount)
                } else {
                    shouldRepeat = iteration < amount
                }
            }

            if shouldRepeat {
                iteration += 1
                currentDuration = 0
                
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
}
