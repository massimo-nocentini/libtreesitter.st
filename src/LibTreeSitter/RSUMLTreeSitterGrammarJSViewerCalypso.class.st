"
# Why

I am a variant that uses a Microdown visitor to produce a _Roassal rendering_ of the given class comment.
"
Class {
	#name : 'RSUMLTreeSitterGrammarJSViewerCalypso',
	#superclass : 'RSUMLClassCalypso',
	#category : 'LibTreeSitter-Calypso',
	#package : 'LibTreeSitter',
	#tag : 'Calypso'
}

{ #category : 'testing' }
RSUMLTreeSitterGrammarJSViewerCalypso class >> shouldBeActivatedInContext: aBrowserContext [

	^ (super shouldBeActivatedInContext: aBrowserContext) and: [
		  aBrowserContext lastSelectedClass inheritsFrom: TSLanguage ]
]

{ #category : 'building' }
RSUMLTreeSitterGrammarJSViewerCalypso >> buildUmlCanvas [

	| lang |
	lang := self targetClass new.

	^ RSCanvas new
		  useRTree;
		  @ RSCanvasController;
		  add: lang asGrammarJsShape;
		  zoomToFit;
		  yourself
]

{ #category : 'initialization' }
RSUMLTreeSitterGrammarJSViewerCalypso >> defaultTitle [

	^ 'grammar.js'
]
