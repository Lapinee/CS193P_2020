//
//  Array+Only.swift
//  Memorize
//
//  Created by Azuchan on 2021/03/16.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
