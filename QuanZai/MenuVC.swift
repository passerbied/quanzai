//
//  MenuVC.swift
//  QuanZai
//
//  Created by i-chou on 6/20/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

import SlideMenuControllerSwift
import KeychainAccess
import ObjectMapper
import AlamofireImage
import SwiftyDrop

enum LeftMenu: Int {
    case 账户余额 = 0
    case 个人信息修改
    case 租车资格验证
    case 关于
}

protocol MenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class MenuVC : BaseVC {
    
    var menus = ["账户余额", "个人信息修改", "租车资格验证" , "关于"]
    
    var avatarIMG : UIImageView!
    var screenNameLabel : UILabel!
    var logoutBtn: UIButton!
    var delegate: MenuProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let keychain = Keychain(service: service)
        if keychain[k_UserID] == nil {
            self.slideMenuController()?.removeLeftGestures()
        } else {
            self.slideMenuController()?.addLeftGestures()
        }
                
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.getUserInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupUI()
        self.view.layoutIfNeeded()
    }
}

// MARK: - setupUI

extension MenuVC {
    
    func setupUI() {
        self.view.backgroundColor = UIColorFromRGB(0x0aa29c)
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        var w : CGFloat = self.view.width
        var h : CGFloat = k_NAV_BAR_H
        let headerView = UIView(frame:ccr(x, y, w, h))
        headerView.backgroundColor = UIColorFromRGB(0x1b5b76)
        
        x = 20
        y = 10
        w = 40
        h = w
        self.avatarIMG = UIImageView(frame:ccr(x, y, w, h))
        self.avatarIMG.image = IMG("menu-icon")
        
        x = CGRectGetMaxX(self.avatarIMG.frame)+20
        y = self.avatarIMG.y
        w = 100
        h = self.avatarIMG.height
        self.screenNameLabel = UILabel(frame: ccr(x, y, w, h),
                                       color: UIColor.whiteColor(),
                                       font: HS_FONT(15),
                                       text: "",
                                       alignment: NSTextAlignment.Left,
                                       numberOfLines: 1)
        
        
        headerView.addSubview(self.avatarIMG)
        headerView.addSubview(self.screenNameLabel)
        self.view.addSubview(headerView)
        
        var lastY : CGFloat = 0
        
        for index in 0 ..< self.menus.count {
            let title : String = self.menus[index]

            let menuBtn = UIButton(imageName: "",
                                   hlImageName: "",
                                   title: title,
                                   titleColor: UIColor.whiteColor(),
                                   font: HS_FONT(15),
                                   titleEdgeInsets: UIEdgeInsetsZero,
                                   contentHorizontalAlignment: UIControlContentHorizontalAlignment.Left,
                                   onTapBlock: { (menuBtn) in
                                    self.menuTapped(index)
            })
            
            if index == self.menus.count-1 {
                x = 20
                y = 40 * CGFloat(index) + CGRectGetMaxY(headerView.frame)+30
                w = self.view.width - 20*2
                h = 0.5
                let line = UIImageView(frame: ccr(x, y, w, h))
                line.backgroundColor = UIColorFromRGBA(0xcccccc, alpha: 0.5)
                self.view.addSubview(line)
                
                x = self.screenNameLabel.x
                y = CGRectGetMaxY(line.frame)+20
                w = 100
                h = 20
                
            } else {
                x = self.screenNameLabel.x
                y = 40 * CGFloat(index) + CGRectGetMaxY(headerView.frame)+30
                w = 100
                h = 20
            }
            
            menuBtn.frame = ccr(x, y, w, h)
            self.view.addSubview(menuBtn)
            print(menuBtn.frame)
            lastY = menuBtn.y
        }
        
        //退出登录按钮
        logoutBtn = UIButton(imageName: "",
                             hlImageName: "",
                             title: "退出登录",
                             titleColor: UIColor.whiteColor(),
                             font: HS_FONT(15),
                             titleEdgeInsets: UIEdgeInsetsZero,
                             contentHorizontalAlignment: UIControlContentHorizontalAlignment.Left,
                             onTapBlock: { (menuBtn) in
                                self.logout()
        })
        logoutBtn.frame = ccr(self.screenNameLabel.x, lastY + 40, 100, 20)
        self.view.addSubview(logoutBtn)
        
        let keychain = Keychain(service: service)
        if keychain[k_UserID] == nil {
            logoutBtn.alpha = 0
        } else {
            logoutBtn.alpha = 1
        }
    }
    
    func menuTapped(index: Int) {
        if let menu = LeftMenu(rawValue: index) {
            self.slideMenuController()?.closeLeft()
            self.delegate?.changeViewController(menu)
//            self.changeViewController(menu)
        }
    }
}

extension MenuVC {
    
    //加载用户信息
    func getUserInfo() {
        
        guard let user_id = Keychain(service: service)[k_UserID] else {
            logoutBtn.alpha = 0
            self.slideMenuController()?.removeLeftGestures()
            return
        }
        
        logoutBtn.alpha = 1
        self.slideMenuController()?.addLeftGestures()
        APIClient.sharedAPIClient().sendRequest(Router.GetUserInfo(user_id: user_id)) { (objc, error, badNetWork) in
            if let userInfo = Mapper<UserModel>().map(objc) {
                self.avatarIMG.af_setImageWithURL(URL(userInfo.head_portrait!))
                self.avatarIMG.layer.cornerRadius = self.avatarIMG.width/2
                self.avatarIMG.layer.masksToBounds = true
                self.screenNameLabel.text = userInfo.phone!
            }
        }
    }
    
    //退出登录
    func logout() {
        
        let alertControler = UIAlertController(title: "确定要退出登录吗？", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (cancelAction) in
            //do nothing
        }
        
        let logoutAction = UIAlertAction(title: "退出", style: UIAlertActionStyle.Destructive) { (cameraAction) in
            let keychain = Keychain(service: service)
            do {
                try keychain.removeAll()
                self.resetUserInfo()
            } catch {
                Drop.down("退出登录失败", state: DropState.Error)
            }
            
        }
        
        alertControler.addAction(cancelAction)
        alertControler.addAction(logoutAction)
        self.presentViewController(alertControler, animated: true, completion: nil)
    }
    
    func resetUserInfo() {
        self.avatarIMG.image = IMG("menu-icon")
        self.screenNameLabel.text = ""
        self.logoutBtn.alpha = 0
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.closeLeft()
    }
}