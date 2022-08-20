//
//  ErrorTypeManager.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 20.08.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case notFound
    case dublicateUser
    case decodingError
    case notResponse
}

final class ErrorTypeManager {
    
    static let shared = ErrorTypeManager()
    
    /// Return Error in text for Alert: (title: String, message: String)
    func getErrorAlert(_ error: NetworkError) -> (String, String) {
        var title = "Ошибка"
        var message = "Неизвестная ошибка"
        
        print(error)
        
        switch error {
        case .invalidURL:
            message = "Неверный адрес"
        case .noData:
            message = "Данные не найдены"
        case .notFound:
            title = "Пользователь не найден!"
            message = "Пожалуйста, введите корректные данные!"
        case .dublicateUser:
            title = "Пользователь существует!"
            message = "Пожалуйста, введите новые данные!"
        case .decodingError:
            message = "Ошибка кодирования"
        case .notResponse:
            message = "Сервер недоступен"
        }
        
        return (title, message)
    }
    
    private init() {}
}
