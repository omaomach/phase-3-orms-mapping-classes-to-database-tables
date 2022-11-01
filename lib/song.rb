class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  def self.create_table # I am creating a class method because it is the job of the class as a whole to create the table that it is mapped to
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)  
  end

  def save # takes the attributes that characterize a given song and saves them in a new row of the songs table in our database
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.album) # insert the song

    # get the song id from the database and save it to the Ruby instance
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

    #return the Ruby instance
    self

  end

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end

end

# hello = Song.new(name: "Hello", album: "25")
# hello.save
# gold_digger = Song.new(name: "Gold Digger", album: "Late Registration")
# gold_digger.save

# song = Song.create(name: "Hello", album: "25")
# song.name
# song.album