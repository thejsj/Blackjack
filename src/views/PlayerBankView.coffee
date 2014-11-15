class window.PlayerBankView extends Backbone.View

  className: 'player-bank-container'

  template: _.template '
    <h2>Player Bank</h2>
    <button class="plus-ten">+10</button>
    <button class="minus-ten">-10</button>
    <p>Bet Amount: <%= betAmount %></p>
    <p>Total: <%= total %></p>
  '

  events:
    'click .plus-ten': -> @model.increaseBy10(),
    'click .minus-ten': -> @model.decreaseBy10()

  initialize: ->
    that = @
    $(window).on 'keydown', (e) ->
      console.log 'Increase By 10'
      if e.keyCode == 187
        that.model.increaseBy10()
        e.preventDefault()
        e.stopPropagation()
      if e.keyCode == 189
        that.model.decreaseBy10()
        e.preventDefault()
        e.stopPropagation()

    @model.on 'change', @render, @
    @render()

  render: ->
    @$el.html @template @model.attributes
    @$el
