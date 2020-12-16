//
//  EditarContactoViewController.swift
//  Agenda
//
//  Created by Mac13 on 15/11/20.
//  Copyright © 2020 daniela_villa. All rights reserved.
//

import UIKit
import CoreData 

class EditarContactoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var contactos = [Contacto]()
    var recibirNombre: String?
    var recibirTelefono: String?
    var recibirDireccion: String?
    var recibirIndice: Int?
    var recibirFoto: Data?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        @IBOutlet weak var imagenUsuario: UIImageView!
    
    @IBOutlet weak var nombreContacto: UITextField!
    @IBOutlet weak var telefonoContacto: UITextField!
    @IBOutlet weak var direccionContacto: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarInfoCoreData()
        
        nombreContacto.text = recibirNombre
        telefonoContacto.text = recibirTelefono
        direccionContacto.text = recibirDireccion
        imagenUsuario.image = UIImage(data: recibirFoto!)
        // Do any additional setup after loading the view.
    }
    
    func guardarContacto(){
        do {
            try context.save()
            print("Se guardo correctamente")
            self.cargarInfoCoreData()
            
        }catch let error as NSError{
            print("Error al guardar en la base de datos \(error.localizedDescription)")
        }
        
    }
    
    func cargarInfoCoreData(){
        
        let fetchRequest : NSFetchRequest <Contacto> = Contacto.fetchRequest()
        
        do{
            contactos = try context.fetch(fetchRequest)
            
            
        } catch let error as NSError {
            print("Error al cargar la bd \(error.localizedDescription)")
        }
    }

    @IBAction func guardarContactobtn(_ sender: UIButton) {
       
        if(nombreContacto.text != "" && telefonoContacto.text != "" && direccionContacto.text != "")
        {
        contactos[recibirIndice!].setValue(nombreContacto.text, forKey: "nombre")
       contactos[recibirIndice!].setValue(Int64(telefonoContacto.text!), forKey: "telefono")
       contactos[recibirIndice!].setValue(direccionContacto.text, forKey: "direccion")
       contactos[recibirIndice!].setValue(self.imagenUsuario.image?.pngData(), forKey: "foto")
       
        
            guardarContacto()
            navigationController?.popViewController(animated: true)        }
        else{
            let alert = UIAlertController(title: "Campo vacío", message: "Todos los campos son obligatorios", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)          }
        
        
        
    }
    
    @IBAction func cancelarBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    //CAMBIAR IMAGEN
    @IBAction func seleccionarImagen(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated:true)      }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagen = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        imagenUsuario.image = imagen
        
        picker.dismiss(animated: true, completion: nil)    }}
