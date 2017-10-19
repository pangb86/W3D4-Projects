def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie
    .select(:id,:title,:yr,:score)
    .where(yr: 1980..1989)
    .where(score: 3..5)

end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.

  #we first want to list out the years that rating 8 not above
  #check to see yr in that subquery

  Movie
    .having('MAX(score) <= 8')
    .group(:yr)
    .distinct
    .pluck(:yr)

end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.

  Actor
    .select(:id, :name)
    .joins(:movies)
    .where(movies: {title: title})
    .order('castings.ord')


    #so you can only directly call methods on the class you are in, ie
    #we are in actor, so we can use the stuff defined in the actors model.
    #however, if we want to access movies.title, we have to use the above
    #syntax. can't just say :title

end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.

  Movie
    .select(:id, :title, :name)
    .joins(:actors)
    .where(castings: {ord: 1})
    .where('director_id = actors.id')


end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor
    .select('actors.id, actors.name, COUNT(*) AS roles')
    .joins(:movies)
    .where.not(castings: {ord: 1})
    .group('actors.id')
    .order('roles DESC')
    .limit(2)
end
