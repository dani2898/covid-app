//
//  ViewController.swift
//  Agenda
//
//  Created by Mac13 on 14/11/20.
//  Copyright © 2020 daniela_villa. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var contactos = [Contacto]()
    var nombreContacto : String?
    var telefonoContacto : String?
    var direccionContacto : String?
    var fotoContacto : Data?
    var indice : Int?
    
    @IBOutlet weak var imgcontactoView: UIImageView!
    @IBOutlet weak var tablaContactos: UITableView!
    //Conexion a la base de datos
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registro de la nueva celda
        tablaContactos.register(UINib(nibName: "UsuarioTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaUsuario")
        
        cargarInfoCoreData()
        
        self.tablaContactos.reloadData()        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        cargarInfoCoreData()
        tablaContactos.reloadData()
    }

    @IBAction func agregarContactoBtn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Agregar contacto", message: "Nuevo contacto", preferredStyle: .alert)
        
        alert.addTextField { (nombreAlert) in
            nombreAlert.placeholder = "Nombre"
        }
        
        
        alert.addTextField { (numeroAlert) in
            numeroAlert.placeholder = "Telefono"
        }
        
        alert.addTextField { (direccionAlert) in
            direccionAlert.placeholder = "Dirección"
        }
        
        
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            print("Agregar elemento")
            
            //Variables para guardar la info del nuevo contacto
            guard let nombreAlert = alert.textFields?.first?.text else { return }
            guard let numeroAlert = alert.textFields?[1].text else { return }
            guard let direccionAlert = alert.textFields?.last?.text else { return }
            
            if(nombreAlert != "" && numeroAlert != "" && direccionAlert != ""){
            //guardando en la base de datos
            
            let nuevoContacto = Contacto(context: self.context)
            //img = ima
            nuevoContacto.nombre = nombreAlert
            nuevoContacto.telefono = Int64(numeroAlert) ?? 0
            nuevoContacto.direccion = direccionAlert
            nuevoContacto.foto =  self.imgcontactoView.image?.pngData()
            self.guardarContacto()
            }
            else{
                let alert = UIAlertController(title: "Fallido", message: "Por favor ingrese información", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)            }
            
            self.tablaContactos.reloadData()
        
        }
        
        let actionCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        alert.addAction(actionAceptar)
        alert.addAction(actionCancelar)
        
        present(alert, animated: true, completion: nil)
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
}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaContactos.dequeueReusableCell(withIdentifier: "celdaUsuario") as! UsuarioTableViewCell
        
        celda.nombreContactoLabel.text = contactos[indexPath.row].nombre!
        celda.telefonoContactoLabel.text = String(contactos[indexPath.row].telefono)
        celda.imgUsuario.image =  UIImage(data: contactos[indexPath.row].foto!)
        return celda
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //eliminar elemento del arreglo
            context.delete(contactos[indexPath.row])
            guardarContacto()
            
            self.cargarInfoCoreData()
             self.tablaContactos.reloadData()
            
        }
        
       
       // tabla.reloadData()
    }
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        nombreContacto = contactos[indexPath.row].nombre
        telefonoContacto = String(contactos[indexPath.row].telefono)
        direccionContacto = contactos[indexPath.row].direccion
        indice = indexPath.row
        fotoContacto = contactos[indexPath.row].foto
        performSegue(withIdentifier: "editarContacto", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarContacto"{
            let objContacto = segue.destination as! EditarContactoViewController
            objContacto.recibirNombre = nombreContacto
            objContacto.recibirTelefono = telefonoContacto
            objContacto.recibirDireccion = direccionContacto
            objContacto.recibirIndice = indice
            objContacto.recibirFoto = fotoContacto
        }	
    }
    
    
}

