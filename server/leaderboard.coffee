Meteor.startup(->
  if (Lists.find().count() == 0)
    names = ['Ada Lovelace', 'Grace Hopper', 'Marie Curie', 'Carl Friedrich Gauss', 'Nikola Tesla', 'Claude Shannon', 
             "Liam O'Connor", 'Natasha Newberry', 'Bill Nye', 'Carl Sagan', 'Neil Degrasse Tyson']
    for name in names
      Lists.insert(
        name: name
        score: Math.floor(Random.fraction() * 10) * 5
      )
)