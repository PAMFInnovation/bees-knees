//
//  UIViewController+Alert.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/8/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


extension UIViewController {
    func alert(message: String, title: String, cancelAction: UIAlertAction, confirmAction: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if cancelAction != nil {
            alertController.addAction(cancelAction)
        }
        if confirmAction != nil {
            alertController.addAction(confirmAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
