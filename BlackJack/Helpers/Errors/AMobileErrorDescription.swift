//
//  CustomErrors.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 1/22/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import Foundation

enum AMobileErrorDescription: Int {
    case tecknick = -1
    case noToken = 1
    case tokenMistake = 2
    case numberNotExist = 3
    case toMuchSMS = 4
    case wrongSmsCode = 5
    case wrongPassword = 6
    case usersWalletHasBeenAlreadyCreated = 7
    case walletCreationMistake = 8
    case noRecordWithSuchId = 9
    case createQuotaMistake = 10
    case securityParametr = 102
    
    func errorText() -> String {
        switch self {
        case .tecknick:
            return "Техническая ошибка"
        case .securityParametr:
            return "Неверный параметр безопасности"
        case .noToken:
            return "Токен не существует"
        case .tokenMistake:
            return "Ошибка токена"
        case .numberNotExist:
            return "Номер не существует"
        case .toMuchSMS:
            return "Превышено число отправок SMS-кода в сутки"
        case .wrongSmsCode:
            return "Неверный SMS-код"
        case .wrongPassword:
            return "Неверный пароль"
        case .usersWalletHasBeenAlreadyCreated:
            return "Кошелек у пользователя уже создан "
        case .walletCreationMistake:
            return "Ошибка при создании кошелька"
        case .noRecordWithSuchId:
            return "Записи с таким ID не существует"
        case .createQuotaMistake:
            return "Ошибка при создании квоты, запрещающей расходы на связь с кошелька"
        }
    }
}
