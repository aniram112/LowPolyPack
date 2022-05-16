//
//  Incircle.swift
//  LowPoly
//
//  Created by Marina Roshchupkina on 21.04.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

public struct Incircle {
    public let incenter: Point
    public let radius: Double
    
    public init(incenter: Point, radius: Double) {
        self.incenter = incenter
        self.radius = radius
    }
}
