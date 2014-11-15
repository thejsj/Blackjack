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
    beforeEach ->
      game = new Game({betAmount: 100})
      playerHand = new Hand()
      playerHand.add(new Card({rank: 0, suit:0}))
      playerHand.add(new Card({rank: 0, suit:1}))
      dealerHand = new Hand()
      dealerHand.add(new Card({rank: 9, suit:0}))
      dealerHand.add(new Card({rank: 0, suit:2}))
      game.set('playerHand', playerHand)
      game.set('dealerHand', dealerHand)

    it 'should decide winner based on score', ->
      betReturn = null
      game.on 'finish', (returnAmount) ->
        betReturn = returnAmount
      game.decideWinner()
      expect(betReturn).to.equal(200);

    it 'should push when score is the same', ->
      dealerHand = new DealerHand()
      dealerHand.add(new Card({rank: 12, suit:0}))
      dealerHand.add(new Card({rank: 0, suit:2}))
      game.set('dealerHand', dealerHand)

      betReturn = null
      game.on 'finish', (returnAmount) ->
        betReturn = returnAmount
      game.decideWinner()
      expect(betReturn).to.equal(100);

    it 'should return 1.5 times payout when true blackjack', ->
      console.log 'BlackJack Test'
      playerHand = new Hand()
      playerHand.add(new Card({rank: 0, suit:0}))
      playerHand.add(new Card({rank: 1, suit:1}))
      game.set('playerHand', playerHand)
      console.log game.get 'playerHand'
      console.log game.get('playerHand').score()
      console.log game.get('playerHand').isBlackJack()
      console.log game.get 'dealerHand'
      console.log game.get('dealerHand').score()

      betReturn = null
      game.on 'finish', (returnAmount) ->
        console.log returnAmount
        betReturn = returnAmount
      game.decideWinner()
      expect(betReturn).to.equal(250);
