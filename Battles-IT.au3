#include-once

#include "FastPixel.au3"
#include "Signatures.au3"

Func ColorRange($source, $color, $delta)
	If ($source >= ($color - $delta)) And ($source <= ($color + $delta)) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func fastPixelGetColorMod($x, $y)
	Dim $p = fastPixelGetColor($x, $y)
	If ($p >= 0xF7F7F7) And ($p <= 0xFFFFFF) Then
		$p = 0xFFFFFF
	EndIf
	Return $p
EndFunc

Func SignatureMatches($sig)
	Dim $x

	For $x = 0 to Ubound($sig) - 1
		If fastPixelGetColor($sig[$x][0], $sig[$x][1]) < 0x700000 Then
			Return False
		EndIf
	Next
	Return True
EndFunc

Func IsWeepingQueen ()
	;If ((fastPixelGetColorMod(17, 78) == 0xFFFFFF) And (fastPixelGetColorMod(84, 92) == 0xFFFFFF) And (fastPixelGetColorMod(109, 92) == 0xFFFFFF) And (fastPixelGetColorMod(58, 103) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TheWeepingQueen) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsDecisiveBattle ()
	;If ((fastPixelGetColorMod(18, 82) == 0xFFFFFF) And (fastPixelGetColorMod(53, 78) == 0xFFFFFF) And (fastPixelGetColorMod(115, 78) == 0xFFFFFF) And (fastPixelGetColorMod(125, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_DecisiveBattle) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTheContract ()
	;If ((fastPixelGetColorMod(13, 84) == 0xFFFFFF) And (fastPixelGetColorMod(60, 89) == 0xFFFFFF) And (fastPixelGetColorMod(78, 81) == 0xFFFFFF) And (fastPixelGetColorMod(110, 82) == 0xFFFFFF) And (fastPixelGetColorMod(14, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TheContract) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTrampledPlains ()
	;If ((fastPixelGetColorMod(14, 83) == 0xFFFFFF) And (fastPixelGetColorMod(52, 92) == 0xFFFFFF) And (fastPixelGetColorMod(102, 80) == 0xFFFFFF) And (fastPixelGetColorMod(135, 88) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TrampledPlains) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsBrynnsResearch ()
	;If ((fastPixelGetColorMod(10, 82) == 0xFFFFFF) And (fastPixelGetColorMod(27, 91) == 0xFFFFFF) And (fastPixelGetColorMod(58, 79) == 0xFFFFFF) And (fastPixelGetColorMod(144, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_BrynnsResearch) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsKoboldChief ()
	;If ((fastPixelGetColorMod(15, 84) == 0xFFFFFF) And (fastPixelGetColorMod(44, 88) == 0xFFFFFF) And (fastPixelGetColorMod(63, 78) == 0xFFFFFF) And (fastPixelGetColorMod(110, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_KoboldChief) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsDethroneTheWhiteTyrant ()
	;If ((fastPixelGetColorMod(11, 78) == 0xFFFFFF) And (fastPixelGetColorMod(97, 78) == 0xFFFFFF) And (fastPixelGetColorMod(78, 112) == 0xFFFFFF) And (fastPixelGetColorMod(114, 103) == 0xFFFFFF)) Then
	If SignatureMatches($sig_DethroneTheWhiteTyrant) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWhiteTyrantsChallenge ()
	;If ((fastPixelGetColorMod(11, 81) == 0xFFFFFF) And (fastPixelGetColorMod(77, 92) == 0xFFFFFF) And (fastPixelGetColorMod(36, 108) == 0xFFFFFF) And (fastPixelGetColorMod(80, 108) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WhiteTyrantsChallenge) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsDeadEndStreet ()
	;If ((fastPixelGetColorMod(11, 84) == 0xFFFFFF) And (fastPixelGetColorMod(81, 79) == 0xFFFFFF) And (fastPixelGetColorMod(92, 88) == 0xFFFFFF) And (fastPixelGetColorMod(132, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_DeadEndStreet) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsBeingFromTheOtherWorld ()
	;If ((fastPixelGetColorMod(11, 83) == 0xFFFFFF) And (fastPixelGetColorMod(109, 80) == 0xFFFFFF) And (fastPixelGetColorMod(69, 102) == 0xFFFFFF) And (fastPixelGetColorMod(103, 109) == 0xFFFFFF)) Then
	If SignatureMatches($sig_BeingFromTheOtherWorld) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRegretsTooLate ()
	;If ((fastPixelGetColorMod(11, 84) == 0xFFFFFF) And (fastPixelGetColorMod(82, 88) == 0xFFFFFF) And (fastPixelGetColorMod(91, 89) == 0xFFFFFF) And (fastPixelGetColorMod(148, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_RegretsTooLate) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTheUnveilingTruth ()
	;If ((fastPixelGetColorMod(10, 78) == 0xFFFFFF) And (fastPixelGetColorMod(115, 92) == 0xFFFFFF) And (fastPixelGetColorMod(14, 102) == 0xFFFFFF) And (fastPixelGetColorMod(51, 108) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TheUnveilingTruth) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFriends ()
	;If ((fastPixelGetColorMod(11, 80) == 0xFFFFFF) And (fastPixelGetColorMod(25, 78) == 0xFFFFFF) And (fastPixelGetColorMod(63, 88) == 0xFFFFFF) And (fastPixelGetColorMod(45, 88) == 0xFFFFFF) And (fastPixelGetColorMod(70, 80) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Friends) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRevenge ()
	;If ((fastPixelGetColorMod(16, 87) == 0xFFFFFF) And (fastPixelGetColorMod(37, 82) == 0xFFFFFF) And (fastPixelGetColorMod(60, 92) == 0xFFFFFF) And (fastPixelGetColorMod(70, 87) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Revenge) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFinalSlingshot ()
	;If ((fastPixelGetColorMod(14, 78) == 0xFFFFFF) And (fastPixelGetColorMod(43, 78) == 0xFFFFFF) And (fastPixelGetColorMod(88, 91) == 0xFFFFFF) And (fastPixelGetColorMod(122, 88) == 0xFFFFFF)) Then
	If SignatureMatches($sig_finalSlingshot) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsSourceOfTheRumor ()
	;If ((fastPixelGetColorMod(14, 84) == 0xFFFFFF) And (fastPixelGetColorMod(97, 78) == 0xFFFFFF) And (fastPixelGetColorMod(17, 109) == 0xFFFFFF) And (fastPixelGetColorMod(60, 103) == 0xFFFFFF)) Then
	If SignatureMatches($sig_SourceOfTheRumor) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsPrepareForCounterattack ()
	;If ((fastPixelGetColorMod(16, 81) == 0xFFFFFF) And (fastPixelGetColorMod(76, 78) == 0xFFFFFF) And (fastPixelGetColorMod(17, 109) == 0xFFFFFF) And (fastPixelGetColorMod(117, 106) == 0xFFFFFF)) Then
	If SignatureMatches($sig_PrepareForCounterattack) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWakeUpCall ()
	;If ((fastPixelGetColorMod(18, 82) == 0xFFFFFF) And (fastPixelGetColorMod(76, 92) == 0xFFFFFF) And (fastPixelGetColorMod(112, 78) == 0xFFFFFF) And (fastPixelGetColorMod(117, 78) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WakeUpCall) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsCulpritBehindTheDisturbance ()
	;If ((fastPixelGetColorMod(17, 78) == 0xFFFFFF) And (fastPixelGetColorMod(120, 79) == 0xFFFFFF) And (fastPixelGetColorMod(90, 99) == 0xFFFFFF) And (fastPixelGetColorMod(133, 104) == 0xFFFFFF)) Then
	If SignatureMatches($sig_CulpritBehindTheDisturbance) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsSpiderOverload ()
	;If ((fastPixelGetColorMod(15, 86) == 0xFFFFFF) And (fastPixelGetColorMod(19, 92) == 0xFFFFFF) And (fastPixelGetColorMod(105, 78) == 0xFFFFFF) And (fastPixelGetColorMod(134, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_SpiderOverload) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsDepthsOfAinle ()
	;If ((fastPixelGetColorMod(17, 80) == 0xFFFFFF) And (fastPixelGetColorMod(32, 92) == 0xFFFFFF) And (fastPixelGetColorMod(106, 78) == 0xFFFFFF) And (fastPixelGetColorMod(131, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_DepthsOfAinle) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsBurntPumpkinField ()
	;If ((fastPixelGetColorMod(16, 84) == 0xFFFFFF) And (fastPixelGetColorMod(114, 78) == 0xFFFFFF) And (fastPixelGetColorMod(95, 92) == 0xFFFFFF) And (fastPixelGetColorMod(43, 99) == 0xFFFFFF)) Then
	If SignatureMatches($sig_BurntPumpkinField) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsHolyGround ()
	;If ((fastPixelGetColorMod(18, 83) == 0xFFFFFF) And (fastPixelGetColorMod(38, 92) == 0xFFFFFF) And (fastPixelGetColorMod(60, 79) == 0xFFFFFF) And (fastPixelGetColorMod(107, 78) == 0xFFFFFF)) Then
	If SignatureMatches($sig_HolyGround) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsShadowedByDarkness ()
	;If ((fastPixelGetColorMod(15, 86) == 0xFFFFFF) And (fastPixelGetColorMod(110, 90) == 0xFFFFFF) And (fastPixelGetColorMod(38, 99) == 0xFFFFFF) And (fastPixelGetColorMod(75, 105) == 0xFFFFFF)) Then
	If SignatureMatches($sig_ShadowedByDarkness) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWhereTheLegendSleeps ()
	;If ((fastPixelGetColorMod(14, 87) == 0xFFFFFF) And (fastPixelGetColorMod(76, 79) == 0xFFFFFF) And (fastPixelGetColorMod(26, 113) == 0xFFFFFF) And (fastPixelGetColorMod(113, 108) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WhereTheLegendSleeps) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFomorianOrder ()
	;If ((fastPixelGetColorMod(12, 83) == 0xFFFFFF) And (fastPixelGetColorMod(60, 78) == 0xFFFFFF) And (fastPixelGetColorMod(93, 78) == 0xFFFFFF) And (fastPixelGetColorMod(130, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_FomorianOrder) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsPrairieGnoll ()
	;If ((fastPixelGetColorMod(14, 84) == 0xFFFFFF) And (fastPixelGetColorMod(47, 78) == 0xFFFFFF) And (fastPixelGetColorMod(69, 79) == 0xFFFFFF) And (fastPixelGetColorMod(104, 80) == 0xFFFFFF)) Then
	If SignatureMatches($sig_PrairieGnoll) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRuinsOfSanctity ()
	;If ((fastPixelGetColorMod(16, 82) == 0xFFFFFF) And (fastPixelGetColorMod(32, 78) == 0xFFFFFF) And (fastPixelGetColorMod(71, 78) == 0xFFFFFF) And (fastPixelGetColorMod(137, 92) == 0xFFFFFF)) Then
	If SignatureMatches($sig_RuinsOfSanctity) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsGoliath ()
	;If ((fastPixelGetColorMod(10, 84) == 0xFFFFFF) And (fastPixelGetColorMod(32, 88) == 0xFFFFFF) And (fastPixelGetColorMod(37, 78) == 0xFFFFFF) And (fastPixelGetColorMod(64, 87) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Goliath) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsHidden ()
	;If ((fastPixelGetColorMod(14, 83) == 0xFFFFFF) And (fastPixelGetColorMod(33, 78) == 0xFFFFFF) And (fastPixelGetColorMod(43, 78) == 0xFFFFFF) And (fastPixelGetColorMod(63, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Hidden) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsNightmareAtTheRuins ()
	;If ((fastPixelGetColorMod(15, 83) == 0xFFFFFF) And (fastPixelGetColorMod(128, 78) == 0xFFFFFF) And (fastPixelGetColorMod(35, 91) == 0xFFFFFF) And (fastPixelGetColorMod(50, 106) == 0xFFFFFF)) Then
	If SignatureMatches($sig_NightmareAtTheRuins) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsGnollKingRulerOfTheRuins ()
	;If ((fastPixelGetColorMod(17, 87) == 0xFFFFFF) And (fastPixelGetColorMod(96, 88) == 0xFFFFFF) And (fastPixelGetColorMod(22, 98) == 0xFFFFFF) And (fastPixelGetColorMod(103, 108) == 0xFFFFFF)) Then
	If SignatureMatches($sig_GnollKingRulerOfTheRuins) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsHoarfrostHollowInFlames ()
	;If ((fastPixelGetColorMod(18, 80) == 0xFFFFFF) And (fastPixelGetColorMod(119, 78) == 0xFFFFFF) And (fastPixelGetColorMod(10, 99) == 0xFFFFFF) And (fastPixelGetColorMod(79, 106) == 0xFFFFFF) And (fastPixelGetColorMod(99, 78) == 0xFFFFFF)) Then
	If SignatureMatches($sig_HoarfrostHollowInFlames) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsYetiKing ()
	;If ((fastPixelGetColorMod(14, 84) == 0xFFFFFF) And (fastPixelGetColorMod(37, 78) == 0xFFFFFF) And (fastPixelGetColorMod(75, 92) == 0xFFFFFF) And (fastPixelGetColorMod(80, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_YetiKing) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsMadness ()
	;If ((fastPixelGetColorMod(15, 86) == 0xFFFFFF) And (fastPixelGetColorMod(36, 88) == 0xFFFFFF) And (fastPixelGetColorMod(58, 85) == 0xFFFFFF) And (fastPixelGetColorMod(75, 85) == 0xFFFFFF) And (fastPixelGetColorMod(21, 79) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Madness) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsIrukul ()
	;If ((fastPixelGetColorMod(10, 78) == 0xFFFFFF) And (fastPixelGetColorMod(33, 78) == 0xFFFFFF) And (fastPixelGetColorMod(34, 85) == 0xFFFFFF) And (fastPixelGetColorMod(53, 79) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Irukul) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRevivedFear ()
	;If ((fastPixelGetColorMod(15, 84) == 0xFFFFFF) And (fastPixelGetColorMod(41, 78) == 0xFFFFFF) And (fastPixelGetColorMod(82, 78) == 0xFFFFFF) And (fastPixelGetColorMod(108, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_RevivedFear) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsUnfinishedBusiness ()
	;If ((fastPixelGetColorMod(18, 87) == 0xFFFFFF) And (fastPixelGetColorMod(56, 78) == 0xFFFFFF) And (fastPixelGetColorMod(69, 77) == 0xFFFFFF) And (fastPixelGetColorMod(73, 106) == 0xFFFFFF)) Then
	If SignatureMatches($sig_UnfinishedBusiness) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTheHowlingSoul ()
	;If ((fastPixelGetColorMod(13, 83) == 0xFFFFFF) And (fastPixelGetColorMod(89, 78) == 0xFFFFFF) And (fastPixelGetColorMod(105, 92) == 0xFFFFFF) And (fastPixelGetColorMod(149, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TheHowlingSoul) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTwoMoons ()
	;If ((fastPixelGetColorMod(14, 80) == 0xFFFFFF) And (fastPixelGetColorMod(63, 79) == 0xFFFFFF) And (fastPixelGetColorMod(84, 86) == 0xFFFFFF) And (fastPixelGetColorMod(101, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TwoMoons) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsAppearanceOfASmallBear ()
	;If ((fastPixelGetColorMod(13, 79) == 0xFFFFFF) And (fastPixelGetColorMod(135, 84) == 0xFFFFFF) And (fastPixelGetColorMod(49, 99) == 0xFFFFFF) And (fastPixelGetColorMod(90, 103) == 0xFFFFFF)) Then
	If SignatureMatches($sig_AppearanceOfASmallBear) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsSnowmanAlert ()
	;If ((fastPixelGetColorMod(13, 84) == 0xFFFFFF) And (fastPixelGetColorMod(98, 79) == 0xFFFFFF) And (fastPixelGetColorMod(108, 78) == 0xFFFFFF) And (fastPixelGetColorMod(130, 82) == 0xFFFFFF)) Then
	If SignatureMatches($sig_SnowmanAlert) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsProofOfCourage ()
	;If ((fastPixelGetColorMod(16, 82) == 0xFFFFFF) And (fastPixelGetColorMod(49, 77) == 0xFFFFFF) And (fastPixelGetColorMod(69, 78) == 0xFFFFFF) And (fastPixelGetColorMod(140, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_ProofOfCourage) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFightThatMustBeWon ()
	;If ((fastPixelGetColorMod(11, 79) == 0xFFFFFF) And (fastPixelGetColorMod(23, 91) == 0xFFFFFF) And (fastPixelGetColorMod(33, 79) == 0xFFFFFF) And (fastPixelGetColorMod(69, 103) == 0xFFFFFF)) Then
	If SignatureMatches($sig_FightThatMustBeWon) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsShadyForest ()
	;If ((fastPixelGetColorMod(13, 84) == 0xFFFFFF) And (fastPixelGetColorMod(44, 78) == 0xFFFFFF) And (fastPixelGetColorMod(50, 90) == 0xFFFFFF) And (fastPixelGetColorMod(106, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_ShadyForest) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWestHilderForest ()
	;If ((fastPixelGetColorMod(18, 82) == 0xFFFFFF) And (fastPixelGetColorMod(71, 78) == 0xFFFFFF) And (fastPixelGetColorMod(86, 78) == 0xFFFFFF) And (fastPixelGetColorMod(154, 82) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WestHilderForest) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsForestRuins ()
	;If ((fastPixelGetColorMod(13, 78) == 0xFFFFFF) And (fastPixelGetColorMod(52, 80) == 0xFFFFFF) And (fastPixelGetColorMod(70, 80) == 0xFFFFFF) And (fastPixelGetColorMod(103, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_ForestRuins) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsContact ()
	;If ((fastPixelGetColorMod(16, 78) == 0xFFFFFF) And (fastPixelGetColorMod(42, 81) == 0xFFFFFF) And (fastPixelGetColorMod(52, 86) == 0xFFFFFF) And (fastPixelGetColorMod(67, 80) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Contact) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsCadetsChallenge ()
	;If ((fastPixelGetColorMod(13, 78) == 0xFFFFFF) And (fastPixelGetColorMod(57, 79) == 0xFFFFFF) And (fastPixelGetColorMod(136, 92) == 0xFFFFFF) And (fastPixelGetColorMod(145, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_CadetsChallenge) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsLostRoad ()
	;If ((fastPixelGetColorMod(15, 89) == 0xFFFFFF) And (fastPixelGetColorMod(36, 81) == 0xFFFFFF) And (fastPixelGetColorMod(51, 78) == 0xFFFFFF) And (fastPixelGetColorMod(84, 78) == 0xFFFFFF)) Then
	If SignatureMatches($sig_LostRoad) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsBuriedSorrow ()
	;If ((fastPixelGetColorMod(15, 84) == 0xFFFFFF) And (fastPixelGetColorMod(37, 78) == 0xFFFFFF) And (fastPixelGetColorMod(67, 80) == 0xFFFFFF) And (fastPixelGetColorMod(118, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_BuriedSorrow) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRocktunesCabin ()
	;If ((fastPixelGetColorMod(15, 85) == 0xFFFFFF) And (fastPixelGetColorMod(87, 79) == 0xFFFFFF) And (fastPixelGetColorMod(136, 78) == 0xFFFFFF) And (fastPixelGetColorMod(147, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_RocktunesCabin) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsColhenInFlames ()
	;If ((fastPixelGetColorMod(16, 78) == 0xFFFFFF) And (fastPixelGetColorMod(32, 77) == 0xFFFFFF) And (fastPixelGetColorMod(101, 77) == 0xFFFFFF) And (fastPixelGetColorMod(142, 88) == 0xFFFFFF)) Then
	If SignatureMatches($sig_ColhenInFlames) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRescue ()
	;If ((fastPixelGetColorMod(16, 81) == 0xFFFFFF) And (fastPixelGetColorMod(33, 82) == 0xFFFFFF) And (fastPixelGetColorMod(48, 88) == 0xFFFFFF) And (fastPixelGetColorMod(62, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Rescue) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsStoreroom()
	;If ((fastPixelGetColorMod(15, 86) == 0xFFFFFF) And (fastPixelGetColorMod(36, 87) == 0xFFFFFF) And (fastPixelGetColorMod(60, 82) == 0xFFFFFF) And (fastPixelGetColorMod(89, 84) == 0xFFFFFF) And (fastPixelGetColorMod(45, 89) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Storeroom) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTheLastFragment()
	;If ((fastPixelGetColorMod(14, 79) == 0xFFFFFF) And (fastPixelGetColorMod(47, 78) == 0xFFFFFF) And (fastPixelGetColorMod(107, 92) == 0xFFFFFF) And (fastPixelGetColorMod(152, 80) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TheLastFragment) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTheInvestigation()
	;If ((fastPixelGetColorMod(18, 78) == 0xFFFFFF) And (fastPixelGetColorMod(96, 78) == 0xFFFFFF) And (fastPixelGetColorMod(101, 92) == 0xFFFFFF) And (fastPixelGetColorMod(147, 83) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TheInvestigation) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsInvestigation()
	;If ((fastPixelGetColorMod(10, 78) == 0xFFFFFF) And (fastPixelGetColorMod(60, 78) == 0xFFFFFF) And (fastPixelGetColorMod(64, 91) == 0xFFFFFF) And (fastPixelGetColorMod(111, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Investigation) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsMercenaryTrainingSite()
	;If ((fastPixelGetColorMod(21, 79) == 0xFFFFFF) And (fastPixelGetColorMod(86, 91) == 0xFFFFFF) And (fastPixelGetColorMod(37, 99) == 0xFFFFFF) And (fastPixelGetColorMod(103, 107) == 0xFFFFFF)) Then
	If SignatureMatches($sig_MercenaryTrainingSite) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFruitful()
	;If ((fastPixelGetColorMod(14, 78) == 0xFFFFFF) And (fastPixelGetColorMod(35, 78) == 0xFFFFFF) And (fastPixelGetColorMod(49, 77) == 0xFFFFFF) And (fastPixelGetColorMod(64, 77) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Fruitful) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsPursuit()
	;If ((fastPixelGetColorMod(16, 82) == 0xFFFFFF) And (fastPixelGetColorMod(55, 78) == 0xFFFFFF) And (fastPixelGetColorMod(59, 82) == 0xFFFFFF) And (fastPixelGetColorMod(60, 80) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Pursuit) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsChicanery()
	;If ((fastPixelGetColorMod(17, 79) == 0xFFFFFF) And (fastPixelGetColorMod(22, 77) == 0xFFFFFF) And (fastPixelGetColorMod(49, 84) == 0xFFFFFF) And (fastPixelGetColorMod(80, 92) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Chicanery) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTheSecret()
	;If ((fastPixelGetColorMod(18, 78) == 0xFFFFFF) And (fastPixelGetColorMod(22, 77) == 0xFFFFFF) And (fastPixelGetColorMod(49, 78) == 0xFFFFFF) And (fastPixelGetColorMod(88, 80) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TheSecret) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsTakingInitiative()
	;If ((fastPixelGetColorMod(18, 78) == 0xFFFFFF) And (fastPixelGetColorMod(55, 91) == 0xFFFFFF) And (fastPixelGetColorMod(119, 78) == 0xFFFFFF) And (fastPixelGetColorMod(139, 84) == 0xFFFFFF)) Then
	If SignatureMatches($sig_TakingInitiative) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsAmbush()
	;If ((fastPixelGetColorMod(18, 89) == 0xFFFFFF) And (fastPixelGetColorMod(39, 79) == 0xFFFFFF) And (fastPixelGetColorMod(67, 77) == 0xFFFFFF) And (fastPixelGetColorMod(72, 87) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Ambush) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsStrongDrink()
	;If ((fastPixelGetColorMod(13, 84) == 0xFFFFFF) And (fastPixelGetColorMod(53, 92) == 0xFFFFFF) And (fastPixelGetColorMod(102, 78) == 0xFFFFFF) And (fastPixelGetColorMod(107, 88) == 0xFFFFFF)) Then
	If SignatureMatches($sig_StrongDrink) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWhatTheDeadLeaveBehind()
	;If ((fastPixelGetColorMod(18, 80) == 0xFFFFFF) And (fastPixelGetColorMod(93, 79) == 0xFFFFFF) And (fastPixelGetColorMod(61, 99) == 0xFFFFFF) And (fastPixelGetColorMod(111, 99) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WhatTheDeadLeaveBehind) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsGatekeeperOfTheCatacombs()
	;If ((fastPixelGetColorMod(17, 84) == 0xFFFFFF) And (fastPixelGetColorMod(75, 92) == 0xFFFFFF) And (fastPixelGetColorMod(45, 99) == 0xFFFFFF) And (fastPixelGetColorMod(123, 106) == 0xFFFFFF)) Then
	If SignatureMatches($sig_GateKeeperOfTheCatacombs) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRedRuins()
	;If ((fastPixelGetColorMod(15, 84) == 0xFFFFFF) And (fastPixelGetColorMod(36, 78) == 0xFFFFFF) And (fastPixelGetColorMod(52, 80) == 0xFFFFFF) And (fastPixelGetColorMod(87, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_RedRuins) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFomorianEmblem()
	;If ((fastPixelGetColorMod(14, 78) == 0xFFFFFF) And (fastPixelGetColorMod(60, 78) == 0xFFFFFF) And (fastPixelGetColorMod(115, 78) == 0xFFFFFF) And (fastPixelGetColorMod(149, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_FomorianEmblem) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsAnotherSlingshot()
	;If ((fastPixelGetColorMod(11, 78) == 0xFFFFFF) And (fastPixelGetColorMod(110, 91) == 0xFFFFFF) And (fastPixelGetColorMod(128, 78) == 0xFFFFFF) And (fastPixelGetColorMod(149, 81) == 0xFFFFFF)) Then
	If SignatureMatches($sig_AnotherSlingshot) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsHoarfrostHollow()
	;If ((fastPixelGetColorMod(17, 78) == 0xFFFFFF) And (fastPixelGetColorMod(49, 80) == 0xFFFFFF) And (fastPixelGetColorMod(114, 79) == 0xFFFFFF) And (fastPixelGetColorMod(145, 82) == 0xFFFFFF)) Then
	If SignatureMatches($sig_HoarfrostHollow) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWindgun()
	;If ((fastPixelGetColorMod(25, 79) == 0xFFFFFF) And (fastPixelGetColorMod(50, 78) == 0xFFFFFF) And (fastPixelGetColorMod(54, 91) == 0xFFFFFF) And (fastPixelGetColorMod(79, 82) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Windgun) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsGwynnsRequest()
	;If ((fastPixelGetColorMod(17, 85) == 0xFFFFFF) And (fastPixelGetColorMod(38, 91) == 0xFFFFFF) And (fastPixelGetColorMod(92, 78) == 0xFFFFFF) And (fastPixelGetColorMod(147, 82) == 0xFFFFFF)) Then
	If SignatureMatches($sig_GwynnsRequest) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWhereTheSunDontShine()
	;If ((fastPixelGetColorMod(17, 79) == 0xFFFFFF) And (fastPixelGetColorMod(76, 78) == 0xFFFFFF) And (fastPixelGetColorMod(44, 99) == 0xFFFFFF) And (fastPixelGetColorMod(96, 107) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WhereTheSunDontShine) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWhereTheRoadLeads()
	;If ((fastPixelGetColorMod(17, 81) == 0xFFFFFF) And (fastPixelGetColorMod(14, 109) == 0xFFFFFF) And (fastPixelGetColorMod(106, 80) == 0xFFFFFF) And (fastPixelGetColorMod(49, 106) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WhereTheRoadLeads) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWesternIcePassage()
	;If ((fastPixelGetColorMod(17, 82) == 0xFFFFFF) And (fastPixelGetColorMod(85, 79) == 0xFFFFFF) And (fastPixelGetColorMod(53, 112) == 0xFFFFFF) And (fastPixelGetColorMod(63, 108) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WesternIcePassage) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWetDarkAndMossy()
	;If ((fastPixelGetColorMod(17, 82) == 0xFFFFFF) And (fastPixelGetColorMod(46, 88) == 0xFFFFFF) And (fastPixelGetColorMod(95, 89) == 0xFFFFFF) And (fastPixelGetColorMod(55, 109) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WetDarkAndMossy) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsHabitatForWildPlants()
	;If ((fastPixelGetColorMod(17, 84) == 0xFFFFFF) And (fastPixelGetColorMod(20, 99) == 0xFFFFFF) And (fastPixelGetColorMod(137, 78) == 0xFFFFFF) And (fastPixelGetColorMod(55, 108) == 0xFFFFFF)) Then
	If SignatureMatches($sig_HabitatForWildPlants) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsGiveABeggarACoin()
	;If ((fastPixelGetColorMod(18, 84) == 0xFFFFFF) And (fastPixelGetColorMod(93, 91) == 0xFFFFFF) And (fastPixelGetColorMod(47, 109) == 0xFFFFFF) And (fastPixelGetColorMod(59, 109) == 0xFFFFFF)) Then
	If SignatureMatches($sig_GiveABeggarACoin) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsGremlinLair()
	;If ((fastPixelGetColorMod(17, 85) == 0xFFFFFF) And (fastPixelGetColorMod(53, 78) == 0xFFFFFF) And (fastPixelGetColorMod(79, 79) == 0xFFFFFF) And (fastPixelGetColorMod(104, 82) == 0xFFFFFF)) Then
	If SignatureMatches($sig_GremlinLair) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsBandits()
	;If ((fastPixelGetColorMod(11, 83) == 0xFFFFFF) And (fastPixelGetColorMod(45, 78) == 0xFFFFFF) And (fastPixelGetColorMod(50, 78) == 0xFFFFFF) And (fastPixelGetColorMod(65, 87) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Bandits) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsAnotherStoreroom()
	;If ((fastPixelGetColorMod(14, 78) == 0xFFFFFF) And (fastPixelGetColorMod(51, 78) == 0xFFFFFF) And (fastPixelGetColorMod(84, 78) == 0xFFFFFF) And (fastPixelGetColorMod(160, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_AnotherStoreroom) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsHerbLands()
	;If ((fastPixelGetColorMod(15, 83) == 0xFFFFFF) And (fastPixelGetColorMod(39, 77) == 0xFFFFFF) And (fastPixelGetColorMod(54, 79) == 0xFFFFFF) And (fastPixelGetColorMod(93, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_HerbLands) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsRockyWilderness()
	;If ((fastPixelGetColorMod(15, 85) == 0xFFFFFF) And (fastPixelGetColorMod(50, 92) == 0xFFFFFF) And (fastPixelGetColorMod(89, 79) == 0xFFFFFF) And (fastPixelGetColorMod(150, 87) == 0xFFFFFF)) Then
	If SignatureMatches($sig_RockyWilderness) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsSewers()
	;If ((fastPixelGetColorMod(13, 84) == 0xFFFFFF) And (fastPixelGetColorMod(34, 84) == 0xFFFFFF) And (fastPixelGetColorMod(43, 86) == 0xFFFFFF) And (fastPixelGetColorMod(61, 85) == 0xFFFFFF)) Then
	If SignatureMatches($sig_Sewers) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsBeginningOfTheMemory()
	;If ((fastPixelGetColorMod(15, 88) == 0xFFFFFF) And (fastPixelGetColorMod(29, 92) == 0xFFFFFF) And (fastPixelGetColorMod(106, 78) == 0xFFFFFF) And (fastPixelGetColorMod(68, 112) == 0xFFFFFF)) Then
	If SignatureMatches($sig_BeginningOfTheMemory) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsGoldLeather()
	;If ((fastPixelGetColorMod(16, 78) == 0xFFFFFF) And (fastPixelGetColorMod(32, 78) == 0xFFFFFF) And (fastPixelGetColorMod(53, 78) == 0xFFFFFF) And (fastPixelGetColorMod(107, 82) == 0xFFFFFF)) Then
	If SignatureMatches($sig_GoldLeather) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsWindThroughTheRuins()
	;If ((fastPixelGetColorMod(17, 79) == 0xFFFFFF) And (fastPixelGetColorMod(119, 78) == 0xFFFFFF) And (fastPixelGetColorMod(14, 99) == 0xFFFFFF) And (fastPixelGetColorMod(85, 106) == 0xFFFFFF)) Then
	If SignatureMatches($sig_WindThroughTheRuins) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFrostStones()
	;If ((fastPixelGetColorMod(10, 78) == 0xFFFFFF) And (fastPixelGetColorMod(44, 82) == 0xFFFFFF) And (fastPixelGetColorMod(55, 79) == 0xFFFFFF) And (fastPixelGetColorMod(103, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_FrostStones) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsATownEngulfed()
	;If ((fastPixelGetColorMod(10, 78) == 0xFFFFFF) And (fastPixelGetColorMod(44, 82) == 0xFFFFFF) And (fastPixelGetColorMod(55, 79) == 0xFFFFFF) And (fastPixelGetColorMod(103, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_ATownEngulfed) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsHellBeyondTheDoor()
	;If ((fastPixelGetColorMod(10, 78) == 0xFFFFFF) And (fastPixelGetColorMod(44, 82) == 0xFFFFFF) And (fastPixelGetColorMod(55, 79) == 0xFFFFFF) And (fastPixelGetColorMod(103, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_HellBeyondTheDoor) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsResenliansLabyrinth()
	;If ((fastPixelGetColorMod(10, 78) == 0xFFFFFF) And (fastPixelGetColorMod(44, 82) == 0xFFFFFF) And (fastPixelGetColorMod(55, 79) == 0xFFFFFF) And (fastPixelGetColorMod(103, 86) == 0xFFFFFF)) Then
	If SignatureMatches($sig_ResenliansLabyrinth) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsSouthernRockCliff()
	If SignatureMatches($sig_SouthernRockCliff) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsFriendOrFoe()
	If SignatureMatches($sig_FriendOrFoe) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsPiercingTheCrescentMoon()
	If SignatureMatches($sig_PiercingTheCrescentMoon) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsUlchassRelic()
	If SignatureMatches($sig_UlchasRelic) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsEllissTrust()
	If SignatureMatches($sig_EllissTrust) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func IsBloodPrince()
	If SignatureMatches($sig_BloodPrince) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

