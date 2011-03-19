require 'dbi'
require 'pacote'
require "historico"
require "singleton"

class Banco
  include Singleton

  attr_accessor :conn

  def initialize
    self
  end

  # Ve o endereço do banco
  def get_host_db
    hostname = `hostname`.chomp
    if hostname == "atilacamurca-desktop"
      return "localhost"
    elsif hostname == "samir-home"
      return "localhost"
    else
      return "10.50.40.69"
    end
  end

  # Faz o singleton
  def db_connect
    if @conn.nil?
      get_conn
    end
    return @conn
  end

  # Faz a conexão com o banco de dados.
  def get_conn
    begin
      database = "rsonline_prod"
      username = "postgres"
      password = "postgres"
      hostname = get_host_db
      port = 5432
      @conn = DBI.connect("DBI:Pg:dbname=#{database};host=#{hostname};port=#{port}", username, password)
    rescue DBI::DatabaseError => e
      puts "Ocorreu erro ao se conectar no banco de dados.\nStack do erro: #{e.err} #{e.errstr} SQLSTATE: #{e.state}"
      sleep 5
    end
  end

  # Disconecta-se do banco de dados.
  def db_disconnect
    begin
      @conn.disconnect
      @conn = nil
    rescue DBI::DatabaseError => e
      puts "Ocorreu erro ao se disconectar no banco de dados.\nStack do erro: #{e.err} #{e.errstr} SQLSTATE: #{e.state}"
      sleep 5
    end
  end

  def select_prioridade
    sql = "SELECT * FROM priorities"
    rst = Banco.instance.db_connect.execute(sql)
    array = rst.fetch_all
    rst.finish
    Banco.instance.db_disconnect
    array.sort
  end

end
