PAIRDIR='/home/pair'
DBPATH=PAIRDIR + '/pair-ips.db'
TABLENAME='connections'

require 'rubygems'
require 'sqlite3'

module PairCobbler 
  class NetHook
    attr_accessor :db
    def initialize
      @db = SQLite3::Database.new(DBPATH)
      File.chmod(0644, DBPATH)
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
