class OrdenTrabajosImport
  include ActiveModel::Model
  require 'roo'


  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_orden_trabajos
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      
      if row["cliente"] and row["producto"]
        
        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE ot = " + row["ot"].to_s + " and cliente like '" + row["cliente"].to_s + "' and producto like '" + row["producto"].to_s + "'").to_a
      
      elsif row["cliente"].nil? and row["producto"]
        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE ot = " + row["ot"].to_s + " and cliente IS NUll and producto '" + row["producto"].to_s + "'").to_a

      elsif row["cliente"] and row["producto"].nil? 
        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE ot = " + row["ot"].to_s + " and cliente like '" + row["cliente"].to_s + "' and producto IS NULL").to_a
      elsif row["cliente"].nil? and row["producto"].nil?
        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE ot = " + row["ot"].to_s + " and cliente IS NULL and producto IS NULL").to_a
      end
      
      if @orden_trabajos_bd[0] != nil
        row["id"] = (@orden_trabajos_bd[0].to_hash)["id"] 
      end  

      orden_trabajos = OrdenTrabajo.find_by_id(row["id"]) || OrdenTrabajo.new
      print "row[id] : "
      puts row["id"]

        
      orden_trabajos.attributes = row.to_hash
      print "orden_trabajos.attributes :"
      print orden_trabajos.attributes 

      orden_trabajos

    end
  end

  def imported_orden_trabajos
    @imported_orden_trabajos ||= load_imported_orden_trabajos
  end

  def save

      if imported_orden_trabajos.map(&:valid?).all?
        imported_orden_trabajos.each(&:save!)
        true
      else
        imported_orden_trabajos.each_with_index do |orden_trabajos, index|
          orden_trabajos.errors.full_messages.each do |msg|
            errors.add :base, "Row #{index + 2}: #{msg}"
          end
        end
        false
      end
    end
end