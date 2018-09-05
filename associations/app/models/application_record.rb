# t.integer "course_id"
# t.integer "student_id"

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
