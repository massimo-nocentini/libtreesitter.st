"
A TSChunkTest is a test class for testing the behavior of TSChunk
"
Class {
	#name : 'TSChunkTest',
	#superclass : 'TestCase',
	#category : 'LibTreeSitter-Tests',
	#package : 'LibTreeSitter-Tests'
}

{ #category : 'chunks - python' }
TSChunkTest >> pythonFibChunk [

	^ '
def fib(n):
	# comment
	a, b = 0, 1
	while a < n:
		print(a, end=" ")
		a, b = b, a+b

fib (1000)
'
]

{ #category : 'tests' }
TSChunkTest >> testASTofCSimpleChunk [

	| tree node src |
	src := 'int main (int argc, char **argv) { printf("Hello world!"); }'.

	tree := TSLanguage c parser treeOfString: src.
	node := tree ast.

	self
		assert: node isNotNil;
		assert: node content equals: src.

	self
		assert:
		(src copyFrom: node absolutePoint x to: node absolutePoint y)
		equals: src
]

{ #category : 'tests' }
TSChunkTest >> testASTofPythonSimpleChunk [

	| tree node src |
	src := self pythonFibChunk trimLeft withUnixLineEndings.

	tree := TSLanguage python parser treeOfString: src.
	node := tree ast.
	node inspect.

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
TSChunkTest >> testHighlightsQueryForC [

	self
		assert: TSLanguage c highlightsQueryString size > 1000;
		assert: TSLanguage json highlightsQueryString size > 250;
		assert: TSLanguage javascript highlightsQueryString size > 250;
		assert: TSLanguage python highlightsQueryString size > 1800
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsQueryMatches [

	| captures lang tree |
	lang := TSLanguage c.

	tree := lang parser treeOfString:
		        'int main (int argc, char **argv) { printf("Hello world!"); }'.

	captures := lang highlightsQuery matchesOnTree: tree.

	self assert: captures isNotEmpty
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsQueryMatchesGrammarJavascript [

	| captures lang tree |
	lang := TSLanguage javascript.

	tree := lang parser treeOfString: lang jsGrammarString.

	captures := lang highlightsQuery matchesOnTree: tree.

	self assert: captures isNotEmpty
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsQueryMatchesJavascript [

	| captures lang tree |
	lang := TSLanguage javascript.

	tree := lang parser treeOfString: '
var canvas = new fabric.Canvas(''c'');

// create a rectangle with angle=45
var rect = new fabric.Rect({
  left: 100,
  top: 100,
  fill: ''red'',
  width: 20,
  height: 20,
  angle: 45
});

canvas.add(rect);
'.

	captures := lang highlightsQuery matchesOnTree: tree.

	self assert: captures isNotEmpty
]

{ #category : 'tests' }
TSChunkTest >> testInstantiatingParser [

	self deny: TSParser new getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testParsingCSimpleChunk [

	| tree |
	tree := TSLanguage c parser treeOfString:
		        'int main (int argc, char **argv) { printf("Hello world!"); }'.

	self deny: tree getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testParsingPythonSimpleChunk [

	| tree |
	tree := TSLanguage python parser treeOfString:
		        '
def fib(n):
    a, b = 0, 1
    while a < n:
        print(a, end='' '')
        a, b = b, a+b
    print()

fib(1000)
'.

	self deny: tree getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testSettingLanguageCToParser [

	self
		assert: TSLanguage c parser hasLanguageAssigned;
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
