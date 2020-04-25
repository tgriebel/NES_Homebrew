
;;; assumes projectile type is unlockable weapon 00000010 
LDA weaponsUnlocked
ORA #%00000010
STA weaponsUnlocked
TriggerScreen screenType
PlaySound #SFX_UNLOCK_PROJECTILES
