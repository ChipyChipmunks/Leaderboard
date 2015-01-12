  Template.leaderboard.helpers(
    Lists: -> Lists.find({}, { sort: { score: -1, name: 1 } })
    selectedName: -> 
      player = Lists.findOne(Session.get('selectedPlayer'))
      player && player.name
  )

  Template.leaderboard.events(
    'click #add_button': -> Lists.update(Session.get('selectedPlayer'), {$inc: {score: 5}})
    'click #remove_button': -> Lists.update(Session.get('selectedPlayer'), {$inc: {score: -5}})
    'submit .new_player_form': (event, template) ->
      field = template.find('#player_name')
      if (field.value != '')
        Lists.insert(
          name: field.value
          score: 0
          createdAt: new Date()
        )
      field.value=''
      false
    'click .trash': -> Lists.remove(this._id)
  )

  Template.player.helpers(
    selected: -> Session.equals('selectedPlayer', this._id) ? 'selected' : ''
  )

  Template.player.events(
    'click': -> Session.set('selectedPlayer', this._id)
  )

  Template.layout.helpers(
   activeIfTemplateIs: template -> currentRoute = Router.current;
   currentRoute && template == currentRoute.lookupTemplate() ? 'active' : '';
  )