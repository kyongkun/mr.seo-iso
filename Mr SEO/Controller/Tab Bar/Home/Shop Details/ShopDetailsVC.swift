//
//  ShopDetailsVC.swift
//  Mr SEO
//
//  Created by Mac on 02/03/21.
//

import UIKit
import SDWebImage
class ShopDetailsVC: UIViewController
{
    // MARK: - UIControlers Outlate
    var ObjHomeModel = PostModel.init(dictionary: [:])
    var ArrDetails = [KeyValue]()
    var post_id = ""
    var user_name = ""
    // MARK: - Variables
    var TitleNavigation = String()
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
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.BtnSubmit.setTitle("Apply For Help", for: .normal)
        self.BtnSubmit.setTitle("Apply For Help", for: .selected)
        self.BtnSubmit.addTarget(self, action: #selector(self.OpenChat(sender:)), for: .touchUpInside)
        self.TblDetails.setDefaultProperties(vc: self)
        self.TblDetails.registerCell(type: ShopDetailsXIB.self)
        self.TblDetails.registerCell(type: AppliedForUserCellXIB.self)
        if let title1 = self.ObjHomeModel?.title{
            self.LblNavigationTitle.text = title1
        }
        self.WSGetPostDetails(Parameter: ["post_id":self.ObjHomeModel!.post_id!])

    }
    // MARK: - Functions
    @objc func OpenChat(sender:UIButton){
        let vc = (storyBoards.Chat.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - UIButton Actions
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods

    func WSAppliedForHelp(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .AppliedForHelp, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let DataDict = ResponseDict?.value(forKey: "data")  as? NSDictionary{
                    if let threads_id = DataDict.value(forKey: "threads_id") as? String{
                        let vc = (storyBoards.Chat.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC)!
                        vc.threads_id = threads_id
                        vc.IsFromThreadList = false
                        vc.ToUserName = self.user_name
                        self.navigationController?.pushViewController(vc, animated: true)

                    }
                    if let threads_id = DataDict.value(forKey: "threads_id") as? Int{
                        let vc = (storyBoards.Chat.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC)!
                        vc.threads_id = "\(threads_id)"
                        vc.IsFromThreadList = false
                        vc.ToUserName = self.user_name
                        self.navigationController?.pushViewController(vc, animated: true)

                    }

                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSGetPostDetails(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .GetPostDetails, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let DataDict = ResponseDict?.value(forKey: "data")  as? NSDictionary{
                    self.ArrDetails.removeAll()
                    
                    if let title = DataDict.value(forKey: "title") as? String{
                        let obj = KeyValue.init(names: "Title", value: title)
                        self.ArrDetails.append(obj)
                    }
                    if let category_name = DataDict.value(forKey: "category_name") as? String{
                        let obj = KeyValue.init(names: "Category", value: category_name)
                        self.ArrDetails.append(obj)
                    }
                    if let name = DataDict.value(forKey: "name") as? String{
                        let obj = KeyValue.init(names: "Name", value: name)
                        self.ArrDetails.append(obj)
                    }
                    
                    if let keyword = DataDict.value(forKey: "keyword") as? String{
                        let obj = KeyValue.init(names: "Keyword", value: keyword.description)
                        self.ArrDetails.append(obj)
                    }
                    if let URL = DataDict.value(forKey: "url") as? String{
                        let obj = KeyValue.init(names: "URL", value: URL)
                        self.ArrDetails.append(obj)
                    }
                    if let Adescription = DataDict.value(forKey: "description") as? String{
                        let obj = KeyValue.init(names: "Description", value: Adescription)
                        self.ArrDetails.append(obj)
                    }
                    if let point = DataDict.value(forKey: "point") as? Int{
                        let obj = KeyValue.init(names: "Point", value: "\(point)")
                        self.ArrDetails.append(obj)
                    }
                    
                    if let user_name = DataDict.value(forKey: "user_name") as? String{
                        self.user_name = ""
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
// MARK: - UITableView Delegate Methods
extension ShopDetailsVC:UITableViewDataSource,UITableViewDelegate{
    @objc func btnApplyforHelp(){
        self.WSAppliedForHelp(Parameter: ["post_id":self.ObjHomeModel!.post_id!])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            print("self.ArrDetails.count :",self.ArrDetails.count)
            return self.ArrDetails.count
        }
        else{
            if(self.ArrDetails.count>0){
            return 1
            }
            else{
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
        guard let cell = tableView.dequeueCell(
                withType: ShopDetailsXIB.self,
                for: indexPath) as? ShopDetailsXIB else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
            cell.LblTitle.text = self.ArrDetails[indexPath.row].name.description
            cell.LblInfo.text = self.ArrDetails[indexPath.row].value.description
        cell.layoutIfNeeded()
        return cell
    }
        else{
            guard let cell = tableView.dequeueCell(
                    withType: AppliedForUserCellXIB.self,
                    for: indexPath) as? AppliedForUserCellXIB else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.BtnApplyforHelp.addTarget(self, action: #selector(self.btnApplyforHelp), for: .touchUpInside)
            return cell
        }
    }
    
}
struct KeyValue{
     var name: String
     var value: String
     var IsStatus:Bool

     init(names: String, value: String){
        self.name = names
        self.value = value
        self.IsStatus = false
    }
}
