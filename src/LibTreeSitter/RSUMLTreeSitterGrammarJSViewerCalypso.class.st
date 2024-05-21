"
# Why

I am a variant that uses a Microdown visitor to produce a _Roassal rendering_ of the given class comment.
"
Class {
	#name : 'RSUMLTreeSitterGrammarJSViewerCalypso',
	#superclass : 'RSUMLClassCalypso',
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'testing' }
RSUMLTreeSitterGrammarJSViewerCalypso class >> shouldBeActivatedInContext: aBrowserContext [

	^ (super shouldBeActivatedInContext: aBrowserContext) and: [
		  aBrowserContext lastSelectedClass inheritsFrom: TSLanguage ]
]

{ #category : 'building' }
RSUMLTreeSitterGrammarJSViewerCalypso >> buildUmlCanvas [

	| lang shape canvas |
	lang := self targetClass new.
	shape := TSChunk new
		         language: lang name;
		         sourceCode: lang jsGrammarString;
		         asRSPangoShapeUsingFont: LogicalFont pangoMonospace.
	"shape children first asMorph openInWindow."
	^ RSCanvas new
		  useRTree;
		  @ RSCanvasController;
		  add: shape;
		  zoomToFit;
		  yourself
]

{ #category : 'initialization' }
RSUMLTreeSitterGrammarJSViewerCalypso >> defaultTitle [

	^ 'grammar.js'
]
