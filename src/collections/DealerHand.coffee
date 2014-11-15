class window.DealerHand extends window.Hand

  hitUntil17: ->
    @hit()
    if @minScore() < 17
      return @hitUntil17()
    if not @isBusted()
      @stand()
    @
