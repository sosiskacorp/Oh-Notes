//
//  NoteManager.swift
//  Oh, Notes
//
//  Created by Александр Гапоненко on 01.02.2024.
//

import Foundation

class NoteManager {
    //Массив заметок
    var notes: [Note] = []
    
    init() {
        loadNotesFromFile()
    }
    
    //Функция создания новой заметки
    func addNote() {
        print("Введите текст заметки")
        if let noteText = readLine() {
            let newNote = Note(text: noteText)
            notes.append(newNote)
            print("Заметка создана")
            saveNotesToFile()
        }
    }
    
    //Функция просмотра заметок
    func showNotes() {
        if notes.isEmpty {
            print("Заметок не найдено")
        } else {
            print("Список заметок:")
            for (index, note) in notes.enumerated() {
                print("\(index + 1). \(note.text)")
            }
        }
    }
    
    //Функция редактирования заметок
    func editNotes() {
        showNotes()
        if let indexStr = readLine(), let index = Int(indexStr) {
            if index > 0 && index <= notes.count {
                print("Введите новый текст заметки:")
                if let newText = readLine() {
                    notes[index - 1].text = newText
                    print("Заметка отредактирована.")
                    saveNotesToFile()
                }
            } else {
                print("Недопустимый номер заметки.")
            }
        }
    }
    
    //Функция удаления заметки
    func deleteNote() {
            showNotes()
            print("Выберите номер заметки для удаления:")
            if let indexStr = readLine(), let index = Int(indexStr) {
                if index > 0 && index <= notes.count {
                    let deletedNote = notes.remove(at: index - 1)
                    print("Заметка удалена: \(deletedNote.text)")
                    saveNotesToFile()
                } else {
                    print("Недопустимый номер заметки.")
                }
            }
        }
    
    //Функция сохранения заметок в файл(Файл будет хранится в директории "Документы")
    func saveNotesToFile() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let notesURL = documentDirectory.appendingPathComponent("notes.txt")
        
        do {
            let notesData = try JSONEncoder().encode(notes)
            try notesData.write(to: notesURL)
            print("Заметки сохранены.")
        } catch {
            print("Ошибка при сохранении заметок: \(error.localizedDescription)")
        }
    }
    
    //Функция загрузки заметок из файла
    func loadNotesFromFile() {
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let notesURL = documentDirectory.appendingPathComponent("notes.txt")

            if fileManager.fileExists(atPath: notesURL.path) {
                do {
                    let notesData = try Data(contentsOf: notesURL)
                    notes = try JSONDecoder().decode([Note].self, from: notesData)
                    print("Заметки загружены.")
                } catch {
                    print("Ошибка при загрузке заметок: \(error.localizedDescription)")
                }
            } else {
                print("Файл с заметками не найден. Создан новый файл.")
                saveNotesToFile() // Создаем файл и сохраняем первую заметку
            }
        }
    }

