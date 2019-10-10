class TareasSpreadsheet
  attr_accessor :tareas

  def initialize tareas
    @tareas = tareas
  end

  def generate_xls
    book = Spreadsheet::Workbook.new

    create_body book

    data_to_send = StringIO.new
    book.write data_to_send
    data_to_send.string
  end

  def create_body book
    sheet = book.create_worksheet name: "Tareas"
    sheet.row(0).concat %w{FECHA TRABAJO DESCRIPCION TAREA CANTIDAD P.UNITARIO P.TOTAL}
    book.set_custom_color(41, 0x21, 0x4b, 0x77)
    header_format = Spreadsheet::Format.new(:weight => :bold, :size => 14, :align => :center, :vertical_align => :center, :color => :white, :pattern_fg_color => :xls_color_41, :pattern => 1, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    sheet.row(0).set_format 0, header_format
    sheet.row(0).set_format 1, header_format
    sheet.row(0).set_format 2, header_format
    sheet.row(0).set_format 3, header_format
    sheet.row(0).set_format 4, header_format
    sheet.row(0).set_format 5, header_format
    sheet.row(0).set_format 6, header_format
    sheet.column(0).width = 15
    sheet.column(1).width = 30
    sheet.column(2).width = 80
    sheet.column(3).width = 20
    sheet.column(4).width = 20
    sheet.column(5).width = 20
    sheet.column(6).width = 20
    currency_format = Spreadsheet::Format.new(:number_format =>  '$#,##0.00_);[Red]($#,##0.00)', :text_wrap => true, :size => 12, :align => :center, :vertical_align => :center, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    default_format = Spreadsheet::Format.new(:weight => :bold, :text_wrap => true, :size => 12, :align => :center, :vertical_align => :center, :align => :center, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    default_format2 = Spreadsheet::Format.new(:text_wrap => true, :size => 12, :align => :center, :vertical_align => :center, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    date_format = Spreadsheet::Format.new(:number_format =>  'MM/YY', :text_wrap => true, :size => 12, :align => :center, :vertical_align => :center, :bottom => :thin, :top => :thin, :left => :thin, :right => :thin)
    row_index = 1
    total = 0
    tareas.each do |tarea|
      sheet.row(row_index).set_format(0, date_format)
      sheet.row(row_index).set_format(1, default_format2)
      sheet.row(row_index).set_format(2, default_format2)
      sheet.row(row_index).set_format(3, default_format2)
      sheet.row(row_index).set_format(4, default_format2)

      sheet.row(row_index).insert 0, tarea.trabajo.fecha_de_inicio.strftime("%m/%Y")
      sheet.row(row_index).insert 1, tarea.trabajo.titulo
      sheet.row(row_index).insert 2, tarea.trabajo.descripcion
      sheet.row(row_index).insert 3, tarea.tipo_de_tarea.to_s
      sheet.row(row_index).insert 4, tarea.cantidad

      sheet.row(row_index).set_format(5, currency_format)
      sheet.row(row_index).insert 5, tarea.precio_unitario

      sheet.row(row_index).set_format(6, currency_format)
      sheet.row(row_index).insert 6, tarea.precio_total
      row_index += 1
      total += tarea.precio_total
    end
  end
end
