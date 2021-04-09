//
//  MyContentVC.swift
//  Mr SEO
//
//  Created by Mac on 02/03/21.
//

import UIKit
import TTSegmentedControl

class MyContentVC: UIViewController {
    // MARK: - UIControlers Outlate
    
    // MARK: - Variables
    var ArrHomeData = [MyPostModel]()
    var BankImage:UIImage? = nil
    var selectedTab:Int = 0
    @IBOutlet weak var segmentedControl: TTSegmentedControl!{
        didSet{
            //segmentedControl.allowChangeThumbWidth = false
            segmentedControl.itemTitles = ["My Contents","Helps"]
        }
    }
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    @IBOutlet weak var TblProducts:UITableView!

    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.TblProducts.setDefaultProperties(vc: self)
        self.TblProducts.registerCell(type: MyContentCellXIB.self)
        self.TblProducts.reloadData()
        //self.TblChat.RegisterCellXIB(cell: UserChatCellXIB.self, identifire: "UserChatCellXIB", tbl: "UserChatCellXIB")
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            self.selectedTab = index
            if(index == 0){
                self.WSMyContent(Parameter: [:])
            }
            else{
                self.WSMyHelpContent(Parameter: [:])
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        //self.segmentedControl.selectItemAt(index: 0)
        if(self.selectedTab == 0){
            self.WSMyContent(Parameter: [:])
        }
        else{
            self.WSMyHelpContent(Parameter: [:])
        }

    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    
    
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    
    
    func WSMyContent(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .MyContent, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let coin = ResponseDict?.value(forKey: "coin") as? String{
                    EstalimUser.shared.coin = coin
                    EstalimUser.shared.save()
                }
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrHomeData.removeAll()
                    self.ArrHomeData = MyPostModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrHomeData.count>0){
                        self.TblProducts.setEmptyMessage("")
                    }
                    else{
                        self.TblProducts.setEmptyMessage("No Post Found!")
                    }
                    self.TblProducts.reloadData()
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            print("Failure Response:",ResponseDict)
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSMyHelpContent(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .MyCompletedPoints, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let coin = ResponseDict?.value(forKey: "coin") as? String{
                    EstalimUser.shared.coin = coin
                    EstalimUser.shared.save()
                }
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrHomeData.removeAll()
                    self.ArrHomeData = MyPostModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrHomeData.count>0){
                        self.TblProducts.setEmptyMessage("")
                    }
                    else{
                        self.TblProducts.setEmptyMessage("No Post Found!")
                    }
                    self.TblProducts.reloadData()
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            print("Failure Response:",ResponseDict)
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSMyCompletedPoints(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .MyCompletedPoints, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrHomeData.removeAll()
                    self.ArrHomeData = MyPostModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrHomeData.count>0){
                        self.TblProducts.setEmptyMessage("")
                    }
                    else{
                        self.TblProducts.setEmptyMessage("No Post Found!")
                    }
                    self.TblProducts.reloadData()
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
extension MyContentVC:UITableViewDataSource,UITableViewDelegate{
    @objc func OpenChat(sender:UIButton){
        let vc = (storyBoards.Chat.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC)!
        vc.ToUserId =  self.ArrHomeData[sender.tag].user_id!.description
        vc.threads_id = self.ArrHomeData[sender.tag].thread_id!.description
        vc.IsFromThreadList = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func changeStatus(_ sender:UISwitch){
       // self.WSPostStatus(Parameter: ["id":self.ArrHomeData[sender.tag].id!,"status":sender.isOn])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrHomeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
             withType: MyContentCellXIB.self,
             for: indexPath) as? MyContentCellXIB else {
                  return UITableViewCell()
        }
        if(self.selectedTab == 0){
            cell.SwitchProduct.isHidden = true
            cell.LblStatus.isHidden = true
            cell.BtnGoToChat.isHidden = true
            cell.setData(Data: self.ArrHomeData[indexPath.row])
        }
        else{
            cell.SwitchProduct.isHidden = true
            cell.LblStatus.isHidden = false
            cell.BtnGoToChat.isHidden = false
            cell.setHelpData(Data: self.ArrHomeData[indexPath.row])
            if let str = self.ArrHomeData[indexPath.row].status{
                let newString = str.replacingOccurrences(of: "_", with: " ")

                cell.LblStatus.text = newString.capitalized
            }
            
        }
        cell.BtnGoToChat.addTarget(self, action: #selector(self.OpenChat(sender:)), for: .touchUpInside)
        cell.SwitchProduct.addTarget(self, action: #selector(self.changeStatus(_:)), for: .valueChanged)
        cell.selectionStyle = .none
        //cell.setData(Data: self.ArrHomeData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.selectedTab == 0){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyContentDetailsVC") as! MyContentDetailsVC
        vc.ObjHomeModel = self.ArrHomeData[indexPath.row]
        vc.isMyContent = true
        self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpDetailsVC") as! HelpDetailsVC
            vc.ObjHomeModel = self.ArrHomeData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
}
