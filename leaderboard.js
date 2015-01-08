// Set up a collection to contain player information. On the server,
// it is backed by a MongoDB collection named "players".

Players = new Mongo.Collection("players");

if (Meteor.isClient) {
  Template.leaderboard.helpers({
    players: function () {
      return Players.find({}, { sort: { score: -1, name: 1 } });
    },
    selectedName: function () {
      var player = Players.findOne(Session.get("selectedPlayer"));
      return player && player.name;
    }
  });

  Template.leaderboard.events({
    'click #add_button': function () {
      Players.update(Session.get("selectedPlayer"), {$inc: {score: 5}});
    },
    'click #remove_button': function () {
      Players.update(Session.get("selectedPlayer"), {$inc: {score: -5}});
    },
    'submit .new_player': function (event, template) {
        var field = template.find('#player_name');
      
        if (field.value !== ""){
          Players.insert({
            name: field.value,
            score: 0
            //createdAt: new Date() // current time
          });
        }
        field.value='';


        // Prevent default form submit
        return false;

      },
      'click .trash': function () {
        Players.remove(this._id)
      }
  });
  
  Template.player.helpers({
    selected: function () {
      return Session.equals("selectedPlayer", this._id) ? "selected" : '';
    }
  });

  Template.player.events({
    'click': function () {
      Session.set("selectedPlayer", this._id);
    }
  });
}

// On server startup, create some players if the database is empty.
if (Meteor.isServer) {
  Meteor.startup(function () {
    if (Players.find().count() === 0) {
      var names = ["Ada Lovelace", "Grace Hopper", "Marie Curie",
                   "Carl Friedrich Gauss", "Nikola Tesla", "Claude Shannon", "Liam O'Connor", "Natasha Newberry",
                   "Bill Nye", "Carl Sagan", "Neil Degrasse Tyson"];
      _.each(names, function (name) {
        Players.insert({
          name: name,
          score: Math.floor(Random.fraction() * 10) * 5
        });
      });
    }
  });
}
