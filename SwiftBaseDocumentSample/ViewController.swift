//
//  ViewController.swift
//  SwiftBaseDocumentSample
//
//  This sample code was create by CocoaCafe Forum communauty in MIT Licence
//
//  Refered topic :
//  http://forum.cocoacafe.fr/topic/13410-disparition-de-fileowners-de-xib-à-storyboard/
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
    

    
    
    @IBOutlet var myTextView: NSTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
            println("Document: \(representedObject)")
            if let doc = representedObject as? Document {
                self.myTextView.string = doc.myText
            }
        }
    }
    
    // MARK: Delegates
    
    func textDidEndEditing (notification: NSNotification)
    {
        println("textDidEndEditing")
    }
    
     func textView(aTextView: NSTextView,
        willChangeSelectionFromCharacterRange oldSelectedCharRange: NSRange,
        toCharacterRange newSelectedCharRange: NSRange) -> NSRange
    {
        // Update Document
        if let doc = representedObject as? Document {
            doc.myText = self.myTextView.string!
            
        }

        println("willChangeSelectionFromCharacterRange")
        
        return newSelectedCharRange
    }
    

}

