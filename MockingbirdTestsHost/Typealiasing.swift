//
//  Typealiasing.swift
//  MockingbirdTestsHost
//
//  Created by Andrew Chang on 8/29/19.
//

import Foundation

// MARK: - Type-scoped typealiases

protocol TypealiasedProtocol {
  typealias Callback = (Bool, Int) -> Void
  typealias IndirectCallback = Callback
  typealias RequestResult = Bool
  typealias IndirectRequestResult = RequestResult
  typealias NSObject = IndirectRequestResult // Shadowing `Foundation.NSObject`
  func request(callback: IndirectCallback) -> IndirectRequestResult
  func request(escapingCallback: @escaping IndirectCallback) -> IndirectRequestResult
  func request(callback: IndirectCallback) -> Foundation.NSObject
}

class TypealiasedClass {
  typealias Callback = (Bool, Int) -> Void
  typealias IndirectCallback = Callback
  typealias RequestResult = Bool
  typealias IndirectRequestResult = RequestResult
  typealias NSObject = IndirectRequestResult // Shadowing `Foundation.NSObject`
  func request(callback: IndirectCallback) -> IndirectRequestResult { return true }
  func request(escapingCallback: @escaping IndirectCallback) -> IndirectRequestResult {
    return true
  }
  func request(callback: IndirectCallback) -> Foundation.NSObject {
    return Foundation.NSObject()
  }
}

// MARK: - Module-scoped typealiases

typealias NSObject = TopLevelType.SecondLevelType
typealias NSObjectProtocol = ModuleScopedAssociatedTypeProtocol

protocol ModuleScopedAssociatedTypeProtocol {
  associatedtype Element
  associatedtype Subelement
  associatedtype Data: ModuleScopedAssociatedTypeProtocol where Data.Element == NSObject
}

protocol InheritingModuleScopedAssociatedTypeProtocol: ModuleScopedAssociatedTypeProtocol {}

protocol ModuleScopedTypealiasedProtocol {
  func request(object: NSObject) -> NSObject
  func request(object: Foundation.NSObject) -> Foundation.NSObject
  func genericRequest<T: NSObjectProtocol>(object: T)
    -> T where T.Element == Foundation.NSObjectProtocol, T.Subelement == NSObject
  
  // MARK: Optional overloads
  func request(object: NSObject?) -> NSObject?
  func request(object: Foundation.NSObject?) -> Foundation.NSObject?
  func genericRequest<T: NSObjectProtocol>(object: T?)
    -> T? where T.Element == Foundation.NSObjectProtocol?, T.Subelement == NSObject?
}
