class window.AppView extends Backbone.View
  template: _.template '
    <div class="container-fluid">
      <div class="row header">
        <div class="player-bank-container"></div>
      </div>
      <div class="alert-container row">
        <div class="alert alert-info" role="alert">
          <strong>Go Ahead!</strong> Start playing
        </div>
      </div>
      <div class="hand-container row">
        <div class="col-sm-6 player-hand-container"></div>
        <div class="col-sm-6 dealer-hand-container"></div>
      </div>
      <div class="row footer">
        <div class="col-sm-9">
          <p>Keyboard Shortcuts <strong>\'H\'</strong> Hit &#8226 <strong>\'S\'</strong> Stand &#8226 <strong>\'+\'</strong> +10 &#8226 <strong>\'-\'</strong> -10</p>
        </div>
        <div class="col-sm-3">
          <p><a href="https://twitter.com/TonyRizko">Tony Rizko</a> and <a href="http://hiphipjorge.com">Jorge Silva</a></p>
        </div>
    </div>
  '

  events:
    'click .hit-button': ->
      @model.get('currentGame').get('playerHand').hit()

    'click .stand-button': ->
      @model.get('currentGame').get('playerHand').stand()

  initialize: ->
    that = @
    $(window).on 'keydown', (e) ->
      if e.keyCode == 72
        that.model.get('currentGame').get('playerHand').hit()
        e.preventDefault()
        e.stopPropagation()
      if e.keyCode == 83
        that.model.get('currentGame').get('playerHand').stand()
        e.preventDefault()
        e.stopPropagation()

    @playerBankView = new PlayerBankView {model: @model.get('playerBank')}
    @alertView = new AlertView()

    @model.on 'finish', @finish, @
    @model.createNewGame()
    @render()

  finish: (betAmount) ->
    originalBet = @model.get('currentGame').get('originalBetAmount')
    @model.createNewGame()
    @render(betAmount, originalBet)

  render: (betAmount, originalBet) ->
    @$el.children().detach()
    @$el.html @template()
    if betAmount? and originalBet?
      @$('.alert-container').html @alertView.render(betAmount, originalBet)
    @$('.player-bank-container').html @playerBankView.$el
    @$('.player-hand-container').html new HandView({
        collection: @model.get('currentGame').get 'playerHand'
      }).el
    @$('.dealer-hand-container').html new DealerHandView({
        collection: @model.get('currentGame').get 'dealerHand'
      }).el

