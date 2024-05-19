"
A TSChunkTest is a test class for testing the behavior of TSChunk
"
Class {
	#name : 'TSChunkTest',
	#superclass : 'TestCase',
	#category : 'LibTreeSitter-Tests',
	#package : 'LibTreeSitter-Tests'
}

{ #category : 'tests' }
TSChunkTest >> testASTofCSimpleChunk [

	| node src |
	src := 'int main (int argc, char **argv) { printf("Hello world!"); }'.

	node := TSParser c astOfString: src.

	self
		assert: node isNotNil;
		assert: node content equals: src.

	self
		assert:
		(src copyFrom: node absolutePoint x to: node absolutePoint y)
		equals: src
]

{ #category : 'tests' }
TSChunkTest >> testAllocatingLanguageHandleForC [

	self deny: TSLanguage c getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testCreateQuery [

	| query |
	query := TSLanguage c highlightsQuery.

	self
		deny: query getHandle isNull;
		assert: query errorType equals: 0
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsOfCSimpleChunk [

	| query src |
	src := 'int main (int argc, char **argv) { printf("Hello world!"); }'.

	query := TSParser c
		         source: src
		         query: TSLanguage c highlightsQueryString.

	self
		assert: query isNotNil;
		assert: query errorType equals: 0;
		deny: query getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsQueryForC [

	self assert: TSLanguage c highlightsQueryString size > 1000
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsQueryMatches [

	| matches lang tree |
	lang := TSLanguage c.

	tree := lang parser treeOfString:
		        'int main (int argc, char **argv) { printf("Hello world!"); }'.

	matches := lang highlightsQuery matchesOnTree: tree.

	self assert: matches isNotEmpty
]

{ #category : 'tests' }
TSChunkTest >> testInstantiatingParser [

	self deny: TSParser new getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testParsingCSimpleChunk [

	| tree |
	tree := TSParser c treeOfString:
		        'int main (int argc, char **argv) { printf("Hello world!"); }'.

	self deny: tree getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testSettingLanguageCToParser [

	self
		assert: TSParser c hasLanguageAssigned;
		deny: TSParser new hasLanguageAssigned
]

{ #category : 'tests' }
TSChunkTest >> testSlotInTraits [

	| a b |
	a := TSDummy new
		     value: #a;
		     yourself.

	b := TSDummy new
		     value: #b;
		     yourself.

	self
		assert: a value equals: #a;
		assert: b value equals: #b
]
