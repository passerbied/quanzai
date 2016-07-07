//
//  ServiceAPI.swift
//  QuanZai
//
//  Created by i-chou on 6/21/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

class ServiceApi: NSObject {
    
    static var host : String = "http://123.185.175.210:8081/RentCarManage"
    
    class func encodeUrl(url: String) -> String {
        return url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    
    //获取用户信息
    internal class func getUserInfoUrl(user_id:String) -> String {
        let url = "\(host)/User/Api/GetUserInfo.action?user_id=\(user_id)"
        return self.encodeUrl(url)
    }
    
    //登录
    internal class func loginUrl(phone:String, validateCode:String) -> String {
        
        let url = "\(host)/User/Api/Login.action?phone=\(phone)&validateCode=\(validateCode)"
        return self.encodeUrl(url)
    }
    
    //获取短信验证码
    internal class func GetValidateCodeUrl(phone:String) -> String {
        
        let url = "\(host)/User/Api/GetValidateCode.action?phone=\(phone)"
        return self.encodeUrl(url)
    }

    
    //获取租车类型
    internal class func GetDateTypeUrl(car_id:String) -> String {
        
        let url = "\(host)/Car/Api/GetDateType.action?car_id=\(car_id)"
        return self.encodeUrl(url)
    }
    
    
    //获取车辆详情
    internal class func GetCarInfoUrl(car_id:String) -> String {
        
        let url = "\(host)/Car/Api/GetCarInfo.action?car_id=\(car_id)"
        return self.encodeUrl(url)
    }
    
    
    //搜索车辆
    internal class func SearchCarUrl(lng:String, lat:String, type:String) -> String {
        
        let url = "\(host)/Car/Api/SerachCar.action?lng=\(lng)&lat=\(lat)&type=\(type)"
        return self.encodeUrl(url)
    }
    
    //搜索车场
    internal class func SerachNearStoreUrl(lng:String, lat:String, type:String) -> String {
        
        let url = "\(host)/Car/Api/SerachNearStore.action?lng=\(lng)&lat=\(lat)&type=\(type)"
        return self.encodeUrl(url)
    }
    
    //修改个人信息
    internal class func EditUserInfoUrl(user_id:String,phone:String,gender:String,head_portrait:String) -> String {

        let url = "\(host)/User/Api/EditUserInfo.action?user_id=\(user_id)&phone=\(phone)&gender=\(gender)&head_portrait=\(head_portrait)"
        return self.encodeUrl(url)
    }
    
    //上传图片
    internal class func UploadPictureUrl(type:String) -> String{
        
        let url="\(host)/User/Api/UploadPicture.action?type=\(type)"
        return url
    }
    
    //租车资格验证信息
    internal class func EditValidateInfoUrl(user_id: String, real_name: String, driving_license: String, dirving_picture: String) -> String{
        
        let url="\(host)/User/Api/EditValidateInfo.action?user_id=\(user_id)&real_name=\(real_name)&driving_license=\(driving_license)&dirving_picture=\(dirving_picture)"
        return self.encodeUrl(url)
    }
    
    //获取个人租车验证信息
    internal class func getUserValidateInfoUrl(user_id: String) -> String {
        let url = "\(host)/User/Api/GetUserValidateInfo.action?user_id=\(user_id)"
        return self.encodeUrl(url)
    }
}

