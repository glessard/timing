//
//  Timing.swift
//
//  Created by Guillaume Lessard on 2014-06-24.
//  Copyright (c) 2014 Guillaume Lessard. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.TimeInterval

/**
  Time pretty-printing, based on Foundation.Date
*/

extension Date
{
  public var toc: Interval
  {
    return Interval(seconds: -self.timeIntervalSinceNow)
  }
}

/**
  A struct whose purpose is to pretty-print short durations of time.
*/

public struct Interval: CustomStringConvertible
{
  public let ns: Int64

  public init(_ nanoseconds: Int64)
  {
    ns = nanoseconds
  }

  public init(_ nanoseconds: Int)
  {
    ns = Int64(nanoseconds)
  }

  public init(_ nanoseconds: Double)
  {
    ns = Int64(nanoseconds)
  }

  public init(seconds: TimeInterval)
  {
    ns = Int64(seconds*1e9)
  }

  public static func Since(_ tic: Date) -> Interval
  {
    return tic.toc
  }

  public var description: String {
    if abs(ns) > 5_000_000_000
    { // over 5 seconds: round to milliseconds, display as seconds
      return (Double(ns/1_000_000)/1e3).description + " s"
    }
    if abs(ns) >= 1_000_000_000
    { // over 1 second: round to 10s of µs, display as milliseconds
      return (Double(ns/10_000)/1e2).description + " ms"
    }
    if abs(ns) >= 100_000
    { // round to microseconds, display as milliseconds
      return (Double(ns/1000)/1e3).description + " ms"
    }
    if abs(ns) >= 10_000
    { // round to 10s of ns, display as microseconds
      return (Double(ns/10)/1e2).description + " µs"
    }
    if abs(ns) >= 1_000
    {
      // otherwise display as microseconds
      return (Double(ns)/1e3).description + " µs"
    }
    return ns.description + " ns"
  }

  public var interval: TimeInterval
  {
    return Double(ns)*1e-9
  }
}

public func / (dt: Interval, n: Int) -> Interval
{
  return Interval(dt.ns/Int64(n))
}

public func - (lhs: Interval, rhs: Interval) -> Interval
{
  return Interval(lhs.ns - rhs.ns)
}
