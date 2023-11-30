require 'sqlite3'

class User
    attr_accessor :id, :firstname, :lastname, :age, :password , :email
    def initialize (id=000, firstname, lastname, age, password , email)
        @firstname=firstname
        @lastname=lastname
        @age=age 
        @password=password 
        @email=email
        @id=id
    end

    def self.connection()
        begin
            @db = SQLite3::Database.open 'db.sql'
            @db = SQLite3::Database.new 'db.sql' if !@db
            @db.results_as_hash = true
            @db.execute "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, firstname STRING, lastname STRING, age INTEGER, password STRING, email STRING)"
            return @db
        rescue SQLite3::Exception => err
            p "Error Ocurred: "
            p err
        end
    end 

    def self.create(user_info)
        @db = self.connection
        @db.execute "INSERT INTO users(firstname, lastname, age, password, email) VALUES(?,?,?,?,?)", user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email]

        new_users=User.new(user_info[:firstname], user_info[:lastname], user_info[:age], '', user_info[:email])
        new_users.id = @db.last_insert_row_id
        @db.close
        return new_users
    end 

    def self.authenticate(password, email)
        @db = self.connection
        user_attn = @db.execute "SELECT * FROM users WHERE email = ? AND password = ?", email, password
        @db.close
        return user_attn 
    end

    def self.find(user_id)
        @db = self.connection
        user = @db.execute "SELECT * FROM users WHERE id = ?", user_id
        user_info=User.new(user[0]["firstname"], user[0]["lastname"], user[0]["age"],user[0]["password"], user[0]["email"])
        @db.close
        return user_info
    end
     
    def self.all()
        @db = self.connection()
        all_user = @db.execute "SELECT * FROM users"
        @db.close
        return all_user
    end 

    def self.destroy(user_id)
        @db=self.connection()
        deleted_user=@db.execute "DELETE FROM users WHERE id=#{user_id}"
        @db.close
        return deleted_user 
    end 

    def self.update(user_id, attribute, value)
        @db = self.connection
        @db.execute "UPDATE users SET #{attribute} = ? WHERE id = ? ", value, user_id
        up_user = @db.execute "SELECT * FROM users where id = ? ", user_id
        @db.close
        return up_user
    end


end
