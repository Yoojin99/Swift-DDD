//
//  Error.swift
//  DDD
//
//  Created by NHN on 2021/06/29.
//

import Foundation

enum ExceptionError: Error {
    case ArgumentExceptionError(String)
    case ExceptionError(String)
}
