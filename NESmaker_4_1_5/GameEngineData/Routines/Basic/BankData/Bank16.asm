;;==========include all palettes	
	.include "GameData\AllPaletteData.asm"
AllTextGroups:	
	.include "ScreenData\npcTextGroup.dat"
	
	.include "ScreenData\ObjectData\MonsterGroups.dat"
NameTablePointers:
	.dw NT_StartScreen
	.dw NT_WinScreen
	;; starts at room 09
	;;game starts then at 19 for now
NameTablePointers_Map1:
	.dw NT_Rm00, NT_Rm01, NT_Rm02, NT_Rm03, NT_Rm04, NT_Rm05, NT_Rm06, NT_Rm07, NT_Rm08
	.dw NT_Rm09, NT_Rm10, NT_Rm11, NT_Rm12, NT_Rm13, NT_Rm14, NT_Rm15, NT_Rm16, NT_Rm17
	.dw NT_Rm18, NT_Rm19, NT_Rm20, NT_Rm21, NT_Rm22, NT_Rm23, NT_Rm24, NT_Rm25, NT_Rm26 
	.dw NT_Rm27, NT_Rm28, NT_Rm29, NT_Rm30, NT_Rm31, NT_Rm32, NT_Rm33, NT_Rm34, NT_Rm35 
	.dw NT_Rm36, NT_Rm37, NT_Rm38, NT_Rm39, NT_Rm40, NT_Rm41, NT_Rm42, NT_Rm43, NT_Rm44 
	.dw NT_Rm45, NT_Rm46, NT_Rm47, NT_Rm48, NT_Rm49, NT_Rm50, NT_Rm51, NT_Rm52, NT_Rm53 
	.dw NT_Rm54, NT_Rm55, NT_Rm56, NT_Rm57, NT_Rm58, NT_Rm59, NT_Rm60, NT_Rm61, NT_Rm62 
	.dw NT_Rm63, NT_Rm64, NT_Rm65, NT_Rm66, NT_Rm67, NT_Rm68, NT_Rm69, NT_Rm70, NT_Rm71 
	.dw NT_Rm72, NT_Rm73, NT_Rm74, NT_Rm75, NT_Rm76, NT_Rm77, NT_Rm78, NT_Rm79, NT_Rm80 
	.dw NT_Rm81, NT_Rm82, NT_Rm83, NT_Rm84, NT_Rm85, NT_Rm86, NT_Rm87, NT_Rm88, NT_Rm89
	.dw NT_Rm90, NT_Rm91, NT_Rm92, NT_Rm93, NT_Rm94, NT_Rm95, NT_Rm96, NT_Rm97, NT_Rm98
	.dw NT_Rm99, NT_Rm100, NT_Rm101, NT_Rm102, NT_Rm103, NT_Rm104, NT_Rm105, NT_Rm106, NT_Rm107
	.dw NT_Rm108, NT_Rm109, NT_Rm110, NT_Rm111, NT_Rm112, NT_Rm113, NT_Rm114, NT_Rm115, NT_Rm116 
	.dw NT_Rm117, NT_Rm118, NT_Rm119, NT_Rm120, NT_Rm121, NT_Rm122, NT_Rm123, NT_Rm124, NT_Rm125 
	.dw NT_Rm126, NT_Rm127, NT_Rm128, NT_Rm129, NT_Rm130, NT_Rm131, NT_Rm132, NT_Rm133, NT_Rm134
	.dw NT_Rm135, NT_Rm136, NT_Rm137, NT_Rm138, NT_Rm139, NT_Rm140, NT_Rm141, NT_Rm142, NT_Rm143 
	.dw NT_Rm144, NT_Rm145, NT_Rm146, NT_Rm147, NT_Rm148, NT_Rm149, NT_Rm150, NT_Rm151, NT_Rm152 
	.dw NT_Rm153, NT_Rm154, NT_Rm155, NT_Rm156, NT_Rm157, NT_Rm158, NT_Rm159, NT_Rm160, NT_Rm161 
	.dw NT_Rm162, NT_Rm163, NT_Rm164, NT_Rm165, NT_Rm166, NT_Rm167, NT_Rm168, NT_Rm169, NT_Rm170
	.dw NT_Rm171, NT_Rm172, NT_Rm173, NT_Rm174, NT_Rm175, NT_Rm176, NT_Rm177, NT_Rm178, NT_Rm179 
	.dw NT_Rm180, NT_Rm181, NT_Rm182, NT_Rm183, NT_Rm184, NT_Rm185, NT_Rm186, NT_Rm187, NT_Rm188 
	.dw NT_Rm189, NT_Rm190, NT_Rm191, NT_Rm192, NT_Rm193, NT_Rm194, NT_Rm195, NT_Rm196, NT_Rm197
	.dw NT_Rm198, NT_Rm199, NT_Rm200, NT_Rm201, NT_Rm202, NT_Rm203, NT_Rm204, NT_Rm205, NT_Rm206 
	.dw NT_Rm207, NT_Rm208, NT_Rm209, NT_Rm210, NT_Rm211, NT_Rm212, NT_Rm213, NT_Rm214, NT_Rm215
	.dw NT_Rm216, NT_Rm217, NT_Rm218, NT_Rm219, NT_Rm220, NT_Rm221, NT_Rm222, NT_Rm223, NT_Rm224 
	.dw NT_Rm225, NT_Rm226, NT_Rm227, NT_Rm228, NT_Rm229, NT_Rm230, NT_Rm231, NT_Rm232, NT_Rm233 
	.dw NT_Rm234, NT_Rm235, NT_Rm236, NT_Rm237, NT_Rm238, NT_Rm239, NT_Rm240, NT_Rm241, NT_Rm242
	.dw NT_Rm243, NT_Rm244, NT_Rm245, NT_Rm246, NT_Rm247, NT_Rm248, NT_Rm249, NT_Rm250, NT_Rm251 
	.dw NT_Rm252, NT_Rm253, NT_Rm254, NT_Rm255

NameTablePointers_Map2:
	.dw bNT_Rm00, bNT_Rm01, bNT_Rm02, bNT_Rm03, bNT_Rm04, bNT_Rm05, bNT_Rm06, bNT_Rm07, bNT_Rm08, bNT_Rm09, bNT_Rm10 
	.dw bNT_Rm11, bNT_Rm12, bNT_Rm13, bNT_Rm14, bNT_Rm15, bNT_Rm16, bNT_Rm17, bNT_Rm18, bNT_Rm19, bNT_Rm20 
	.dw bNT_Rm21, bNT_Rm22, bNT_Rm23, bNT_Rm24, bNT_Rm25, bNT_Rm26, bNT_Rm27, bNT_Rm28, bNT_Rm29, bNT_Rm30
	.dw bNT_Rm31, bNT_Rm32, bNT_Rm33, bNT_Rm34, bNT_Rm35, bNT_Rm36, bNT_Rm37, bNT_Rm38, bNT_Rm39, bNT_Rm40
	.dw bNT_Rm41, bNT_Rm42, bNT_Rm43, bNT_Rm44, bNT_Rm45, bNT_Rm46, bNT_Rm47, bNT_Rm48, bNT_Rm49, bNT_Rm50
	.dw bNT_Rm51, bNT_Rm52, bNT_Rm53, bNT_Rm54, bNT_Rm55, bNT_Rm56, bNT_Rm57, bNT_Rm58, bNT_Rm59, bNT_Rm60
	.dw bNT_Rm61, bNT_Rm62, bNT_Rm63, bNT_Rm64, bNT_Rm65, bNT_Rm66, bNT_Rm67, bNT_Rm68, bNT_Rm69, bNT_Rm70
	.dw bNT_Rm71, bNT_Rm72, bNT_Rm73, bNT_Rm74, bNT_Rm75, bNT_Rm76, bNT_Rm77, bNT_Rm78, bNT_Rm79, bNT_Rm80 
	.dw bNT_Rm81, bNT_Rm82, bNT_Rm83, bNT_Rm84, bNT_Rm85, bNT_Rm86, bNT_Rm87, bNT_Rm88, bNT_Rm89, bNT_Rm90 
	.dw bNT_Rm91, bNT_Rm92, bNT_Rm93, bNT_Rm94, bNT_Rm95, bNT_Rm96, bNT_Rm97, bNT_Rm98, bNT_Rm99, bNT_Rm100
	.dw bNT_Rm101, bNT_Rm102, bNT_Rm103, bNT_Rm104, bNT_Rm105, bNT_Rm106, bNT_Rm107, bNT_Rm108, bNT_Rm109, bNT_Rm110 
	.dw bNT_Rm111, bNT_Rm112, bNT_Rm113, bNT_Rm114, bNT_Rm115, bNT_Rm116, bNT_Rm117, bNT_Rm118, bNT_Rm119, bNT_Rm120
	.dw bNT_Rm121, bNT_Rm122, bNT_Rm123, bNT_Rm124, bNT_Rm125, bNT_Rm126, bNT_Rm127, bNT_Rm128, bNT_Rm129, bNT_Rm130
	.dw bNT_Rm131, bNT_Rm132, bNT_Rm133, bNT_Rm134, bNT_Rm135, bNT_Rm136, bNT_Rm137, bNT_Rm138, bNT_Rm139, bNT_Rm140
	.dw bNT_Rm141, bNT_Rm142, bNT_Rm143, bNT_Rm144, bNT_Rm145, bNT_Rm146, bNT_Rm147, bNT_Rm148, bNT_Rm149, bNT_Rm150
	.dw bNT_Rm151, bNT_Rm152, bNT_Rm153, bNT_Rm154, bNT_Rm155, bNT_Rm156, bNT_Rm157, bNT_Rm158, bNT_Rm159, bNT_Rm160
	.dw bNT_Rm161, bNT_Rm162, bNT_Rm163, bNT_Rm164, bNT_Rm165, bNT_Rm166, bNT_Rm167, bNT_Rm168, bNT_Rm169, bNT_Rm170
	.dw bNT_Rm171, bNT_Rm172, bNT_Rm173, bNT_Rm174, bNT_Rm175, bNT_Rm176, bNT_Rm177, bNT_Rm178, bNT_Rm179, bNT_Rm180
	.dw bNT_Rm181, bNT_Rm182, bNT_Rm183, bNT_Rm184, bNT_Rm185, bNT_Rm186, bNT_Rm187, bNT_Rm188, bNT_Rm189, bNT_Rm190
	.dw bNT_Rm191, bNT_Rm192, bNT_Rm193, bNT_Rm194, bNT_Rm195, bNT_Rm196, bNT_Rm197, bNT_Rm198, bNT_Rm199, bNT_Rm200
	.dw bNT_Rm201, bNT_Rm202, bNT_Rm203, bNT_Rm204, bNT_Rm205, bNT_Rm206, bNT_Rm207, bNT_Rm208, bNT_Rm209, bNT_Rm210
	.dw bNT_Rm211, bNT_Rm212, bNT_Rm213, bNT_Rm214, bNT_Rm215, bNT_Rm216, bNT_Rm217, bNT_Rm218, bNT_Rm219, bNT_Rm220
	.dw bNT_Rm221, bNT_Rm222, bNT_Rm223, bNT_Rm224, bNT_Rm225, bNT_Rm226, bNT_Rm227, bNT_Rm228, bNT_Rm229, bNT_Rm230
	.dw bNT_Rm231, bNT_Rm232, bNT_Rm233, bNT_Rm234, bNT_Rm235, bNT_Rm236, bNT_Rm237, bNT_Rm238, bNT_Rm239, bNT_Rm240
	.dw bNT_Rm241, bNT_Rm242, bNT_Rm243, bNT_Rm244, bNT_Rm245, bNT_Rm246, bNT_Rm247, bNT_Rm248, bNT_Rm249, bNT_Rm250
	.dw bNT_Rm251, bNT_Rm252, bNT_Rm253, bNT_Rm254, bNT_Rm255
	

	
	
	
AttributeTablesMainGameAboveLo:
	.db <AT_Rm00, <AT_Rm01, <AT_Rm02, <AT_Rm03, <AT_Rm04, <AT_Rm05, <AT_Rm06, <AT_Rm07, <AT_Rm08, <AT_Rm09
	.db <AT_Rm10, <AT_Rm11, <AT_Rm12, <AT_Rm13, <AT_Rm14, <AT_Rm15, <AT_Rm16, <AT_Rm17, <AT_Rm18, <AT_Rm19 
	.db <AT_Rm20, <AT_Rm21, <AT_Rm22, <AT_Rm23, <AT_Rm24, <AT_Rm25, <AT_Rm26, <AT_Rm27, <AT_Rm28, <AT_Rm29
	.db <AT_Rm30, <AT_Rm31, <AT_Rm32, <AT_Rm33, <AT_Rm34, <AT_Rm35, <AT_Rm36, <AT_Rm37, <AT_Rm38, <AT_Rm39
	.db <AT_Rm40, <AT_Rm41, <AT_Rm42, <AT_Rm43, <AT_Rm44, <AT_Rm45, <AT_Rm46, <AT_Rm47, <AT_Rm48, <AT_Rm49
	.db <AT_Rm50, <AT_Rm51, <AT_Rm52, <AT_Rm53, <AT_Rm54, <AT_Rm55, <AT_Rm56, <AT_Rm57, <AT_Rm58, <AT_Rm59
	.db <AT_Rm60, <AT_Rm61, <AT_Rm62, <AT_Rm63, <AT_Rm64, <AT_Rm65, <AT_Rm66, <AT_Rm67, <AT_Rm68, <AT_Rm69
	.db <AT_Rm70, <AT_Rm71, <AT_Rm72, <AT_Rm73, <AT_Rm74, <AT_Rm75, <AT_Rm76, <AT_Rm77, <AT_Rm78, <AT_Rm79
	.db <AT_Rm80, <AT_Rm81, <AT_Rm82, <AT_Rm83, <AT_Rm84, <AT_Rm85, <AT_Rm86, <AT_Rm87, <AT_Rm88, <AT_Rm89
	.db <AT_Rm90, <AT_Rm91, <AT_Rm92, <AT_Rm93, <AT_Rm94, <AT_Rm95, <AT_Rm96, <AT_Rm97, <AT_Rm98, <AT_Rm99
	.db <AT_Rm100, <AT_Rm101, <AT_Rm102, <AT_Rm103, <AT_Rm104, <AT_Rm105, <AT_Rm106, <AT_Rm107, <AT_Rm108
	.db <AT_Rm109, <AT_Rm110, <AT_Rm111, <AT_Rm112, <AT_Rm113, <AT_Rm114, <AT_Rm115, <AT_Rm116, <AT_Rm117
	.db <AT_Rm118, <AT_Rm119, <AT_Rm120, <AT_Rm121, <AT_Rm122, <AT_Rm123, <AT_Rm124, <AT_Rm125, <AT_Rm126
	.db <AT_Rm127, <AT_Rm128, <AT_Rm129, <AT_Rm130, <AT_Rm131, <AT_Rm132, <AT_Rm133, <AT_Rm134, <AT_Rm135
	.db <AT_Rm136, <AT_Rm137, <AT_Rm138, <AT_Rm139, <AT_Rm140, <AT_Rm141, <AT_Rm142, <AT_Rm143, <AT_Rm144
	.db <AT_Rm145, <AT_Rm146, <AT_Rm147, <AT_Rm148, <AT_Rm149, <AT_Rm150, <AT_Rm151, <AT_Rm152, <AT_Rm153
	.db <AT_Rm154, <AT_Rm155, <AT_Rm156, <AT_Rm157, <AT_Rm158, <AT_Rm159, <AT_Rm160, <AT_Rm161, <AT_Rm162
	.db <AT_Rm163, <AT_Rm164, <AT_Rm165, <AT_Rm166, <AT_Rm167, <AT_Rm168, <AT_Rm169, <AT_Rm170, <AT_Rm171
	.db <AT_Rm172, <AT_Rm173, <AT_Rm174, <AT_Rm175, <AT_Rm176, <AT_Rm177, <AT_Rm178, <AT_Rm179, <AT_Rm180
	.db <AT_Rm181, <AT_Rm182, <AT_Rm183, <AT_Rm184, <AT_Rm185, <AT_Rm186, <AT_Rm187, <AT_Rm188, <AT_Rm189
	.db <AT_Rm190, <AT_Rm191, <AT_Rm192, <AT_Rm193, <AT_Rm194, <AT_Rm195, <AT_Rm196, <AT_Rm197, <AT_Rm198
	.db <AT_Rm199, <AT_Rm200, <AT_Rm201, <AT_Rm202, <AT_Rm203, <AT_Rm204, <AT_Rm205, <AT_Rm206, <AT_Rm207
	.db <AT_Rm208, <AT_Rm209, <AT_Rm210, <AT_Rm211, <AT_Rm212, <AT_Rm213, <AT_Rm214, <AT_Rm215, <AT_Rm216
	.db <AT_Rm217, <AT_Rm218, <AT_Rm219, <AT_Rm220, <AT_Rm221, <AT_Rm222, <AT_Rm223, <AT_Rm224, <AT_Rm225
	.db <AT_Rm226, <AT_Rm227, <AT_Rm228, <AT_Rm229, <AT_Rm230, <AT_Rm231, <AT_Rm232, <AT_Rm233, <AT_Rm234
	.db <AT_Rm235, <AT_Rm236, <AT_Rm237, <AT_Rm238, <AT_Rm239, <AT_Rm240, <AT_Rm241, <AT_Rm242, <AT_Rm243
	.db <AT_Rm244, <AT_Rm245, <AT_Rm246, <AT_Rm247, <AT_Rm248, <AT_Rm249, <AT_Rm250, <AT_Rm251, <AT_Rm252
	.db <AT_Rm253, <AT_Rm254, <AT_Rm255

AttributeTablesMainGameAboveHi:
	.db >AT_Rm00, >AT_Rm01, >AT_Rm02, >AT_Rm03, >AT_Rm04, >AT_Rm05, >AT_Rm06, >AT_Rm07, >AT_Rm08, >AT_Rm09
	.db >AT_Rm10, >AT_Rm11, >AT_Rm12, >AT_Rm13, >AT_Rm14, >AT_Rm15, >AT_Rm16, >AT_Rm17, >AT_Rm18, >AT_Rm19 
	.db >AT_Rm20, >AT_Rm21, >AT_Rm22, >AT_Rm23, >AT_Rm24, >AT_Rm25, >AT_Rm26, >AT_Rm27, >AT_Rm28, >AT_Rm29
	.db >AT_Rm30, >AT_Rm31, >AT_Rm32, >AT_Rm33, >AT_Rm34, >AT_Rm35, >AT_Rm36, >AT_Rm37, >AT_Rm38, >AT_Rm39
	.db >AT_Rm40, >AT_Rm41, >AT_Rm42, >AT_Rm43, >AT_Rm44, >AT_Rm45, >AT_Rm46, >AT_Rm47, >AT_Rm48, >AT_Rm49
	.db >AT_Rm50, >AT_Rm51, >AT_Rm52, >AT_Rm53, >AT_Rm54, >AT_Rm55, >AT_Rm56, >AT_Rm57, >AT_Rm58, >AT_Rm59
	.db >AT_Rm60, >AT_Rm61, >AT_Rm62, >AT_Rm63, >AT_Rm64, >AT_Rm65, >AT_Rm66, >AT_Rm67, >AT_Rm68, >AT_Rm69
	.db >AT_Rm70, >AT_Rm71, >AT_Rm72, >AT_Rm73, >AT_Rm74, >AT_Rm75, >AT_Rm76, >AT_Rm77, >AT_Rm78, >AT_Rm79
	.db >AT_Rm80, >AT_Rm81, >AT_Rm82, >AT_Rm83, >AT_Rm84, >AT_Rm85, >AT_Rm86, >AT_Rm87, >AT_Rm88, >AT_Rm89
	.db >AT_Rm90, >AT_Rm91, >AT_Rm92, >AT_Rm93, >AT_Rm94, >AT_Rm95, >AT_Rm96, >AT_Rm97, >AT_Rm98, >AT_Rm99
	.db >AT_Rm100, >AT_Rm101, >AT_Rm102, >AT_Rm103, >AT_Rm104, >AT_Rm105, >AT_Rm106, >AT_Rm107, >AT_Rm108
	.db >AT_Rm109, >AT_Rm110, >AT_Rm111, >AT_Rm112, >AT_Rm113, >AT_Rm114, >AT_Rm115, >AT_Rm116, >AT_Rm117
	.db >AT_Rm118, >AT_Rm119, >AT_Rm120, >AT_Rm121, >AT_Rm122, >AT_Rm123, >AT_Rm124, >AT_Rm125, >AT_Rm126
	.db >AT_Rm127, >AT_Rm128, >AT_Rm129, >AT_Rm130, >AT_Rm131, >AT_Rm132, >AT_Rm133, >AT_Rm134, >AT_Rm135
	.db >AT_Rm136, >AT_Rm137, >AT_Rm138, >AT_Rm139, >AT_Rm140, >AT_Rm141, >AT_Rm142, >AT_Rm143, >AT_Rm144
	.db >AT_Rm145, >AT_Rm146, >AT_Rm147, >AT_Rm148, >AT_Rm149, >AT_Rm150, >AT_Rm151, >AT_Rm152, >AT_Rm153
	.db >AT_Rm154, >AT_Rm155, >AT_Rm156, >AT_Rm157, >AT_Rm158, >AT_Rm159, >AT_Rm160, >AT_Rm161, >AT_Rm162
	.db >AT_Rm163, >AT_Rm164, >AT_Rm165, >AT_Rm166, >AT_Rm167, >AT_Rm168, >AT_Rm169, >AT_Rm170, >AT_Rm171
	.db >AT_Rm172, >AT_Rm173, >AT_Rm174, >AT_Rm175, >AT_Rm176, >AT_Rm177, >AT_Rm178, >AT_Rm179, >AT_Rm180
	.db >AT_Rm181, >AT_Rm182, >AT_Rm183, >AT_Rm184, >AT_Rm185, >AT_Rm186, >AT_Rm187, >AT_Rm188, >AT_Rm189
	.db >AT_Rm190, >AT_Rm191, >AT_Rm192, >AT_Rm193, >AT_Rm194, >AT_Rm195, >AT_Rm196, >AT_Rm197, >AT_Rm198
	.db >AT_Rm199, >AT_Rm200, >AT_Rm201, >AT_Rm202, >AT_Rm203, >AT_Rm204, >AT_Rm205, >AT_Rm206, >AT_Rm207
	.db >AT_Rm208, >AT_Rm209, >AT_Rm210, >AT_Rm211, >AT_Rm212, >AT_Rm213, >AT_Rm214, >AT_Rm215, >AT_Rm216
	.db >AT_Rm217, >AT_Rm218, >AT_Rm219, >AT_Rm220, >AT_Rm221, >AT_Rm222, >AT_Rm223, >AT_Rm224, >AT_Rm225
	.db >AT_Rm226, >AT_Rm227, >AT_Rm228, >AT_Rm229, >AT_Rm230, >AT_Rm231, >AT_Rm232, >AT_Rm233, >AT_Rm234
	.db >AT_Rm235, >AT_Rm236, >AT_Rm237, >AT_Rm238, >AT_Rm239, >AT_Rm240, >AT_Rm241, >AT_Rm242, >AT_Rm243
	.db >AT_Rm244, >AT_Rm245, >AT_Rm246, >AT_Rm247, >AT_Rm248, >AT_Rm249, >AT_Rm250, >AT_Rm251, >AT_Rm252
	.db >AT_Rm253, >AT_Rm254, >AT_Rm255


AttributeTablesMainGameBelowLo:
	.db <bAT_Rm00, <bAT_Rm01, <bAT_Rm02, <bAT_Rm03, <bAT_Rm04, <bAT_Rm05, <bAT_Rm06, <bAT_Rm07, <bAT_Rm08, <bAT_Rm09
	.db <bAT_Rm10, <bAT_Rm11, <bAT_Rm12, <bAT_Rm13, <bAT_Rm14, <bAT_Rm15, <bAT_Rm16, <bAT_Rm17, <bAT_Rm18,  <bAT_Rm19 
	.db <bAT_Rm20, <bAT_Rm21, <bAT_Rm22, <bAT_Rm23, <bAT_Rm24, <bAT_Rm25, <bAT_Rm26, <bAT_Rm27, <bAT_Rm28, <bAT_Rm29
	.db <bAT_Rm30, <bAT_Rm31, <bAT_Rm32, <bAT_Rm33, <bAT_Rm34, <bAT_Rm35, <bAT_Rm36, <bAT_Rm37, <bAT_Rm38, <bAT_Rm39
	.db <bAT_Rm40, <bAT_Rm41, <bAT_Rm42, <bAT_Rm43, <bAT_Rm44, <bAT_Rm45, <bAT_Rm46, <bAT_Rm47, <bAT_Rm48, <bAT_Rm49
	.db <bAT_Rm50, <bAT_Rm51, <bAT_Rm52, <bAT_Rm53, <bAT_Rm54, <bAT_Rm55, <bAT_Rm56, <bAT_Rm57, <bAT_Rm58, <bAT_Rm59
	.db <bAT_Rm60, <bAT_Rm61, <bAT_Rm62, <bAT_Rm63, <bAT_Rm64, <bAT_Rm65, <bAT_Rm66, <bAT_Rm67, <bAT_Rm68, <bAT_Rm69
	.db <bAT_Rm70, <bAT_Rm71, <bAT_Rm72, <bAT_Rm73, <bAT_Rm74, <bAT_Rm75, <bAT_Rm76, <bAT_Rm77, <bAT_Rm78, <bAT_Rm79
	.db <bAT_Rm80, <bAT_Rm81, <bAT_Rm82, <bAT_Rm83, <bAT_Rm84, <bAT_Rm85, <bAT_Rm86, <bAT_Rm87, <bAT_Rm88, <bAT_Rm89
	.db <bAT_Rm90, <bAT_Rm91, <bAT_Rm92, <bAT_Rm93, <bAT_Rm94, <bAT_Rm95, <bAT_Rm96, <bAT_Rm97, <bAT_Rm98, <bAT_Rm99
	.db <bAT_Rm100, <bAT_Rm101, <bAT_Rm102, <bAT_Rm103, <bAT_Rm104, <bAT_Rm105, <bAT_Rm106, <bAT_Rm107, <bAT_Rm108
	.db <bAT_Rm109, <bAT_Rm110, <bAT_Rm111, <bAT_Rm112, <bAT_Rm113, <bAT_Rm114, <bAT_Rm115, <bAT_Rm116, <bAT_Rm117
	.db <bAT_Rm118, <bAT_Rm119, <bAT_Rm120, <bAT_Rm121, <bAT_Rm122, <bAT_Rm123, <bAT_Rm124, <bAT_Rm125, <bAT_Rm126
	.db <bAT_Rm127, <bAT_Rm128, <bAT_Rm129, <bAT_Rm130, <bAT_Rm131, <bAT_Rm132, <bAT_Rm133, <bAT_Rm134, <bAT_Rm135
	.db <bAT_Rm136, <bAT_Rm137, <bAT_Rm138, <bAT_Rm139, <bAT_Rm140, <bAT_Rm141, <bAT_Rm142, <bAT_Rm143, <bAT_Rm144
	.db <bAT_Rm145, <bAT_Rm146, <bAT_Rm147, <bAT_Rm148, <bAT_Rm149, <bAT_Rm150, <bAT_Rm151, <bAT_Rm152, <bAT_Rm153
	.db <bAT_Rm154, <bAT_Rm155, <bAT_Rm156, <bAT_Rm157, <bAT_Rm158, <bAT_Rm159, <bAT_Rm160, <bAT_Rm161, <bAT_Rm162
	.db <bAT_Rm163, <bAT_Rm164, <bAT_Rm165, <bAT_Rm166, <bAT_Rm167, <bAT_Rm168, <bAT_Rm169, <bAT_Rm170, <bAT_Rm171
	.db <bAT_Rm172, <bAT_Rm173, <bAT_Rm174, <bAT_Rm175, <bAT_Rm176, <bAT_Rm177, <bAT_Rm178, <bAT_Rm179, <bAT_Rm180
	.db <bAT_Rm181, <bAT_Rm182, <bAT_Rm183, <bAT_Rm184, <bAT_Rm185, <bAT_Rm186, <bAT_Rm187, <bAT_Rm188, <bAT_Rm189
	.db <bAT_Rm190, <bAT_Rm191, <bAT_Rm192, <bAT_Rm193, <bAT_Rm194, <bAT_Rm195, <bAT_Rm196, <bAT_Rm197, <bAT_Rm198
	.db <bAT_Rm199, <bAT_Rm200, <bAT_Rm201, <bAT_Rm202, <bAT_Rm203, <bAT_Rm204, <bAT_Rm205, <bAT_Rm206, <bAT_Rm207
	.db <bAT_Rm208, <bAT_Rm209, <bAT_Rm210, <bAT_Rm211, <bAT_Rm212, <bAT_Rm213, <bAT_Rm214, <bAT_Rm215, <bAT_Rm216
	.db <bAT_Rm217, <bAT_Rm218, <bAT_Rm219, <bAT_Rm220, <bAT_Rm221, <bAT_Rm222, <bAT_Rm223, <bAT_Rm224, <bAT_Rm225
	.db <bAT_Rm226, <bAT_Rm227, <bAT_Rm228, <bAT_Rm229, <bAT_Rm230, <bAT_Rm231, <bAT_Rm232, <bAT_Rm233, <bAT_Rm234
	.db <bAT_Rm235, <bAT_Rm236, <bAT_Rm237, <bAT_Rm238, <bAT_Rm239, <bAT_Rm240, <bAT_Rm241, <bAT_Rm242, <bAT_Rm243
	.db <bAT_Rm244, <bAT_Rm245, <bAT_Rm246, <bAT_Rm247, <bAT_Rm248, <bAT_Rm249, <bAT_Rm250, <bAT_Rm251, <bAT_Rm252
	.db <bAT_Rm253, <bAT_Rm254, <bAT_Rm255
AttributeTablesMainGameBelowHi:	
	.db >bAT_Rm00, >bAT_Rm01, >bAT_Rm02, >bAT_Rm03, >bAT_Rm04, >bAT_Rm05, >bAT_Rm06, >bAT_Rm07, >bAT_Rm08, >bAT_Rm09
	.db >bAT_Rm10, >bAT_Rm11, >bAT_Rm12, >bAT_Rm13, >bAT_Rm14, >bAT_Rm15, >bAT_Rm16, >bAT_Rm17, >bAT_Rm18,  >bAT_Rm19 
	.db >bAT_Rm20, >bAT_Rm21, >bAT_Rm22, >bAT_Rm23, >bAT_Rm24, >bAT_Rm25, >bAT_Rm26, >bAT_Rm27, >bAT_Rm28, >bAT_Rm29
	.db >bAT_Rm30, >bAT_Rm31, >bAT_Rm32, >bAT_Rm33, >bAT_Rm34, >bAT_Rm35, >bAT_Rm36, >bAT_Rm37, >bAT_Rm38, >bAT_Rm39
	.db >bAT_Rm40, >bAT_Rm41, >bAT_Rm42, >bAT_Rm43, >bAT_Rm44, >bAT_Rm45, >bAT_Rm46, >bAT_Rm47, >bAT_Rm48, >bAT_Rm49
	.db >bAT_Rm50, >bAT_Rm51, >bAT_Rm52, >bAT_Rm53, >bAT_Rm54, >bAT_Rm55, >bAT_Rm56, >bAT_Rm57, >bAT_Rm58, >bAT_Rm59
	.db >bAT_Rm60, >bAT_Rm61, >bAT_Rm62, >bAT_Rm63, >bAT_Rm64, >bAT_Rm65, >bAT_Rm66, >bAT_Rm67, >bAT_Rm68, >bAT_Rm69
	.db >bAT_Rm70, >bAT_Rm71, >bAT_Rm72, >bAT_Rm73, >bAT_Rm74, >bAT_Rm75, >bAT_Rm76, >bAT_Rm77, >bAT_Rm78, >bAT_Rm79
	.db >bAT_Rm80, >bAT_Rm81, >bAT_Rm82, >bAT_Rm83, >bAT_Rm84, >bAT_Rm85, >bAT_Rm86, >bAT_Rm87, >bAT_Rm88, >bAT_Rm89
	.db >bAT_Rm90, >bAT_Rm91, >bAT_Rm92, >bAT_Rm93, >bAT_Rm94, >bAT_Rm95, >bAT_Rm96, >bAT_Rm97, >bAT_Rm98, >bAT_Rm99
	.db >bAT_Rm100, >bAT_Rm101, >bAT_Rm102, >bAT_Rm103, >bAT_Rm104, >bAT_Rm105, >bAT_Rm106, >bAT_Rm107, >bAT_Rm108
	.db >bAT_Rm109, >bAT_Rm110, >bAT_Rm111, >bAT_Rm112, >bAT_Rm113, >bAT_Rm114, >bAT_Rm115, >bAT_Rm116, >bAT_Rm117
	.db >bAT_Rm118, >bAT_Rm119, >bAT_Rm120, >bAT_Rm121, >bAT_Rm122, >bAT_Rm123, >bAT_Rm124, >bAT_Rm125, >bAT_Rm126
	.db >bAT_Rm127, >bAT_Rm128, >bAT_Rm129, >bAT_Rm130, >bAT_Rm131, >bAT_Rm132, >bAT_Rm133, >bAT_Rm134, >bAT_Rm135
	.db >bAT_Rm136, >bAT_Rm137, >bAT_Rm138, >bAT_Rm139, >bAT_Rm140, >bAT_Rm141, >bAT_Rm142, >bAT_Rm143, >bAT_Rm144
	.db >bAT_Rm145, >bAT_Rm146, >bAT_Rm147, >bAT_Rm148, >bAT_Rm149, >bAT_Rm150, >bAT_Rm151, >bAT_Rm152, >bAT_Rm153
	.db >bAT_Rm154, >bAT_Rm155, >bAT_Rm156, >bAT_Rm157, >bAT_Rm158, >bAT_Rm159, >bAT_Rm160, >bAT_Rm161, >bAT_Rm162
	.db >bAT_Rm163, >bAT_Rm164, >bAT_Rm165, >bAT_Rm166, >bAT_Rm167, >bAT_Rm168, >bAT_Rm169, >bAT_Rm170, >bAT_Rm171
	.db >bAT_Rm172, >bAT_Rm173, >bAT_Rm174, >bAT_Rm175, >bAT_Rm176, >bAT_Rm177, >bAT_Rm178, >bAT_Rm179, >bAT_Rm180
	.db >bAT_Rm181, >bAT_Rm182, >bAT_Rm183, >bAT_Rm184, >bAT_Rm185, >bAT_Rm186, >bAT_Rm187, >bAT_Rm188, >bAT_Rm189
	.db >bAT_Rm190, >bAT_Rm191, >bAT_Rm192, >bAT_Rm193, >bAT_Rm194, >bAT_Rm195, >bAT_Rm196, >bAT_Rm197, >bAT_Rm198
	.db >bAT_Rm199, >bAT_Rm200, >bAT_Rm201, >bAT_Rm202, >bAT_Rm203, >bAT_Rm204, >bAT_Rm205, >bAT_Rm206, >bAT_Rm207
	.db >bAT_Rm208, >bAT_Rm209, >bAT_Rm210, >bAT_Rm211, >bAT_Rm212, >bAT_Rm213, >bAT_Rm214, >bAT_Rm215, >bAT_Rm216
	.db >bAT_Rm217, >bAT_Rm218, >bAT_Rm219, >bAT_Rm220, >bAT_Rm221, >bAT_Rm222, >bAT_Rm223, >bAT_Rm224, >bAT_Rm225
	.db >bAT_Rm226, >bAT_Rm227, >bAT_Rm228, >bAT_Rm229, >bAT_Rm230, >bAT_Rm231, >bAT_Rm232, >bAT_Rm233, >bAT_Rm234
	.db >bAT_Rm235, >bAT_Rm236, >bAT_Rm237, >bAT_Rm238, >bAT_Rm239, >bAT_Rm240, >bAT_Rm241, >bAT_Rm242, >bAT_Rm243
	.db >bAT_Rm244, >bAT_Rm245, >bAT_Rm246, >bAT_Rm247, >bAT_Rm248, >bAT_Rm249, >bAT_Rm250, >bAT_Rm251, >bAT_Rm252
	.db >bAT_Rm253, >bAT_Rm254, >bAT_Rm255	

AttributeTablesSpecialLo:
	.db <ATT_StartScreen, <ATT_WinScreen
AttributeTablesSpecialHi:	
	.db >ATT_StartScreen, >ATT_WinScreen
	
	
CollisionTablesSpecialLo:
	;.db <CT_Start
CollisionTablesSpecialHi:
	;.db >CT_Start
	
	
	
CollisionTables_Map1_Lo:	
	.db <Ct00, <Ct01, <Ct02, <Ct03, <Ct04, <Ct05, <Ct06, <Ct07, <Ct08, <Ct09, <Ct10, <Ct11, <Ct12, <Ct13, <Ct14, <Ct15, <Ct16, <Ct17, <Ct18, <Ct19, <Ct20, <Ct21, <Ct22, <Ct23, <Ct24, <Ct25, <Ct26, <Ct27, <Ct28, <Ct29, <Ct30, <Ct31, <Ct32, <Ct33, <Ct34, <Ct35, <Ct36, <Ct37, <Ct38, <Ct39, <Ct40, <Ct41, <Ct42, <Ct43, <Ct44, <Ct45, <Ct46, <Ct47, <Ct48, <Ct49, <Ct50, <Ct51, <Ct52, <Ct53, <Ct54, <Ct55, <Ct56, <Ct57, <Ct58, <Ct59, <Ct60, <Ct61, <Ct62, <Ct63, <Ct64, <Ct65, <Ct66, <Ct67, <Ct68, <Ct69, <Ct70, <Ct71, <Ct72, <Ct73, <Ct74, <Ct75, <Ct76, <Ct77, <Ct78, <Ct79, <Ct80, <Ct81, <Ct82, <Ct83, <Ct84, <Ct85, <Ct86, <Ct87, <Ct88, <Ct89, <Ct90, <Ct91, <Ct92, <Ct93, <Ct94, <Ct95, <Ct96, <Ct97, <Ct98, <Ct99, <Ct100, <Ct101, <Ct102, <Ct103, <Ct104, <Ct105, <Ct106, <Ct107, <Ct108, <Ct109, <Ct110, <Ct111, <Ct112, <Ct113, <Ct114, <Ct115, <Ct116, <Ct117, <Ct118, <Ct119, <Ct120, <Ct121, <Ct122, <Ct123, <Ct124, <Ct125, <Ct126, <Ct127, <Ct128, <Ct129, <Ct130, <Ct131, <Ct132, <Ct133, <Ct134, <Ct135, <Ct136, <Ct137, <Ct138, <Ct139, <Ct140, <Ct141, <Ct142, <Ct143, <Ct144, <Ct145, <Ct146, <Ct147, <Ct148, <Ct149, <Ct150, <Ct151, <Ct152, <Ct153, <Ct154, <Ct155, <Ct156, <Ct157, <Ct158, <Ct159, <Ct160, <Ct161, <Ct162, <Ct163, <Ct164, <Ct165, <Ct166, <Ct167, <Ct168, <Ct169, <Ct170, <Ct171, <Ct172, <Ct173, <Ct174, <Ct175, <Ct176, <Ct177, <Ct178, <Ct179, <Ct180, <Ct181, <Ct182, <Ct183, <Ct184, <Ct185, <Ct186, <Ct187, <Ct188, <Ct189, <Ct190, <Ct191, <Ct192, <Ct193, <Ct194, <Ct195, <Ct196, <Ct197, <Ct198, <Ct199, <Ct200, <Ct201, <Ct202, <Ct203, <Ct204, <Ct205, <Ct206, <Ct207, <Ct208, <Ct209, <Ct210, <Ct211, <Ct212, <Ct213, <Ct214, <Ct215, <Ct216, <Ct217, <Ct218, <Ct219, <Ct220, <Ct221, <Ct222, <Ct223, <Ct224, <Ct225, <Ct226, <Ct227, <Ct228, <Ct229, <Ct230, <Ct231, <Ct232, <Ct233, <Ct234, <Ct235, <Ct236, <Ct237, <Ct238, <Ct239, <Ct240, <Ct241, <Ct242, <Ct243, <Ct244, <Ct245, <Ct246, <Ct247, <Ct248, <Ct249, <Ct250, <Ct251, <Ct252, <Ct253, <Ct254, <Ct255


CollisionTables_Map2_Lo:	
	.db <bCt00, <bCt01, <bCt02, <bCt03, <bCt04, <bCt05, <bCt06, <bCt07, <bCt08, <bCt09 
	.db <bCt10, <bCt11, <bCt12, <bCt13, <bCt14, <bCt15, <bCt16, <bCt17, <bCt18, <bCt19
	.db <bCt20, <bCt21, <bCt22, <bCt23, <bCt24, <bCt25, <bCt26, <bCt27, <bCt28, <bCt29
	.db <bCt30, <bCt31, <bCt32, <bCt33, <bCt34, <bCt35, <bCt36, <bCt37, <bCt38, <bCt39
	.db <bCt40, <bCt41, <bCt42, <bCt43, <bCt44, <bCt45, <bCt46, <bCt47, <bCt48, <bCt49
	.db <bCt50, <bCt51, <bCt52, <bCt53, <bCt54, <bCt55, <bCt56, <bCt57, <bCt58, <bCt59
	.db <bCt60, <bCt61, <bCt62, <bCt63, <bCt64, <bCt65, <bCt66, <bCt67, <bCt68, <bCt69
	.db <bCt70, <bCt71, <bCt72, <bCt73, <bCt74, <bCt75, <bCt76, <bCt77, <bCt78, <bCt79
	.db <bCt80, <bCt81, <bCt82, <bCt83, <bCt84, <bCt85, <bCt86, <bCt87, <bCt88, <bCt89
	.db <bCt90, <bCt91, <bCt92, <bCt93, <bCt94, <bCt95, <bCt96, <bCt97, <bCt98, <bCt99
	.db <bCt100, <bCt101, <bCt102, <bCt103, <bCt104, <bCt105, <bCt106, <bCt107, <bCt108
	.db <bCt109, <bCt110, <bCt111, <bCt112, <bCt113, <bCt114, <bCt115, <bCt116, <bCt117
	.db <bCt118, <bCt119, <bCt120, <bCt121, <bCt122, <bCt123, <bCt124, <bCt125, <bCt126
	.db <bCt127, <bCt128, <bCt129, <bCt130, <bCt131, <bCt132, <bCt133, <bCt134, <bCt135
	.db <bCt136, <bCt137, <bCt138, <bCt139, <bCt140, <bCt141, <bCt142, <bCt143, <bCt144
	.db <bCt145, <bCt146, <bCt147, <bCt148, <bCt149, <bCt150, <bCt151, <bCt152, <bCt153
	.db <bCt154, <bCt155, <bCt156, <bCt157, <bCt158, <bCt159, <bCt160, <bCt161, <bCt162
	.db <bCt163, <bCt164, <bCt165, <bCt166, <bCt167, <bCt168, <bCt169, <bCt170, <bCt171
	.db <bCt172, <bCt173, <bCt174, <bCt175, <bCt176, <bCt177, <bCt178, <bCt179, <bCt180
	.db <bCt181, <bCt182, <bCt183, <bCt184, <bCt185, <bCt186, <bCt187, <bCt188, <bCt189
	.db <bCt190, <bCt191, <bCt192, <bCt193, <bCt194, <bCt195, <bCt196, <bCt197, <bCt198
	.db <bCt199, <bCt200, <bCt201, <bCt202, <bCt203, <bCt204, <bCt205, <bCt206, <bCt207
	.db <bCt208, <bCt209, <bCt210, <bCt211, <bCt212, <bCt213, <bCt214, <bCt215, <bCt216
	.db <bCt217, <bCt218, <bCt219, <bCt220, <bCt221, <bCt222, <bCt223, <bCt224, <bCt225
	.db <bCt226, <bCt227, <bCt228, <bCt229, <bCt230, <bCt231, <bCt232, <bCt233, <bCt234 
	.db <bCt235, <bCt236, <bCt237, <bCt238, <bCt239, <bCt240, <bCt241, <bCt242, <bCt243 
	.db <bCt244, <bCt245, <bCt246, <bCt247, <bCt248, <bCt249, <bCt250, <bCt251, <bCt252 
	.db <bCt253, <bCt254, <bCt255	


CollisionTables_Map1_Hi:	
	.db >Ct00, >Ct01, >Ct02, >Ct03, >Ct04, >Ct05, >Ct06, >Ct07, >Ct08, >Ct09, >Ct10, >Ct11, >Ct12, >Ct13, >Ct14, >Ct15, >Ct16, >Ct17, >Ct18, >Ct19, >Ct20, >Ct21, >Ct22, >Ct23, >Ct24, >Ct25, >Ct26, >Ct27, >Ct28, >Ct29, >Ct30, >Ct31, >Ct32, >Ct33, >Ct34, >Ct35, >Ct36, >Ct37, >Ct38, >Ct39, >Ct40, >Ct41, >Ct42, >Ct43, >Ct44, >Ct45, >Ct46, >Ct47, >Ct48, >Ct49, >Ct50, >Ct51, >Ct52, >Ct53, >Ct54, >Ct55, >Ct56, >Ct57, >Ct58, >Ct59, >Ct60, >Ct61, >Ct62, >Ct63, >Ct64, >Ct65, >Ct66, >Ct67, >Ct68, >Ct69, >Ct70, >Ct71, >Ct72, >Ct73, >Ct74, >Ct75, >Ct76, >Ct77, >Ct78, >Ct79, >Ct80, >Ct81, >Ct82, >Ct83, >Ct84, >Ct85, >Ct86, >Ct87, >Ct88, >Ct89, >Ct90, >Ct91, >Ct92, >Ct93, >Ct94, >Ct95, >Ct96, >Ct97, >Ct98, >Ct99, >Ct100, >Ct101, >Ct102, >Ct103, >Ct104, >Ct105, >Ct106, >Ct107, >Ct108, >Ct109, >Ct110, >Ct111, >Ct112, >Ct113, >Ct114, >Ct115, >Ct116, >Ct117, >Ct118, >Ct119, >Ct120, >Ct121, >Ct122, >Ct123, >Ct124, >Ct125, >Ct126, >Ct127, >Ct128, >Ct129, >Ct130, >Ct131, >Ct132, >Ct133, >Ct134, >Ct135, >Ct136, >Ct137, >Ct138, >Ct139, >Ct140, >Ct141, >Ct142, >Ct143, >Ct144, >Ct145, >Ct146, >Ct147, >Ct148, >Ct149, >Ct150, >Ct151, >Ct152, >Ct153, >Ct154, >Ct155, >Ct156, >Ct157, >Ct158, >Ct159, >Ct160, >Ct161, >Ct162, >Ct163, >Ct164, >Ct165, >Ct166, >Ct167, >Ct168, >Ct169, >Ct170, >Ct171, >Ct172, >Ct173, >Ct174, >Ct175, >Ct176, >Ct177, >Ct178, >Ct179, >Ct180, >Ct181, >Ct182, >Ct183, >Ct184, >Ct185, >Ct186, >Ct187, >Ct188, >Ct189, >Ct190, >Ct191, >Ct192, >Ct193, >Ct194, >Ct195, >Ct196, >Ct197, >Ct198, >Ct199, >Ct200, >Ct201, >Ct202, >Ct203, >Ct204, >Ct205, >Ct206, >Ct207, >Ct208, >Ct209, >Ct210, >Ct211, >Ct212, >Ct213, >Ct214, >Ct215, >Ct216, >Ct217, >Ct218, >Ct219, >Ct220, >Ct221, >Ct222, >Ct223, >Ct224, >Ct225, >Ct226, >Ct227, >Ct228, >Ct229, >Ct230, >Ct231, >Ct232, >Ct233, >Ct234, >Ct235, >Ct236, >Ct237, >Ct238, >Ct239, >Ct240, >Ct241, >Ct242, >Ct243, >Ct244, >Ct245, >Ct246, >Ct247, >Ct248, >Ct249, >Ct250, >Ct251, >Ct252, >Ct253, >Ct254, >Ct255

CollisionTables_Map2_Hi:	
	.db >bCt00, >bCt01, >bCt02, >bCt03, >bCt04, >bCt05, >bCt06, >bCt07, >bCt08, >bCt09 
	.db >bCt10, >bCt11, >bCt12, >bCt13, >bCt14, >bCt15, >bCt16, >bCt17, >bCt18, >bCt19
	.db >bCt20, >bCt21, >bCt22, >bCt23, >bCt24, >bCt25, >bCt26, >bCt27, >bCt28, >bCt29
	.db >bCt30, >bCt31, >bCt32, >bCt33, >bCt34, >bCt35, >bCt36, >bCt37, >bCt38, >bCt39
	.db >bCt40, >bCt41, >bCt42, >bCt43, >bCt44, >bCt45, >bCt46, >bCt47, >bCt48, >bCt49
	.db >bCt50, >bCt51, >bCt52, >bCt53, >bCt54, >bCt55, >bCt56, >bCt57, >bCt58, >bCt59
	.db >bCt60, >bCt61, >bCt62, >bCt63, >bCt64, >bCt65, >bCt66, >bCt67, >bCt68, >bCt69
	.db >bCt70, >bCt71, >bCt72, >bCt73, >bCt74, >bCt75, >bCt76, >bCt77, >bCt78, >bCt79
	.db >bCt80, >bCt81, >bCt82, >bCt83, >bCt84, >bCt85, >bCt86, >bCt87, >bCt88, >bCt89
	.db >bCt90, >bCt91, >bCt92, >bCt93, >bCt94, >bCt95, >bCt96, >bCt97, >bCt98, >bCt99
	.db >bCt100, >bCt101, >bCt102, >bCt103, >bCt104, >bCt105, >bCt106, >bCt107, >bCt108
	.db >bCt109, >bCt110, >bCt111, >bCt112, >bCt113, >bCt114, >bCt115, >bCt116, >bCt117
	.db >bCt118, >bCt119, >bCt120, >bCt121, >bCt122, >bCt123, >bCt124, >bCt125, >bCt126
	.db >bCt127, >bCt128, >bCt129, >bCt130, >bCt131, >bCt132, >bCt133, >bCt134, >bCt135
	.db >bCt136, >bCt137, >bCt138, >bCt139, >bCt140, >bCt141, >bCt142, >bCt143, >bCt144
	.db >bCt145, >bCt146, >bCt147, >bCt148, >bCt149, >bCt150, >bCt151, >bCt152, >bCt153
	.db >bCt154, >bCt155, >bCt156, >bCt157, >bCt158, >bCt159, >bCt160, >bCt161, >bCt162
	.db >bCt163, >bCt164, >bCt165, >bCt166, >bCt167, >bCt168, >bCt169, >bCt170, >bCt171
	.db >bCt172, >bCt173, >bCt174, >bCt175, >bCt176, >bCt177, >bCt178, >bCt179, >bCt180
	.db >bCt181, >bCt182, >bCt183, >bCt184, >bCt185, >bCt186, >bCt187, >bCt188, >bCt189
	.db >bCt190, >bCt191, >bCt192, >bCt193, >bCt194, >bCt195, >bCt196, >bCt197, >bCt198
	.db >bCt199, >bCt200, >bCt201, >bCt202, >bCt203, >bCt204, >bCt205, >bCt206, >bCt207
	.db >bCt208, >bCt209, >bCt210, >bCt211, >bCt212, >bCt213, >bCt214, >bCt215, >bCt216
	.db >bCt217, >bCt218, >bCt219, >bCt220, >bCt221, >bCt222, >bCt223, >bCt224, >bCt225
	.db >bCt226, >bCt227, >bCt228, >bCt229, >bCt230, >bCt231, >bCt232, >bCt233, >bCt234 
	.db >bCt235, >bCt236, >bCt237, >bCt238, >bCt239, >bCt240, >bCt241, >bCt242, >bCt243 
	.db >bCt244, >bCt245, >bCt246, >bCt247, >bCt248, >bCt249, >bCt250, >bCt251, >bCt252 
	.db >bCt253, >bCt254, >bCt255		
	
	
	
	
CHRAddressLo:
	.db <startScreenTiles, <winScreenTiles, <hudTiles
CHRAddressHi:
	.db >startScreenTiles, >winScreenTiles, >hudTiles
	
	
	
BckCHRAddLo:
	.db <BckChr00, <BckChr01, <BckChr02, <BckChr03, <BckChr04, <BckChr05
	.db <BckChr06, <BckChr07, <BckChr08, <BckChr09, <BckChr10, <BckChr11
	.db <BckChr12, <BckChr13, <BckChr14, <BckChr15, <BckChr16, <BckChr17
	
BckCHRAddHi: 
	.db >BckChr00, >BckChr01, >BckChr02, >BckChr03, >BckChr04, >BckChr05
	.db >BckChr06, >BckChr07, >BckChr08, >BckChr09, >BckChr10, >BckChr11
	.db >BckChr12, >BckChr13, >BckChr14, >BckChr15, >BckChr16, >BckChr17
		
		
SpecialBackPalLo:
	.db <Pal_StartScreen, <Pal_WinScreen
SpecialBackPalHi:
	.db >Pal_StartScreen, >Pal_WinScreen
	
	
BckSSChrAddLo:	
	.db <BckSSChr00, <BckSSChr01, <BckSSChr02, <BckSSChr03, <BckSSChr04, <BckSSChr05, <BckSSChr06, <BckSSChr07, <BckSSChr08, <BckSSChr09
	.db <BckSSChr10, <BckSSChr11, <BckSSChr12, <BckSSChr13, <BckSSChr14, <BckSSChr15, <BckSSChr16, <BckSSChr17, <BckSSChr18, <BckSSChr19	
	.db <BckSSChr20, <BckSSChr21, <BckSSChr22, <BckSSChr23, <BckSSChr24, <BckSSChr25, <BckSSChr26, <BckSSChr27, <BckSSChr28, <BckSSChr29

BckSSChrAddHi: ;; chr type 2	
	.db >BckSSChr00, >BckSSChr01,>BckSSChr02, >BckSSChr03, >BckSSChr04, >BckSSChr05, >BckSSChr06, >BckSSChr07, >BckSSChr08, >BckSSChr09
	.db >BckSSChr10, >BckSSChr11, >BckSSChr12, >BckSSChr13, >BckSSChr14, >BckSSChr15, >BckSSChr16, >BckSSChr17, >BckSSChr18, >BckSSChr19	
	.db >BckSSChr20, >BckSSChr21, >BckSSChr22, >BckSSChr23, >BckSSChr24, >BckSSChr25, >BckSSChr26, >BckSSChr27, >BckSSChr28, >BckSSChr29


PathCHRAddLo:  ;; chr type 1
	;paths
	.db <PathTiles00, <PathTiles01, <PathTiles02, <PathTiles03, <PathTiles04, <PathTiles05, <PathTiles06, <PathTiles07
	.db <PathTiles08, <PathTiles09, <PathTiles10, <PathTiles11, <PathTiles12, <PathTiles13, <PathTiles14, <PathTiles15
	.db <PathTiles16, <PathTiles17, <PathTiles18, <PathTiles19, <PathTiles20, <PathTiles21, <PathTiles22, <PathTiles23

PathCHRAddHi: 
	;paths
	.db >PathTiles00, >PathTiles01, >PathTiles02, >PathTiles03, >PathTiles04, >PathTiles05, >PathTiles06, >PathTiles07
	.db >PathTiles08, >PathTiles09, >PathTiles10, >PathTiles11, >PathTiles12, >PathTiles13, >PathTiles14, >PathTiles15
	.db >PathTiles16, >PathTiles17, >PathTiles18, >PathTiles19, >PathTiles20, >PathTiles21, >PathTiles22, >PathTiles23	
	
		
GameBckPalLo:
	.db <BckPal00, <BckPal01, <BckPal02, <BckPal03, <BckPal04, <BckPal05, <BckPal06, <BckPal07
	.db <BckPal08, <BckPal09, <BckPal0a, <BckPal0b, <BckPal0c, <BckPal0d, <BckPal0e, <BckPal0f
	.db <BckPal10, <BckPal11, <BckPal12, <BckPal13, <BckPal14, <BckPal15, <BckPal16, <BckPal17
	.db <BckPal18, <BckPal19, <BckPal1a, <BckPal1b, <BckPal1c, <BckPal1d, <BckPal1e, <BckPal1f
	.db <BckPal20, <BckPal21, <BckPal22, <BckPal23, <BckPal24, <BckPal25, <BckPal26, <BckPal27
	.db <BckPal28, <BckPal29, <BckPal2a, <BckPal2b, <BckPal2c, <BckPal2d, <BckPal2e, <BckPal2f
	.db <BckPal30, <BckPal31, <BckPal32, <BckPal33, <BckPal34, <BckPal35, <BckPal36, <BckPal37
	.db <BckPal38, <BckPal39, <BckPal3a, <BckPal3b, <BckPal3c, <BckPal3d, <BckPal3e, <BckPal3f
	
GameBckPalHi:	
	.db >BckPal00, >BckPal01, >BckPal02, >BckPal03, >BckPal04, >BckPal05, >BckPal06, >BckPal07
	.db >BckPal08, >BckPal09, >BckPal0a, >BckPal0b, >BckPal0c, >BckPal0d, >BckPal0e, >BckPal0f
	.db >BckPal10, >BckPal11, >BckPal12, >BckPal13, >BckPal14, >BckPal15, >BckPal16, >BckPal17
	.db >BckPal18, >BckPal19, >BckPal1a, >BckPal1b, >BckPal1c, >BckPal1d, >BckPal1e, >BckPal1f
	.db >BckPal20, >BckPal21, >BckPal22, >BckPal23, >BckPal24, >BckPal25, >BckPal26, >BckPal27
	.db >BckPal28, >BckPal29, >BckPal2a, >BckPal2b, >BckPal2c, >BckPal2d, >BckPal2e, >BckPal2f
	.db >BckPal30, >BckPal31, >BckPal32, >BckPal33, >BckPal34, >BckPal35, >BckPal36, >BckPal37
	.db >BckPal38, >BckPal39, >BckPal3a, >BckPal3b, >BckPal3c, >BckPal3d, >BckPal3e, >BckPal3f
	
	
	
	
	
MonsterAddressLo:
	.db <monster_0_00, <monster_0_01, <monster_0_02, <monster_0_03, <monster_0_04, <monster_0_05, <monster_0_06, <monster_0_07
	.db <monster_1_00, <monster_1_01, <monster_1_02, <monster_1_03, <monster_1_04, <monster_1_05, <monster_1_06, <monster_1_07
MonsterAddressHi:
	.db >monster_0_00, >monster_0_01, >monster_0_02, >monster_0_03, >monster_0_04, >monster_0_05, >monster_0_06, >monster_0_07
	.db >monster_1_00, >monster_1_01, >monster_1_02, >monster_1_03, >monster_1_04, >monster_1_05, >monster_1_06, >monster_1_07
	
	
	
	
ObjectLoSpriteAddressLo:
	.db #<GameItem0_Lo, #<GameItem1_Lo, #<GameItem2_Lo, #<GameItem3_Lo, #<GameItem4_Lo, #<GameItem5_Lo, #<GameItem6_Lo, #<GameItem7_Lo
	.db #<GameItem8_Lo, #<GameItem9_Lo,#<GameItem10_Lo,#<GameItem11_Lo,#<GameItem12_Lo,#<GameItem13_Lo,#<GameItem14_Lo,#<GameItem15_Lo
	
	.db #<Object0_Lo,#<Object1_Lo,#<Object2_Lo,#<Object3_Lo,#<Object4_Lo,#<Object5_Lo,#<Object6_Lo,#<Object7_Lo
	.db #<Object8_Lo,#<Object9_Lo,#<Object10_Lo,#<Object11_Lo,#<Object12_Lo,#<Object13_Lo,#<Object14_Lo,#<Object15_Lo
	.db #<Object16_Lo,#<Object17_Lo,#<Object18_Lo,#<Object19_Lo,#<Object20_Lo,#<Object21_Lo,#<Object22_Lo,#<Object23_Lo
	.db #<Object24_Lo,#<Object25_Lo,#<Object26_Lo,#<Object27_Lo,#<Object28_Lo,#<Object29_Lo,#<Object30_Lo,#<Object31_Lo
	.db #<Object32_Lo,#<Object33_Lo,#<Object34_Lo,#<Object35_Lo,#<Object36_Lo,#<Object37_Lo,#<Object38_Lo,#<Object39_Lo
	.db #<Object40_Lo,#<Object41_Lo,#<Object42_Lo,#<Object43_Lo,#<Object44_Lo,#<Object45_Lo,#<Object46_Lo,#<Object47_Lo
	.db #<Object48_Lo,#<Object49_Lo,#<Object50_Lo,#<Object51_Lo,#<Object52_Lo,#<Object53_Lo,#<Object54_Lo,#<Object55_Lo
	.db #<Object56_Lo,#<Object57_Lo,#<Object58_Lo,#<Object59_Lo,#<Object60_Lo,#<Object61_Lo,#<Object62_Lo,#<Object63_Lo
	
ObjectLoSpriteAddressHi:
	.db #>GameItem0_Lo, #>GameItem1_Lo, #>GameItem2_Lo, #>GameItem3_Lo, #>GameItem4_Lo, #>GameItem5_Lo, #>GameItem6_Lo, #>GameItem7_Lo
	.db #>GameItem8_Lo, #>GameItem9_Lo,#>GameItem10_Lo,#>GameItem11_Lo,#>GameItem12_Lo,#>GameItem13_Lo,#>GameItem14_Lo,#>GameItem15_Lo
	
	.db #>Object0_Lo,#>Object1_Lo,#>Object2_Lo,#>Object3_Lo,#>Object4_Lo,#>Object5_Lo,#>Object6_Lo,#>Object7_Lo
	.db #>Object8_Lo,#>Object9_Lo,#>Object10_Lo,#>Object11_Lo,#>Object12_Lo,#>Object13_Lo,#>Object14_Lo,#>Object15_Lo
	.db #>Object16_Lo,#>Object17_Lo,#>Object18_Lo,#>Object19_Lo,#>Object20_Lo,#>Object21_Lo,#>Object22_Lo,#>Object23_Lo
	.db #>Object24_Lo,#>Object25_Lo,#>Object26_Lo,#>Object27_Lo,#>Object28_Lo,#>Object29_Lo,#>Object30_Lo,#>Object31_Lo
	.db #>Object32_Lo,#>Object33_Lo,#>Object34_Lo,#>Object35_Lo,#>Object36_Lo,#>Object37_Lo,#>Object38_Lo,#>Object39_Lo
	.db #>Object40_Lo,#>Object41_Lo,#>Object42_Lo,#>Object43_Lo,#>Object44_Lo,#>Object45_Lo,#>Object46_Lo,#>Object47_Lo
	.db #>Object48_Lo,#>Object49_Lo,#>Object50_Lo,#>Object51_Lo,#>Object52_Lo,#>Object53_Lo,#>Object54_Lo,#>Object55_Lo
	.db #>Object56_Lo,#>Object57_Lo,#>Object58_Lo,#>Object59_Lo,#>Object60_Lo,#>Object61_Lo,#>Object62_Lo,#>Object63_Lo


ObjectHiSpriteAddressLo:
		.db #<GameItem0_Hi, #<GameItem1_Hi, #<GameItem2_Hi, #<GameItem3_Hi, #<GameItem4_Hi, #<GameItem5_Hi, #<GameItem6_Hi, #<GameItem7_Hi
	.db #<GameItem8_Hi, #<GameItem9_Hi,#<GameItem10_Hi,#<GameItem11_Hi,#<GameItem12_Hi,#<GameItem13_Hi,#<GameItem14_Hi,#<GameItem15_Hi
	
	.db #<Object0_Hi,#<Object1_Hi,#<Object2_Hi,#<Object3_Hi,#<Object4_Hi,#<Object5_Hi,#<Object6_Hi,#<Object7_Hi
	.db #<Object8_Hi,#<Object9_Hi,#<Object10_Hi,#<Object11_Hi,#<Object12_Hi,#<Object13_Hi,#<Object14_Hi,#<Object15_Hi
	.db #<Object16_Hi,#<Object17_Hi,#<Object18_Hi,#<Object19_Hi,#<Object20_Hi,#<Object21_Hi,#<Object22_Hi,#<Object23_Hi
	.db #<Object24_Hi,#<Object25_Hi,#<Object26_Hi,#<Object27_Hi,#<Object28_Hi,#<Object29_Hi,#<Object30_Hi,#<Object31_Hi
	.db #<Object32_Hi,#<Object33_Hi,#<Object34_Hi,#<Object35_Hi,#<Object36_Hi,#<Object37_Hi,#<Object38_Hi,#<Object39_Hi
	.db #<Object40_Hi,#<Object41_Hi,#<Object42_Hi,#<Object43_Hi,#<Object44_Hi,#<Object45_Hi,#<Object46_Hi,#<Object47_Hi
	.db #<Object48_Hi,#<Object49_Hi,#<Object50_Hi,#<Object51_Hi,#<Object52_Hi,#<Object53_Hi,#<Object54_Hi,#<Object55_Hi
	.db #<Object56_Hi,#<Object57_Hi,#<Object58_Hi,#<Object59_Hi,#<Object60_Hi,#<Object61_Hi,#<Object62_Hi,#<Object63_Hi
	
ObjectHiSpriteAddressHi:
	.db #>GameItem0_Hi, #>GameItem1_Hi, #>GameItem2_Hi, #>GameItem3_Hi, #>GameItem4_Hi, #>GameItem5_Hi, #>GameItem6_Hi, #>GameItem7_Hi
	.db #>GameItem8_Hi, #>GameItem9_Hi,#>GameItem10_Hi,#>GameItem11_Hi,#>GameItem12_Hi,#>GameItem13_Hi,#>GameItem14_Hi,#>GameItem15_Hi
	
	.db #>Object0_Hi,#>Object1_Hi,#>Object2_Hi,#>Object3_Hi,#>Object4_Hi,#>Object5_Hi,#>Object6_Hi,#>Object7_Hi
	.db #>Object8_Hi,#>Object9_Hi,#>Object10_Hi,#>Object11_Hi,#>Object12_Hi,#>Object13_Hi,#>Object14_Hi,#>Object15_Hi
	.db #>Object16_Hi,#>Object17_Hi,#>Object18_Hi,#>Object19_Hi,#>Object20_Hi,#>Object21_Hi,#>Object22_Hi,#>Object23_Hi
	.db #>Object24_Hi,#>Object25_Hi,#>Object26_Hi,#>Object27_Hi,#>Object28_Hi,#>Object29_Hi,#>Object30_Hi,#>Object31_Hi
	.db #>Object32_Hi,#>Object33_Hi,#>Object34_Hi,#>Object35_Hi,#>Object36_Hi,#>Object37_Hi,#>Object38_Hi,#>Object39_Hi
	.db #>Object40_Hi,#>Object41_Hi,#>Object42_Hi,#>Object43_Hi,#>Object44_Hi,#>Object45_Hi,#>Object46_Hi,#>Object47_Hi
	.db #>Object48_Hi,#>Object49_Hi,#>Object50_Hi,#>Object51_Hi,#>Object52_Hi,#>Object53_Hi,#>Object54_Hi,#>Object55_Hi
	.db #>Object56_Hi,#>Object57_Hi,#>Object58_Hi,#>Object59_Hi,#>Object60_Hi,#>Object61_Hi,#>Object62_Hi,#>Object63_Hi
	
	
	
	
	
	
ObjectPaletteDataLo:
	.db <objectPal_0, <objectPal_1, <objectPal_2, <objectPal_3, <objectPal_4, <objectPal_5, <objectPal_6, <objectPal_7
	.db <objectPal_8, <objectPal_9, <objectPal_10, <objectPal_11, <objectPal_12, <objectPal_13, <objectPal_14, <objectPal_15
	.db <objectPal_16, <objectPal_17, <objectPal_18, <objectPal_19, <objectPal_20, <objectPal_21, <objectPal_22, <objectPal_23 
	.db <objectPal_24, <objectPal_25, <objectPal_26, <objectPal_27, <objectPal_28, <objectPal_29, <objectPal_30, <objectPal_31 
	.db <objectPal_32, <objectPal_33, <objectPal_34, <objectPal_35, <objectPal_36, <objectPal_37, <objectPal_38, <objectPal_39 
	.db <objectPal_40, <objectPal_41, <objectPal_42, <objectPal_43, <objectPal_44, <objectPal_45, <objectPal_46, <objectPal_47 
	.db <objectPal_48, <objectPal_49, <objectPal_50, <objectPal_51, <objectPal_52, <objectPal_53, <objectPal_54, <objectPal_55 
	.db <objectPal_56, <objectPal_57, <objectPal_58, <objectPal_59, <objectPal_60, <objectPal_61, <objectPal_62, <objectPal_63 


ObjectPaletteDataHi:
	.db >objectPal_0, >objectPal_1, >objectPal_2, >objectPal_3, >objectPal_4, >objectPal_5, >objectPal_6, >objectPal_7
	.db >objectPal_8, >objectPal_9, >objectPal_10, >objectPal_11, >objectPal_12, >objectPal_13, >objectPal_14, >objectPal_15
	.db >objectPal_16, >objectPal_17, >objectPal_18, >objectPal_19, >objectPal_20, >objectPal_21, >objectPal_22, >objectPal_23 
	.db >objectPal_24, >objectPal_25, >objectPal_26, >objectPal_27, >objectPal_28, >objectPal_29, >objectPal_30, >objectPal_31 
	.db >objectPal_32, >objectPal_33, >objectPal_34, >objectPal_35, >objectPal_36, >objectPal_37, >objectPal_38, >objectPal_39 
	.db >objectPal_40, >objectPal_41, >objectPal_42, >objectPal_43, >objectPal_44, >objectPal_45, >objectPal_46, >objectPal_47 
	.db >objectPal_48, >objectPal_49, >objectPal_50, >objectPal_51, >objectPal_52, >objectPal_53, >objectPal_54, >objectPal_55 
	.db >objectPal_56, >objectPal_57, >objectPal_58, >objectPal_59, >objectPal_60, >objectPal_61, >objectPal_62, >objectPal_63



i:


TextStrings00_Lo:
	.db <Text0, <Text1, <Text2, <Text3, <Text4, <Text5,<Text6, <Text7, <Text8, <Text9, <Text10, <Text11, <Text12, <Text13,<Text14, <Text15
	.db <Text16, <Text17, <Text18, <Text19, <Text20, <Text21,<Text22, <Text23, <Text24, <Text25, <Text26, <Text27, <Text28, <Text29,<Text30, <Text31
	.db <Text32, <Text33, <Text34, <Text35, <Text36, <Text37,<Text38, <Text39, <Text40, <Text41, <Text42, <Text43, <Text44, <Text45,<Text46, <Text47
	.db <Text48, <Text49, <Text50, <Text51, <Text52, <Text53,<Text54, <Text55, <Text56, <Text57, <Text58, <Text59, <Text60, <Text61,<Text62, <Text63
	.db <Text64, <Text65, <Text66, <Text67, <Text68, <Text69,<Text70, <Text71, <Text72, <Text73, <Text74, <Text75, <Text76, <Text77,<Text78, <Text79
	.db <Text80, <Text81, <Text82, <Text83, <Text84, <Text85,<Text86, <Text87, <Text88, <Text89, <Text90, <Text91, <Text92, <Text93,<Text94, <Text95
	.db <Text96, <Text97, <Text98, <Text99, <Text100, <Text101,<Text102, <Text103, <Text104, <Text105, <Text106, <Text107, <Text108, <Text109,<Text110, <Text111
	.db <Text112, <Text113, <Text114, <Text115, <Text116, <Text117,<Text118, <Text119, <Text120, <Text121, <Text122, <Text123, <Text124, <Text125,<Text126, <Text127
	.db <Text128, <Text129, <Text130, <Text131, <Text132, <Text133,<Text134, <Text135, <Text136, <Text137, <Text138, <Text139, <Text140, <Text141,<Text142, <Text143
	.db <Text144, <Text145, <Text146, <Text147, <Text148, <Text149,<Text150, <Text151, <Text152, <Text153, <Text154, <Text155, <Text156, <Text157,<Text158, <Text159
	.db <Text160, <Text161, <Text162, <Text163, <Text164, <Text165,<Text166, <Text167, <Text168, <Text169, <Text170, <Text171, <Text172, <Text173,<Text174, <Text175
	.db <Text176, <Text177, <Text178, <Text179, <Text180, <Text181,<Text182, <Text183, <Text184, <Text185, <Text186, <Text187, <Text188, <Text189,<Text190, <Text191
	.db <Text192, <Text193, <Text194, <Text195, <Text196, <Text197,<Text198, <Text199, <Text200, <Text201, <Text202, <Text203, <Text204, <Text205,<Text206, <Text207
	.db <Text208, <Text209, <Text210, <Text211, <Text212, <Text213,<Text214, <Text215, <Text216, <Text217, <Text218, <Text219, <Text220, <Text221,<Text222, <Text223
	.db <Text224, <Text225, <Text226, <Text227, <Text228, <Text229,<Text230, <Text231, <Text232, <Text233, <Text234, <Text235, <Text236, <Text237,<Text238, <Text239
	.db <Text240, <Text241, <Text242, <Text243, <Text244, <Text245,<Text246, <Text247, <Text248, <Text249, <Text250, <Text251, <Text252, <Text253,<Text254, <Text255
TextStrings00_Hi:
	.db >Text0, >Text1, >Text2, >Text3, >Text4, >Text5,>Text6, >Text7, >Text8, >Text9, >Text10, >Text11, >Text12, >Text13,>Text14, >Text15
	.db >Text16, >Text17, >Text18, >Text19, >Text20, >Text21,>Text22, >Text23, >Text24, >Text25, >Text26, >Text27, >Text28, >Text29,>Text30, >Text31
	.db >Text32, >Text33, >Text34, >Text35, >Text36, >Text37,>Text38, >Text39, >Text40, >Text41, >Text42, >Text43, >Text44, >Text45,>Text46, >Text47
	.db >Text48, >Text49, >Text50, >Text51, >Text52, >Text53,>Text54, >Text55, >Text56, >Text57, >Text58, >Text59, >Text60, >Text61,>Text62, >Text63
	.db >Text64, >Text65, >Text66, >Text67, >Text68, >Text69,>Text70, >Text71, >Text72, >Text73, >Text74, >Text75, >Text76, >Text77,>Text78, >Text79
	.db >Text80, >Text81, >Text82, >Text83, >Text84, >Text85,>Text86, >Text87, >Text88, >Text89, >Text90, >Text91, >Text92, >Text93,>Text94, >Text95
	.db >Text96, >Text97, >Text98, >Text99, >Text100, >Text101,>Text102, >Text103, >Text104, >Text105, >Text106, >Text107, >Text108, >Text109,>Text110, >Text111
	.db >Text112, >Text113, >Text114, >Text115, >Text116, >Text117,>Text118, >Text119, >Text120, >Text121, >Text122, >Text123, >Text124, >Text125,>Text126, >Text127
	.db >Text128, >Text129, >Text130, >Text131, >Text132, >Text133,>Text134, >Text135, >Text136, >Text137, >Text138, >Text139, >Text140, >Text141,>Text142, >Text143
	.db >Text144, >Text145, >Text146, >Text147, >Text148, >Text149,>Text150, >Text151, >Text152, >Text153, >Text154, >Text155, >Text156, >Text157,>Text158, >Text159
	.db >Text160, >Text161, >Text162, >Text163, >Text164, >Text165,>Text166, >Text167, >Text168, >Text169, >Text170, >Text171, >Text172, >Text173,>Text174, >Text175
	.db >Text176, >Text177, >Text178, >Text179, >Text180, >Text181,>Text182, >Text183, >Text184, >Text185, >Text186, >Text187, >Text188, >Text189,>Text190, >Text191
	.db >Text192, >Text193, >Text194, >Text195, >Text196, >Text197,>Text198, >Text199, >Text200, >Text201, >Text202, >Text203, >Text204, >Text205,>Text206, >Text207
	.db >Text208, >Text209, >Text210, >Text211, >Text212, >Text213,>Text214, >Text215, >Text216, >Text217, >Text218, >Text219, >Text220, >Text221,>Text222, >Text223
	.db >Text224, >Text225, >Text226, >Text227, >Text228, >Text229,>Text230, >Text231, >Text232, >Text233, >Text234, >Text235, >Text236, >Text237,>Text238, >Text239
	.db >Text240, >Text241, >Text242, >Text243, >Text244, >Text245,>Text246, >Text247, >Text248, >Text249, >Text250, >Text251, >Text252, >Text253,>Text254, >Text255
	
	