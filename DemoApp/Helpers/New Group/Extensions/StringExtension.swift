//
//  StringExtension.swift
//  MyProof
//
//  Created by Athi S on 01/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import Foundation
import UIKit

extension String{
    public func isMatch(regEx: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    public var isEmail: Bool {
        return isMatch(regEx: "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$")
    }
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters as CharacterSet)
    }
    
    func getTimeInterval() -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.timeZone = TimeZone.current
        if let date = timeFormatter.date(from: self){
            return Int(date.timeIntervalSince1970 * 1000).description
        }
        return ""
    }
    
    func getCreatedDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "d"
            let dateStr = dateFormatter.string(from: dateFromStr)
            dateFormatter.dateFormat = "MMM"
            let monthStr = dateFormatter.string(from: dateFromStr)
            dateFormatter.dateFormat = "yyyy"
            let yearStr = dateFormatter.string(from: dateFromStr)
            return dateStr + " " + monthStr.uppercased() + " " + yearStr
        }
        return ""
    }
    
    func getCommentsDateString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: dateFromStr)
        }
        return ""
    }
    
    func getFullDateString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "MMM dd,yyyy hh:mm a"
            let dateStr = dateFormatter.string(from: dateFromStr)
            return dateStr
        }
        return ""
        
    }
    
    func convertToUTCDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            return dateFormatter.string(from: dateFromStr)
        }
        return ""
    }
    
    func utcFromDateAndTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            return dateFormatter.string(from: dateFromStr)
        }
        return ""
    }
    
    func getDateMonthYearString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: dateFromStr)
        }
        return ""
    }
    
    
    func getDate() -> Date{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.timeZone = TimeZone.current
        if let date = timeFormatter.date(from: self){
            return date
        }
        return Date()
    }
    
    func getMonth() -> Date{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MMM"
        timeFormatter.timeZone = TimeZone.current
        if let date = timeFormatter.date(from: self){
            return date
        }
        return Date()
    }
    func getYear() -> Date{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy"
        timeFormatter.timeZone = TimeZone.current
        if let date = timeFormatter.date(from: self){
            return date
        }
        return Date()
    }
    
    func getChatdate() -> Date{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        timeFormatter.timeZone = TimeZone.current
        if let date = timeFormatter.date(from: self){
            return date
        }
        return Date()
    }
    
    func getMessagedate() -> String
    {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        if let dateFromStr = formatter.date(from: self){
            let dayString = formatter.string(from: dateFromStr)
            return dayString
        }
        return ""
    }
    
    
    func getchatDate() -> String
    {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone.current
        if let dateFromStr = formatter.date(from: self){
            let dayString = formatter.string(from: dateFromStr)
            return dayString
        }
        return ""
    }
    
    
    func getDayFromDate() -> String {
        let calendar = NSCalendar.current
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone.current
        if let dateFromStr = formatter.date(from: self){
            if calendar.isDateInToday(dateFromStr) {
                return "Today"
            }
            formatter.dateFormat = "EEEE, dd LLLL"
            let dayString = formatter.string(from: dateFromStr)
            return dayString
        }
        return ""
        
    }
    
    func getDueDateFromString() -> String
    {
        let calendar = NSCalendar.current
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone.current
        if let dateFromStr = formatter.date(from: self){
            if calendar.isDateInToday(dateFromStr) {
                return "Today"
            }
            formatter.dateFormat = "MMM d"
            return formatter.string(from: dateFromStr)
        }
        return ""
    }
    
    func getTimeFromString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "h:mm a"
            let timeStr = dateFormatter.string(from: dateFromStr)
            return timeStr
        }
        return ""
    }
    
    func getMediaTimeFromString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
            let timeStr = dateFormatter.string(from: dateFromStr)
            return timeStr
        }
        return ""
    }
    
    func getBackUpMessageTimeFromString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
            let timeStr = dateFormatter.string(from: dateFromStr)
            return timeStr
        }
        return ""
    }
    
    func getGroupMessage() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "MMM dd,h:mm a"
            let timeStr = dateFormatter.string(from: dateFromStr)
            return timeStr
        }
        return ""
    }
    
    
    
    
    
    func getManageUserTimeFromString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "mm.dd.yyyy"
            let timeStr = dateFormatter.string(from: dateFromStr)
            return timeStr
        }
        return ""
    }
    
    func getMessageTimeFromString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let timeStr = dateFormatter.string(from: dateFromStr)
            return timeStr
        }
        return ""
    }
    
    func getFieldtaskCompletionDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "dd MMM yyyy"
            let dateStr = dateFormatter.string(from: dateFromStr)
            dateFormatter.dateFormat = "hh:mm a"
            let timeStr = dateFormatter.string(from: dateFromStr)
            return timeStr + " on " + dateStr
        }
        return ""
        
    }
    
    
    
    func checkDateInToday() -> Bool{
        let calendar = NSCalendar.current
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        if let dateFromStr = formatter.date(from: self){
            return calendar.isDateInToday(dateFromStr)
        }
        return false
    }
    
    func dateMonthYear() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: dateFromStr)
        }
        return ""
    }
    func hoursAndMinutes() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: dateFromStr)
        }
        return ""
    }
    
    func ConvertStringToDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        if let dateFromStr = dateFormatter.date(from: self){
            return dateFromStr
        }
        return Date()
    }
    
    func currentDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        return dateFormatter.string(from: Date())
    }
    
    
    func getPastTimeStamp(for date : Date) -> String {
        
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr <= 24{
                return "Today"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "Yesterday"
            }
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        formatter.locale = Locale.current
        let strDate: String = formatter.string(from: date)
        return strDate
    }
    
    func getChatTimeStamp(for date : Date) -> String {
        
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale.current
        let strDate: String = formatter.string(from: date)
        return strDate
    }
    
    func meetingDateIsToday() -> Bool {
        _ = NSCalendar.current
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone.current
        if let dateFromStr = formatter.date(from: self){
            return dateFromStr < Date()
        }
        return false
        
    }
        
        /// Returns a new string made by removing in the `String` all "soft line
        /// breaks" and replacing all quoted-printable escape sequences with the
        /// matching characters as determined by a given encoding.
        /// - parameter encoding:     A string encoding. The default is UTF-8.
        /// - returns:                The decoded string, or `nil` for invalid input.
        
        func decodeQuotedPrintable(encoding enc : String.Encoding = .utf8) -> String? {
            
            // Handle soft line breaks, then replace quoted-printable escape sequences.
            return self
                .replacingOccurrences(of: "=\r\n", with: "")
                .replacingOccurrences(of: "=\n", with: "")
                .decodeQuotedPrintableSequences(encoding: enc)
        }
        
        /// Helper function doing the real work.
        /// Decode all "=HH" sequences with respect to the given encoding.
        
        private func decodeQuotedPrintableSequences(encoding enc : String.Encoding) -> String? {
            
            var result = ""
            var position = startIndex
            
            // Find the next "=" and copy characters preceding it to the result:
            while let range = range(of: "=", range: position..<endIndex) {
                result.append(contentsOf: self[position ..< range.lowerBound])
                position = range.lowerBound
                
                // Decode one or more successive "=HH" sequences to a byte array:
                var bytes = Data()
                repeat {
                    let hexCode = self[position...].dropFirst().prefix(2)
                    if hexCode.count < 2 {
                        return nil // Incomplete hex code
                    }
                    guard let byte = UInt8(hexCode, radix: 16) else {
                        return nil // Invalid hex code
                    }
                    bytes.append(byte)
                    position = index(position, offsetBy: 3)
                } while position != endIndex && self[position] == "="
                
                // Convert the byte array to a string, and append it to the result:
                guard let dec = String(data: bytes, encoding: enc) else {
                    return nil // Decoded bytes not valid in the given encoding
                }
                result.append(contentsOf: dec)
            }
            
            // Copy remaining characters to the result:
            result.append(contentsOf: self[position ..< endIndex])
            
            return result
        }
    
}

extension UIFont
{
    class func boldCabinFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: "Cabin-Bold", size: size)!
    }
    class func regularCabinFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: "Cabin-Regular", size: size)!
    }
    class func regularWorkSansFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: "WorkSans-Regular", size: size)!
    }
    class func boldGibsonFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: "Gibson-Bold", size: size)!
    }
    class func boldItalicGibsonFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: "Gibson-BoldItalic", size: size)!
    }
    class func lightRegularGibsonFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: "GibsonLight-Regular", size: size)!
    }
    class func semiboldGibsonFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: "Gibson-SemiBold", size: size)!
    }
}


extension Double{
    func toString() -> String {
        return String(format: "%f",self)
    }
    func twoDigitString() -> String{
        let value = String(format: "%.2f", arguments: [self])
        return value
    }
    func oneDigitString() -> String{
        let value = String(format: "%.1f", arguments: [self])
        return value
    }
}

extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    func widthForWithFont(_ font: UIFont) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x:0,y: 0,width: CGFloat.greatestFiniteMagnitude ,height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 1
        label.font = font
        label.text = self
        
       label.sizeToFit()
        return label.frame.width + 10
    }
}


