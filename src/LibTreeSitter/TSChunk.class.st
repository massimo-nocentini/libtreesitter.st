Class {
	#name : 'TSChunk',
	#superclass : 'Object',
	#instVars : [
		'language',
		'sourceCode'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'evaluating' }
TSChunk >> asRSPangoShapeUsingFont: aFont [

	| code selector |
	selector := language asSymbol.

	code := sourceCode replaceAllTabsWithThreeSpaces.

	^ selector = MicAbstractCodeBlock defaultLanguage
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
			  chunks := OrderedCollection new.

			  (TSLanguage respondsTo: selector) ifTrue: [
				  | matches tree sorted cumulatedSizes tsLanguage |
				  cumulatedSizes := code cumulatedLineSizes.

				  tsLanguage := TSLanguage perform: selector.
				  tree := tsLanguage parser treeOfString: code.
				  matches := tsLanguage highlightsQuery
					             matchesGroupByCategoryOnTree: tree.

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

				  RSPangoText new
					  font: aFont;
					  text: code;
					  attributesChunks: chunks;
					  asCompositeShape ] ]
]

{ #category : 'accessing' }
TSChunk >> language: anObject [

	language := anObject
]

{ #category : 'accessing' }
TSChunk >> sourceCode: anObject [

	sourceCode := anObject
]
