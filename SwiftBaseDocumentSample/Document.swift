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

class Document: NSDocument {

    var myText:String = ""
    
    override init() {
        
        // Subclass-specific initialization here.
        super.init()
        println("init \(myText)")
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
        return self.myText
    }

    // MARK: Read / Write file
    
    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
 
        // Return data to save
        println("SAVE  :")
        println("----------")
        println("\(myText)")
        println()
        
        return self.myText.dataUsingEncoding ( NSUTF8StringEncoding , allowLossyConversion : false )
    }

    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        
        // Read file
        
        if data.length > 0 {
            // Load data
            let aString = NSString (data: data, encoding: NSUTF8StringEncoding)
            self.myText = aString as String
        } else {
            // Empty file
            self.myText = ""
        }
        
        println("LOAD  :")
        println("----------")
        println("\(myText)")
        println()
        
        return true
    }
}

