assert = chai.assert
expect = chai.expect

describe 'Card', ->

  describe 'value', ->
    it 'should know it\'s value', ->
      card = new Card {rank: 7, suit: 0}
      expect(card.get('value')).to.equal 7
      card = new Card {rank: 0, suit: 0}
      expect(card.get('value')).to.equal 10
      card = new Card {rank: 1, suit: 0}
      expect(card.get('value')).to.equal 1
      card = new Card {rank: 12, suit: 0}
      expect(card.get('value')).to.equal 10

    it 'should know it\'s rankName', ->
      card = new Card {rank: 0, suit: 0}
      expect(card.get('rankName')).to.equal 'King'
      card = new Card {rank: 1, suit: 0}
      expect(card.get('rankName')).to.equal 'Ace'
      card = new Card {rank: 11, suit: 0}
      expect(card.get('rankName')).to.equal 'Jack'
      card = new Card {rank: 12, suit: 0}
      expect(card.get('rankName')).to.equal 'Queen'

    it 'should know it\'s suit', ->
      card = new Card {rank: 0, suit: 0}
      expect(card.get('suitName')).to.equal 'Spades'
      card = new Card {rank: 0, suit: 1}
      expect(card.get('suitName')).to.equal 'Diamonds'
      card = new Card {rank: 0, suit: 2}
      expect(card.get('suitName')).to.equal 'Clubs'
      card = new Card {rank: 0, suit: 3}
      expect(card.get('suitName')).to.equal 'Hearts'

  describe 'flip', ->
    it 'should not be revealed after it\'s flipped', ->
      card = new Card {rank: 7, suit: 0}
      expect(card.get('revealed')).to.equal true
      card.flip()
      expect(card.get('revealed')).to.equal false

