//
//  NetworkService.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/16/24.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    let mainService: MainService = MainService()
    
    let authService: AuthService = AuthService()
    
    let userService: UserService = UserService()

}
