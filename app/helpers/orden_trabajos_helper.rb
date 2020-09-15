module OrdenTrabajosHelper

    def cadenatovector(cadena)
        if cadena == nil
      return [""]
        else
            cadena = cadena.gsub "[", ""
            cadena = cadena.gsub "]", ""
            cadena = cadena.gsub '"', ""
            cadena = cadena.gsub "'", ""
            cadena = cadena.gsub " ", ""
            return cadena.split(",")
        end
    end

    def cadenatohash(cadena)
        
        hash_post = Hash.new
        OrdenTrabajo::POST.each do |clave, valor|
            if cadenatovector(cadena).include? valor
                hash_post[clave] = valor
            end
        end
        return hash_post
    end  	

end
