class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '
    <h4><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h4>
  '

  initialize: ->
    console.log 'Init HandView'
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    console.log 'Render HandView: ', @collection.length
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      console.log 'new CardView'
      console.log card
      new CardView(model: card).$el
    @$('.score').text @collection.score()

