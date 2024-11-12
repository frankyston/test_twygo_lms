## Users

User.find_or_create_by(email: 'student@student.com', role: 'student') do |user|
  user.password = '123456'
  user.password_confirmation = '123456'
end

User.find_or_create_by(email: 'admin@admin.com', role: 'admin') do |user|
  user.password = '123456'
  user.password_confirmation = '123456'
end

## Courses

5.times do |i|
  covers = ['cover.jpg', 'cover2.png']
  Course.find_or_create_by(
    title: "Curso ##{i}",
    description: "Curso ##{i}",
    short_description: "Curso ##{i}",
    instructor: 'Teste',
    started_at: Date.today,
    ended_at: Date.today + 1.month,
    user: User.last
    ) do |course|
      course.cover = File.open(Rails.root.join('test', 'fixtures', 'files', covers.sample))
    end
end

## Lessons

files = ['sample.mp4', 'sample2.mp4']
thumbnails = ['thumb1.png', 'thumb2.jpg']

Course.all.each do |course|
  5.times do |i|
    Lesson.find_or_create_by(
      title: "Aula ##{i}",
      description: "Aula ##{i}",
      short_description: "Aula ##{i}",
      duration: 4,
      file_size: 8503379,
      course: course
    ) do |lesson|
      lesson.file = File.open(Rails.root.join('test', 'fixtures', 'files', files.sample))
      lesson.thumbnail = File.open(Rails.root.join('test', 'fixtures', 'files', thumbnails.sample))
    end
  end
end
