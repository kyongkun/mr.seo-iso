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

class AddContentDetailsForCafeVC: UIViewController,UITextFieldDelegate
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var txtTitle: MDCOutlinedTextField!{
        didSet{
            txtTitle.autocorrectionType = .no
            txtTitle.label.text = "Title"
            txtTitle.label.textColor = UIColor.AppTextField
            txtTitle.placeHolderColor = UIColor.AppPlaceHolder
            txtTitle.outlineColor(for: .editing)
            txtTitle.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtTitle.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtTitle.sizeToFit()
        }
    }
    @IBOutlet weak var txtCafeName: MDCOutlinedTextField!{
        didSet{
            txtCafeName.autocorrectionType = .no
            txtCafeName.label.text = "Cafe Name"
            txtCafeName.label.textColor = UIColor.AppTextField
            txtCafeName.placeHolderColor = UIColor.AppPlaceHolder
            txtCafeName.outlineColor(for: .editing)
            txtCafeName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtCafeName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtCafeName.sizeToFit()
        }
    }
    @IBOutlet weak var txtCafeUrl: MDCOutlinedTextField!{
        didSet{
            txtCafeUrl.autocorrectionType = .no
            txtCafeUrl.label.text = "Cafe URL"
            txtCafeUrl.label.textColor = UIColor.AppTextField
            txtCafeUrl.placeHolderColor = UIColor.AppPlaceHolder
            txtCafeUrl.outlineColor(for: .editing)
            txtCafeUrl.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtCafeUrl.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtCafeUrl.sizeToFit()
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
    @IBOutlet weak var ImgProduct:UIImageView!
    var id = String()
var IsEdit = false
    var dataDict = NSDictionary()

    // MARK: - Variables
    var ArrPlatform = [PlatformModel]()
    var ObjCategory = CategoryModel.init(dictionary: [:])

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
            if let title = self.dataDict.value(forKey: "title") as? String
            {
                self.txtTitle.text = title
            }
            if let name = self.dataDict.value(forKey: "name") as? String
            {
                self.txtCafeName.text = name
            }
            if let description = self.dataDict.value(forKey: "description") as? String
            {
                self.txtDescription.textView.text = description
            }
            if let url = self.dataDict.value(forKey: "url") as? String{
                self.txtCafeUrl.text = url
            }
            if let point = self.dataDict.value(forKey: "point") as? Int
            {
                self.txtRegisterPoint.text = point.description
                self.txtRegisterPoint.isUserInteractionEnabled  = false
            }
        }
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    
    @IBAction func BtnChangeImageAction(_ sender:UIButton){
        ImagePickerManager().pickImage(self){ image in
            self.ImgProduct.image = image
        }
    }
    @IBAction func BtnCreatePostAction(_ sender:UIButton){
        guard let textTitle = txtTitle.text, !textTitle.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.TitleMissing)
            return
        }
        guard let textCafeName = txtCafeName.text, !textCafeName.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.CafeNameMissing)
            return
        }
        guard let textRegisterPoint = txtRegisterPoint.text, !textRegisterPoint.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.RegisterPointMissing)
            return
        }
        
        guard let textDescription = txtDescription.textView.text, !textDescription.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.DescriptionMissing)
            return
        }
        guard let textCafeUrl = txtCafeUrl.text, !textCafeUrl.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.CafeURlMissing)
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
        self.WSCreatePost(Parameter: ["title":self.txtTitle.text!,"name":self.txtCafeName.text!,"platform_id":self.id,"category_id":self.ObjCategory!.id!.description,"description":self.txtDescription.textView.text!,"register_point":self.txtRegisterPoint.text!,"url":textCafeUrl])
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
    func WSCreatePost(Parameter:[String:String]) -> Void {
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
    
    
    
    
}
