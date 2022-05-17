//
//  PickerController.swift
//  ProjectSetUp
//
//  Created by PSSPL on 03/05/22.
//

import UIKit

class PickerController {
    var viewController:UIViewController?
    var selectedDate:selectedDate?
    var selectedValue:buttonClickedEvent?
    func setUpDatePicker() {
        SBPickerSwiftSelector(mode: SBPickerSwiftSelector.Mode.dateDefault, defaultDate: Date()).cancel {
                    print("cancel, will be autodismissed")
                    }.set { values in
                      if let values = values as? [Date] {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "YYYY-MM-dd"
                            self.selectedDate!(values[0])
                        }

                }.present(into: viewController!)
    }
    
    func setUpTextPicker(data:[String]) {
        SBPickerSwiftSelector(mode: SBPickerSwiftSelector.Mode.text, data: data).cancel {
                    print("cancel, will be autodismissed")
                    }.set { values in
                        if let values = values as? [String] {
                            self.selectedValue!(values[0])
                        }
                }.present(into: viewController!)
    }
}
