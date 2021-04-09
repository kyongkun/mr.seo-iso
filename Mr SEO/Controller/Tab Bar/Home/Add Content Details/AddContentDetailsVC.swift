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

class AddContentDetailsVC: UIViewController,UITextFieldDelegate
{
    var dataDict = NSDictionary()
    
    // MARK: - UIControlers Outlate
    @IBOutlet weak var txtPlatform: MDCOutlinedTextField!{
        didSet{
            txtPlatform.label.text = "오픈마켓"
            txtPlatform.autocorrectionType = .no
            
            let eyeIcon = UIImageView(image: UIImage(named: "ic_dropdown"))
            txtPlatform.trailingView = eyeIcon
            txtPlatform.trailingViewMode = .always
            txtPlatform.label.textColor = UIColor.AppTextField
            txtPlatform.placeHolderColor = UIColor.AppPlaceHolder
            txtPlatform.outlineColor(for: .editing)
            txtPlatform.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtPlatform.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtPlatform.sizeToFit()
        }
    }
    @IBOutlet weak var TxtOther: MDCOutlinedTextField!{
        didSet{
            TxtOther.label.text = "기타"
            TxtOther.autocorrectionType = .no
            TxtOther.label.textColor = UIColor.AppTextField
            TxtOther.placeHolderColor = UIColor.AppPlaceHolder
            TxtOther.outlineColor(for: .editing)
            TxtOther.setOutlineColor(UIColor.AppTextField, for: .editing)
            TxtOther.setOutlineColor(UIColor.AppTextField, for: .normal)
            TxtOther.sizeToFit()
            TxtOther.isHidden = true
        }
    }
    @IBOutlet weak var txtKeyword: MDCOutlinedTextField!{
        didSet{
            txtKeyword.label.text = "키워드"
            txtKeyword.autocorrectionType = .no
            txtKeyword.label.textColor = UIColor.AppTextField
            txtKeyword.placeHolderColor = UIColor.AppPlaceHolder
            txtKeyword.outlineColor(for: .editing)
            txtKeyword.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtKeyword.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtKeyword.sizeToFit()
        }
    }
    @IBOutlet weak var txtShoppingMallName: MDCOutlinedTextField!{
        didSet{
            txtShoppingMallName.autocorrectionType = .no
            txtShoppingMallName.label.text = "쇼핑몰 이름"
            txtShoppingMallName.label.textColor = UIColor.AppTextField
            txtShoppingMallName.placeHolderColor = UIColor.AppPlaceHolder
            txtShoppingMallName.outlineColor(for: .editing)
            txtShoppingMallName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtShoppingMallName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtShoppingMallName.sizeToFit()
        }
    }
    @IBOutlet weak var txtDescription: MDCOutlinedTextArea!{
        didSet{
            txtDescription.textView.autocorrectionType = .no
            txtDescription.label.text = "내용"
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
            txtRegisterPoint.label.text = "포인트 등록"
            txtRegisterPoint.label.textColor = UIColor.AppTextField
            txtRegisterPoint.placeHolderColor = UIColor.AppPlaceHolder
            txtRegisterPoint.outlineColor(for: .editing)
            txtRegisterPoint.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtRegisterPoint.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtRegisterPoint.sizeToFit()
        }
    }
    let dropDown = DropDown()
    var id = String()
    // MARK: - Variables
    var category_id = ""
    var post_id = ""
    var ObjCategory = CategoryModel.init(dictionary: [:])
    
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
    var IsEdit = false
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = self.txtPlatform
        txtRegisterPoint.delegate = self
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtPlatform.text = item
            if(self.ArrPlatform[index].title == "기타"){
                self.TxtOther.isHidden = false
                self.view.layoutIfNeeded()
            }
            else{
                self.TxtOther.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
        dropDown.width = self.txtPlatform.frame.width
        dropDown.direction = .any
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        if(IsEdit == false){
            self.BtnSubmit.setTitle("추가", for: .normal)
            self.BtnSubmit.setTitle("추가", for: .selected)
        }
        else{
            self.BtnSubmit.setTitle("업데이트", for: .normal)
            self.BtnSubmit.setTitle("업데이트", for: .selected)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.WSGetPlatform(Parameter: [:])
        print(self.dataDict)
        if(self.IsEdit == true){
            if let platform_id = self.dataDict.value(forKey: "platform_id") as? Int
            {
                if(self.ArrPlatform.count>0){
                    let Obj = self.ArrPlatform.filter({$0.id == platform_id}).first
                    self.txtPlatform.text = Obj?.title
                }
            }
            if let keyword = self.dataDict.value(forKey: "keyword") as? String
            {
                self.txtKeyword.text = keyword
            }
            if let name = self.dataDict.value(forKey: "name") as? String
            {
                self.txtShoppingMallName.text = name
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
        else{
            self.txtRegisterPoint.isUserInteractionEnabled  = true
            
        }
    }
    // MARK: - Functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.txtRegisterPoint){
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        return true
    }
    // MARK: - UIButton Actions
    @IBAction func BtnDropDownAction(_ sender:UIButton){
        if self.ArrPlatform.count > 0{
            self.dropDown.show()
        }
    }
    
    @IBAction func BtnCreatePostAction(_ sender:UIButton){
        guard let textPlatform = txtPlatform.text, !textPlatform.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.PlatformMissing)
            return
        }
        if(self.TxtOther.isHidden == false){
            guard let TextOther = TxtOther.text, !TextOther.isEmpty else {
                showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.OtherMissing)
                return
            }
        }
        guard let textKeyword = txtKeyword.text, !textKeyword.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.KeywordMissing)
            return
        }
        guard let textShoppingMallName = txtShoppingMallName.text, !textShoppingMallName.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ShoppingMallNameMissing)
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
        if(Int(textRegisterPoint)! > Int(EstalimUser.shared.coin)!) {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidRegisterPoint)
            return
        }
        if( Int(textRegisterPoint)! == 0) {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.enValidRegisterPoint)
            return
        }
        if(self.IsEdit == true){
            if let id = self.dataDict.value(forKey: "id") as? Int{
                if(self.TxtOther.isHidden == false){
                    self.WSEditPost(Parameter: ["post_id":id,"keyword":self.txtKeyword.text!,"platform_id":"1","category_id":self.id,"name":self.txtShoppingMallName.text!,"description":self.txtDescription.textView.text!.removeWhiteSpace(),"register_point":self.txtRegisterPoint.text!,"platform_info":self.TxtOther.text!])
                }
                else{
                    self.WSEditPost(Parameter: ["post_id":id,"keyword":self.txtKeyword.text!,"platform_id":"1","category_id":self.id,"name":self.txtShoppingMallName.text!,"description":self.txtDescription.textView.text!.removeWhiteSpace(),"register_point":self.txtRegisterPoint.text!,"platform_info":self.TxtOther.text!])
                }
                
            }
            
        }
        else{
            if(self.TxtOther.isHidden == false){
                self.WSCreatePost(Parameter: ["keyword":self.txtKeyword.text!,"platform_id":"1","category_id":self.id,"name":self.txtShoppingMallName.text!,"description":self.txtDescription.textView.text!,"register_point":self.txtRegisterPoint.text!])
            }
            else{
                self.WSCreatePost(Parameter: ["keyword":self.txtKeyword.text!,"platform_id":"1","category_id":self.id,"name":self.txtShoppingMallName.text!,"description":self.txtDescription.textView.text!,"register_point":self.txtRegisterPoint.text!,"platform_info":self.TxtOther.text!])
            }
            
        }
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    
    func WSCreatePost(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .CreatePost, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let message =  ResponseDict?.value(forKey: "message") as? String{
                    showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: message, buttons: ["홈으로 가기"]) { (i) in
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
    
    func WSEditPost(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .EditPost, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let message  = ResponseDict?.value(forKey: "message") as? String{
                    //   showAlertWithTitleFromVC(vc: self, andMessage: message)
                    showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: message, buttons: ["뒤로가기"]) { (i) in
                        self.popTo()
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
                        if(self.IsEdit == true){
                            if let platform_id = self.dataDict.value(forKey: "platform_id") as? Int
                            {
                                let Obj = self.ArrPlatform.filter({$0.id == platform_id}).first
                                self.txtPlatform.text = Obj?.title
                                self.id = Obj!.id!.description
                                
                            }
                        }
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
