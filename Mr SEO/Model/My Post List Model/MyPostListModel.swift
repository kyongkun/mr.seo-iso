/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class MyPostListModel {
	public var id : Int?
	public var platform_id : Int?
	public var category_id : Int?
	public var user_id : Int?
	public var title : String?
	public var image : String?
	public var mall_name : String?
	public var description : String?
	public var price : String?
	public var register_point : Int?
	public var keywordword : String?
	public var is_active : String?
	public var created_at : String?
	public var updated_at : String?
	public var url : String?
	public var category : CategoryModel?
	public var user : UserModel?
	public var platform : PlatformModel?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [MyPostListModel]
    {
        var models:[MyPostListModel] = []
        for item in array
        {
            models.append(MyPostListModel(dictionary: item as! NSDictionary)!)
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

		id = dictionary["id"] as? Int
		platform_id = dictionary["platform_id"] as? Int
		category_id = dictionary["category_id"] as? Int
		user_id = dictionary["user_id"] as? Int
		title = dictionary["title"] as? String
		image = dictionary["image"] as? String
		mall_name = dictionary["mall_name"] as? String
		description = dictionary["description"] as? String
		price = dictionary["price"] as? String
		register_point = dictionary["register_point"] as? Int
        keywordword = dictionary["keyword"] as? String
		is_active = dictionary["is_active"] as? String
		created_at = dictionary["created_at"] as? String
		updated_at = dictionary["updated_at"] as? String
		url = dictionary["url"] as? String
        
        if (dictionary["category"] != nil) { category = CategoryModel(dictionary: dictionary["category"] as? NSDictionary ?? [:]) }
		if (dictionary["user"] != nil) { user = UserModel(dictionary: dictionary["user"] as! NSDictionary) }
		if (dictionary["platform"] != nil) { platform = PlatformModel(dictionary: dictionary["platform"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.platform_id, forKey: "platform_id")
		dictionary.setValue(self.category_id, forKey: "category_id")
		dictionary.setValue(self.user_id, forKey: "user_id")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.image, forKey: "image")
		dictionary.setValue(self.mall_name, forKey: "mall_name")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.price, forKey: "price")
		dictionary.setValue(self.register_point, forKey: "register_point")
		dictionary.setValue(self.keywordword, forKey: "keyword")
		dictionary.setValue(self.is_active, forKey: "is_active")
		dictionary.setValue(self.created_at, forKey: "created_at")
		dictionary.setValue(self.updated_at, forKey: "updated_at")
		dictionary.setValue(self.url, forKey: "url")
		dictionary.setValue(self.category?.dictionaryRepresentation(), forKey: "category")
		dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
		dictionary.setValue(self.platform?.dictionaryRepresentation(), forKey: "platform")

		return dictionary
	}

}