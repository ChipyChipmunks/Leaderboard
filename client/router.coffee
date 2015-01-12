Router.configure layoutTemplate: 'layout'

Router.route '/', -> @render('leaderboard')
Router.route 'about'
Router.route 'contact'
Router.route 'create'