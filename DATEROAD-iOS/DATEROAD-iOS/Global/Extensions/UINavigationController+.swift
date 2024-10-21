//
//  UINavigationController+.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 8/26/24.
//

import UIKit

extension UINavigationController {
    
    /// ofType에 해당하는 VC 이동 직전의 화면으로 전환하는 함수
    func popToPreviousViewController<T: UIViewController>(ofType type: T.Type, defaultViewController: UIViewController, animated: Bool = false) {
        if let firstVCIndex = self.viewControllers.firstIndex(where: { $0 is T }) {
            if firstVCIndex > 0 {
                let previousVC = self.viewControllers[firstVCIndex - 1]
                self.popToViewController(previousVC, animated: animated)
            } else {
                // 스택에 해당 ViewController가 없을 경우 기본으로 설정된 ViewController로 이동
                self.setViewControllers([defaultViewController], animated: animated)
            }
        } else {
            // 스택에 해당 ViewController가 없을 경우 기본으로 설정된 ViewController로 이동
            self.setViewControllers([defaultViewController], animated: animated)
        }
    }
    
}
