//
//  HelpDetailsVC.swift
//  Mr SEO
//
//  Created by Mac on 31/03/21.
//

import UIKit
import  SDWebImage

class HelpDetailsVC: UIViewController {
    var imageArr = [imagArrModel]()
    var imageStrArr = [String]()
    // MARK: - UIControlers Outlate
    var ArrHelper = [HelperModel]()
    var IsHavingImage = false
    var ObjHomeModel = MyPostModel.init(dictionary: [:])
    var ArrDetails = [LIstDetailsModel]()
    var categoy = String()
    var threads_id = String()
    
    // MARK: - Variables
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
    @IBOutlet weak var TblDetails:UITableView!
//    @IBOutlet weak var LblTitle:UILabel!
//    @IBOutlet weak var LblInfo:UILabel!
//    @IBOutlet weak var LblPrice:UILabel!
    var  user_name = String()

    var dataDict = NSDictionary()
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func setData(Data :HomeDataModel){
//        self.LblTitle.text = Data.category?.title
//
//        self.ImgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        self.ImgProduct.sd_setImage(with: URL(string:Data.image ?? ""), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
//
//        self.LblInfo.text = Data.description
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.BtnSubmit.setTitle("요청하기", for: .normal)
        self.BtnSubmit.setTitle("요청하기", for: .selected)
        self.BtnSubmit.addTarget(self, action: #selector(self.OpenChat(sender:)), for: .touchUpInside)
        self.TblDetails.setDefaultProperties(vc: self)
        self.TblDetails.registerCell(type: ShopDetailsXIB.self)
        self.TblDetails.registerCell(type: AppliedUserCellXIB.self)
        self.TblDetails.registerCell(type: StatusCellXIB.self)
        self.TblDetails.registerCell(type: UploadImageCellXIB.self)
        self.WSGetHelpPostDetails(Parameter: ["help_id":self.ObjHomeModel!.help_id!])

    }
    // MARK: - Functions
    @objc func OpenChat(sender:UIButton){
        let vc = (storyBoards.Chat.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - UIButton Actions
    @IBAction func BtnEdiPostAction(_ sender:UIButton){
        if(category.HelpOnlineSHopBuy.rawValue == self.categoy){
            let vc = (storyBoards.Home.instantiateViewController(withIdentifier: "AddContentDetailsVC") as? AddContentDetailsVC)!
            vc.IsEdit = true
            vc.dataDict = self.dataDict
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if(category.HelpOnlineShopBrowse.rawValue == self.categoy){
            let vc = (storyBoards.Home.instantiateViewController(withIdentifier: "AddContentDetailsVC") as? AddContentDetailsVC)!
            vc.IsEdit = true
            vc.dataDict = self.dataDict
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if(category.HelpBlog.rawValue == self.categoy){
            let vc = (storyBoards.Home.instantiateViewController(withIdentifier: "AddContentforBlogVC") as? AddContentforBlogVC)!
            vc.IsEdit = true
            vc.dataDict = self.dataDict
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if(category.HelpCafe.rawValue == self.categoy){
            let vc = (storyBoards.Home.instantiateViewController(withIdentifier: "AddContentDetailsForCafeVC") as? AddContentDetailsForCafeVC)!
            vc.IsEdit = true
            vc.dataDict = self.dataDict
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            
        }
    }
    
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func BtnChatWithOwner(){
        let vc = (storyBoards.Chat.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC)!
        vc.threads_id = self.threads_id
        vc.ToUserName = self.user_name
        vc.IsFromThreadList = false
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @objc func BtnSaveImage(){
        if(self.imageArr.count>0 && self.imageArr[0].AlreadyUploded == false){
            self.WSUploadImage(Parameter: ["help_id":self.ObjHomeModel!.help_id!], bank_image: self.imageArr[0].img!)
        }
        else if(self.imageArr.count>1 && self.imageArr[1].AlreadyUploded == false){
            self.WSUploadImage2(Parameter: ["help_id":self.ObjHomeModel!.help_id!], bank_image: self.imageArr[1].img!)
        }
        else{
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ImageMissing)
        }
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSUploadImage(Parameter:[String:Any],bank_image:UIImage) -> Void {
        ServiceManager.shared.callAPIWithImage(WithType: .UploadImage, imageUpload: bank_image, imageName: "file", WithParams: Parameter) { (DataResponce, Status, Message) in
            if(Status == true){
                if(self.imageArr.count>1 && self.imageArr[1].AlreadyUploded == false){
                    self.WSUploadImage2(Parameter: ["help_id":self.ObjHomeModel!.help_id!], bank_image: self.imageArr[1].img!)
                }
                else{
                    self.WSGetHelpPostDetails(Parameter: ["help_id":self.ObjHomeModel!.help_id!])
                }
               
            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        } Failure: { (DataResponce, Status, Message) in
            
        }
    }
    func WSUploadImage2(Parameter:[String:Any],bank_image:UIImage) -> Void {
        ServiceManager.shared.callAPIWithImage(WithType: .UploadImage, imageUpload: bank_image, imageName: "file", WithParams: Parameter) { (DataResponce, Status, Message) in
            if(Status == true){
                self.WSGetHelpPostDetails(Parameter: ["help_id":self.ObjHomeModel!.help_id!])
               
            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        } Failure: { (DataResponce, Status, Message) in
            
        }
    }
    func WSGetHelpPostDetails(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .HelpPostDetails, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let DataDictArr = ResponseDict?.value(forKey: "data")  as? [NSDictionary]{
                    //self.dataDict = DataDict
                    if let DataDict = DataDictArr.first{
                        if let user_name = DataDict.value(forKey: "user_name") as? String{
                            self.user_name = user_name
                        }
                    if let help = DataDict.value(forKey: "helper") as? [NSDictionary]{
                        self.ArrHelper.removeAll()
                        self.ArrHelper = HelperModel.modelsFromDictionaryArray(array: help as NSArray)
                    }
                    self.ArrDetails.removeAll()
                        if let category_id = DataDict.value(forKey: "category_id") as? Int{
                            self.categoy =  "\(category_id)"

                        }
                    if let category_name = DataDict.value(forKey: "category_name") as? String{
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "종류"
                        ListObj?.value = category_name
                        self.ArrDetails.append(ListObj!)
                    }
                    if let name = DataDict.value(forKey: "name") as? String{
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "이름"
                        ListObj?.value = name
                        self.ArrDetails.append(ListObj!)
                    }
                    
                    if let keyword = DataDict.value(forKey: "keyword") as? String{
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "키워드"
                        ListObj?.value = keyword
                        self.ArrDetails.append(ListObj!)
                    }
                    if let URL = DataDict.value(forKey: "url") as? String{
                        if(URL != ""){
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "URL"
                        ListObj?.value = URL
                        self.ArrDetails.append(ListObj!)
                        }
                    }
                    if let Andescription = DataDict.value(forKey: "description") as? String{
                        
                        let descriptionObj = LIstDetailsModel.init(dictionary: [:])
                        descriptionObj?.name = "내용"
                        descriptionObj?.value = Andescription
                        self.ArrDetails.append(descriptionObj!)
                        
                    }
                    if let point = DataDict.value(forKey: "point") as? Int{

                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "등록 포인트"
                        ListObj?.value = "\(point)"
                        self.ArrDetails.append(ListObj!)

                    }
                        if let threads_id = DataDict.value(forKey: "thread_id") as? Int{
                            self.threads_id = "\(threads_id)"
                            
                        }
                        if let status = DataDict.value(forKey: "status") as? String{
                            var status1 = ""
                            switch status {
                                case "request completed": status1 = "요청 완료"
                                case "cash sent": status1 = "송금 완료"
                                case "check proofs": status1 = "증빙 완료"
                                case "checking proofs": status1 = "증빙중"
                                case "finished": status1 = "최종 완료"
                                default : status1 = status
                            }
                            let statusObj = LIstDetailsModel.init(dictionary: [:])
                            statusObj?.name = "진행 상황"
                            statusObj?.value = status1
                            statusObj?.IsStatus = true
                            self.ArrDetails.append(statusObj!)
                            
                        }
                        if let proof_image = DataDict.value(forKey: "proof_image") as? [NSDictionary]{
                            
                            if(proof_image.count>0){
                                self.imageStrArr.removeAll()
                                for arr in proof_image{
                                    if let img = arr.value(forKey: "file") as? String{
                                        self.imageStrArr.append(img)
                                    }
                                }
                                if(self.imageStrArr.count == 1){
                                    self.IsHavingImage = false
                                    DispatchQueue.main.async {
                                        self.SHOW_CUSTOM_LOADER()
                                        SDWebImageManager.shared.loadImage(with: URL(string: self.imageStrArr.first!), options: SDWebImageOptions.allowInvalidSSLCertificates) { (i, a , myURL) in
                                  
                                            self.HIDE_CUSTOM_LOADER()
                                        } completed: { (MyImage, imgData, error, SDImageCacheType, status, url) in
                                            self.HIDE_CUSTOM_LOADER()
                                            if(MyImage != nil){
                                                let obj = imagArrModel()
                                                obj.img = MyImage!
                                                obj.AlreadyUploded = true
                                                self.imageArr.append(obj)
                                            self.TblDetails.reloadData()
                                            }
                                        }
                                    }
                                }
                                else{
                                    self.IsHavingImage = true

                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    if(self.ArrDetails.count>0){
                        self.TblDetails.setEmptyMessage("")
                        self.ArrDetails = self.ArrDetails.filter(){$0.value != ""}
                    }
                    else{
                        self.TblDetails.setEmptyMessage("No Data Found!")
                    }
                    self.TblDetails.reloadData()
                }
                
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    
}
extension HelpDetailsVC:UploadImageProtocol{
    func ShowAlertForMaximumImage() {
        showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.MaximumImageReached)
    }
    
    func DeleteImage(index: Int) {
        if(self.imageArr.count == 1){
            self.imageArr.removeAll()
            
        }
        else{
        self.imageArr.remove(at: index)
        }
        self.TblDetails.reloadSections(IndexSet(integer: 1), with: .none)

    }
    
    
    func ChooseImage() {
        DispatchQueue.main.async {
            ImagePickerManager().pickImage(self){ image in
                let obj = imagArrModel()
                obj.img = image
                obj.AlreadyUploded = false
                self.imageArr.append(obj)
                self.TblDetails.reloadSections(IndexSet(integer: 1), with: .none)
            }
        }
        
    }
    
    
}
// MARK: - UITableView Delegate Methods
extension HelpDetailsVC:UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return self.ArrDetails.count
        }
        else{
            return 1 //return self.ArrHelper.count
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            if(self.ArrDetails[indexPath.row].IsStatus == true){
                guard let cell = tableView.dequeueCell(
                        withType: StatusCellXIB.self,
                        for: indexPath) as? StatusCellXIB else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                if let sts = self.ArrDetails[indexPath.row].value as? String{
                    let str = sts.replace("_", withString: " ")
                    
                    var status1 = ""
                    switch str {
                        case "request completed": status1 = "요청 완료"
                        case "cash sent": status1 = "송금 완료"
                        case "proofs checked": status1 = "증빙 완료"
                        case "finished": status1 = "최종 완료"
                        default : status1 = str
                    }
                    cell.LblStatus.text = status1
                }
                
                cell.layoutIfNeeded()
                return cell
            }
            else{
                guard let cell = tableView.dequeueCell(
                        withType: ShopDetailsXIB.self,
                        for: indexPath) as? ShopDetailsXIB else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.LblTitle.text = self.ArrDetails[indexPath.row].name
                cell.LblInfo.text = self.ArrDetails[indexPath.row].value
                cell.layoutIfNeeded()
                return cell
            }
        
        }
        else{
            guard let cell = tableView.dequeueCell(
                    withType: UploadImageCellXIB.self,
                    for: indexPath) as? UploadImageCellXIB else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.ImagArr = self.imageArr
            cell.ImgStrArr = self.imageStrArr
            cell.IsHavingImage = self.IsHavingImage
            cell.imageCollection.reloadData()
            if(self.IsHavingImage == true && self.imageStrArr.count >= 2){
                
                cell.BtnSave.isHidden = true
                
            }
            else{
                cell.BtnSave.isHidden = false
            }
            cell.BtnChatwithOwner.addTarget(self, action: #selector(self.BtnChatWithOwner), for: .touchUpInside)

            cell.BtnSave.addTarget(self, action: #selector(self.BtnSaveImage), for: .touchUpInside)
            cell.layoutIfNeeded()
            return cell
            
        }
    }
    
}
class imagArrModel:NSObject{
    var img:UIImage?
    var AlreadyUploded:Bool?
    
}
