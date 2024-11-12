require 'csv'
class ReportCsv
  def initialize(course)
    @course = course
  end

  def call
    rows_csv = []
    rows_csv << ["Aula", "Duração", "Tamanho"]
    @course.lessons.each do |lesson|
      rows_csv << [lesson.title, lesson.duration, lesson.bytes_to_megabytes]
    end

    file_path = Rails.root.join("tmp", "report_#{@course.title.parameterize}-#{Time.current.strftime('%Y%m%d%H%M%S')}.csv")
    File.write(file_path, rows_csv.map(&:to_csv).join)
    file_path
  end
end
