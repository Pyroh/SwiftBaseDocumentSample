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
    weak var mainWindowController: NSWindowController!
    private var textCache: String?
    dynamic var myState: Bool = false {
        didSet {
            self.undoManager?.prepareWithInvocationTarget(self).setValue(oldValue, forKey: "myState")
            println("myState: \(myState)")
        }
    }
    dynamic var myAuthor: String? {
        didSet {
            self.undoManager?.prepareWithInvocationTarget(self).setValue(oldValue, forKey: "myAuthor")
            println("myAuthor: \(myAuthor)")
        }
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
        if let text = textCache {
            vc.textView.string = text
        }
        textCache = nil
        self.mainWindowController = windowController
    }
    
    func description() -> String {
        return "\nDescription\nImportant: \(self.myState)\nAuthor: \(myAuthor)\nText: \n"
    }

    // MARK: Read / Write file
    
    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        // Json serialization
        let textView = (self.mainWindowController.contentViewController as ViewController).textView
        var savedDict: [String: AnyObject] = [MYCHECK_KEY: self.myState]
        
        // Print data to save
        println("SAVE  :")
        println("----------")
        println("(\(myState)) \(myAuthor) \(textView.string)")
        
        if let text = textView.string {
            savedDict[MYTEXT_KEY] = text
        }
        if let author = myAuthor {
            savedDict[MYAUTHOR_KEY] = author
        }
        var error: NSError? = nil
        let serializedData = NSJSONSerialization.dataWithJSONObject(savedDict, options: NSJSONWritingOptions(), error: &error)
        
        return serializedData
    }

    override func readFromData(data: NSData, ofType typeName: String?, error outError: NSErrorPointer) -> Bool {
        // Load data
        
        if let loadedDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: outError) as? [String: AnyObject] {
            self.undoManager?.disableUndoRegistration()
        
            if let check = loadedDict[MYCHECK_KEY] as? Bool {
                self.myState = check
            }
            self.myAuthor = loadedDict[MYAUTHOR_KEY] as? String
            self.textCache = loadedDict[MYTEXT_KEY] as? String
            
            self.undoManager?.enableUndoRegistration()
            
            println("LOAD  :")
            println("----------")
            println("(\(myState)) \(myAuthor) \(textCache)")
            
            return true
        } else {
            return false
        }
    }
}

