class window.CardView extends Backbone.View
  className: 'single-card'

  template: _.template '
    <div class="card two <%= suitName %>">
      <div class="front">
        <div class="corner top">
          <span class="number"><%= rankSymbol %></span>
          <span><%= symbol %></span>
        </div>

        <span class="suit top_center"><%= symbol %></span>
        <span class="suit bottom_center"><%= symbol %></span>

        <div class="corner bottom">
          <span class="number"><%= rankSymbol %></span>
          <span><%= symbol %></span>
        </div>
      </div>

      <div class="back">

      </div>
    </div>
  '

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    if not @model.get 'revealed'
      @$el.addClass 'covered'
    @$el.addClass @model.get 'abbreviation'

