//
//  Session.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 27.09.2021.
//

import Foundation

/// Синглтон содержащий данные сессии
class Session {
    /// Экземпляр класса session
    static var shared = Session()
    /// Токен сессии
    var token: String?
    /// Идентификатор  пользователя
    var userID: Int?
    
    private init() {}
}
