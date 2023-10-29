import XCTest
@testable import SwiftyAnimations

import simd

extension CGPoint: Interpolatable {
    public static func interpolate(start: Self, end: Self, position: Float) -> Self {
        return CGPoint(
            x: Double.interpolate(start: start.x, end: end.x, position: position),
            y: Double.interpolate(start: start.x, end: end.x, position: position)
        )
    }
}

extension Double: Interpolatable {
    public static func interpolate(start: Self, end: Self, position: Float) -> Self {
        return simd_mix(start, end, Double(position))
    }
}

extension CGFloat: Interpolatable {
    public static func interpolate(start: Self, end: Self, position: Float) -> Self {
        return simd_mix(start, end, CGFloat(position))
    }
}

class Element {
    var point: CGPoint
    
    init(point: CGPoint) {
        self.point = point
    }
}

final class SwiftyAnimationsTests: XCTestCase {
    func testKeypath() {
        let element = Element(point: .zero)
        
        let animationDescriptor = AnimationDescriptor<KeypathAnimationBlockDescriptor<Element>>(
            duration: 10,
            easingFunction: EasingFunction.linear,
            blockDescriptors: [
                \Element.point.x ~ (0-->2)
            ]
        )
        
        let animation = Animation(
            duration: animationDescriptor.duration,
            easingFunction: animationDescriptor.easingFunction,
            blocks: animationDescriptor.blockDescriptors.map { $0.block(target: element) }
        )
        
        _ = animation.advanceAnimation(deltaTime: 5)
        
        XCTAssert(element.point.x == 1)
    }
    
    func testKeyframe() {
        let element = Element(point: .zero)
        
        let animationDescriptor = AnimationDescriptor<KeyframeAnimationBlockDescriptor<Element>>(
            duration: 1,
            easingFunction: EasingFunction.linear,
            blockDescriptors: [
                \Element.point.x ~ [
                    .init(position: 0.5, value: 1),
                    .init(position: 0.75, value: 1.5),
                    .init(position: 1, value: 2)
                ]
            ]
        )
        
        let animation = Animation(
            duration: animationDescriptor.duration,
            easingFunction: animationDescriptor.easingFunction,
            blocks: animationDescriptor.blockDescriptors.map { $0.block(target: element) }
        )
        
        _ = animation.advanceAnimation(deltaTime: 0.49)
        
        XCTAssert(element.point.x == 0)
        
        _ = animation.advanceAnimation(deltaTime: 0.01)
        
        XCTAssert(element.point.x == 1)
        
        _ = animation.advanceAnimation(deltaTime: 0.25)
        
        XCTAssert(element.point.x == 1.5)
        
        _ = animation.advanceAnimation(deltaTime: 0.25)
        
        XCTAssert(element.point.x == 2)
    }
}
