## Users

User.find_or_create_by(email: 'admin@example.com', role: 'admin') do |user|
  user.password = '123456'
  user.password_confirmation = '123456'
end

## Courses

Course.find_or_create_by(
  title: 'Curso de Ruby on Rails',
  description: 'Curso de Ruby on Rails',
  instructor: 'Teste',
  started_at: Date.today,
  ended_at: Date.today + 1.month,
  user: User.first
) do |course|
  course.cover = File.open(Rails.root.join('app', 'assets', 'images', 'cover.jpg'))
end

## Lessons

Lesson.find_or_create_by(
  title: 'Aula 1',
  description: 'Aula 1',
  duration: 4,
  file_size: 8503379,
  course: Course.first
) do |lesson|
  lesson.file = File.open(Rails.root.join('app', 'assets', 'videos', 'sample.mp4'))
  lesson.thumbnail = File.open(Rails.root.join('app', 'assets', 'images', 'thumbnail.png'))
end
