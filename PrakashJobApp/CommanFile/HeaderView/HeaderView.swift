//
//  HeaderView.swift
//  ProjectSetUp
//
//  Created by PSSPL on 17/05/22.
//

import UIKit

@IBDesignable class HeaderView: UIView {

    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnleft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    var btnClickedEvent:buttonClickedEvent?
    var isRightAvailable:Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
    override init(frame: CGRect) {
           super.init(frame: frame)
           // Setup view from .xib file
        self.setUpCustomView()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           // Setup view from .xib file
           self.setUpCustomView()
       }
    
    
    @IBInspectable var isRight:Bool {
        get {
            return isRightAvailable
        }
        set {
            if (newValue) {
                self.showRightButton()
            } else {
                self.setUpHiddenRight()
            }
        }
    }
    
    @IBInspectable var leftImage:UIImage? {
        get {
            return  self.imgLeft.image
        }
        set {
            self.imgLeft.image = newValue
        }
    }

    @IBInspectable var rightImage:UIImage? {
        get {
            return self.imgRight.image
        }
        set {
            self.imgRight.image = newValue
        }
    }
    
    @IBInspectable var title:String? {
        get {
            return lblTitle.text
        }
        set {
            lblTitle.text = newValue
        }
    }
    func setUpCustomView()  {
       let view = self.xibSetup()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        self.setUpHiddenRight()
        addSubview(view)
    }
    func xibSetup() -> UIView {
//        // Adding custom subview on top of our view
        let bundleName = Bundle(for: type(of: self))
        let nib = UINib(nibName: "HeaderView", bundle: bundleName)
        let view = nib.instantiate(withOwner: self, options: nil).last as! UIView
        view.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: (screenWidth * 0.1))
        return view
    }
    func setUpHiddenRight() {
        self.imgRight.isHidden = true
    //    self.btnRight.isHidden = true
    }
    func showRightButton() {
        self.imgRight.isHidden = false
       // self.btnRight.isHidden = false
    }
    @IBAction func btnLeftClicked(_ sender: Any) {
        btnClickedEvent!(kLeftClicked)
    }
    @IBAction func btnRightClicked(_ sender: Any) {
        btnClickedEvent!(kRightClicked)
    }
    
}
