//vagones//
class Vagon{
	
	method cantPasajeros()= 0
	method esDePasajeros()= self.cantPasajeros() > 0
}

class VagonDePasajeros inherits Vagon{
    const largo 
    const ancho
    var tieneBanio
    var estaOrdenado

    override method cantPasajeros() = 
        if(ancho<=3)8* largo else(10*largo)- if(estaOrdenado)0 else 15

    method cargaMaxima()=
        if(tieneBanio)300 else 800
    method tieneBanio()= tieneBanio
    method pesoMaximo()=
        2000 + 80* self.cantPasajeros() + self.cargaMaxima()

    method recibirMantenimiento(){
        estaOrdenado= true
    }
}

class VagonDeCarga inherits Vagon{
    const cargaMaximaIdeal
    var maderasSueltas

    method cargaMaxima()=
        cargaMaximaIdeal - 400* maderasSueltas
    
    method tieneBanio()= false
    method pesoMaximo()= 
        1500 + self.cargaMaxima()
    method recibirMantenimiento(){
        maderasSueltas= 0.max(maderasSueltas- 2)
    }

}

class VagonDormitorio inherits Vagon{
    const cantDeCompartimientos
    var cantDeCamasPorCompartimientos

    override method cantPasajeros()=
        cantDeCompartimientos* cantDeCamasPorCompartimientos

    method tieneBanio()= true

    method cargaMaxima()= 1200

    method pesoMaximo()= 4000 +(80 * self.cantPasajeros)+ self.cargaMaxima()

    method recibirMantenimiento(){}
}

//formaciones//
import vagones.*

class Formaciones{
    const property vagones= []
    cost locomotoras=[]

    method agregarVagon(unVagon){
        vagones.add(unVagon)
    }

    method desarmarFormacion(){
        vagones.clear()
        locomotoras.clear()
    }

    method cuantosPasajerosPuedeLlevar()=
        vagones.sum({v=> v.cantPasajeros()})
    
    method cantVagonesPopulares()=
        vagones.count({v=> v.cantPasajeros()>50})
        //vagones.count({v=> v.esPopular()})
    method esFormacionCarguera()=
        vagones.all({v=> v.cargaMaxima()>=1000})
    method vagonMasPesado()=
        vagones.max({v=> v.pesoMaximo()})
    method vagonMasLiviano()=
        vagones.min({v=> v.pesoMaximo()})
    method dispersionDePeso()=
        self.vagonMasPesado().pesoMaximo()- self.vagonMasLiviano().pesoMaximo()

    method cantidadDeBanios()=
        vagones.count({v=> v.tieneBanio()})

    method hacerMantenimiento(){
        vagones.forEach({v=> v.recibirMantenimiento()})
    }
    method vagonesConPasajeros()=
        vagones.filter({v=> v.cantPasajeros()>0})
    method vagonConMasPasajeros()=
        self.vagonesConPasajeros().max({v=> v.cantPasajeros()})
    method vagonConMenosPasajeros()=
        self.vagonesConPasajeros().min({v=> v.cantPasajeros()})
    method estaEquilibrada()=
        self.vagonConMasPasajeros()-self.vagonConMenosPasajeros <= 20

    method estaOrganizada()=
        
}   



