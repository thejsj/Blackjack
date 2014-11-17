class window.PlayerBankView extends Backbone.View

  className: 'player-bank-container'

  template: _.template '
    <div class="col-sm-3">
      <h1>BlackJack</h1>
    </div>
    <div class="col-sm-3">
      <span class="info-title">Total</span>
      <h3>$<%= total %></h3>
    </div>
    <div class="col-sm-3">
      <span class="info-title">Bet Amount</span>
      <h3 class="bet-amount">$<%= betAmount %></h3>
    </div>
    <div class="col-sm-3">
      <span class="info-title">Change Bet Amount</span>
      <div class="btn-group buttons" role="group">
        <button class="plus-ten btn btn-md btn-primary">+10</button>
        <button class="minus-ten btn btn-md btn-primary">-10</button>
      </div>
    </div>
  '

  events:
    'click .plus-ten': -> @model.increaseBy10(),
    'click .minus-ten': -> @model.decreaseBy10()

  initialize: ->
    that = @
    $(window).on 'keydown', (e) ->
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
