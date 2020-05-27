//
//  LoginViewController.swift
//  app2
//
//  Created by Jack Liu on 2020/4/26.
//  Copyright © 2020 Jack Liu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var userid:String?
    
    @IBOutlet weak var UserNameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func LoginBtn(_ sender: Any) {
        FuncController.shared.LoginFunc(Email: trylogin.username, Password: trylogin.password) { (recieving) in
            switch recieving{
            case .success(let logindata):
                print(logindata)
                //let storyboard=UIStoryboard(name: "Main", bundle: nil)
                DispatchQueue.main.async {
                    /* let vc = 	storyboard.instantiateViewController(identifier: "PPageView") as! UIViewController
                     vc.modalPresentationStyle = .fullScreen
                     self.present(vc, animated: true, completion: nil)*/
                    self.userid = logindata?._embedded.user.id
                    print("****\n"+(self.userid)!+"\n****")
                    self.performSegue(withIdentifier: "ToPPageLogin", sender: nil)
                    
                }
            case .failure(let networkError):
                switch networkError {
                case .invalidUrl:
                    print("invalid url")
                case .requestFailed(let error):
                    print(error)
                case .invalidData:
                    print(networkError)
                case .invalidResponse:
                    print(networkError)
                    DispatchQueue.main.async {
                         let AController=UIAlertController(title: "Wrong Password or Email.", message: "Please try again.", preferredStyle: .alert)
                         let okAction=UIAlertAction(title: "ok", style: .default, handler: nil)
                         AController.addAction(okAction)
                         self.present(AController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as? PersonalPageViewController
        print(userid)
        controller?.userid=userid
    }
    

}
