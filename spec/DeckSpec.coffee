assert = chai.assert
expect = chai.expect

describe 'deck', ->
  deck = null
  hand = null

  describe "deck constructor", ->
    it "should create a card collection", ->
      collection = new Deck()
      assert.strictEqual collection.length, 52

  describe 'deal hands to the player', ->
    beforeEach ->
      deck = new Deck()
      hand = deck.dealPlayer()

    it 'should deal a new hand to the player', ->
      assert.strictEqual hand.length, 2

    it 'should deal a hand to the player where all cards are revealed', ->
      assert.strictEqual hand.at(0).get('revealed'), true
      assert.strictEqual hand.at(1).get('revealed'), true

  describe 'deal hand to the dealer', ->
    beforeEach ->
      deck = new Deck()
      hand = deck.dealDealer()

    it 'should deal a new hand to the dealer', ->
      assert.strictEqual hand.length, 2

    it 'should deal a hand to the dealer, where one card is not revealed', ->
      assert.strictEqual hand.at(0).get('revealed'), false
      assert.strictEqual hand.at(1).get('revealed'), true


  describe 'hit', ->

    it 'should give the last card from the deck', ->
      deck = new Deck()
      hand = deck.dealPlayer()
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit().last()
      assert.strictEqual deck.length, 49

