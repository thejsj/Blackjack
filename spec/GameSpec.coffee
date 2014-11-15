assert = chai.assert
expect = chai.expect

game = null

describe 'Game', ->
  describe 'Bust and stand', ->

    beforeEach ->
      game = new Game({betAmount: 100})

    it 'should end game when player busts', ->
      called = false
      game.on 'finish', ->
        called = true
      expect(called).to.equal false
      for num in [0..10]
        game.get('playerHand').hit()
      expect(called).to.equal true

    it 'should dealer.hitUntil17 when player stands', ->
      called = 0
      game.get('dealerHand').on 'bust', ->
        called += 1
      game.get('dealerHand').on 'stand', ->
        called += 1
      expect(called).to.equal 0
      game.get('playerHand').stand()
      expect(called).to.equal 1

    it 'should end game when dealer busts', ->
      called = 0
      game.on 'finish', ->
        called += 1
      expect(called).to.equal 0
      game.get('playerHand').stand()
      for num in [0..10]
        game.get('dealerHand').hit()
      expect(called).to.equal 1

    it 'should end game when dealer stands', ->
      called = 0
      game.on 'finish', ->
        called += 1
      expect(called).to.equal 0
      game.get('playerHand').stand()
      game.get('dealerHand').stand()
      expect(called).to.equal 1

  describe 'Decide winner', ->
    it 'should decide winner based on score', ->

    it 'should push when score is the same', ->

    it 'should return 1.5 times payout when true blackjack', ->
