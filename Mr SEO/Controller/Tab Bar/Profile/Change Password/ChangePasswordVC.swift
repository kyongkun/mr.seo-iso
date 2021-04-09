//
//  ChangePasswordVC.swift
//  Mr SEO
//
//  Created by Mac on 10/03/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTypographyScheme_BasicFontScheme
class ChangePasswordVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var txtOldPassword: MDCOutlinedTextField!{
        didSet{
            
            txtOldPassword.label.text = "Old Password"
            txtOldPassword.isSecureTextEntry = true
            txtOldPassword.label.textColor = UIColor.AppTextField
            txtOldPassword.placeHolderColor = UIColor.AppPlaceHolder
            txtOldPassword.outlineColor(for: .editing)
            txtOldPassword.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtOldPassword.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtOldPassword.sizeToFit()
        }
    }
    @IBOutlet weak var txtNewPassword: MDCOutlinedTextField!{
        didSet{
            
            txtNewPassword.label.text = "New Password"
            txtNewPassword.isSecureTextEntry = true
            txtNewPassword.label.textColor = UIColor.AppTextField
            txtNewPassword.placeHolderColor = UIColor.AppPlaceHolder
            txtNewPassword.outlineColor(for: .editing)
            txtNewPassword.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtNewPassword.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtNewPassword.sizeToFit()
        }
    }
    @IBOutlet weak var txtCoinfirmPassword: MDCOutlinedTextField!{
        didSet{
            txtCoinfirmPassword.label.text = "Confirm Password"
            txtCoinfirmPassword.isSecureTextEntry = true
            txtCoinfirmPassword.label.textColor = UIColor.AppTextField
            txtCoinfirmPassword.placeHolderColor = UIColor.AppPlaceHolder
            txtCoinfirmPassword.outlineColor(for: .editing)
            txtCoinfirmPassword.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtCoinfirmPassword.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtCoinfirmPassword.sizeToFit()
        }
    }
    // MARK: - Variables
    @IBOutlet weak var BtnChangePassword: EMButton!
    {
        didSet{
            BtnChangePassword.btnType = .Submit
    }
    
    }
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
            LblNavigationTitle.text = "Edit Password"
        }
    }
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnChangePasswordAction(_ sender:UIButton){
        guard let OldPassword = txtOldPassword.text, !OldPassword.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.OldpasswordMissing)
            return
        }
        guard OldPassword.length > 7 else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.OldPasswordLenghtMissing)
            return
        }
        guard let NewPassword = txtNewPassword.text, !NewPassword.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.NewpasswordMissing)
            return
        }
        guard NewPassword.length > 7 else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.NewPasswordLenghtMissing)
            return
        }
        guard let ConfirmPassword = txtCoinfirmPassword.text, !ConfirmPassword.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ConfirmPasswordMissing)
            return
        }
        guard ConfirmPassword.length > 7 else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ConfirmPasswordMissing)
            return
        }

        self.WSChangePassword(Parameter: ["old_password":self.txtOldPassword.text!,"password":self.txtNewPassword.text!,"confirm_password":self.txtCoinfirmPassword.text!])
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    
    func WSChangePassword(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .ChangePassword, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let message = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: message, buttons: ["Go Back!"]) { (i) in
                    if(i == 0){
                        self.popTo()
                    }
                    
                }            }
            }
            
            
        } Failure: { (ResponseDict, Success, Status) in
            print("Failure Response:",ResponseDict)
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
}
