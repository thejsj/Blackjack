assert = chai.assert
expect = chai.expect

describe 'Dealer Hand', ->

  it 'should have a score over 16 when hitUntil17 runs', ->
    deck = new Deck()
    hand = deck.dealDealer()
    hand.hitUntil17()
    # This would be a hard 17. No soft 17 allowed
    assert.strictEqual hand.minScore() >= 17, true

  it 'should trigger bust or stand event', ->
    deck = new Deck()
    hand = deck.dealDealer()
    called = 0;
    hand.on 'bust', ->
      called += 1
    hand.on 'stand', ->
      called += 1
    hand.hitUntil17()
    expect(called).to.equal 1

