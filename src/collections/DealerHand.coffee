class window.DealerHand extends window.Hand

  hitUntil17: ->
    if not @at(0).get('revealed')
      @at(0).flip()

    @hit()
    if @minScore() < 17
      return @hitUntil17()
    if not @isBusted()
      @stand()
    @
