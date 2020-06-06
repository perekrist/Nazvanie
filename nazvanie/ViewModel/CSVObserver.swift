//
//  CSV.swift
//  nazvanie
//
//  Created by Кристина Перегудова on 06.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation

class CSVObserver: ObservableObject {
    
    var data = ""
    var csvRows: [[String]] = [[""]]
    
    init() {
        data = readDataFromCSV(fileName: "new_bad", fileType: "csv")
        data = cleanRows(file: data)
        csvRows = csv(data: data)
    }
    
    func getRandomRow() -> String {
        let a = Int.random(in: 0 ..< csvRows.count)
        let b = Int.random(in: 0 ..< csvRows[a].count)
        
        return csvRows[a][b]
    }
    
    func readDataFromCSV(fileName: String, fileType: String) -> String! {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    
    func cleanRows(file: String) -> String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        return cleanFile
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }
}
