//
//  HomeVC.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController
{
    // MARK: - UIControlers Outlate
    
    // MARK: - Variables
    var ArrHomeData = [PostModel]()
    var ArrHomePost = [PostModel]()

    var ArrHomeAdvertise = [PostModel]()
    var advArIndex = 5
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    @IBOutlet weak var TblProducts:UITableView!
    @IBOutlet weak var LblCoin:UILabel!{
        didSet{
            LblCoin.text = EstalimUser.shared.coin.description
        }
    }

    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TblProducts.setDefaultProperties(vc: self)
        self.TblProducts.registerCell(type: ProductCellXIB.self)        
        self.TblProducts.reloadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.LblCoin.text = EstalimUser.shared.coin.description
        self.WSGetHomeData(Parameter: [:])
        if(EstalimUser.shared.set_image != ""){
            self.openImagePopUp()
        }
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false

    }
    // MARK: - Functions
    func openImagePopUp(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "imagePopUpVC") as! imagePopUpVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.tabBarController?.present(vc, animated: true)
    }
    // MARK: - UIButton Actions
    @IBAction func BtnAddContentAction(_ sender:UIButton){
        self.pushTo("AddContentVC")
    }
    
    @IBAction func BtnCheckCoinAction(_ sender:UIButton){
        let vc = storyBoards.MyContent.instantiateViewController(withIdentifier: "CoinsVC") as? CoinsVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    
    func WSGetHomeData(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .GetHome, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let coin = ResponseDict?.value(forKey: "coin") as? String{
                    EstalimUser.shared.coin = coin
                    EstalimUser.shared.save()
                    self.LblCoin.text = coin
                }
                if let data = ResponseDict?.value(forKey: "data") as? [NSDictionary]{
                    self.ArrHomeData.removeAll()
                    self.ArrHomeData = PostModel.modelsFromDictionaryArray(array: data as NSArray)
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
    
}
// MARK: - UITableView Delegate Methods
extension HomeVC:UITableViewDataSource,UITableViewDelegate{
    @objc func openURL(_ sender:UIButton){
        if let urlstr = self.ArrHomeData[sender.tag].advertisements?.url{
            guard let url = URL(string: urlstr) else { return }
            UIApplication.shared.open(url)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.ArrHomeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueCell(withType: ProductCellXIB.self,for: indexPath) as? ProductCellXIB else {
                      return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setData(Data: self.ArrHomeData[indexPath.row])
            cell.BtnAdver.tag = indexPath.row
            cell.BtnAdver.addTarget(self, action: #selector(self.openURL(_:)), for: .touchUpInside)
            cell.layoutIfNeeded()
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShopDetailsVC") as! ShopDetailsVC
        vc.ObjHomeModel = self.ArrHomeData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
