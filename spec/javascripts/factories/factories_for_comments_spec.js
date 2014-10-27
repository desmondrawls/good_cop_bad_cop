Factory.define('cop_with_comments', CopCentral.Models.Cop)
  .sequence('id')
  .sequence('name', function(i) { return 'Officer ShinyShoes the' + i; })
  .sequence('precinct_number', function(i) { return abs(123 - i); })
  .attr('approval_rating', function() { return Math.random(); })

  // Default to two comments. If comments were given, fill in
  // whatever attributes might be missing.
  .attr('comments', ['comments'], function(comments) {
    if (!comments) { comments = [{}, {}]; }
    return comments.map(function(data) {
      return Factory.attributes('comment', data);
    });
  });

Factory.define('comment', CopCentral.Models.Comment)
  .sequence('id')
  .sequence('title', function(i) { return 'This guy sucked times' + i; })
  .attr('author', 'concerned citizen')
  .attr('text', 'wtf')

  // Define `position` to depend on `id`.
  // .attr('position', ['id'], function(id) {
  //   var positions = ['pitcher', '1st base', '2nd base', '3rd base'];
  //   return positions[id % positions.length];
  // });

// Factory.define('disabled-comment').extend('comment').attr('state', 'disabled')