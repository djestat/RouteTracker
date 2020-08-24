//
//  DegreesConverter.swift
//  RouteTracker
//
//  Created by Igor on 24.08.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

let π = CGFloat(Double.pi)

func DegreesToRadians (value: CGFloat) -> CGFloat {
    return value * π / 180.0
}

func RadiansToDegrees (value: CGFloat) -> CGFloat {
    return value * 180.0 / π
}

func DegreesToAB (aLong: CGFloat, bShort: CGFloat) -> [CGFloat] {
    var value: [CGFloat] = []
    let tangents: CGFloat = aLong / bShort
    
    let angleDegreesBC: CGFloat = RadiansToDegrees(value: atan(tangents))
    let angleDegreesAC: CGFloat = 180 - 90 - angleDegreesBC
    
    let angleRadiansBC: CGFloat = DegreesToRadians(value: angleDegreesBC)
    let angleRadiansAC: CGFloat = DegreesToRadians(value: angleDegreesAC)
    
    value.append(angleRadiansBC)
    value.append(angleRadiansAC)
    return value
}

/*

let sinus = sin(90.0 * Double.pi / 180)
print("Sinus \(sinus)")

let cosinus = cos(90 * Double.pi / 180)
print("Cosinus \(cosinus)")

let tangents = tan(90 * Double.pi / 180)
print("Tangents \(tangents)")

let arcsinus = asin(1) * 180 / Double.pi
print("Arcsinus \(arcsinus)")

let arcosinus = acos(0) * 180 / Double.pi
print("Arcosinus \(arcosinus)")

let arctangent = atan(1) * 180 / Double.pi
print("Arctangent \(arctangent)")

*/
