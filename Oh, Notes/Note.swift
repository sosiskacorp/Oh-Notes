//
//  Note.swift
//  Oh, Notes
//
//  Created by Александр Гапоненко on 01.02.2024.
//

import Foundation
// Модель заметки
class Note: Codable {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}
