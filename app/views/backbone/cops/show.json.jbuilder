json.(@cop, :id, :name, :badge_number, :approval_rating, :precinct_number, :cpr_rating)
json.comments @cop.comments, :id, :title, :author, :text
