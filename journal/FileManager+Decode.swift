//
//  FileManager+Decode.swift
//  journal
//
//  Created by Loris on 30/01/21.
//
// Built on top of https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way

import Foundation

extension FileManager {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = paths[0].appendingPathComponent(file)
        
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
        let filePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(file)
        let data = FileManager.default.encode(page)
        
        do {
            try data.write(to: filePath, options: .atomic)
        } catch {
            fatalError("🔴 Failed to write data in Documents folder: \(error.localizedDescription)")
        }
    }
}
