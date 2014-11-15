# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set 'playerBank', new PlayerBank {total: 1000, betAmount: 100 }

  createNewGame: ->
    @set('currentGame', new Game({betAmount: @get('playerBank').getBet() }))
    @get('currentGame').on 'finish', @finish, @

  finish: (betAmount) ->
    console.log 'App.Finish: ', betAmount
    newPlayerBankTotal = @get('playerBank').get('total') + betAmount
    console.log newPlayerBankTotal
    @get('playerBank').set 'total', newPlayerBankTotal
    @trigger 'finish', betAmount

