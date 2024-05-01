/*
     <?xml version="1.0" encoding="UTF-8"?>
     <root>
       <city>San Jose</city>
       <firstName>John</firstName>
       <lastName>Doe</lastName>
       <state>CA</state>
     </root>
 */

import Foundation

class ApogeeXmlParser: NSObject, XMLParserDelegate {
    var currentElement: String = ""
    var city: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var state: String = ""
    
    func startParsing(url: URL) {
        let parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        print("City: \(city), First Name: \(firstName), Last Name: \(lastName), State: \(state)")
    }

    func startParsing(data: Data) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        print("City: \(city), First Name: \(firstName), Last Name: \(lastName), State: \(state)")
    }

    // event while parsing an element
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    // event after parsing an element
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }

    // event while parsing text inside an element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            switch currentElement {
            case "city": city = data
            case "firstName": firstName = data
            case "lastName": lastName = data
            case "state": state = data
            default: break
            }
        }
    }
    
    // event when parser error occurs
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: %@", parseError)
    }
}
