//
//  AddContentDetailsVC.swift
//  Mr SEO
//
//  Created by Mac on 02/03/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTypographyScheme_BasicFontScheme
import MaterialComponents.MaterialTextControls_FilledTextAreasTheming
import MaterialComponents.MaterialTextControls_FilledTextFieldsTheming
import MaterialComponents.MaterialTextControls_OutlinedTextAreasTheming
import MaterialComponents.MaterialTextControls_OutlinedTextFieldsTheming
import DropDown

class AddContentforBlogVC: UIViewController,UITextFieldDelegate
{
    // MARK: - UIControlers Outlate
var IsEdit = false
    @IBOutlet weak var txtKeyword: MDCOutlinedTextField!{
        didSet{
            txtKeyword.autocorrectionType = .no
            txtKeyword.label.text = "Keyword"
            txtKeyword.label.textColor = UIColor.AppTextField
            txtKeyword.placeHolderColor = UIColor.AppPlaceHolder
            txtKeyword.outlineColor(for: .editing)
            txtKeyword.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtKeyword.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtKeyword.sizeToFit()
        }
    }
    @IBOutlet weak var txtBlogName: MDCOutlinedTextField!{
        didSet{
            txtBlogName.autocorrectionType = .no

            txtBlogName.label.text = "Blog Name"
            txtBlogName.label.textColor = UIColor.AppTextField
            txtBlogName.placeHolderColor = UIColor.AppPlaceHolder
            txtBlogName.outlineColor(for: .editing)
            txtBlogName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtBlogName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtBlogName.sizeToFit()
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
        }
    }
    
    @IBOutlet weak var txtRegisterPoint: MDCOutlinedTextField!{
        didSet{
            txtRegisterPoint.autocorrectionType = .no

            txtRegisterPoint.label.text = "Register Point"
            txtRegisterPoint.label.textColor = UIColor.AppTextField
            txtRegisterPoint.placeHolderColor = UIColor.AppPlaceHolder
            txtRegisterPoint.outlineColor(for: .editing)
            txtRegisterPoint.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtRegisterPoint.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtRegisterPoint.sizeToFit()
        }
    }
    let dropDown = DropDown()
    var ObjCategory = CategoryModel.init(dictionary: [:])
    var dataDict = NSDictionary()

    var id = String()

    // MARK: - Variables
    var ArrPlatform = [PlatformModel]()
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    @IBOutlet weak var BtnSubmit: EMButton!{
        didSet{
            BtnSubmit.btnType = .Submit
        }
    }

    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        txtRegisterPoint.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        if(self.IsEdit  == false){
            self.BtnSubmit.setTitle("Add", for: .normal)
            self.BtnSubmit.setTitle("Add", for: .selected)
        }
        else{
            self.BtnSubmit.setTitle("Update", for: .normal)
            self.BtnSubmit.setTitle("Update", for: .selected)
        }
        print(self.dataDict)
        if(self.IsEdit == true){
            if let platform_id = self.dataDict.value(forKey: "platform_id") as? Int
            {
                if(self.ArrPlatform.count>0){
                    let Obj = self.ArrPlatform.filter({$0.id == platform_id}).first
                    self.txtKeyword.text = Obj?.title
                    }
            }
            if let keyword = self.dataDict.value(forKey: "keyword") as? String
            {
                self.txtKeyword.text = keyword
            }
            if let name = self.dataDict.value(forKey: "name") as? String
            {
                self.txtBlogName.text = name
            }
            if let description = self.dataDict.value(forKey: "description") as? String
            {
                self.txtDescription.textView.text = description
            }
            if let point = self.dataDict.value(forKey: "point") as? Int
            {
                self.txtRegisterPoint.text = point.description
                self.txtRegisterPoint.isUserInteractionEnabled  = false
            }

        }
        self.WSGetPlatform(Parameter: [:])
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnDropDownAction(_ sender:UIButton){
        if self.ArrPlatform.count > 0{
            self.dropDown.show()
        }
    }
    
    @IBAction func BtnCreatePostAction(_ sender:UIButton){
        guard let textBlogName = txtBlogName.text, !textBlogName.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.BlogMissing)
            return
        }
        guard let textKeyword = txtKeyword.text, !textKeyword.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.KeywordMissing)
            return
        }
        guard let textDescription = txtDescription.textView.text, !textDescription.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.DescriptionMissing)
            return
        }
        guard let textRegisterPoint = txtRegisterPoint.text, !textRegisterPoint.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.RegisterPointMissing)
            return
        }
        if( Int(textRegisterPoint)! > Int(EstalimUser.shared.coin)!) {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidRegisterPoint)
            return
        }
        if( Int(textRegisterPoint)! == 0) {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.enValidRegisterPoint)
            return
        }
        self.WSCreatePost(Parameter: ["name":textBlogName,"keyword":self.txtKeyword.text!,"platform_id":"1","category_id":self.ObjCategory!.id!,"description":self.txtDescription.textView.text!,"register_point":self.txtRegisterPoint.text!])
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.txtRegisterPoint){
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
        }
        return true
    }
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSCreatePost(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .CreatePost, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let message =  ResponseDict?.value(forKey: "message") as? String{
                    showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: message, buttons: ["Go to home"]) { (i) in
                        self.popToRoot()
                    }
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSCreatePost1(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .CreatePost, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let message =  ResponseDict?.value(forKey: "message") as? String{
                    showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: message, buttons: ["Go to home"]) { (i) in
                        self.popToRoot()
                    }
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    
    func WSGetPlatform(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .GetPlatform, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrPlatform.removeAll()
                    self.ArrPlatform = PlatformModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrPlatform.count>0){
                        self.dropDown.dataSource = self.ArrPlatform.map({$0.title!})
                    }
                    else{
                        
                    }
                    
                }
            }
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    
}
