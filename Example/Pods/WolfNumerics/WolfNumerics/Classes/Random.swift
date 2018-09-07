//
//  Random.swift
//  WolfNumerics
//
//  Created by Wolf McNally on 1/10/16.
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

#if canImport(Glibc)
    import Glibc
#elseif canImport(Security)
    import Security
#endif

private func seedRandom() {
    #if os(Linux)
        srand48(Int(time(nil)))
    #else
        srand48(Int(truncatingIfNeeded: UInt64(arc4random())))
    #endif
}

private var _instance: Random = {
    seedRandom()
    return Random()
}()

public struct Random {
    #if os(Linux)
    let m: UInt64 = UInt64(RAND_MAX) + 1
    #else
    let m: UInt64 = 1 << 32
    #endif

    public static var shared: Random {
        return _instance
    }

    #if os(iOS) || os(macOS) || os(tvOS)
    public func cryptoRandom() -> Int32 {
        let a = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
        defer {
            a.deallocate()
        }
        a.withMemoryRebound(to: UInt8.self, capacity: 4) { p in
            _ = SecRandomCopyBytes(kSecRandomDefault, 4, p)
        }
        let n = a.pointee
        return n
    }
    #endif

    /// Returns a random number in the half-open range 0..<1
    public func number<T: BinaryFloatingPoint>() -> T {
        return T(drand48())
    }

    /// Returns a random number in the half-open range start..<end
    public func number<T: BinaryFloatingPoint>(_ i: Interval<T>) -> T {
        let n: T = number()
        return n.lerpedFromFrac(to: i)
    }

    /// Returns an integer in the half-open range start..<end
    public func number<T: BinaryInteger>(_ i: CountableRange<T>) -> T {
        let a = Double(exactly: Int(i.lowerBound))
        let b = Double(exactly: Int(i.upperBound))
        return T(number(a! .. b!))
    }

    /// Returns an integer in the closed range start...end
    public func number<T: BinaryInteger>(_ i: CountableClosedRange<T>) -> T {
        let a = Double(exactly: Int(i.lowerBound))
        let b = Double(exactly: Int(i.upperBound) + 1)
        return T(number(a! .. b!))
    }

    public func count<T: BinaryInteger>(_ i: CountableClosedRange<T>) -> CountableClosedRange<T> {
        return 0 ... number(i.lowerBound ..< i.upperBound)
    }

    /// Returns a random boolean
    public func boolean() -> Bool {
        return number(0...1) > 0
    }

    // "Generating Gaussian Random Numbers"
    // http://www.taygeta.com/random/gaussian.html

    /// Returns a random number in the range -1.0...1.0 with a Gaussian distribution with zero mean and a standard deviation of one.
    public func gaussian<T: BinaryFloatingPoint>() -> T {
        var x1, x2, w1: Double
        repeat {
            x1 = 2.0 * number() - 1.0
            x2 = 2.0 * number() - 1.0
            w1 = x1 * x1 + x2 * x2
        } while w1 >= 1.0

        let w2 = sqrt( (-2.0 * log(w1)) / 2.0)

        let y1 = x1 * w2
        //let y2 = x2 * w2
        return T(y1)
    }

    /// Returns a random number in the half-open range 0..<1
    public static func number<T: BinaryFloatingPoint>() -> T {
        return Random.shared.number()
    }

    public static func number<T: BinaryFloatingPoint>(_ i: Interval<T>) -> T {
        return Random.shared.number(i)
    }

    /// Returns an integer in the half-open range start..<end
    public static func number<T: BinaryInteger>(_ i: CountableRange<T>) -> T {
        return Random.shared.number(i)
    }

    /// Returns an integer in the closed range start...end
    public static func number<T: BinaryInteger>(_ i: CountableClosedRange<T>) -> T {
        return Random.shared.number(i)
    }

    public static func count<T: BinaryInteger>(_ i: CountableClosedRange<T>) -> CountableClosedRange<T> {
        return Random.shared.count(i)
    }

    /// Returns a random boolean
    public static func boolean() -> Bool {
        return Random.shared.boolean()
    }

    public static func index<C: Collection>(in choices: C) -> C.Index {
        let offset = number(Int(0) ..< choices.count)
        return choices.index(choices.startIndex, offsetBy: offset)
    }

    public static func choice<T, C: Collection>(among choices: C) -> T where C.Iterator.Element == T {
        let index = self.index(in: choices)
        return choices[index]
    }

    public static func choice<T>(_ choices: T...) -> T {
        return choice(among: choices)
    }

    public static func gaussian<T: BinaryFloatingPoint>() -> T {
        return Random.shared.gaussian()
    }
}

extension Random {
    public func index(in string: String) -> String.Index {
        let i = number(0..<string.count)
        return string.index(string.startIndex, offsetBy: i)
    }

    public func insertionPoint(in string: String) -> String.Index {
        let i = number(0...string.count)
        return string.index(string.startIndex, offsetBy: i)
    }

    public static func index(in string: String) -> String.Index {
        return Random.shared.index(in: string)
    }

    public static func insertionPoint(in string: String) -> String.Index {
        return Random.shared.insertionPoint(in: string)
    }
}
