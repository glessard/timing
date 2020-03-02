//
//  Timing.swift
//
//  Copyright (c) 2014-2020 Guillaume Lessard. All rights reserved.
//

import class  Foundation.ProcessInfo
import struct Foundation.TimeInterval

/**
  Timestamp
*/

public struct Tic
{
  private let tic: TimeInterval

  public init()
  {
    tic = ProcessInfo.processInfo.systemUptime
  }

  public var toc: TimingInterval
  {
    return TimingInterval(seconds: ProcessInfo.processInfo.systemUptime - tic)
  }
}

/**
  A struct whose purpose is to pretty-print short durations of time.
*/

public struct TimingInterval: CustomStringConvertible
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

  public static func since(_ tic: Tic) -> TimingInterval
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

@available(*, unavailable, renamed: "TimingInterval")
public struct Interval {}

public func / (dt: TimingInterval, n: Int) -> TimingInterval
{
  return TimingInterval(dt.ns/Int64(n))
}

public func - (lhs: TimingInterval, rhs: TimingInterval) -> TimingInterval
{
  return TimingInterval(lhs.ns - rhs.ns)
}
