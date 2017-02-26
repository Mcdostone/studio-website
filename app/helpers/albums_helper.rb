module AlbumsHelper

  def format_album_date(album)
    album.date.strftime('%d/%m/%Y')
  end

  def random_media(album)
    return album.media.sample
  end

  def cover(album)
    album.cover.url ? album.cover.url : '/images/spiral-film.jpg'
  end

end
