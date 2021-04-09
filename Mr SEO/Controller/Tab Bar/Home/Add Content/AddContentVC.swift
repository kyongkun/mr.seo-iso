//
//  AddContentVC.swift
//  Mr SEO
//
//  Created by Mac on 01/03/21.
//

import UIKit

class AddContentVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var CollectionViewCategory: UICollectionView!
    
    // MARK: - Variables
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    @IBOutlet weak var LblCoin:UILabel!{
        didSet{
            LblCoin.text = EstalimUser.shared.coin.description
        }
    }
    var arrCategory = [CategoryModel]()
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionViewCategory.delegate = self
        self.CollectionViewCategory.dataSource = self
        self.CollectionViewCategory.register(UINib(nibName: "AddContentCell", bundle: nil), forCellWithReuseIdentifier: "AddContentCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.WSGetCategory(Parameter: [:])
        LblCoin.text = EstalimUser.shared.coin.description

        
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnAddContentAction(_ sender:UIButton){
        self.pushTo("AddContentDetailsVC")
        
    }
    @IBAction func BtnAddBlogContentAction(_ sender:UIButton){
        
        self.pushTo("AddContentforBlogVC")
        
    }
    @IBAction func BtnAddCafeContentAction(_ sender:UIButton){
        
        self.pushTo("AddContentDetailsForCafeVC")
        
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSGetCategory(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .GetCategory, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                if let CountryList = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.arrCategory.removeAll()
                    self.arrCategory = CategoryModel.modelsFromDictionaryArray(array: CountryList)
                    if (self.arrCategory.count>0){
                        self.CollectionViewCategory.reloadData()
                        self.CollectionViewCategory.setEmptyMessage("")
                    }
                    else{
                        self.CollectionViewCategory.setEmptyMessage("No Category Found!")
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
extension AddContentVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    @objc func btnCellAction(_ sender:UIButton){
        if(self.arrCategory[sender.tag].title == "Help Online Shop (Buy)"){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddContentDetailsVC") as! AddContentDetailsVC
            vc.id = "\(self.arrCategory[sender.tag].id!)"
            
            vc.ObjCategory = self.arrCategory[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if(self.arrCategory[sender.tag].title == "Help Blog"){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddContentforBlogVC") as! AddContentforBlogVC
            vc.ObjCategory = self.arrCategory[sender.tag]

            vc.id = "\(self.arrCategory[sender.tag].id!)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if(self.arrCategory[sender.tag].title == "Help Cafe"){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddContentDetailsForCafeVC") as! AddContentDetailsForCafeVC
            vc.ObjCategory = self.arrCategory[sender.tag]

            vc.id = "\(self.arrCategory[sender.tag].id!)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if(self.arrCategory[sender.tag].title == "Help Online Shop (Browse)"){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddContentDetailsVC") as! AddContentDetailsVC
            vc.ObjCategory = self.arrCategory[sender.tag]

            vc.id = "\(self.arrCategory[sender.tag].id!)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddContentDetailsVC") as! AddContentDetailsVC
            vc.id = "\(self.arrCategory[sender.tag].id!)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.arrCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.CollectionViewCategory.dequeueReusableCell(withReuseIdentifier: "AddContentCell", for: indexPath) as! AddContentCell
        cell.BtnCell.tag = indexPath.row
        cell.BtnCell.addTarget(self, action: #selector(self.btnCellAction(_:)), for: .touchUpInside)
        cell.LblTitle.text = self.arrCategory[indexPath.row].title
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size:CGFloat = (collectionView.frame.size.width - 40) / 2.0
        let Height:CGFloat = (collectionView.frame.size.height - 40) / 2.0
        
        return CGSize(width: size, height: Height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
