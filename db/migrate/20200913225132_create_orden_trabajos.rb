class CreateOrdenTrabajos < ActiveRecord::Migration[6.0]
  def change
    create_table :orden_trabajos do |t|
      t.integer :trnum
      t.integer :trcan
      t.date :trcar #fecha de carga?
      t.string :clinom
      t.string :papel
      t.integer :gramaje
      t.string :colores
      t.string :pliego
      t.string :nomprod
      t.date :fecentr #fecha de entrega
      t.string :cam10
      t.string :cam12
      t.string :cam24
      t.string :procesos
      t.string :observaciones
      t.string :estado_actual
      t.boolean :estado

      t.timestamps
    end
  end
end
