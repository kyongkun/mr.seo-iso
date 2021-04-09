//
//  LIstDetailsModel.swift
//  Mr SEO
//
//  Created by Mac on 20/03/21.
//

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class LIstDetailsModel
{
    public var name : String?
    public var value : String?
    public var IsStatus : Bool?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [LIstDetailsModel]
    {
        var models:[LIstDetailsModel] = []
        for item in array
        {
            models.append(LIstDetailsModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let data = Data(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Data Instance.
*/
    required public init?(dictionary: NSDictionary) {
        IsStatus = false
        name = dictionary["name"] as? String
        value = dictionary["value"] as? String
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.IsStatus, forKey: "IsStatus")

        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.value, forKey: "value")

        return dictionary
    }

}
