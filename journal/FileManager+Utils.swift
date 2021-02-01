//
//  FileManager+Utils.swift
//  journal
//
//  Created by Loris on 30/01/21.
//
// Decoding/Encoding built on top of https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way
// Writing file with FileHandle with: https://www.techotopia.com/index.php/Working_with_Files_in_Swift_on_iOS_8#Reading_and_Writing_Files_with_FileManager

import Foundation

extension FileManager {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        let filePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: filePath) else {
            fatalError("Couldn't load data from url took from FileManager")
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("🔴 Failed to decode \(file) from FileManager due to missing key '\(key.stringValue)' not found - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            fatalError("🔴 Failed to decode \(file) from FileManager due to type mismatch on \(type) - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context){
            fatalError("🔴 Failed to decode \(file) from FileManager due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("🔴 Failed to decode \(file) from FileManager because it apperas to be invalid JSON")
        } catch {
            fatalError("🔴 Failed to decode from FileManager: \(error.localizedDescription)")
        }
    }
    
    func encode<T: Encodable>(_ type: T) -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            return try encoder.encode(type)
        } catch EncodingError.invalidValue(let value, let context) {
            fatalError("🔴 Failed to encode the given value \(value) - \(context.debugDescription)")
        } catch {
            fatalError("🔴 Failed to encode from FileManager: \(error.localizedDescription)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func writeJSONToDocumentsFolder(_ page: Page, to file: String) {
        let filePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(file)
        var isEmptyFileCreated: Bool
        
        if FileManager.default.fileExists(atPath: filePath.path) == false {
            FileManager.default.createFile(atPath: filePath.path, contents: nil)
            isEmptyFileCreated = true
        } else {
            isEmptyFileCreated = false
        }
        
        let data = FileManager.default.encode([page])
        let file: FileHandle? = FileHandle(forUpdatingAtPath: filePath.path)
        
        if file == nil {
            fatalError("🔴 Failed to create a FileHandle for JSON file, make sure it exists first before using it")
        } else {
            // if the file exists and is empty fill it with a blank page
            // if there is some data in the file:
            // - take it and decode it to a swift object
            // - update the object with a new page
            // - encode the swift object back to a Data object and write it to file
            if isEmptyFileCreated {
                file?.write(data)
                file?.closeFile()
            } else {
                var swiftObject = FileManager.default.decode([Page].self, from: filePath.lastPathComponent)
                
                // Check if the data is up to date
                for item in swiftObject {
                    if item.day == page.day {
                        file?.closeFile()
                        return
                    }
                }
                
                swiftObject.append(page)
                let newData = FileManager.default.encode(swiftObject)
                file?.write(newData)
                file?.closeFile()
            }
        }
    }
}
