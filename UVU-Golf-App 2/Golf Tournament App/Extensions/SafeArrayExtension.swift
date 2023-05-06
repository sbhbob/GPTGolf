//
//  SafeArrayExtension.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 5/3/23.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
