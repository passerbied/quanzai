//
//  LoginVC.swift
//  QuanZai
//
//  Created by i-chou on 6/22/16.
//  Copyright © 2016 i-chou. All rights reserved.
//


 /// 单例

protocol LoginVCProtocol : class {
    
    func loginSuccessed()
}

class LoginVC: BaseVC {
    
    static let sharedInstance = LoginVC()
    
    var phoneTxt : UITextField!
    var codeTxt : UITextField!
    var codeBtn : UIButton!
    var delegate : LoginVCProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showTitle("登录")
        let closeBtn = UIButton(imageName: "login-close-btn", hlImageName: "") { (closeBtn) in
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.showLeftBarItem(closeBtn)
        self.setupUI()
        
    }
    
    func setupUI() {
        
        self.view.backgroundColor = UIColorFromRGB(0xefefef)
        
        let inputView = UIView()
        inputView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(inputView)
        
        
        var x : CGFloat = 20
        var y : CGFloat = 20
        var w : CGFloat = 100
        var h : CGFloat = 10
        let phoneTitle = UILabel(frame: ccr(x, y, w, h))
        phoneTitle.font = HS_FONT(10)
        phoneTitle.textColor = UIColorFromRGB(0x929292)
        phoneTitle.textAlignment = NSTextAlignment.Left
        phoneTitle.text = "电话号码"
        inputView.addSubview(phoneTitle)
        
        x = phoneTitle.x
        y = CGRectGetMaxY(phoneTitle.frame) + 10
        w = k_SCREEN_W - 20*2
        h = 30
        self.phoneTxt = UITextField(frame: ccr(x, y, w, h))
        self.phoneTxt.font = HS_FONT(18)
        self.phoneTxt.textColor = UIColorFromRGB(0x000000)
        self.phoneTxt.delegate = self
        self.phoneTxt.textAlignment = NSTextAlignment.Left
        self.phoneTxt.returnKeyType = UIReturnKeyType.Next
        self.phoneTxt.keyboardType = UIKeyboardType.NumbersAndPunctuation
        inputView.addSubview(self.phoneTxt)
        
        x = k_SCREEN_W-20-80
        y = self.phoneTxt.y
        w = 80
        h = self.phoneTxt.height
        self.codeBtn = UIButton(imageName: "btn-blue",
                                hlImageName: "",
                                title: "获取验证码",
                                titleColor: UIColorFromRGB(0xcccccc),
                                font: HS_FONT(12),
                                onTapBlock: { (codeBtn) in
                                    self.getCode()
        })
        self.codeBtn.frame = ccr(x, y, w, h)
        inputView.addSubview(self.codeBtn)
        
        
        let line1 = UIImageView(frame: ccr(0, CGRectGetMaxY(self.phoneTxt.frame)+10, k_SCREEN_W, 0.5))
        line1.backgroundColor = UIColorFromRGB(0x929292)
        inputView.addSubview(line1)
        
        x = phoneTitle.x
        y = CGRectGetMaxY(line1.frame) + 20
        w = phoneTitle.width
        h = phoneTitle.height
        let codeTitle = UILabel(frame: ccr(x, y, w, h))
        codeTitle.font = HS_FONT(10)
        codeTitle.textColor = UIColorFromRGB(0x929292)
        codeTitle.textAlignment = NSTextAlignment.Left
        codeTitle.text = "短信验证码"
        inputView.addSubview(codeTitle)
        
        x = phoneTxt.x
        y = CGRectGetMaxY(codeTitle.frame) + 10
        w = phoneTxt.width
        h = phoneTxt.height
        self.codeTxt = UITextField(frame: ccr(x, y, w, h))
        self.codeTxt.font = HS_FONT(18)
        self.codeTxt.textColor = UIColorFromRGB(0x000000)
        self.codeTxt.textAlignment = NSTextAlignment.Left
        self.codeTxt.returnKeyType = UIReturnKeyType.Done
        self.codeTxt.keyboardType = UIKeyboardType.NumbersAndPunctuation
        self.codeTxt.delegate = self
        inputView.addSubview(self.codeTxt)
        
        let line2 = UIImageView(frame: ccr(0, CGRectGetMaxY(self.codeTxt.frame)+10, line1.width, line1.height))
        line2.backgroundColor = UIColorFromRGB(0x929292)
        inputView.addSubview(line2)
        inputView.frame = ccr(0, 0, k_SCREEN_W, CGRectGetMaxY(line2.frame))
        
        let okBtn = UIButton(imageName: "btn-blue",
                             hlImageName: "",
                             title: "登录",
                             titleColor: UIColorFromRGB(0xcccccc),
                             font: HS_FONT(15),
                             onTapBlock: { (codeBtn) in
                                self.login()
        })
        okBtn.frame = ccr(40, CGRectGetMaxY(line2.frame)+50, k_SCREEN_W-40*2, 40)
        self.view.addSubview(okBtn)
        
    }
}

extension LoginVC {
    
    func getCode() {
        print("fetch code")
    }
    
    func login() {
        
        self.delegate?.loginSuccessed()
    }
}

extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.phoneTxt {
            self.codeTxt.becomeFirstResponder()
        } else {
            textField.endEditing(true)
        }
        return true
    }
}
