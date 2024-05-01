//
//  SampleChatUserDefaults.swift
//  SwiftUIProject
//
//  Created by Mani Sankar on 02/05/24.
//

import Foundation

class SampleChatUserDefaults {
    // Define keys for UserDefaults
    private enum Keys {
        static let username = "username"
        static let darkModeEnabled = "darkModeEnabled"
        static let isUserLogin = "isUserLogin"
        // Add more keys for other settings as needed
    }
    
    // MARK: - User Preferences
    private static var getUserDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    // Function to save username to UserDefaults
    static func saveUsername(_ username: String) {
        getUserDefaults.set(username, forKey: Keys.username)
    }
    
    // Function to retrieve username from UserDefaults
    static func getUsername() -> String? {
        return getUserDefaults.string(forKey: Keys.username)
    }
    
    /// Variable will set user login and get the value
    static var isUserLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isUserLogin)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isUserLogin)
        }
    }
}
