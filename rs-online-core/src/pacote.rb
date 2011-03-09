require "timestamp"
require "rubygems"
require "shorturl"
require "prioridade"
require "status"
require "link"
require "plugins/rapidshare"
require "plugins/megaupload"

class Pacote
  attr_accessor :id_pacote, :tamanho, :problema, :nome, :completado, \
    :mostrar, :prioridade, :senha, :data_inicio, :data_fim, :descricao, \
    :url_fonte, :legenda

  def initialize nome
    @nome = nome
    @tamanho = 0
    @problema = false
    @completado = false
    @data_inicio = nil
    @data_fim = nil
    @mostrar = nil
    @senha = nil
    @descricao = nil
    @url_fonte = nil
    @legenda = nil
  end
  
  def update_db
    # FIXME testar pacote update_db
    sql = "UPDATE packages SET "
    @tamanho ? sql += "size = #{@tamanho}, " : sql += "size = NULL, "
    @prioridade ? sql += "priority_id = #{@prioridade}, " : sql += "priority_id = #{Prioridade::NENHUMA}, "
    @data_inicio ? sql += "date_started = '#{StrTime.timestamp(@data_inicio)}', " : sql += "date_started = NULL, "
    @data_fim ? sql += "date_finished = '#{StrTime.timestamp(@data_fim)}', " : sql += "date_finished = NULL, "
    @completado != nil ? sql += "completed = '#{@completado}', " : sql += "completed = DEFAULT, "
    @mostrar != nil ? sql += "show = '#{@mostrar}', " : sql += "show = DEFAULT, "
    @problema != nil ? sql += "problem = '#{@problema}', " : sql += "problem = DEFAULT, "
    @senha ? sql += "pass_phrase = '#{@senha}', " : sql += "pass_phrase = NULL, "
    @descricao ? sql += "comment = '#{@descricao}', " : sql += "comment = NULL, "
    @url_fonte ? sql += "url_source = '#{@url_fonte}', " : sql += "url_source = NULL, "
    @legenda ? sql += "url_subtitle = '#{@legenda}', " : sql += "url_subtitle = NULL "
    sql += "WHERE id = ?"
    Banco.instance.db_connect.do(sql, @id_pacote)
  end

  def encurta_url text
    return nil if text == nil
    text_original = text
    text.strip!
    if text =~ /http:\/\/.+/i and not text =~ /http:\/\/tinyurl.+/i
      return ShortURL.shorten(text, :tinyurl)
    else
      return text_original
    end
  end
  
  def reset
    @tamanho = nil
    @problema = false
    @completado = false
    @data_inicio = nil
    @data_fim = nil
    update_db
  end

  
  ######################
  ## Funções do Banco
  ######################

  def select_count_links
    # seleciona todos do pacote.
    sql = "SELECT count(id) FROM links WHERE package_id = ? "
    rst = Banco.instance.db_connect.execute(sql, @id_pacote)
    count_total = rst.fetch_all[0]
    rst.finish

    # seleciona todos os baixados.
    sql = "SELECT count(id) FROM links WHERE package_id = ? AND status_id = #{Status::BAIXADO} "
    rst = Banco.instance.db_connect.execute(sql, @id_pacote)

    count_baixados = rst.fetch_all[0]
    rst.finish
    Banco.instance.db_disconnect

    count = []
    count.push count_baixados
    count.push count_total
    count
  end

  # Retorna o pacote a ser baixado mais prioritário e mais recente.
  # Retorno: Objeto Pacote
  def self.select_pendente
    sql = "SELECT id, description, MAX(priority_id) AS prioridade_max \
      FROM packages WHERE completed = 'false' AND problem = 'false' \
      GROUP BY id, description, priority_id ORDER BY priority_id desc, id desc LIMIT 1"
    begin
      rst = Banco.instance.db_connect.execute(sql)
      pacote = nil
      rst.fetch do |row|
        pacote = Pacote.new(row["description"])
        pacote.id_pacote = row["id"]
        pacote.prioridade = row["prioridade_max"]
      end
    rescue Exception => err
      puts "Erro no fetch ou resultset: #{err}"
      nil
    end
    rst.finish
    Banco.instance.db_disconnect
    pacote
  end

  def select

    #  id bigserial NOT NULL,
    #  nome character varying(100) NOT NULL,
    #  completado boolean DEFAULT false,
    #  mostrar boolean DEFAULT true,
    #  problema boolean DEFAULT false,
    #  data_inicio timestamp without time zone DEFAULT now(),
    #  data_fim timestamp without time zone,
    #  senha character varying(50),
    #  prioridade integer DEFAULT 3,
    #  tamanho integer,
    #  descricao character varying(250),
    #  url_fonte character varying(200),
    #  legenda character varying(200),

    sql = "SELECT * FROM packages WHERE id = ?"
    begin
      rst = Banco.instance.db_connect.execute(sql, @id_pacote)
      if rst == nil
        raise
      end
      rst.fetch do |row|
        @nome = row["description"]
        @completado = row["completed"]
        @mostrar = row["show"]
        @problema = row["problem"]
        @data_inicio = row["date_started"]
        @data_fim = row["date_finished"]
        @senha = row["pass_phrase"]
        @prioridade = row["priority_id"]
        @tamanho = row["size"]
        @descricao = row["comment"]
        @url_fonte = row["url_source"]
        @legenda = row["url_subtitle"]
      end
      rst.finish
    rescue Exception => err
      puts "Erro: #{err.message}\nBacktrace: #{err.backtrace.join("\n")}"
      @id_pacote = nil
    end
    Banco.instance.db_disconnect
    self
  end

  # Insere o pacote e os links no banco
  def save
    @data_inicio = Time.now
    sql = "INSERT INTO packages   \
        (description, date_started, priority_id, pass_phrase, comment, url_source, url_subtitle) \
        VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id"

    begin
      rst = Banco.instance.db_connect.execute(sql, @nome, StrTime.timestamp(@data_inicio), \
          @prioridade, @senha, @descricao, @url_fonte, \
          @legenda)
    rescue Exception => e
      puts "Erro no resultset. Não foi possível salvar o pacote \"#{@nome}\"."
      puts "#{e.message}\nBacktrace: #{e.backtrace.join("\n")}"
      @id_pacote = nil
      return
    end
    if rst == nil
      puts "Resultset nulo. Não foi possível salvar o pacote \"#{@nome}\"."
      @id_pacote = nil
      return
    end
    
    begin
      @id_pacote = rst.fetch_all[0][0]
    rescue Exception => e
      puts "Erro no fetch: #{e.message}\nBacktrace: #{e.backtrace.join("\n")}"
      @id_pacote = nil
    end
    rst.finish
    Banco.instance.db_disconnect
    @id_pacote
  end

  def save_links(links)
    retorno = []
    links.each do |line|
      sql = "INSERT INTO links (package_id, url) VALUES (?, ?) RETURNING id"
      begin
        rst = Banco.instance.db_connect.execute(sql, @id_pacote, line)
      rescue Exception => e
        puts "Erro no resultset: #{e.message}\nBacktrace: #{e.backtrace.join("\n")}"
        return nil
      end
      retorno.push rst.fetch_all[0][0]
      rst.finish
      Banco.instance.db_disconnect
    end
    return retorno
  end

  # Captura os pacotes que estão para ser baixado com exceção de um, o qual
  # é passado como parâmetro.
  # Retorno: Objeto Pacote
  def self.select_pacotes_pendetes_teste id_pacote
    sql = "SELECT id, description, MAX(priority_id) AS prioridade_max \
      FROM packages WHERE completed = 'false' AND problem = 'false' \
      AND id != ? GROUP BY id, description, priority_id \
      ORDER BY priority_id desc, id desc"
    rst = Banco.instance.db_connect.execute(sql, id_pacote)
    pacotes = Array.new
    pacote = nil
    begin
      rst.fetch do |row|
        pacote = Pacote.new(row["description"])
        pacote.id_pacote = row["id"]
        pacote.prioridade = row["prioridade_max"]
        pacotes << pacote
      end
    rescue Exception => err
      puts "Erro no fetch: #{err}"
      nil
    end
    rst.finish
    Banco.instance.db_disconnect
    pacotes
  end

  def self.select_lista mostrar
    sql = "SELECT * FROM packages WHERE show = ? "
    begin
      rst = Banco.instance.db_connect.execute(sql, mostrar)
      pacotes = Array.new
      pacote = nil
      rst.fetch do |row|
        pacote = Pacote.new(row["nome"])
        pacote.id_pacote = row["id"]
        pacote.completado = row["completed"]
        pacote.mostrar = row["show"]
        pacote.problema = row["problem"]
        pacote.data_inicio = row["date_started"]
        pacote.data_fim = row["date_finished"]
        pacote.senha = row["pass_phrase"]
        pacote.prioridade = row["priority_id"]
        pacote.tamanho = row["size"]
        pacote.descricao = row["comment"]
        pacote.url_fonte = row["url_source"]
        pacote.legenda = row["url_subtitle"]
        pacotes << pacote
      end
    rescue Exception => err
      puts "Erro no fetch"
      puts err
      pacotes = nil
    end
    rst.finish
    Banco.instance.db_disconnect
    return pacotes
  end
  
  # Captura a lista de links.
  # Retorna um Array de Objetos Link
  def select_links
    if @id_pacote == nil or @id_pacote == ""
      return nil
    end
=begin
  id_link bigserial NOT NULL,
  id_pacote integer NOT NULL,
  link character varying(300) NOT NULL,
  completado boolean DEFAULT false,
  tamanho integer,
  id_status integer NOT NULL DEFAULT 5,
  data_inicio timestamp without time zone,
  data_fim timestamp without time zone,
  testado boolean NOT NULL DEFAULT false,
  filename character varying(200),
=end
    sql = "SELECT l.id, l.package_id, l.url, l.completed, l.size, \
    l.status_id, l.date_started, l.date_finished, l.tested \
    FROM packages p, links l \
    WHERE l.package_id = p.id AND p.id = ? "
    
    lista = Array.new
    link = nil
    begin
      rst = Banco.instance.db_connect.execute(sql, @id_pacote)
      rst.fetch do |row|
        case row["url"]
        when /megaupload/i
          link = Megaupload.new(row["url"])
        when /rapidshare/i
          # TODO Refatorar o módulo Rapidshare
          link = Rapidshare.new(row["url"])
          #link = Link.new(row["url"])
        when /4shared/i
          # TODO Refatorar o módulo 4shared
          # link = FourShared.new(row["link"])
          link = Link.new(row["url"])
        end
        link.id_link = row["id"]
        link.id_pacote = row["package_id"]
        link.completado = row["completed"]
        link.tamanho = row["size"]
        link.id_status = row["status_id"]
        link.testado = row["tested"]
        link.data_inicio = row["date_started"]
        link.data_fim = row["date_finished"]
        lista << link
      end
      rst.finish
      Banco.instance.db_disconnect
      #lista.sort
      lista
    rescue Exception => e
      puts "Houve erro => #{e}"
      sleep 1
      return nil
    end
  end

  # Verifica a quantidade de pacotes e a quantidade de pacotes baixado.
  # O retorno é a diferença entre as respectivas quantidades.
  def select_count_remaining_links
    sql = "SELECT count(id) FROM links WHERE package_id = ? "
    rst = Banco.instance.db_connect.execute(sql, @id_pacote)
    count_pacotes = rst.fetch_all[0][0]
    rst.finish

    sql = "SELECT count(id) FROM links WHERE package_id = ? AND status_id = #{Status::BAIXADO} "
    rst = Banco.instance.db_connect.execute(sql, @id_pacote)
    count_baixados = rst.fetch_all[0][0]
    rst.finish
    Banco.instance.db_disconnect

    return count_pacotes - count_baixados
  end
end
