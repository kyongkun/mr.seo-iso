//
//  ChatVC.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import TTSegmentedControl


class ChatVC: UIViewController
{
    // MARK: - UIControlers Outlate
    
    // MARK: - Variables
    @IBOutlet weak var segmentedControl: TTSegmentedControl!{
        didSet{
            segmentedControl.allowChangeThumbWidth = false
            segmentedControl.itemTitles = ["User","Admin"]
        }
    }
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    @IBOutlet weak var BtnBuyPoints:UIButton!{
        didSet{
            BtnBuyPoints.isHidden = true
        }
    }
    @IBOutlet weak var BtnButTickits:UIButton!{
        didSet{
            BtnButTickits   .isHidden = true
        }
    }
    
    @IBOutlet weak var TblChat:UITableView!
    @IBOutlet weak var ViewUserChat:UIView!
    @IBOutlet weak var ViewAdminChat:UIView!
    var ArrChatModel = [ChatDataModel]()
    var selectedIndex = Int()
    var point_message = String()
    var ticket_message = String()
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false

        self.TblChat.setDefaultProperties(vc: self)
        self.TblChat.registerCell(type: UserChatCellXIB.self)
        self.TblChat.reloadData()
        
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            self.selectedIndex = index
            if(index == 1){
                self.WSCheckButtonStatus(Parameter: [:])

                self.ViewUserChat.isHidden = true
                self.ViewAdminChat.isHidden = false
                
            }
            else{
                self.WSGetThereadList(Parameter: [:])
                self.ViewUserChat.isHidden = false
                self.ViewAdminChat.isHidden = true
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        if(appDelegate.setAdminChatSHow == true){
            appDelegate.setAdminChatSHow = false
            self.segmentedControl.selectItemAt(index: 1, animated: true)
            self.ViewUserChat.isHidden = true
            self.ViewAdminChat.isHidden = false
        }
        else{
            
        }
        if(self.selectedIndex == 0){
            self.WSGetThereadList(Parameter: [:])
        }
        else{
            self.WSCheckButtonStatus(Parameter: [:])
        }
        
        

    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnBuyPointAction(_ sender:UIButton){
        self.WSAutoMessage(Parameter: ["message_type":"point"])
    }
    @IBAction func BtnButTickitsAction(_ sender:UIButton){
        self.WSAutoMessage(Parameter: ["message_type":"ticket"])
    }

    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSAutoMessage(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .AutoMessage, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AdminChatVC") as! AdminChatVC
                vc.message_type = Parameter["message_type"] as! String
                vc.AutoMessage = ""
                self.navigationController?.pushViewController(vc, animated: true)

            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSCheckButtonStatus(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .CheckAdminButton, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let coin = ResponseDict?.value(forKey: "coin") as? String{
                    EstalimUser.shared.coin = coin
                    EstalimUser.shared.save()
                }
                if let data = ResponseDict?.value(forKey: "data") as? NSDictionary{
                    if let ticket_message = data.value(forKey: "ticket_message") as? String{
                        self.ticket_message = ticket_message
                    }
                    if let point_message = data.value(forKey: "point_message") as? String{
                        self.point_message = point_message
                    }
                    if let point_button = data.value(forKey: "point_button") as? String{
                        if(point_button == "yes"){
                            self.BtnBuyPoints.isHidden = false
                        }
                        else{
                            self.BtnBuyPoints.isHidden = true
                        }
                    }
                    if let ticket_button = data.value(forKey: "ticket_button") as? String{
                        if(ticket_button == "yes"){
                            self.BtnButTickits.isHidden = false
                        }
                        else{
                            self.BtnButTickits.isHidden = true
                        }
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
    func WSGetThereadList(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .GetThereadList, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let coin = ResponseDict?.value(forKey: "coin") as? String{
                    EstalimUser.shared.coin = coin
                    EstalimUser.shared.save()
                }
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrChatModel.removeAll()
                    self.ArrChatModel = ChatDataModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrChatModel.count>0){
                        self.TblChat.setEmptyMessage("")
                    }
                    else{
                        self.TblChat.setEmptyMessage("No Data Found!")
                    }
                    self.TblChat.reloadData()
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
// MARK: - UITableView Delegate Methods

extension ChatVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrChatModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
             withType: UserChatCellXIB.self,
             for: indexPath) as? UserChatCellXIB else {
                  return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setData(Data: self.ArrChatModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatDetailsVC") as! ChatDetailsVC
        vc.IsFromThreadList = true
        vc.ToUserName = (self.ArrChatModel[indexPath.row].sender_user?.name)!
        vc.ObjChatDataModel = self.ArrChatModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
