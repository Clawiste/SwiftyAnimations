//
//  DisplayLinkRunner.swift
//
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation
import QuartzCore

public extension Animation {
    func start(completion: @escaping () -> Void = { () in }) {
        DisplayLinkRunner(animation: self, completion: completion)
    }
}

fileprivate class DisplayLinkRunner: NSObject {
    private var displayLink: CADisplayLink?
    
    private let animation: Animation
    private let completion: () -> Void
    
    @discardableResult
    init(animation: Animation, completion: @escaping () -> Void) {
        self.animation = animation
        self.completion = completion
        
        super.init()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if !animation.advanceAnimation(deltaTime: 0.1) {
                self.completion()
                
                self.displayLink?.invalidate()
                self.displayLink = nil
            }
        }
        
//        displayLink = CADisplayLink(target: self, selector: #selector(step))
//        displayLink?.add(to: .main, forMode: .default)
//        displayLink?.preferredFramesPerSecond = 60
    }
    
    deinit {
        print("----- DEINIT")
    }
    
    @objc
    func step() {
        guard let displayLink else {
            return
        }
        
        if !animation.advanceAnimation(deltaTime: displayLink.duration) {
            self.completion()
            
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
}
