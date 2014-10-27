json.(@cop, :id, :name, :badge_number, :approval_rating, :precinct_number)
json.comments @cop.comments, :id, :title, :author, :text
