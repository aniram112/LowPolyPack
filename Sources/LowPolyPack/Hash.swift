//
//  Hash.swift
//  LowPoly
//
//  Created by Marina Roshchupkina on 20.04.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

func hash_combine(seed: inout UInt, value: UInt) {
    let tmp = value &+ 0x9e3779b9 &+ (seed << 6) &+ (seed >> 2)
    seed ^= tmp
}
