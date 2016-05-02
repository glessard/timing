//
//  Timing.swift
//
//  Created by Guillaume Lessard on 2014-06-24.
//  Copyright (c) 2014 Guillaume Lessard. All rights reserved.
//

import Foundation.NSDate
import Foundation.NSThread
import AppKit.AppKitDefines

/**
  Timing-related utility based on mach_absolute_time().
*/

public struct Time: CustomStringConvertible
{
  private let t: Int64

  public init()
  {
    t = Int64(mach_absolute_time())
  }

  // offset in seconds between the uptime and a timestamp that can be mapped to a date
  // This is not a constant, strictly speaking. Probably close enough, though.

  private static var offset: CFTimeInterval { return CFAbsoluteTimeGetCurrent() - CACurrentMediaTime() }

  /// scale: how to scale from the mach timebase to nanoseconds. See Technical Q&A QA1398

  private static let scale: mach_timebase_info = {
    var info = mach_timebase_info_data_t()
    mach_timebase_info(&info)
    return info
  }()

  /// An analog to the MATLAB tic ... toc time measurement function pair.
  /// example:
  /// let tic = Time()
  /// println(tic.toc)

  public var toc: Interval
  {
    let dt = (Int64(mach_absolute_time()) - t) * Int64(Time.scale.numer) / Int64(Time.scale.denom)
    return Interval(dt)
  }

  public var nanoseconds: Int64
  {
    return t * Int64(Time.scale.numer)/Int64(Time.scale.denom)
  }

  public var absoluteTime: CFAbsoluteTime
  {
      return Double(self.nanoseconds)*1e-9 + Time.offset
  }

  public var description: String
  {
    return NSDate(timeIntervalSinceReferenceDate: absoluteTime).description
  }
}

extension Time
{
  /**
    Time.Since(t: Time) returns an Interval.
    example:
    let starttime = Time()
    println(Time.Since(starttime))
  */

  public static func Since(_ tic: Time) -> Interval
  {
    return tic.toc
  }
}

/**
  A struct whose purpose is to pretty-print short durations of time.
*/

public struct Interval: CustomStringConvertible
{
  var ns: Int64

  init(_ nanoseconds: Int64)
  {
    ns = nanoseconds
  }

  init(_ nanoseconds: Int)
  {
    ns = Int64(nanoseconds)
  }

  init(_ nanoseconds: Double)
  {
    ns = Int64(nanoseconds)
  }

  init(seconds: CFTimeInterval)
  {
    ns = Int64(seconds*1e9)
  }

  public var description: String
    {
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
      if abs(ns) >= 1_000
      {
        // otherwise display as microseconds
        return (Double(ns)/1e3).description + " µs"
      }
      return ns.description + " ns"
  }

  public var interval: CFTimeInterval
  {
    return Double(ns)*1e-9
  }
}

func / (dt: Interval, n: Int) -> Interval
{
  return Interval(dt.ns/Int64(n))
}

func - (lhs: Interval, rhs: Interval) -> Interval
{
  return Interval(lhs.ns - rhs.ns)
}