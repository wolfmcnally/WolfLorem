//
//  Frac.swift
//  WolfNumerics
//
//  Created by Wolf McNally on 6/19/16.
//  Copyright © 2016 WolfMcNally.com.
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

/// `Frac` represents a `Double` value that should always be constrained to the closed interval `0.0 .. 1.0`. Although it is a simple typealias and therefore cannot do bounds checking, it is quite useful as a way to document a value as being fractional in nature. Within WolfNumerics it is often used for values like color components or interpolation amounts.
public typealias Frac = Double

/// Asserts that the value is in the closed interval `0.0 .. 1.0`. As this function is generic, it can be used with the `Frac` typealias or any other floating-point type.
public func assertFrac<T: BinaryFloatingPoint>(_ n: T) {
    assert(0.0 <= n && n <= 1.0)
}

#if !os(Linux)
    public typealias CGFrac = CGFloat
#endif
