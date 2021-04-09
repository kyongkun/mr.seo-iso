//
//  StringExtension.swift
//  HomeEscape
//
//  Created by Devubha Manek on 8/17/17.
//  Copyright © 2017 Devubha Manek. All rights reserved.
//

import UIKit

//MARK: - String Extension
extension String {
    //Get string length
    var length: Int { return self.count }
    
    //Remove white space in string
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    //Check string is number or not
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
    
    //Check string is Float or not
    var isFloat : Bool {
        get{
     
            if Float(self) != nil {
                return true
            }else {
                return false
            }
        }
    }
    
    //Format Number If Needed
    func formatNumberIfNeeded() -> String {
        
        let charset = CharacterSet(charactersIn: "0123456789.,")
        if self.rangeOfCharacter(from: charset) != nil {
            
            let currentTextWithoutCommas:NSString = (self.replacingOccurrences(of: ",", with: "")) as NSString
            
            if currentTextWithoutCommas.length < 1 {
                return ""
            }
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            
            let numberFromString: NSNumber = numberFormatter.number(from: currentTextWithoutCommas as String)!
            let formattedNumberString: NSString = numberFormatter.string(from: numberFromString)! as NSString
            
            let convertedString:String = String(formattedNumberString)
            return convertedString
            
        } else {
            
            return self
        }
    }
    //MARK: - Check Contains Capital Letter
    func isContainsCapital() -> Bool {

        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let textTest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalResult = textTest.evaluate(with: self)
        return capitalResult
    }
    //MARK: - Check Contains Number Letter
    func isContainsNumber() -> Bool {
        
        let numberRegEx  = ".*[0-9]+.*"
        let textTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberResult = textTest.evaluate(with: self)
        return numberResult
    }
    //MARK: - Check Contains Special Character
    func isContainsSpecialCharacter() -> Bool {
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let textTest = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        let specialResult = textTest.evaluate(with: self)
        return specialResult
    }
    
    func isValidMobileNumber() -> Bool{
        
        if self.length < 10
        {
            return false
        }
        else if self.length > 10
        {
            return true
        }
        else
        {
            return true
        }
    }
    
    func isValidFaxNumber() -> Bool{
        
        if self.length < 12
        {
            return false
        }
        else if self.length > 12
        {
            return false
        }
        else
        {
            return true
        }
    }
    public func isHaveMinmumPassword() -> Bool {
        if self.length < 6
        {
            return false
        }
        else if self.length > 6
        {
            return true
        }
        else
        {
            return true
        }
    }

    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"

            //--> (Minimum 8 characters at least 1 Alphabet and 1 Number)

        //let passwordRegex = "^(?=.*[a-z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        //let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8}$"//mina
        //let passwordRegex = "^(?=.*\\d)(?=.*[a-z])[0-9a-z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        //let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
           return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    
    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    
    func isValidPostalCode() -> Bool {
        do {//  /[A-Z]{1,2}[0-9]{1,2}\s?[0-9]{1,2}[A-Z]{1,2}/i
            let regex = try NSRegularExpression(pattern: "[A-Z]{1,2}[0-9]{1,2}\\s[0-9]{1,2}[A-Z]{1,2}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
//    var length: Int {
//        return self.count
//    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
}
