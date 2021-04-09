//
//  ForgotVC.swift
//  Mitten pets
//
//  Created by Mac on 11/01/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class ForgotVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var LblNavigation: EMLabel!{
        didSet{
            LblNavigation.fontStyle = .Navigation
            LblNavigation.text = "Forgot"
        }
    }
    
    @IBOutlet weak var txtEmail: MDCOutlinedTextField!
    {
        didSet{
            txtEmail.label.text = "Email"
            txtEmail.label.textColor = UIColor.AppTextField
            txtEmail.placeHolderColor = UIColor.AppPlaceHolder
            txtEmail.outlineColor(for: .editing)
            txtEmail.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtEmail.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtEmail.sizeToFit()
        }
    }
    @IBOutlet weak var BtnSend: EMButton!{
        didSet{
            BtnSend.btnType = .Submit
        }
    }

    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnRegisterAction(_ sender:UIButton){
        self.pushTo("RegisterVC")
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnForgotAction(_ sender:UIButton){
        guard let text = txtEmail.text, !text.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.EmailNameMissing)
            return
        }
        guard let validEmail = txtEmail.text,  !validEmail.isValidEmail() == false else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidEmail)
            return
        }
        WSForgot(Parameter: ["email":txtEmail.text!])
        
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSForgot(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .Forgot, isAuth: false, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let message  = ResponseDict?.value(forKey: "message") as? String{
                    showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: message, buttons: ["Back To Login"]) { (i) in
                        self.popTo()
                    }
                }
            }
            print("Success Response:",ResponseDict ?? ["":""])
        } Failure: { (ResponseDict, Success, Status) in
            print("Failure Response:",ResponseDict)
        }


    }
}
