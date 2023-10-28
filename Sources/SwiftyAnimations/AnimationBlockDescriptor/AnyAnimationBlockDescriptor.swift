//
//  AnyAnimationBlockDescriptor.swift
//  
//
//  Created by Jan Prokes on 27.10.2023.
//

import Foundation

public protocol AnyAnimationBlockDescriptor {
    associatedtype A
    
    func block(target: A) -> AnyAnimationBlock
}
