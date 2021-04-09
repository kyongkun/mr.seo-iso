//
//  CoinsVC.swift
//  Mr SEO
//
//  Created by Mac on 03/03/21.
//

import UIKit
import ParallaxHeader

class CoinsVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var TblCoins: UITableView!
    @IBOutlet weak var LblUsername: UILabel!{
        didSet{
            LblUsername.text = EstalimUser.shared.name
        }
    }
    @IBOutlet weak var LblCurruntCoins: UILabel!{
        didSet{
            LblCurruntCoins.text = "잔여 포인트 : " + EstalimUser.shared.coin
        }
    }


    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation_White
        }
    }
    @IBOutlet weak var ViewHeaderTop: UIView!{
        didSet{
            DispatchQueue.main.async {
                self.ViewHeaderTop.backgroundColor = .white
                CommonClass.sharedInstance.roundCornersWithBoarder(view: self.ViewHeaderTop, corners: [.topLeft], radius: 55, borderColor: .clear)
            }
        }
    }

    @IBOutlet weak var ViewHeaderBottom: UIView!
    {
        didSet{
            DispatchQueue.main.async {
                CommonClass.sharedInstance.roundCornersWithBoarder(view: self.ViewHeaderBottom, corners: [.bottomRight], radius: 55, borderColor: .clear)
            }
        }
    }

    // MARK: - Variables
    var ArrCoins = [CoinDataModel]()
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TblCoins.registerCell(type: TotalCoinCellXIB.self)
        self.TblCoins.registerCell(type: CoinsCellXIB.self)
        self.TblCoins.setDefaultProperties(vc: self)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.WSGetCoinHistory(Parameter: [:])
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSGetCoinHistory(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .GetCoinHistory, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                if let CountryList = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrCoins.removeAll()
                    self.ArrCoins = CoinDataModel.modelsFromDictionaryArray(array: CountryList)
                    if(self.ArrCoins.count>0)
                    {
                        self.TblCoins.setEmptyMessage("")
                        self.TblCoins.reloadData()
                    }
                    else{
                        self.TblCoins.setEmptyMessage("No Data Found!")
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
// MARK: - UITableView Delegate Methods
extension CoinsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.ArrCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueCell(
                    withType: CoinsCellXIB.self,
                    for: indexPath) as? CoinsCellXIB else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setData(Data: self.ArrCoins[indexPath.row])
            return cell
    }
    
    
    
    
}
