require "test_helper"

class LessonTest < ActiveSupport::TestCase
  test "should be invalid" do
    lesson = Lesson.new
    assert_not lesson.valid?
  end

  test "should not be valid without title" do
    lesson = Lesson.new(title: nil)
    assert_not lesson.valid?
  end

  test "should not be valid without description" do
    lesson = Lesson.new(description: nil)
    assert_not lesson.valid?
  end

  test "should not be valid without short_description" do
    lesson = Lesson.new(short_description: nil)
    assert_not lesson.valid?
  end

  test "should not be valid with long title" do
    lesson = Lesson.new(title: "a" * 101)
    assert_not lesson.valid?
  end

  test "should not be valid with long short_description" do
    lesson = Lesson.new(short_description: "a" * 101)
    assert_not lesson.valid?
  end

  test "should be valid" do
    lesson = lessons(:one)
    assert lesson.valid?
  end

  test "should return the correct duration" do
    lesson = Lesson.new(duration: 100)
    assert_equal 100, lesson.duration
  end

  test "should return the correct file size in megabytes" do
    lesson = Lesson.new(file_size: 1024 * 1024 * 1024)
    assert_equal 1024, lesson.bytes_to_megabytes
  end

  test "should return processed as true when duration and file_size are present" do
    lesson = Lesson.new(duration: 100, file_size: 1024 * 1024 * 1024)
    assert lesson.processed?
  end

  test "should return processed as false when duration is 0" do
    lesson = Lesson.new(duration: 0, file_size: 1024 * 1024 * 1024)
    assert_equal false, lesson.processed?
  end

  test "should return processed as false when file_size is 0" do
    lesson = Lesson.new(duration: 100, file_size: 0)
    assert_equal false, lesson.processed?
  end

  test "should return processed as false when duration is 0 and file_size is 0" do
    lesson = Lesson.new(duration: 0, file_size: 0)
    assert_equal false, lesson.processed?
  end
end
