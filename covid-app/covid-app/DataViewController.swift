
import UIKit

class DataViewController: UIViewController{
   
    var covManager = covidManager()
    var recibirPais: String?
    @IBOutlet weak var imgPais: UIImageView!
    @IBOutlet weak var paisLabel: UILabel!
    @IBOutlet weak var casosLabel: UILabel!
    @IBOutlet weak var muertesLabel: UILabel!
    @IBOutlet weak var recuperadosLabel: UILabel!
    @IBOutlet weak var pruebasLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        covManager.delegado = self
        
        covManager.fetchCovid(nombrePais: recibirPais!)
    }
    	
  
  	
}

extension DataViewController: covidManagerDelegate{
    
    func huboError(cualError: Error){
        print(cualError.localizedDescription)
        
        DispatchQueue.main.sync{
            let alert = UIAlertController(title: "Error", message: "Error en la ciudad, revise que esté escrito correctamente.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func actualizarCovid(covid: CovidModelo) {
        
        DispatchQueue.main.async {
            print("Casos del covid")
            print(covid.casos)
            self.casosLabel.text = String(covid.casos)
            self.muertesLabel.text = String(covid.muertes)
            self.recuperadosLabel.text = String(covid.recuperados)
            self.pruebasLabel.text = String(covid.pruebas)
            
            let imageUrlString = covid.bandera

            let imageUrl = URL(string: imageUrlString)!

            let imageData = try! Data(contentsOf: imageUrl)
            
            self.imgPais.image =  UIImage(data: imageData)
            
            self.paisLabel.text = covid.pais
            //self.tempMaximaLabel.text = "T. Max: " + String(clima.temperaturaMaxima)+"°C"
        }
        
        
    }
    
}



