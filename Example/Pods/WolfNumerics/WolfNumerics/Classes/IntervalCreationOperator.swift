//
//  IntervalCreationOperator.swift
//  WolfNumerics
//
//  Created by Wolf McNally on 12/16/17.
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

///
/// Interval-Creation Operator
///
infix operator .. : RangeFormationPrecedence

/// Operator to create a closed floating-point interval. The first number may
/// be greater than the second. Examples:
///
///     let i = 0..100
///     let j = 100..3.14
///
/// - Parameter left: The first bound. May be greater than the second bound
/// - Parameter right: The second bound.
public func .. <T>(left: T, right: T) -> Interval<T> {
    return Interval(left, right)
}
