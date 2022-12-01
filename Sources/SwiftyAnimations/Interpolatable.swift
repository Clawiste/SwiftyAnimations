//
//  Interpolatable.swift
//  
//
//  Created by Jan Prokes on 01.12.2022.
//

import Foundation

public protocol Interpolatable {
    static func interpolate(start: Self, end: Self, position: Float) -> Self
}
