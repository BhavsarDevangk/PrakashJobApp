//
//  MBProgressHub.swift
//  ProjectSetUp
//
//  Created by PSSPL on 17/05/22.
//

import Foundation
import MBProgressHUD

class MBProgressHubDisplay: NSObject {
   static var objShared = MBProgressHubDisplay()
    func setupProgressHUB(view:UIView) {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    func dismissProgressHUB(view:UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
 }


