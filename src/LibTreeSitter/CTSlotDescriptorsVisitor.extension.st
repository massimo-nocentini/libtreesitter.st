Extension { #name : 'CTSlotDescriptorsVisitor' }

{ #category : '*LibTreeSitter' }
CTSlotDescriptorsVisitor >> visitTSLanguage: lang [

	^ {
		  (self newSlotDescriptorSelector: #name).
		  (self newSlotDescriptorSelector: #orderedPatterns).
		  ((self newSlotDescriptorSelector: #asGrammarJsShape)
			   inline;
			   quote) }
]
