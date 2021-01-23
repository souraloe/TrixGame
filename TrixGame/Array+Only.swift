//
//  Array+Only.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 19.01.2021.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
