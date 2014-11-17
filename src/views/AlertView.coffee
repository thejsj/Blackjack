class window.AlertView extends Backbone.View
  class: 'score-view'

  template: _.template '
    <div class="alert alert-<%= alertType %>" role="alert">
      <strong><%= strongMessage %></strong> <%= message %>
    </div>
  '

  render: (betAmount, originalBet) ->
    if betAmount == originalBet
      return @renderPush(betAmount)
    if betAmount < originalBet
      return @renderLose(betAmount)
    if betAmount > originalBet
      return @renderWin(betAmount)

  renderLose: (betAmount) ->
      @$el.html @template {
        alertType: 'danger'
        strongMessage: 'Booo!'
        message: 'You lost and didn\'t win anything'
      }
      @$el

  renderPush: (betAmount) ->
    @$el.html @template {
      alertType: 'warning'
      strongMessage: 'Almost!'
      message: 'You tied and won $' + betAmount
    }
    @$el

  renderWin: (betAmount) ->
      @$el.html @template {
        alertType: 'success'
        strongMessage: 'Hooray!'
        message: 'You won $' + betAmount
      }
      @$el
