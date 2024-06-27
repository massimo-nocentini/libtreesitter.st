Trait {
	#name : 'TGMarkupStyleProvider',
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupBoldStyle [

	^ { 'weight bold' }
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupBuiltinStyle [

	^  { ('foreground #'
			 , (SHStyleElement withTokens: { 'true' }) color asHexString) }
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupCommentStyle [

	^ {
		  ('foreground #'
		   , (SHStyleElement withTokens: #( comment )) color asHexString).
		  "('family ' , LogicalFont pangoSans familyName)" }
	  , self gmarkupItalicStyle
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupInstanceVarStyle [

	^ {
		  ('foreground #' , SHPreferences instanceVarStyle color asHexString).
		  ('family ' , PangoLogicalFontManager pangoSans familyName) }
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupItalicStyle [

	^ { 'style italic' }
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupNumberStyle [

	^ {
		  ('foreground #'
		   , (SHStyleElement withTokens: #( number )) color asHexString).
		  ('family ' , PangoLogicalFontManager pangoMath familyName) }
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupReservedWordsStyle [

	^ { ('foreground #'
	   , SHPreferences reservedWordsStyle color asHexString) }
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupStringStyle [

	^ { ('foreground #'
	   , (SHStyleElement withTokens: #( string )) color asHexString) }
]

{ #category : 'accessing' }
TGMarkupStyleProvider >> gmarkupSyntaxStyle [

	^ { ('foreground #' , SHPreferences syntaxStyle color asHexString) }
	  , self gmarkupBoldStyle
]
