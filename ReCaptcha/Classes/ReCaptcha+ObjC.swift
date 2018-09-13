//
//  ReCaptcha+ObjC.swift
//  Vote4DC
//
//  Created by Matthew Becker on 9/12/18.
//  Copyright © 2018 Konnech Inc'. All rights reserved.
//

import UIKit
import WebKit

extension ReCaptcha {
    /**
     Convenience initializer for Objective-C implementations which do not have support for swift enums
     */
    
    @objc public convenience init(
        apiKey: String? = nil,
        baseURL: URL? = nil,
        endpoint: String? = nil,
        locale: Locale? = nil
        ) throws {

        var realendpoint: Endpoint = .default
        if (endpoint != "default") {
            realendpoint = .alternate
        }
        try! self.init(apiKey: apiKey, baseURL: baseURL, endpoint: realendpoint, locale:locale)
    }
    
    /**
     Validate method for use with ObjC; this method implements the original `validate` function and passes the result
     to a new completion closure
     */
    @objc public func objcValidate(on view: UIView, resetOnError: Bool = true,
                                   completion: @escaping (_ result: String?) -> Void) {
        self.validate(on: view, resetOnError: resetOnError) { (result) in
            completion(try! result.dematerialize())
        }
    }
    
    @objc public func objcReset() {
        self.reset()
    }
    
    @objc public func objcConfigureWebView(_ configure: @escaping (WKWebView) -> Void) {
        self.configureWebView(configure)
        manager.configureWebView = configure
    }
}
