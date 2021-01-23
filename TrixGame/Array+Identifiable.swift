//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 19.01.2021.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
