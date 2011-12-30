require 'rubygems'
require 'sqlite3'

TABLENAME='connections'

module PairCobbler 
  class NetHook
    attr_accessor :db, :connection_table
    def initialize(dbpath=nil)
      @db = SQLite3::Database.new(dbpath)
      File.chmod(0644, dbpath)
      initdb
    end

    def addip(ip=nil,name=nil, ctype=nil)
      return if ip.nil? or name.nil? or ctype.nil?
      sql = "INSERT INTO #{TABLENAME} (ip,name,ctype,state) values (?,?,?,1)"
      stmt = @db.prepare(sql)
      stmt.bind_params(ip,name,ctype)
      stmt.execute
    end

    def setdisconnected(ip=nil, ctype=nil)
      return if ip.nil?
      sql = "UPDATE #{TABLENAME} SET state = 0 WHERE ip = ? AND ctype = ?"
      stmt = @db.prepare(sql)
      stmt.bind_params(ip, ctype)
      stmt.execute
    end

    def removeip(ip=nil, ctype=nil)
      return if ip.nil? or ctype.nil?
      sql = "DELETE FROM #{TABLENAME} WHERE ip = ? AND ctype = ?"
      stmt = @db.prepare(sql)
      stmt.bind_params(ip, ctype)
      stmt.execute
    end

    private

    def initdb
      sql = "CREATE TABLE IF NOT EXISTS #{TABLENAME}(id integer primary key,ip TEXT, name TEXT, state BOOLEAN default 0, ctype TEXT, ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP)"
      @db.execute(sql)
    end
  end
end
