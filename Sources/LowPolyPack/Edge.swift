//
//  Edge.swift
//  LowPoly
//
//  Created by Marina Roshchupkina on 20.04.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

struct Edge {
    let p0: Point
    let p1: Point
    
    init(p0: Point, p1: Point) {
        self.p0 = p0
        self.p1 = p1
    }
}

extension Edge: Equatable {
    static func ==(lhs: Edge, rhs: Edge) -> Bool {
        return lhs.p0 == rhs.p0 && lhs.p1 == rhs.p1 || lhs.p0 == rhs.p1 && lhs.p1 == rhs.p0
    }
}
