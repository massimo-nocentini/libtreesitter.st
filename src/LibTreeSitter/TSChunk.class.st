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

	| code langName |
	langName := language asSymbol.

	code := sourceCode replaceAllTabsWithThreeSpaces.

	^ langName = MicAbstractCodeBlock defaultLanguage
		  ifTrue: [
			  | presenter |
			  presenter := SpCodePresenter new
				               beForScripting;
				               text: code;
				               yourself.

			  presenter textWithStyle asRSPangoShapeUsingFont:
				  LogicalFont pangoMonospace ]
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
				  asCompositeShape ]
]

{ #category : 'evaluating' }
TSChunk >> collectChunksOnSourceCode: code treeSitterLanguage: tsLanguage [

	| matches tree sorted cumulatedSizes chunks |
	chunks := OrderedCollection new.
	cumulatedSizes := code cumulatedLineSizes.

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
				| abs from to |
				abs := capture interval: cumulatedSizes.

				from := abs first - 1.
				to := abs last.

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
