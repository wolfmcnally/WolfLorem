//
//  MathUtils.swift
//  WolfNumerics
//
//  Created by Wolf McNally on 7/1/15.
//  Copyright © 2015 WolfMcNally.com.
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

extension BinaryFloatingPoint {
    /// Returns this value clamped to between 0.0 and 1.0
    public func clamped() -> Self {
        return max(min(self, 1.0), 0.0)
    }

    public func clamped(to r: ClosedRange<Self>) -> Self {
        return max(min(self, r.upperBound), r.lowerBound)
    }

    public func ledge() -> Bool {
        return self < 0.5
    }

    public func ledge<T>(_ a: @autoclosure () -> T, _ b: @autoclosure () -> T) -> T {
        return self.ledge() ? a() : b()
    }

    public var fractionalPart: Self {
        return self - rounded(.towardZero)
    }
}

extension BinaryInteger {
    public var isEven: Bool {
        return (self & 1) == 0
    }

    public var isOdd: Bool {
        return (self & 1) == 1
    }
}

public func mod<I: SignedInteger>(_ a: I, _ n: I) -> I {
    precondition(n > 0, "modulus must be positive")
    let r = a % n
    return r >= 0 ? r : r + n
}
