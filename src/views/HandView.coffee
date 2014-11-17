class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '
    <h3>You <span class="badge score"></span>
      <div class="btn-group" role="group">
        <button class="hit-button btn btn-primary">Hit</button>
        <button class="stand-button btn btn-primary">Stand</button>
      </div>
    </h3>
    <div class="cards"></div>
  '

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.addClass 'card-length-' + @collection.length
    @$('.cards').append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.score()

