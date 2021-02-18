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
    
//    func writeBlankTodayPageToDocumentsFolder(_ page: Page, to file: String) {
//        // Create an empty file if there is none
//        let isEmptyFileCreated = FileManager.default.createEmptyFile(to: file)
//
//        // If file is empty aka 0 pages -> write 1 blankTodayPage
//        FileManager.default.checkAndWriteBlankTodayPage(isEmptyFileCreated, page: page, to: file)
//    }
    
    func createEmptyFile(to file: String) -> Bool {
        let filePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(file)
        
        if FileManager.default.fileExists(atPath: filePath.path) == false {
            FileManager.default.createFile(atPath: filePath.path, contents: nil)
            return true
        } else {
            return false
        }
    }
    
//    func checkAndWriteBlankTodayPage(_ isEmptyFileCreated: Bool, page: Page, to file: String) {
//        let filePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(file)
//        let file: FileHandle? = FileHandle(forUpdatingAtPath: filePath.path)
//        
//        if file == nil {
//            fatalError("🔴 Failed to create a FileHandle for JSON file, make sure it exists first before using it")
//        } else {
//            let data = FileManager.default.encode(page)
//            
//            if isEmptyFileCreated {
//                // If file is empty aka 0 pages -> write 1 blankTodayPage
//                file?.write(data)
//                file?.closeFile()
//            } else {
//                file?.closeFile()
//            }
//        }
//    }
}
