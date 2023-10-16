//
//  DisplayLinkRunner.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation
import QuartzCore

public extension Animation {
    @discardableResult
    func start(completion: @escaping () -> Void = { () in }) -> AnimationCancellable {
        return DisplayLinkRunner(animation: self, completion: completion)
    }
}

public protocol AnimationCancellable {
    func stop()
}

fileprivate class DisplayLinkRunner: NSObject, AnimationCancellable {
    private var displayLink: CADisplayLink?
    
    private let animation: Animation
    private let completion: () -> Void
    
    @discardableResult
    init(animation: Animation, completion: @escaping () -> Void) {
        self.animation = animation
        self.completion = completion
        
        super.init()
        
        displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc
    func step() {
        guard let displayLink else {
            return
        }
        
        if animation.advanceAnimation(deltaTime: displayLink.duration) {
            self.completion()
            
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }
}
