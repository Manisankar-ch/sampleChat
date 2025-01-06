//
//  String+Extensions.swift
//  SwiftUIProject
//
//  Created by Mani sankar on 06/01/25.
//

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
