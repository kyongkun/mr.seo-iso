//
//  SupportVC.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTypographyScheme_BasicFontScheme


class SupportVC: UIViewController
{
    // MARK: - UIControlers Outlate

    @IBOutlet weak var txtName: MDCOutlinedTextField!{
        didSet{
            txtName.label.text = "Name"
            txtName.label.textColor = UIColor.AppTextField
            txtName.placeHolderColor = UIColor.AppPlaceHolder
            txtName.outlineColor(for: .editing)
            txtName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtName.sizeToFit()
        }
    }
    @IBOutlet weak var txtEmail: MDCOutlinedTextField!{
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
    @IBOutlet weak var txtPhoneNumber: MDCOutlinedTextField!{
        didSet{
            txtPhoneNumber.label.text = "Phone Number"
            txtPhoneNumber.label.textColor = UIColor.AppTextField
            txtPhoneNumber.placeHolderColor = UIColor.AppPlaceHolder
            txtPhoneNumber.outlineColor(for: .editing)
            txtPhoneNumber.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtPhoneNumber.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtPhoneNumber.sizeToFit()
        }
    }
    @IBOutlet weak var txtDescription: MDCOutlinedTextArea!{
        didSet{
            txtDescription.textView.autocorrectionType = .no
            txtDescription.label.text = "Description"
            txtDescription.label.textColor = UIColor.AppTextField
            txtDescription.placeholderColor = UIColor.AppPlaceHolder
            //txtDescription.textView.placeHolderColor = UIColor.AppPlaceHolder
            txtDescription.outlineColor(for: .editing)
            txtDescription.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtDescription.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtDescription.textView.font = NotoSans_Regular13
            txtDescription.sizeToFit()
            txtDescription.layoutIfNeeded()

        }
    }

    @IBOutlet weak var BtnSend: EMButton!{
        didSet{
            BtnSend.btnType = .Submit
            BtnSend.setTitle("Send", for: .normal)
            BtnSend.setTitle("Send", for: .selected)
        }
    }
    // MARK: - Variables
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
            LblNavigationTitle.text = "Support"
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
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnSendAction(_ sender:UIButton){
        guard let Nametext = txtName.text, !Nametext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.NameMissing)
            return
        }
        guard let text = txtEmail.text, !text.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.EmailNameMissing)
            return
        }
        guard let validEmail = txtEmail.text,  !validEmail.isValidEmail() == false else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidEmail)
            return
        }
        guard let Phonetext = txtPhoneNumber.text, !Phonetext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.MobileMissing)
            return
        }
        guard let Descriptiontext = txtDescription.textView.text, !Descriptiontext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage:"Please enter description.")
            return
        }
        self.WSSupport(Parameter: ["email":txtEmail.text!,"name":self.txtName.text!,"country_code":"+82","mobile":self.txtPhoneNumber.text!,"description":self.txtDescription.textView.text!])
        
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSSupport(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .Support, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let message = ResponseDict?.value(forKey: "message") as? String{
                    
                    showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: message, buttons: ["Go Back"]) { (i) in
                        self.popTo()
                    }
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            print("Failure Response:",ResponseDict)
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
}
