//
//  UserData.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/30/24.
//

import Foundation

class UserData {
    public func getDataBool(key: String) -> Bool {
        print(UserDefaults.standard.bool(forKey: key))
        return UserDefaults.standard.bool(forKey: key) ?? false
    }
}
