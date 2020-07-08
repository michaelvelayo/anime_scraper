class AnimeScraper

  def self.scrape_genres
    html = Nokogiri::HTML(open('https://myanimelist.net/info.php?go=genre'))
    html.css('li').each do |genre|
      name = genre.css("strong").text
      genre.replace(genre.css("strong"))
      description = genre.text
      description[0..2] = ""
      Genre.create(name: name, description: description)
    end
  end

  def self.scrape_types
    html = Nokogiri::HTML(open('https://myanimelist.net/info.php?go=type'))
    html.css('li').each do |type|
      name = type.css("strong").text
      type.replace(type.css("strong"))
      description = type.text
      description[0..2] = ""
      Type.create(name: name, description: description)
    end
  end

  def self.sanitize(html)
    html[0..5] = ""
    html[-1] = ""
    html[-1] = ""
    html[-1] = ""
    html
  end

  def self.scrape_animes
    html = Nokogiri::HTML(open('https://myanimelist.net/anime/558/Major_S2'),nil,"UTF-8")
    #html = Nokogiri::HTML(open('https://myanimelist.net/anime/16498/Shingeki_no_Kyojin'))
    #Alternative Titles#
    title = html.css(".spaceit_pad")
    if title[0].css(".dark_text").text == "English:"
       title[0].replace(title[0].css(".dark_text"))
       english = sanitize(title[0].text)
    elsif title[0].css(".dark_text").text == "Synonyms:"
      title[0].replace(title[0].css(".dark_text"))
      synonyms = sanitize(title[0].text)
    elsif title[0].css(".dark_text").text == "Japanese:"
      title[0].replace(title[0].css(".dark_text"))
      japanese = sanitize(title[0].text)
    end

    current_type = Type.all.select do |type|
      type.name == html.css(".information.type").text
    end


    description = html.css('span[itemprop="description"]').text


    episodes = html.css(".spaceit").find do |element|
      element.css("span").text == "Episodes:"
    end
    episodes.replace(episodes.css(".dark_text"))
    episodes = sanitize(episodes.text)



    aired = html.css(".spaceit").find do |element|
      element.css("span").text == "Aired:"
    end
    aired.replace(aired.css(".dark_text"))
    aired = sanitize(aired.text)



    binding.pry
   if title[1].css(".dark_text").text == "Synonyms:"
      title[1].replace(title[1].css(".dark_text"))
      synonyms = sanitize(title[1].text)
      if title[2].css(".dark_text").text == "Japanese:"
         title[2].replace(title[2].css(".dark_text"))
         japanese = sanitize(title[2].text)
      end
   elsif title[1].css(".dark_text").text == "Japanese:"
     title[1].replace(title[1].css(".dark_text"))
      japanese = sanitize(title[1].text)
      synonyms = ""
   end
   anime = Anime.create(english: english, synonyms: synonyms, japanese: japanese)
   anime_id = anime.id

   genres = html.css('span[itemprop="genre"]').each do |genre|
    genre = Genre.find_by(name: genre.text)
    AnimeGenre.create(anime_id: anime_id, genre_id: genre.id)
   end
  
  characters = html.css('.detail-characters-list')[0].css('table').css('.borderClass').each do |character|
    if !character.attr('align') 
      if !character.attr('width')
       char_name = character.css('a').text
       char_role = character.css('small').text
       role = Role.find_by(name: char_role)
       Character.create(english: char_name,anime_id: anime_id,role_id: role.id)
      end
     end
    end
  end

end
