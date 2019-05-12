//
//  AttrText.swift
//  HTMLEditorNew
//
//  Created by VyacheslavKrivoi on 5/11/19.
//  Copyright © 2019 VyacheslavKrivoi. All rights reserved.
//

import Foundation
import UIKit

class AttrText {      // simple attributed text.....
    init() {}
    
    func textColor(str:String) -> NSAttributedString {
        
        let stringToColorArray = ["<",">","html", "b>","i>", "p>","div","h1","h2","h3","head","body","img","title","meta" ]
        // MARK: - Приводим к строкам с которыми будем работать
        let someAttributedString = NSMutableAttributedString(string: str)
        let rawString = str as NSString
        // MARK: - Подготавливаемся к поиску диапазонов слова для покраски
        var ranges: [NSRange] = []
        var range: NSRange
        var startLocation = 0
        // MARK: - ищем диапазоны
        for i in 0...stringToColorArray.count-1 {
            
            repeat {
                range = rawString.range(of: stringToColorArray[i],
                                        options: .caseInsensitive,
                                        range: NSRange(location: startLocation, length: rawString.length - startLocation))
                if range.location != NSNotFound {
                    startLocation = range.location + range.length
                    ranges.append(range)
                }
            }
                while (range.location != NSNotFound )
            startLocation = 0
            
        }
        // MARK: - задаем найденным диапазонам нужный цвет
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        for range in ranges {
            someAttributedString.addAttributes(attributes, range: range)
        }
        // MARK: - присваиваем
        return someAttributedString
    }
}
