# require 'byebug'

class Student
  attr_accessor :first_name, :last_name, :courses, :name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    @first_name + " " + @last_name
  end

  def courses
    @courses
  end

  def enroll(course)

    raise "you already have a class at that time!" if has_conflict?(course)

    unless course.students.include?(name)
      self.courses << course
      course.add_student(self)
    end
  end

  def has_conflict?(course)
    @courses.any? { |c| course.conflicts_with(c) }
  end



  def course_load
    hash = {}
    @courses.each do |course|
      if hash.include?(course.department)
        hash[course.department] += course.credits
      else
        hash[course.department] = course.credits
      end
    end
    hash
  end

end

class Admin
  def initialize(name)
    @name = name
  end

  def add_course
    puts "Input course name, department, credits, time block, days"

    course_name = gets.chomp
    department = gets.chomp
    credits = gets.chomp
    time_block = gets.chomp
    days = gets.chomp
    Course.new(course_name, department, credits, time_block, days)
  end

  def add_student
    puts "Input student and course name"

    student_name = gets.chomp
    course_name = gets.chomp

    student_name.enroll(course_name)
  end

end

class Course
 attr_accessor :course_name, :department, :credits, :students, :time_block, :days

  def initialize(course_name, department, credits, time_block, *days)
    @course_name = course_name
    @department = department
    @credits = credits
    @time_block = time_block
    @days = days.to_a
    @students = []
    File.open("#{course_name}.txt", "w") {}


  end


  def add_student(student)
    @students << student
    File.open("#{course_name}.txt", "a") do |f|
      f.puts student.name
    end
  end

  def conflicts_with(course2)

    @days.each do |i|
      if course2.days.include?(i) && @time_block == course2.time_block
      return true
    else
      return false
      end
    end
  end

end

dan = Student.new("Dan", "Man")
algebra = Course.new("algebra", "math", 4, 1, :mon)
martine = Student.new("martine", "ehrlich")
english = Course.new("english", "m", 4, 1, :mon)
geometry = Course.new("geometry", "math", 4, 2, :mon)
geometry.conflicts_with(english)
martine.enroll(english)
martine.enroll(geometry)
dan.enroll(geometry)
admin = Admin.new("kush")
#admin.add_course
admin.add_student
