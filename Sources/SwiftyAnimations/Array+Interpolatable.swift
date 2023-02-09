//
//  File.swift
//  
//
//  Created by Jan Prokes on 09.02.2023.
//

import Foundation

public extension Array where Element: Interpolatable {
    func interpolate(points: [Float], progress: Float) -> Element? {
        let count = Swift.min(points.count, count)
        
        switch count {
        case 0:
            return nil
        case 1:
            return self[0];
        case 2:
            return Element.interpolate(start: self[0], end: self[1], position: progress)
        default:
            let firstColorIndex = Int(progress * Float(count - 1))
 
            // Special case: last color (step >= 1.0f)
            if (firstColorIndex == count - 1) {
                return self[count - 1]
            }
 
            // Calculate localStep between local colors:
            
            // stepAtFirstColorIndex will be a bit smaller than step
            let stepAtFirstColorIndex = Float(firstColorIndex) / Float(count - 1)
                    
            // multiply to increase values to range between 0.0f and 1.0f
            let localProgress = (progress - Float(stepAtFirstColorIndex)) * Float(count - 1)
                    
            return Element.interpolate(
                start: self[firstColorIndex],
                end: self[firstColorIndex + 1],
                position: localProgress
            )
        }
    }
}
