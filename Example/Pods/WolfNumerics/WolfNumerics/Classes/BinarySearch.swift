//
//  BinarySearch.swift
//  WolfNumerics
//
//  Created by Wolf McNally on 6/22/17.
//  Copyright © 2017 WolfMcNally.com.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

@discardableResult public func binarySearch<T: BinaryFloatingPoint>(interval: Interval<T>, start: T, compare: (T) -> ComparisonResult) -> T {
    var current = start
    var interval = interval
    while true {
        switch compare(current) {
        case .orderedSame:
            return current
        case .orderedAscending:
            interval = current .. interval.b
            current = T(0.5).lerpedFromFrac(to: interval)
        case .orderedDescending:
            interval = interval.a .. current
            current = T(0.5).lerpedFromFrac(to: interval)
        }
    }
}

public func binarySearch<T: BinaryFloatingPoint, S>(interval: Interval<T>, start: T, state: S, compare: (T, S) -> (ComparisonResult, S)) -> S {
    var current = start
    var interval = interval
    var state = state
    while true {
        let result: ComparisonResult
        (result, state) = compare(current, state)
        switch result {
        case .orderedSame:
            return state
        case .orderedAscending:
            interval = current .. interval.b
            current = T(0.5).lerpedFromFrac(to: interval)
        case .orderedDescending:
            interval = interval.a .. current
            current = T(0.5).lerpedFromFrac(to: interval)
        }
    }
}

public func compareNeverGreater<T: BinaryFloatingPoint>(_ value1: T, _ value2: T, tolerance: T) -> ComparisonResult {
    guard value1 <= value2 else { return .orderedDescending }
    guard abs(value2 - value1) > tolerance else { return .orderedSame }
    return .orderedAscending
}

extension ComparisonResult {
    public var operatorString: String {
        switch self {
        case .orderedSame:
            return "=="
        case .orderedAscending:
            return "<"
        case .orderedDescending:
            return ">"
        }
    }
}
