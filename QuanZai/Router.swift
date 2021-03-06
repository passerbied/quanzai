//
//  Router.swift
//  QuanZai
//
//  Created by i-chou on 6/21/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static var token: String?
    
    //Restfull api
    case Login(phone : String, validateCode : String)
    case GetValidateCode(phone : String)
    case GetUserInfo(user_id : String)
    case GetCarInfo(car_id : String)
    case GetDateType(car_id : String)
    case SearchCar(lng : String, lat : String, type : String)
    case SerachNearStore(lng : String, lat : String, type : String)
    case EditUserInfo(user_id : String, phone : String, gender : String, head_portrait : String)
    case UploadPicture(type : String)
    case EditValidateInfo(user_id: String, real_name: String, driving_license: String, dirving_picture: String)
    case GetUserValidateInfo(user_id : String)
    case UserRentRightValidate(user_id : String)
    case UserBalanceValidate(user_id : String, car_id : String)
    case UserVilidate(phone : String, validateCode : String)
    case MakeOrder(user_id : String, car_id : String, date_type_id : String)
    case GetOrderList(user_id: String)
    case GetOrderDetail(order_id: String)
    case OrderPayment(user_id: String)
    case ControlCarRight(user_id: String, lng: String, lat: String, type: String)
    case ReturnCar(user_id: String, car_id: String, store_id: String, order_id: String)
    case ReturnCarAddressConfirm(user_id: String)
    case GetUserAccountBalance(user_id: String)
    case GetUserAccountDetail(user_id: String)
    case RechargeUserAccount(user_id: String, capital: String, type: String)
    case WxGetPayInfo(account: String, password: String, totalFee: String)
    case AliPayGetPayInfo(account: String, password: String, subject: String, body: String, price: String)
    
    var method: Alamofire.Method {
        switch self {
        case .Login,
             .EditUserInfo,
             .UploadPicture,
             .EditValidateInfo,
             .WxGetPayInfo,
             .AliPayGetPayInfo:
            return .POST
        default:
            return .GET
        }
        
    }
    
    
    var path: String {
        switch self {
        case .GetUserInfo(let user_id):
            return ServiceApi.GetUserInfoUrl(user_id)
        case .Login(let phone, let validateCode):
            return ServiceApi.loginUrl(phone, validateCode: validateCode)
        case .GetValidateCode(let phone):
            return ServiceApi.GetValidateCodeUrl(phone)
        case .GetCarInfo(let car_id):
            return ServiceApi.GetCarInfoUrl(car_id)
        case .GetDateType(let car_id):
            return ServiceApi.GetDateTypeUrl(car_id)
        case .SearchCar(let lng, let lat, let type):
            return ServiceApi.SearchCarUrl(lng, lat: lat, type: type)
        case .SerachNearStore(let lng, let lat, let type):
            return ServiceApi.SerachNearStoreUrl(lng, lat: lat, type: type)
        case .EditUserInfo(let user_id, let phone, let gender, let head_portrait):
            return ServiceApi.EditUserInfoUrl(user_id, phone: phone, gender: gender, head_portrait: head_portrait)
        case .UploadPicture(let type):
            return ServiceApi.UploadPictureUrl(type)
        case .EditValidateInfo(let user_id, let real_name, let driving_license, let dirving_picture):
            return ServiceApi.EditValidateInfoUrl(user_id, real_name: real_name, driving_license: driving_license, dirving_picture: dirving_picture)
        case .GetUserValidateInfo(let user_id):
            return ServiceApi.GetUserValidateInfoUrl(user_id)
        case .UserRentRightValidate(let user_id):
            return ServiceApi.UserRentRightValidateUrl(user_id)
        case .UserBalanceValidate(let user_id, let car_id):
            return ServiceApi.UserBalanceValidateUrl(user_id, car_id: car_id)
        case .UserVilidate(let phone, let validateCode):
            return ServiceApi.UserValidateUrl(phone, validateCode: validateCode)
        case .MakeOrder(let user_id, let car_id, let date_type_id):
            return ServiceApi.MakeOrderUrl(user_id, car_id: car_id, date_type_id: date_type_id)
        case .GetOrderList(let user_id):
            return ServiceApi.GetOrderListUrl(user_id)
        case .GetOrderDetail(let order_id):
            return ServiceApi.GetOrderDetailUrl(order_id)
        case .OrderPayment(let user_id):
            return ServiceApi.OrderPaymentUrl(user_id)
        case .ControlCarRight(let user_id, let lng, let lat, let type):
            return ServiceApi.ControlCarRightUrl(user_id, lng: lng, lat: lat, type: type)
        case .ReturnCar(let user_id, let car_id, let store_id, let order_id):
            return ServiceApi.ReturnCarUrl(user_id, car_id: car_id, store_id: store_id, order_id: order_id)
        case .ReturnCarAddressConfirm(let user_id):
            return ServiceApi.ReturnCarAddressConfirmUrl(user_id)
        case .GetUserAccountBalance(let user_id):
            return ServiceApi.GetUserAccountBalanceUrl(user_id)
        case .GetUserAccountDetail(let user_id):
            return ServiceApi.GetUserAccountDetailUrl(user_id)
        case .RechargeUserAccount(let user_id, let capital, let type):
            return ServiceApi.RechargeUserAccountUrl(user_id, capital: capital, type: type)
        case .WxGetPayInfo(let account, let password, let totalFee):
            return ServiceApi.WxGetPayInfoUrl(account, password: password, totalFee: totalFee)
        case .AliPayGetPayInfo(let account, let password, let subject, let body, let price):
            return ServiceApi.AliPayGetPayInfoUrl(account, password: password, subject: subject, body: body, price: price)
        }
    }
    
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: path)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue

//        if let token = Router.token {
//            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "token")
//        }
        
        switch self {
        case .AliPayGetPayInfo(let account, let password, let subject, let body, let price):
            let postStr = "account=\(account)&password=\(password)&subject=\(subject)&body=\(body)&price=\(price)"
            let postData = postStr.dataUsingEncoding(NSUTF8StringEncoding)
            mutableURLRequest.HTTPBody = postData!
            return mutableURLRequest
        case .WxGetPayInfo(let account, let password, let totalFee):
            let postStr = "account=\(account)&password=\(password)&totalFee=\(totalFee)"
            let postData = postStr.dataUsingEncoding(NSUTF8StringEncoding)
            mutableURLRequest.HTTPBody = postData!
            return mutableURLRequest
        default:
            return mutableURLRequest
        }
        
        
    }
}

