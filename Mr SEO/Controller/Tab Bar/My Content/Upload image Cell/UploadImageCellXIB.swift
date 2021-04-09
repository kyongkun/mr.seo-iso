//
//  UploadImageCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 31/03/21.
//

import UIKit
import SDWebImage
import ImageViewer_swift

protocol  UploadImageProtocol:AnyObject{
    func ChooseImage()
    func DeleteImage(index:Int)
    func ShowAlertForMaximumImage()
}

class UploadImageCellXIB: UITableViewCell,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.IsHavingImage == true && self.ImgStrArr.count >= 2){
            if(section == 0){
                return 0
            }
            else{
                return self.ImgStrArr.count
            }
        }
        else if(self.IsHavingImage == true && self.ImgStrArr.count == 1){
            if(section == 0){
                return 1
            }
            else{
                return self.ImgStrArr.count
            }
        }
        else{
            if(section == 0){
                return 1
            }
            else{
                return self.ImagArr.count
            }
        
        }
        
        
    }
    @objc func DeleteImage(_ sender:UIButton){
        if(self.IsHavingImage == true){
            
        }
        else{
            self.delegate?.DeleteImage(index:sender.tag )
            if(self.ImagArr.count == 1){
                self.ImagArr.removeAll()
                self.imageCollection.reloadData()
            }
            else{
            self.ImagArr.remove(at: sender.tag)
            self.imageCollection.reloadData()
            }
        }
        
    }
    @objc func GetImage(){
        if(self.ImagArr.count >= 2){
            self.delegate?.ShowAlertForMaximumImage()
        }
        else{
            self.delegate?.ChooseImage()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = self.imageCollection.dequeueReusableCell(withReuseIdentifier: "CameraCellXIB", for: indexPath) as! CameraCellXIB
            cell.btnCam.addTarget(self, action: #selector(self.GetImage), for: .touchUpInside)
            return cell
        }
        else{
            let cell = self.imageCollection.dequeueReusableCell(withReuseIdentifier: "ImageViewCellXIB", for: indexPath) as! ImageViewCellXIB
            if(self.IsHavingImage == true){
                cell.ImgCam.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.ImgCam.sd_setImage(with: URL(string:self.ImgStrArr[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
                cell.ImgCam.setupImageViewer(url:URL(string: self.ImgStrArr[indexPath.row])!)
                                             
                cell.BtnClose.isHidden = true
            }
            else{
                if(self.ImagArr[indexPath.row].AlreadyUploded == true){
                    cell.BtnClose.isHidden = true
                }
                else{
                    cell.BtnClose.isHidden = false
                }
                
                cell.ImgCam.image = self.ImagArr[indexPath.row].img
                cell.ImgCam.setupImageViewer(images: [self.ImagArr[indexPath.row].img!])
            }
            
            cell.BtnClose.tag = indexPath.row
            cell.BtnClose.addTarget(self, action: #selector(self.DeleteImage(_:)), for: .touchUpInside)

            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            if(self.ImagArr.count >= 2){
                
            }
            else{
                if(self.IsHavingImage == false){
                self.delegate?.ChooseImage()
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 10)/3, height: (collectionView.frame.width - 10)/3)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
    }
    var IsHavingImage = Bool()
    var delegate: UploadImageProtocol?
    @IBOutlet weak var imageCollection:UICollectionView!
    @IBOutlet weak var BtnSave:EMButton!{
        didSet{
            BtnSave.btnType = .Submit
        }
    }
    @IBOutlet weak var BtnChatwithOwner:EMButton!
    {
        didSet{
            BtnChatwithOwner.btnType = .Submit
        }
    }
    var ImgStrArr = [String]()

    var ImagArr = [imagArrModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        

        self.imageCollection.delegate = self
        self.imageCollection.dataSource = self
        self.imageCollection.register(UINib(nibName: "CameraCellXIB", bundle: nil), forCellWithReuseIdentifier: "CameraCellXIB")
        self.imageCollection.register(UINib(nibName: "ImageViewCellXIB", bundle: nil), forCellWithReuseIdentifier: "ImageViewCellXIB")
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
