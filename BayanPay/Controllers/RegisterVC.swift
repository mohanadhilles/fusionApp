//
//  RegisterVC.swift
//  BayanPay
//
//  Created by Mohanad on 12/17/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegisterVC: UIViewController {

   
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var Password: UITextField!
    var Hamlaid:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.endEditing(true)
        print("HAMLAID",Hamlaid)
        self.navigationItem.hideBackWord()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func RegisterBtn(_ sender: Any) {
        
        let parameters: [String: String]=[
            "Mobile":Email.text!,
            "Password":Password.text!,
            "ConfirmPassword":ConfirmPassword.text!,
        ]
        
        Alamofire.request(Urls.Register, method: .post,parameters:parameters, encoding: URLEncoding.default, headers: Urls.header)
        .validate(statusCode: 200..<500)
        .responseJSON { response  in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if  let _ = json["result"].string,
                    let _ = json["result"].string {
                    self.loadLoginScreen()
                    self.RegisterHamla()
                   
                } else {
                    print("error .. !")
                    self.displayErrorMessage(message: "عذرا قم بإدخال رقم الجوال مبدوء 059 \n وكلمة المرور مكونة من 6 حقول")
                }
                print(response)
            case .failure(let error):
                self.displayErrorMessage(message: "عذرا قم بإدخال رقم الجوال مبدوء 059 \n وكلمة المرور مكونة من 6 حقول")
                print(error)
            }
    }

  }
    
    func RegisterHamla(){
        let url = Urls.RegisterHamla
        let RegisterHamla = url + "\(Email.text!)" + "&Hamlaid=" + "\(Hamlaid)"
        print("RegisterHamla",RegisterHamla)
        Alamofire.request(RegisterHamla, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<500)
            .responseJSON { response  in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if  let _ = json["result"].string,
                        let _ = json["result"].string {
                        
                    } else {
                        print("error .. !")
                    }
                    print(response)
                case .failure(let error):
                    self.displayErrorMessage(message: "عذرا قم بإدخال رقم الجوال مبدوء 059 \n وكلمة المرور مكونة من 6 حقول")
                    print(error)
                }
        }
        
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TbBarVS") as! TbBarVS
        self.present(viewController, animated: true, completion: nil) }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "خطأ بالأدخال", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع ", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }
    }

