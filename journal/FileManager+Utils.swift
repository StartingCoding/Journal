//
//  FileManager+Utils.swift
//  journal
//
//  Created by Loris on 30/01/21.
//
// Built on top of https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way

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
    
    func writeJSONToDocumentsFolder(_ page: [Page], to file: String) {
        // https://www.techotopia.com/index.php/Working_with_Files_in_Swift_on_iOS_8#Reading_and_Writing_Files_with_FileManager
        let filePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(file)
        let data = FileManager.default.encode(page)
        var isEmptyFileCreated: Bool
        print(filePath.path)
        
        if FileManager.default.fileExists(atPath: filePath.path) == false {
            FileManager.default.createFile(atPath: filePath.path, contents: nil)
            isEmptyFileCreated = true
        } else {
            isEmptyFileCreated = false
        }
        
        let file: FileHandle? = FileHandle(forUpdatingAtPath: filePath.path)
        if file == nil {
            fatalError("🔴 Failed to create a FileHandle for JSON file, make sure it exists first before using it")
        } else {
            if isEmptyFileCreated {
                file?.write(data)
                file?.closeFile()
            } else {
                // take the data that exists
                // decode data to swift object
                var swiftObject = FileManager.default.decode([Page].self, from: filePath.lastPathComponent)
                print(swiftObject)
                // Check if the data is up to date
                for item in swiftObject {
                    if item.day == page.first!.day {
                        file?.closeFile()
                        return
                    }
                }
                // update swift object
                swiftObject.append(page.first!)
                print(swiftObject)
                // encode swift object to data updated
                let newData = FileManager.default.encode(swiftObject)
                // write new data
                file?.write(newData)
                // close file
                file?.closeFile()
            }
        }
    }
}
