//
//  HtmlDocument.swift
//  HTMLEditorNew
//
//  Created by VyacheslavKrivoi on 5/11/19.
//  Copyright © 2019 VyacheslavKrivoi. All rights reserved.
//

import UIKit
class HtmlDocument: UIDocument {
    
    var htmlString: String?
    
    override func contents(forType typeName: String) throws -> Any {
        if let content = htmlString {
            let length = content.lengthOfBytes(using: String.Encoding.utf8)
            return NSData(bytes:content, length: length)
        } else {
            return Data()
        }
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let userContent = contents as? Data, userContent.count > 0 {
            htmlString = NSString(bytes: (contents as AnyObject).bytes,
                                  length: userContent.count,
                                  encoding: String.Encoding.utf8.rawValue) as String?
        }
    }
}

