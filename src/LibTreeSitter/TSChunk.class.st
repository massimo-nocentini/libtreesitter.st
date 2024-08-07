Class {
	#name : 'TSChunk',
	#superclass : 'Object',
	#instVars : [
		'language',
		'sourceCode'
	],
	#category : 'LibTreeSitter-API',
	#package : 'LibTreeSitter',
	#tag : 'API'
}

{ #category : 'evaluating' }
TSChunk >> asRSPangoShapeUsingFont: aFont [

	| code langName shape |
	langName := language asSymbol.

	code := sourceCode replaceAllTabsWithThreeSpaces.

	shape := (langName = MicAbstractCodeBlock defaultLanguage or: [
		          langName = #st ])
		         ifTrue: [
			         | presenter |
			         presenter := SpCodePresenter new
				                      beForScripting;
				                      text: code;
				                      yourself.

			         presenter textWithStyle asRSPangoShapeUsingFont: aFont ]
		         ifFalse: [
			         | chunks |
			         chunks := TSLanguage
				                   languageNamed: langName
				                   ifPresent: [ :tsLanguage |
					                   self
						                   collectChunksOnSourceCode: code
						                   treeSitterLanguage: tsLanguage ]
				                   ifAbsent: [ OrderedCollection new ].

			         RSPangoText new
				         font: aFont;
				         text: code;
				         attributesChunks: chunks;
				         yourself ].

	^ shape
		  model: self;
		  yourself
]

{ #category : 'evaluating' }
TSChunk >> collectChunksOnSourceCode: code treeSitterLanguage: tsLanguage [

	| matches tree sorted chunks |
	chunks := OrderedCollection new.

	tree := tsLanguage parser treeOfString: code.
	matches := tsLanguage highlightsQuery matchesGroupByCategoryOnTree:
		           tree.

	sorted := SortedCollection sortUsing: [ :a :b |
		          a first = b first
			          ifTrue: [ a fourth > b fourth ]
			          ifFalse: [ a first < b first ] ].

	tsLanguage orderedPatterns withIndexDo: [ :pattern :priority |
		matches at: pattern ifPresent: [ :captures |
			| specs |
			specs := tsLanguage at: pattern.
			captures do: [ :capture |
				| interval from to |
				interval := capture interval.

				from := interval first - 1.
				to := interval last.

				"capture at: 'content' put: (clean_text copyFrom: from to: to)."

				specs do: [ :spec |
					sorted add: {
							from.
							to.
							spec.
							priority } ] ] ] ].

	sorted do: [ :tuple |
		chunks add: ('{1} {2} {3}' format: tuple) "just exclude the priority" ].

	^ chunks
]

{ #category : 'accessing' }
TSChunk >> language: anObject [

	language := anObject
]

{ #category : 'accessing' }
TSChunk >> sourceCode: anObject [

	sourceCode := anObject
]
