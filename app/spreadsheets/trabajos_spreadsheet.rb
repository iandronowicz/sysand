class TrabajosSpreadsheet
  attr_accessor :trabajos
  
  def initialize trabajos
    @trabajos = trabajos
  end

  def generate_xls
    book = Spreadsheet::Workbook.new
    
    create_body book

    data_to_send = StringIO.new
    book.write data_to_send
    data_to_send.string 
  end

  def create_body book
    sheet = book.create_worksheet name: "Trabajos | Planilla"
    sheet2 = book.create_worksheet name: "Trabajos | Resumen"

    # Header row with a specific format
    sheet.row(0).concat %w{TAREA UNIDAD CANTIDAD P.UNITARIO P.TOTAL}
    sheet2.row(0).concat %w{TRABAJO DESCRIPCIÓN}
    
    book.set_custom_color(41, 0x21, 0x4b, 0x77) 
    header_format = Spreadsheet::Format.new(:weight => :bold, :size => 14, :align => :center, :vertical_align => :center, :color => :white, :pattern_fg_color => :xls_color_41, :pattern => 1, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    sheet.row(0).set_format 0, header_format
    sheet.row(0).set_format 1, header_format
    sheet.row(0).set_format 2, header_format
    sheet.row(0).set_format 3, header_format
    sheet.row(0).set_format 4, header_format

    sheet2.row(0).set_format 0, header_format
    sheet2.row(0).set_format 1, header_format

    sheet.column(0).width = 70
    sheet.column(1).width = 15
    sheet.column(2).width = 20
    sheet.column(3).width = 20
    sheet.column(4).width = 20

    sheet2.column(0).width = 80
    sheet2.column(1).width = 80

    currency_format = Spreadsheet::Format.new(:number_format =>  '$#,##0.00_);[Red]($#,##0.00)', :text_wrap => true, :size => 12, :align => :center, :vertical_align => :center, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    default_format = Spreadsheet::Format.new(:weight => :bold, :text_wrap => true, :size => 12, :align => :center, :vertical_align => :center, :align => :center, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    default_format2 = Spreadsheet::Format.new(:text_wrap => true, :size => 12, :align => :center, :vertical_align => :center, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)

    row_index = 1
    trabajo_index = 1
    total = 0
    trabajos.each do |trabajo|
      sheet.merge_cells(row_index, 0, row_index, 4)
      sheet.row(row_index).insert 0, "#{trabajo.titulo}"
      sheet.row(row_index).set_format 0, header_format

      sheet2.row(trabajo_index).insert 0, "#{trabajo.titulo}"
      sheet2.row(trabajo_index).insert 1, "#{trabajo.descripcion}"
      sheet2.row(trabajo_index).set_format(0, default_format2)
      sheet2.row(trabajo_index).set_format(1, default_format2)
      trabajo_index += 1

      row_index += 1
      if trabajo.tareas.count == 0
        sheet.merge_cells(row_index, 0, row_index, 4)
        sheet.row(row_index).insert 0, "Trabajo Pendiente"
        sheet.row(row_index).set_format 0, default_format2
        row_index += 1
      else  
        trabajo.tareas.each do |tarea|
          sheet.row(row_index).set_format(0, default_format2)
          sheet.row(row_index).set_format(1, default_format2)
          sheet.row(row_index).set_format(2, default_format2)

          sheet.row(row_index).insert 0, tarea.descripcion
          sheet.row(row_index).insert 1, tarea.tipo_de_tarea.to_s
          sheet.row(row_index).insert 2, tarea.cantidad

          sheet.row(row_index).set_format(3, currency_format)
          sheet.row(row_index).insert 3, tarea.precio_unitario

          sheet.row(row_index).set_format(4, currency_format)
          sheet.row(row_index).insert 4, tarea.precio_total
          row_index += 1
          total += tarea.precio_total
        end
      end
    end
    
    sheet.row(row_index).insert 0, "TOTAL"
    sheet.row(row_index).insert 4, total
    sheet.merge_cells(row_index, 0, row_index, 3)
    sheet.row(row_index).set_format(0, header_format)
    sheet.row(row_index).set_format(4, header_format)
    currency_format2 = Spreadsheet::Format.new(:number_format =>  '$#,##0.00_);[Red]($#,##0.00)', :weight => :bold, :size => 14, :align => :center, :vertical_align => :center, :color => :white, :pattern_fg_color => :xls_color_41, :pattern => 1, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    sheet.row(row_index).set_format(4, currency_format2)
  end
end