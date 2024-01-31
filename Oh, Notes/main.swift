//
//  main.swift
//  Oh, Notes
//
//  Created by Александр Гапоненко on 01.02.2024.
//

import Foundation

func main() {
    let noteManager = NoteManager()

    // Загрузка заметок при запуске
    noteManager.loadNotesFromFile()

    // При первом запуске создаем одну заметку
    if noteManager.notes.isEmpty {
        let defaultNote = Note(text: "Привет, это ваша первая заметка!")
        noteManager.notes.append(defaultNote)
        print("Первая заметка создана.")
    }

    var isRunning = true
    while isRunning {
        print("\nМеню:")
        print("1. Добавить заметку")
        print("2. Показать заметки")
        print("3. Редактировать заметку")
        print("4. Сохранить и выйти")

        if let choice = readLine(), let option = Int(choice) {
            switch option {
            case 1:
                noteManager.addNote()
            case 2:
                noteManager.showNotes()
            case 3:
                noteManager.editNotes()
            case 4:
                noteManager.saveNotesToFile()
                isRunning = false
            default:
                print("Недопустимый выбор.")
            }
        }
    }
}

// Запуск основной программы
main()

