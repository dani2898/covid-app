import UIKit
import CoreLocation

class ViewController: UIViewController{

    
    var pais: String?
    
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
        pais = paisTextField.text!
        if pais != ""{
            performSegue(withIdentifier: "enviarDatos", sender: pais)
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Error en el país, revise que esté escrito correctamente.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        paisTextField.text=""
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "enviarDatos"{
      	        
              let destino = segue.destination as! DataViewController
              destino.recibirPais = pais
              
          }
    	
    
        
    }
    


}




