assert = chai.assert
expect = chai.expect

describe 'Hand', ->

  describe 'Instantiation', ->

    it 'should have two cards when instantiated', ->
      deck = new Deck()
      hand = deck.dealPlayer()
      assert.strictEqual hand.length, 2

  describe 'Hit', ->
    it 'should have one more card after hitting', ->
      deck = new Deck()
      hand = deck.dealPlayer()
      hand.hit()
      assert.strictEqual hand.length, 3
      hand.hit()
      assert.strictEqual hand.length, 4

    it 'should emit an event after hitting', ->
      deck = new Deck()
      hand = deck.dealPlayer()
      hand.on 'hit', ->
        hand.called = true
      expect(hand.called).to.equal undefined
      hand.hit()
      expect(hand.called).to.equal true

  describe 'Busting', ->
    it 'should know when it busted', ->
      deck = new Deck()
      hand = deck.dealPlayer()
      expect(hand.isBusted()).to.equal false
      for num in [0..10]
        hand.hit()
      expect(hand.isBusted()).to.equal true

    it 'should emit an event when busted', ->
      deck = new Deck()
      hand = deck.dealPlayer()
      hand.on 'bust', ->
        hand.called = true
      expect(hand.called).to.equal undefined
      for num in [0..10]
        hand.hit()
      expect(hand.called).to.equal true

  describe 'Score', ->
    it 'should know it\'s score when dealing with numbers', ->
      deck = new Deck()
      hand = new Hand()
      expect(hand.minScore()).to.equal 0
      hand.add new Card {rank: 0, suit: 0}
      expect(hand.minScore()).to.equal 10
      hand.add new Card {rank: 8, suit: 0}
      expect(hand.minScore()).to.equal 18

    it 'should know it\'s score when dealing with jacks', ->
      deck = new Deck()
      hand = new Hand()
      hand.add new Card {rank: 12, suit: 0}
      expect(hand.minScore()).to.equal 10
      hand.add new Card {rank: 11, suit: 0}
      expect(hand.minScore()).to.equal 20
      hand.add new Card {rank: 1, suit: 0}
      expect(hand.minScore()).to.equal 21

  describe 'Aces', ->
    it 'should know if it has an ace', ->
      deck = new Deck()
      hand = new Hand()
      hand.add new Card {rank: 1, suit: 0}
      expect(hand.hasAce()).to.equal true

    it 'should have two different values if it has an ace', ->
      deck = new Deck()
      hand = new Hand()
      hand.add new Card {rank: 0, suit: 0}
      hand.add new Card {rank: 1, suit: 0}
      expect(hand.scores()[0]).to.equal 11
      expect(hand.scores()[1]).to.equal 21

    it 'should know it\'s minScore when it has an ace', ->
      deck = new Deck()
      hand = new Hand()
      hand.add new Card {rank: 0, suit: 0}
      hand.add new Card {rank: 1, suit: 0}
      expect(hand.minScore()).to.equal 11
      hand.add new Card {rank: 1, suit: 0}
      expect(hand.minScore()).to.equal 12
      hand.add new Card {rank: 1, suit: 0}
      expect(hand.minScore()).to.equal 13





