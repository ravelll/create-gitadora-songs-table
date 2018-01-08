require 'nokogiri'
require 'mysql2'

client = Mysql2::Client.new(host: 'localhost', username: 'root', database: 'gitadora')

[
  Nokogiri::HTML(open('./existed_songs.html'), nil, 'UTF-8'),
  Nokogiri::HTML(open('./new_songs.html'), nil, 'UTF-8')
].each do |html|
  html.search('tbody/tr').each do |td|
    name = td.xpath('td[2]').inner_text.strip
    next if name.empty?

    bpm = td.xpath('td[5]').inner_text.split('-')[-1].to_i
    drum_bsc    = td.xpath('td[7]').inner_text
    drum_adv    = td.xpath('td[8]').inner_text
    drum_ext    = td.xpath('td[9]').inner_text
    drum_mstr   = td.xpath('td[10]').inner_text
    guitar_bsc  = td.xpath('td[11]').inner_text
    guitar_adv  = td.xpath('td[12]').inner_text
    guitar_ext  = td.xpath('td[13]').inner_text
    guitar_mstr = td.xpath('td[14]').inner_text
    bass_bsc    = td.xpath('td[15]').inner_text
    bass_adv    = td.xpath('td[16]').inner_text
    bass_ext    = td.xpath('td[17]').inner_text
    bass_mstr   = td.xpath('td[18]').inner_text

    sql =<<SQL
replace into songs values (
  '#{client.escape(name)}',
    #{bpm},
    #{drum_bsc    == '-' ? 'null' : drum_bsc},
    #{drum_adv    == '-' ? 'null' : drum_adv},
    #{drum_ext    == '-' ? 'null' : drum_ext},
    #{drum_mstr   == '-' ? 'null' : drum_mstr},
    #{guitar_bsc  == '-' ? 'null' : guitar_bsc},
    #{guitar_adv  == '-' ? 'null' : guitar_adv},
    #{guitar_ext  == '-' ? 'null' : guitar_ext},
    #{guitar_mstr == '-' ? 'null' : guitar_mstr},
    #{bass_bsc    == '-' ? 'null' : bass_bsc},
    #{bass_adv    == '-' ? 'null' : bass_adv},
    #{bass_ext    == '-' ? 'null' : bass_ext},
    #{bass_mstr   == '-' ? 'null' : bass_mstr}
)
SQL

    client.query(sql)
  end
end
