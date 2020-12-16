import UIKit
import CoreLocation

class ViewController: UIViewController {

    var covManager = covidManager()
    
    @IBOutlet weak var paisTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension ViewController: UITextFieldDelegate{

        func textFieldShouldReturn(_textField: UITextField)-> Bool{
            return true
        }
        
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if paisTextField.text != ""{
                   return true
               }
               else{
                   paisTextField.placeholder = "Escribe una pais"
                   return false
               }
    }
        
    @IBAction func buscarPaisBtn(_ sender: Any) {
        covManager.fetchCovid(nombrePais: paisTextField.text!)
        paisTextField.text=""
    }
    
        
}



