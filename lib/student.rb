require_relative "../config/environment.rb"

class Student

attr_accessor :name, :grade
attr_reader :id
 
  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
 
  def save
    if self.id 
      self.update
    else
      sql = <<-SQL
        INSERT INTO songs (name, album) 
        VALUES (?, ?)
      SQL
 
      DB[:conn].execute(sql, self.name, self.album)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    end
  end
  
  def self.create_table
  end 
  
  def self.drop_table
  end


 
  def self.create(name:, grade:)
    song = Student.new(name, grade)
    song.save
    song
  end
 
 def new_from_db
 end
 
  def self.find_by_name(id)
    sql = "SELECT * FROM songs WHERE id = ?"
    result = DB[:conn].execute(sql, id)[0]
    Song.new(result[0], result[1], result[2])
  end
 
  def update
    sql = "UPDATE songs SET name = ?, album = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.album, self.id)
  end

end
