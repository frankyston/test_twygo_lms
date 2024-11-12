require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  test "should be invalid" do
    enrollment = Enrollment.new
    assert_not enrollment.valid?
  end

  test "should not be valid without user" do
    enrollment = Enrollment.new(user: nil)
    assert_not enrollment.valid?
  end

  test "should not be valid without course" do
    enrollment = Enrollment.new(course: nil)
    assert_not enrollment.valid?
  end

  test "should be valid" do
    enrollment = enrollments(:one)
    assert enrollment.valid?
  end

  test "should return the correct course" do
    enrollment = enrollments(:one)
    assert_equal courses(:one), enrollment.course
  end

  test "should return the correct user" do
    enrollment = enrollments(:one)
    assert_equal users(:user_one), enrollment.user
  end
end
