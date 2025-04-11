//
//  UIViewController+.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 4/8/25.
//

import UIKit

extension UIViewController {
    
    // MARK: - 기본 알럿 띄우는 메소드
    
    func presentAlertVC(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: StringLiterals.Alert.confirm, style: .cancel) { _ in
            self.navigationController?.popToRootViewController(animated: false)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
}
