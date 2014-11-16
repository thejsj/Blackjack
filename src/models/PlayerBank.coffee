class window.PlayerBank extends Backbone.Model

  getBet: ->
    @set 'total', (@get('total') - @get('betAmount'))
    @get 'betAmount'

  increaseBy10: ->
    @set 'betAmount', (@get('betAmount') + 10)
    @get 'betAmount'

  decreaseBy10: ->
    @set 'betAmount', (@get('betAmount') - 10)
    @get 'betAmount'
