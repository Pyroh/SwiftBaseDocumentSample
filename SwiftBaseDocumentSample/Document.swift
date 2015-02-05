//
//  Document.swift
//  SwiftBaseDocumentSample
//
//  This sample code was create by CocoaCafe Forum communauty in MIT Licence
//
//  Refered topic :
//  http://forum.cocoacafe.fr/topic/13410-disparition-de-fileowners-de-xib-à-storyboard/
//


import Cocoa

let MYTEXT_KEY  = "Text"
let MYCHECK_KEY = "Check"
let MYAUTHOR_KEY = "Author"

class Document: NSDocument {

    var myState:Bool = false
    
    var myAuthor:String? = "" {
        didSet {
            if myAuthor == nil {
               myAuthor = ""
            }
        }
    }

    var myText:String? = ""  {
        didSet {
            if myText == nil {
                myText = ""
            }
        }
    }

    
    override init() {
        // Subclass-specific initialization here.
        super.init()
        println("DOC INIT  :")
        println("----------")
        println("(\(myState)) \(myAuthor) \(myText)")
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override func makeWindowControllers() {
        
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)!
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as NSWindowController
        self.addWindowController(windowController)
        
        // Connect viewController representedObject to document (self).
        let vc = windowController.contentViewController as ViewController
        vc.representedObject = self
        
        

    }
    
     func description() -> String {
        return "\nDescription\nImportant : \(self.myState)\nAuthor\(myAuthor)\nText : \(self.myText)"
    }

    // MARK: Read / Write file
    
    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
 
        // Print data to save
        println("SAVE  :")
        println("----------")
        println("(\(myState)) \(myAuthor) \(myText)")
        println()
        
        // Json serialization
        let savedDict = [MYCHECK_KEY: self.myState, MYAUTHOR_KEY: self.myAuthor!, MYTEXT_KEY: self.myText!]
        var error: NSError? = nil
        let serializedData = NSJSONSerialization.dataWithJSONObject(savedDict, options: NSJSONWritingOptions(), error: &error)
        
        
        return serializedData
    }

    override func readFromData(data: NSData, ofType typeName: String?, error outError: NSErrorPointer) -> Bool {
        
        // Load data
        
        var error: NSError? = nil
        
        let loadedDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &error) as? NSDictionary
        
        if let check = loadedDict![MYCHECK_KEY] as? Bool {
            self.myState = check
        }
        
        if let author = loadedDict![MYAUTHOR_KEY] as? String {
            self.myAuthor = author
        }
        
        if let text = loadedDict![MYTEXT_KEY] as? NSString {
            self.myText = text
        }
        
        println("LOAD  :")
        println("----------")
        println("(\(myState)) \(myAuthor) \(myText)")
        
        return true
    }
}

