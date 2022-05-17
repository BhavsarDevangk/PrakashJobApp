//
//  TextFieldTableViewCell.swift
//  ProjectSetUp
//
//  Created by PSSPL on 03/05/22.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var txtDescription: UITextField!
    var textValue:selectedValue?
    var eventSelected:selectedEvent?
    var txtBegin:selectedEvent?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.selectionStyle = .none
        txtDescription.delegate = self
        txtDescription.addTarget(self, action: #selector(setUpActionEvent), for: .touchDown)
    }
    @objc func setUpActionEvent() {
        eventSelected!(true, txtDescription.tag)
    }
}

extension TextFieldTableViewCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtBegin!(true, textField.tag)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textValue!(textField.text!, textField.tag)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textValue!(textField.text! + string, textField.tag)
        return true
    }
    
}
