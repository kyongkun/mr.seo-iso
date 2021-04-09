//
//  ShopDetailsVC.swift
//  Mr SEO
//
//  Created by Mac on 02/03/21.
//

import UIKit
import SDWebImage
import ImageViewer_swift

enum category:String{
    case HelpOnlineSHopBuy = "1"
    case HelpOnlineShopBrowse = "2"
    case HelpBlog = "3"
    case HelpCafe = "4"
}
class MyContentDetailsVC: UIViewController
{
    var imageArr = [UIImage]()
    // MARK: - UIControlers Outlate
    var ArrHelper = [HelperModel]()
    var isMyContent = true
    var IsHavingImage = false
    var imageStrArr = [String]()
    var ObjHomeModel = MyPostModel.init(dictionary: [:])
    var ArrDetails = [LIstDetailsModel]()
    var categoy = String()
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
    

    var dataDict = NSDictionary()
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        self.WSGetPostDetails(Parameter: ["post_id":self.ObjHomeModel!.post_id!])
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
    
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSGetPostDetailsWithTableScreen(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .GetMyPostDetails, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let DataDict = ResponseDict?.value(forKey: "data")  as? NSDictionary{
                    self.dataDict = DataDict
                    if let help = DataDict.value(forKey: "helper") as? [NSDictionary]{
                        self.ArrHelper.removeAll()
                        self.ArrHelper = HelperModel.modelsFromDictionaryArray(array: help as NSArray)
                        if(help.count>0){
                        if let proof_image = help[0].value(forKey: "proof_image") as? [NSDictionary]{
                            if(proof_image.count>0){
                                self.IsHavingImage = true
                                self.imageStrArr.removeAll()
                                for arr in proof_image{
                                    if let img = arr.value(forKey: "file") as? String{
                                        self.imageStrArr.append(img)
                                    }
                                }
                                
                            }
                            
                        }
                        }
                    }
                    self.ArrDetails.removeAll()
                    if let title = DataDict.value(forKey: "title") as? String{
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "제목"
                        ListObj?.value = title
                        self.ArrDetails.append(ListObj!)
                    }
                    if let category_name = DataDict.value(forKey: "category_name") as? String{
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "종류"
                        ListObj?.value = category_name
                        self.categoy =  category_name
                        self.ArrDetails.append(ListObj!)
                    }
                    
                    if let name = DataDict.value(forKey: "name") as? String{
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "이름"
                        ListObj?.value = name
                        self.ArrDetails.append(ListObj!)
                    }
                    
                    if let keyword = DataDict.value(forKey: "keyword") as? String{
                        if(keyword != ""){
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "키워드"
                        ListObj?.value = keyword
                        self.ArrDetails.append(ListObj!)
                        }
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
                    
                    //let arr = LIstDetailsModel.modelsFromDictionaryArray(array: DataDict)
                    if(self.ArrDetails.count>0){
                        self.TblDetails.setEmptyMessage("")
                        self.ArrDetails = self.ArrDetails.filter(){$0.value != ""}
                    }
                    else{
                        self.TblDetails.setEmptyMessage("No Data Found!")
                    }
                    let contentOffset = self.TblDetails.contentOffset
                    self.TblDetails.reloadData()
                    self.TblDetails.layoutIfNeeded()
                    self.TblDetails.setContentOffset(contentOffset, animated: false)

//                    self.TblDetails.reloadData()
                }
                
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSGetPostDetails(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .GetMyPostDetails, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let DataDict = ResponseDict?.value(forKey: "data")  as? NSDictionary{
                    self.dataDict = DataDict
                    if let help = DataDict.value(forKey: "helper") as? [NSDictionary]{
                        self.ArrHelper.removeAll()
                        self.ArrHelper = HelperModel.modelsFromDictionaryArray(array: help as NSArray)
                        if(help.count>0){
                        if let proof_image = help[0].value(forKey: "proof_image") as? [NSDictionary]{
                            if(proof_image.count>0){
                                self.IsHavingImage = true
                                self.imageStrArr.removeAll()
                                for arr in proof_image{
                                    if let img = arr.value(forKey: "file") as? String{
                                        self.imageStrArr.append(img)
                                    }
                                }
                                
                            }
                            
                        }
                        }
                    }
                    self.ArrDetails.removeAll()
                    if let title = DataDict.value(forKey: "title") as? String{
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "제목"
                        ListObj?.value = title
                        self.ArrDetails.append(ListObj!)
                    }
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
                        if(keyword != ""){
                        let ListObj = LIstDetailsModel.init(dictionary: [:])
                        ListObj?.name = "키워드"
                        ListObj?.value = keyword
                        self.ArrDetails.append(ListObj!)
                        }
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
                    
                    //let arr = LIstDetailsModel.modelsFromDictionaryArray(array: DataDict)
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

// MARK: - VerifyProtocol Delegate Methods
extension MyContentDetailsVC:VerifyProtocol{
    func VerifyYesButtonAction() {
        self.WSGetPostDetailsWithTableScreen(Parameter: ["post_id":self.ObjHomeModel!.post_id!])
    }
    
    
}
// MARK: - CashPopupProtocol Delegate Methods
extension MyContentDetailsVC:CashPopupProtocol{
    func YesButtonAction() {
        self.WSGetPostDetailsWithTableScreen(Parameter: ["post_id":self.ObjHomeModel!.post_id!])
    }
    
    
}
// MARK: - CashPopupProtocol Delegate Methods
extension MyContentDetailsVC:FinishProtocol{
    func FinishYesButtonAction() {
        self.WSGetPostDetailsWithTableScreen(Parameter: ["post_id":self.ObjHomeModel!.post_id!])
    }
    
    
}
// MARK: - UITableView Delegate Methods
extension MyContentDetailsVC:UITableViewDataSource,UITableViewDelegate{
    @objc func GotoChat(_ sender:UIButton){
        let vc = (storyBoards.Chat.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC)!
        vc.IsFromThreadList = false
        vc.threads_id = self.ArrHelper[sender.tag].thread_id!.description
        vc.ToUserId = self.ArrHelper[sender.tag].user_id!.description
        vc.ToUserName = self.ArrHelper[sender.tag].user_name!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func ShowCashSentPopup(_ sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CashPopupVC") as! CashPopupVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        vc.helpid = self.ArrHelper[sender.tag].help_id!.description
        self.navigationController?.present(vc, animated: true)
    }
    @objc func ConfirmProofPopup(_ sender:UIButton){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPopupVC") as! VerifyPopupVC
                vc.delegate = self
                vc.helpid = self.ArrHelper[sender.tag].help_id!.description
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                self.navigationController?.present(vc, animated: true)
    }
    @objc func ShowViewProofPopup(_ sender:UIButton){
        if(self.ArrHelper[sender.tag].proof_upload?.lowercased() == "no"){
            showAlertWithTitleFromVC(vc: self, andMessage: "There is no image uploded yet!")
        }
        else{
        self.ArrHelper[sender.tag].IsImageDisable = !self.ArrHelper[sender.tag].IsImageDisable!
        self.TblDetails.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .fade)
        }

    }
    @objc func ShowFinishPopup(_ sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinishPopupVC") as! FinishPopupVC
        vc.delegate = self
        vc.helpid = self.ArrHelper[sender.tag].help_id!.description
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return self.ArrDetails.count
        }
        else{
            return self.ArrHelper.count
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
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
        else{
            guard let cell = tableView.dequeueCell(
                    withType: AppliedUserCellXIB.self,
                    for: indexPath) as? AppliedUserCellXIB else {
                return UITableViewCell()
            }
            if(self.dataDict.value(forKey: "category_name") as! String == category.HelpOnlineSHopBuy.rawValue){
                cell.ViewCashSent.isHidden = false
            }
            else{
                cell.ViewCashSent.isHidden = true
            }
            
            cell.BtnCashSent.addTarget(self, action: #selector(self.ShowCashSentPopup(_:)), for: .touchUpInside)
            cell.BtnConfirm.isHidden = self.ArrHelper[indexPath.row].BtnConfirm!
            cell.BtnFinished.addTarget(self, action: #selector(self.ShowFinishPopup), for: .touchUpInside)
            cell.BtnCashSent.tag = indexPath.row
            cell.BtnGotoChat.tag = indexPath.row
            cell.BtnViewProof.tag = indexPath.row
            cell.BtnConfirm.tag = indexPath.row
            
                cell.BtnViewProof.addTarget(self, action: #selector(self.ShowViewProofPopup(_:)), for: .touchUpInside)
            
            cell.BtnConfirm.addTarget(self, action: #selector(self.ConfirmProofPopup(_:)), for: .touchUpInside)

            cell.BtnGotoChat.addTarget(self, action: #selector(self.GotoChat), for: .touchUpInside)
            cell.setData(Data:self.ArrHelper[indexPath.row])
            if(self.ArrHelper[indexPath.row].proof_image?.count == 0){
                cell.ViewImage.isHidden = true
                cell.stackView.layoutIfNeeded()
            }
            if(self.ArrHelper[indexPath.row].proof_image?.count == 1){
//                cell.ImgFirst.isHidden = false
//                cell.ImgSecond.isHidden = true
                
                cell.ImgSecond.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.ImgSecond.sd_setImage(with: URL(string:self.ArrHelper[indexPath.row].proof_image?[0].file ?? ""), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
                cell.ImgFirst.setupImageViewer(url:URL(string: self.ArrHelper[indexPath.row].proof_image?[0].file ?? "")!)
            }
            if(self.ArrHelper[indexPath.row].proof_image?.count == 2){
//                cell.ImgFirst.isHidden = false
//                cell.ImgSecond.isHidden = false
                cell.ImgFirst.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.ImgFirst.sd_setImage(with: URL(string:self.ArrHelper[indexPath.row].proof_image?[0].file ?? "" ), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
                cell.ImgSecond.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.ImgSecond.sd_setImage(with: URL(string:self.ArrHelper[indexPath.row].proof_image?[1].file ?? ""), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
                cell.ImgFirst.setupImageViewer(url:URL(string: self.ArrHelper[indexPath.row].proof_image?[0].file ?? "")!)
                cell.ImgSecond.setupImageViewer(url:URL(string: self.ArrHelper[indexPath.row].proof_image?[1].file ?? "")!)
            }
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            return cell
        }
    }
    
}
