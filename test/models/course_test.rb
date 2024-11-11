require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test 'should be invalid' do
    course = Course.new
    assert_not course.valid?
  end

  test 'should not be valid without title' do
    course = Course.new(title: nil)
    assert_not course.valid?
  end

  test 'should not be valid without description' do
    course = Course.new(description: nil)
    assert_not course.valid?
  end

  test 'should not be valid with ended_at before started_at' do
    course = Course.new(title: 'Teste', description: 'Teste', started_at: Date.today + 1.day, ended_at: Date.today, instructor: 'Teste', user: User.first)
    assert_not course.valid?
  end

  test 'should be active' do
    course = Course.new(title: 'Teste', description: 'Teste', started_at: Date.today - 1.day, ended_at: Date.today + 1.day, instructor: 'Teste', user: User.first)
    assert course.active?
  end

  test 'should be inactive' do
    course = Course.new(title: 'Teste', description: 'Teste', started_at: Date.today - 2.day, ended_at: Date.today - 1.day, instructor: 'Teste', user: User.first)
    assert course.inactive?
  end

  test 'should return active courses' do
    Course.create(title: 'Teste curso 1', description: 'Teste curso 1', started_at: Date.today - 1.day, ended_at: Date.today + 1.day, instructor: 'Teste', user: User.first)
    assert_equal 3, Course.active.count
  end

  test 'should return inactive courses' do
    Course.create(title: 'Teste', description: 'Teste', started_at: Date.today - 2.day, ended_at: Date.today - 1.day, instructor: 'Teste', user: User.first)
    assert_equal 1, Course.inactive.count
  end

  test 'should not be valid without instructor' do
    course = Course.new(instructor: nil)
    assert_not course.valid?
  end

  test 'should not be valid without started_at' do
    course = Course.new(started_at: nil)
    assert_not course.valid?
  end

  test 'should not be valid without ended_at' do
    course = Course.new(ended_at: nil)
    assert_not course.valid?
  end

  test 'should not be valid with ended_at equal to started_at' do
    course = Course.new(started_at: Date.today, ended_at: Date.today)
    assert_not course.valid?
  end

  test 'should not be valid with emphasis' do
    course = Course.new(emphasis: nil)
    assert_not course.valid?
  end
end
