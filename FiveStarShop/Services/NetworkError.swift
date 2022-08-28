//
//  NetworkError.swift
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

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidURL:
            return "Неверный адрес"
        case .noData:
            return "Данные не найдены"
        case .notFound:
            return "Пожалуйста, введите корректные данные!"
        case .dublicateUser:
            return "Пожалуйста, введите новые данные!"
        case .decodingError:
            return "Ошибка кодирования"
        case .notResponse:
            return "Сервер недоступен"
        }
    }
}
