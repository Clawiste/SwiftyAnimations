//
//  InterpolatableRange.swift
//  
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

struct InterpolatableRange<I: Interpolatable> {
    let lowerBound: I
    let upperBound: I
}

infix operator ...
func ...<I: Interpolatable>(lhs: I, rhs: I) -> InterpolatableRange<I> {
    return InterpolatableRange(lowerBound: lhs, upperBound: rhs)
}
