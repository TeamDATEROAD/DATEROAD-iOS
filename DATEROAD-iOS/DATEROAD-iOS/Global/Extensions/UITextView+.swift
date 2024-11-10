//
//  UITextView+.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 11/8/24.
//

import UIKit

extension UITextView {
    
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(title: "완료",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        
        toolbar.items = [flexSpace, doneButton]
        
        self.inputAccessoryView = toolbar
    }
    
    @objc
    func doneButtonTapped() {
        self.resignFirstResponder()
    }
    
}

