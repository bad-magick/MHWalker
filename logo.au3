#include-once
; #INDEX# =======================================================================================================================
; Title .........: _logo()
; AutoIt Version.: 3.3.6.1
; Language.......: English (United States) - 0409
; Description ...: Compressed file embedded
; Author ........: Den
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _logo()
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __logo() ; _LZNTDecompress renamed!
; __logo() ; _Base64 renamed!
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _logo()
; Description ...: Compressed file embedded in your .au3 file
; Syntax ........: _logo( [ lToSave [, sPath [, lExecute ]]] )
; Parameters ....: lToSave             - [optional] If True, save the file, else, return binary data. Default is False.
;                  sPath               - [optional] The path of the file to be save. Default is @TempDir
;                  lExecute            - [optional] Flag to execute file saved. Default is False
; Return values .: Success             - Returns decompressed logo.jpg binary data or saved.
;				     Failure             - Returns 0 and set @error to 1.
; Author(s) .....: João Carlos (Jscript FROM Brazil)
; Modified ......: 
; Remarks .......: This function uses _LZNTDecompress() and _Base64Decode() by trancexx.
; Related .......: 
; Link ..........: 
; Example .......; _logo()
; ===============================================================================================================================
Func _logo( $lToSave = False, $sPath = @TempDir, $lExecute = False )
	Local $hFileHwnd, $bData, $sFileName = $sPath & "\logo.jpg"

	; Original: C:\Users\Den\Desktop\New Shit\logo.jpg
	$bData = "/z//2P/gABBKRklGAAEBAAABAAEAAP/+ADtDUkVBVE9SOiBnZC1qcGVnIHYxLjAgKHVzaW5nIElKRyBKUEVHIHY2MiksIHF1YWxpdHkgPSA4MAr/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAEIAQQDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc"
	$bData &= "3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD6pooooAKKKKACiiigAooooAKzvEUYm8P6nGejW0i/+OmtGqetHGj33/XCT/0E0AfKyjnFW4Rg1DGuTxirkScdKA"
	$bData &= "NGzBOO9WryH93kAVWsuuB1qe9lIULQByep/urgc9TVWzYfa5COuR/KrOsZaVCO1Z+mMW1KZfoaAOy05SyrV6dMLxVXTRhRVq5fHFAFBuM4qtN2q444JqpMMc4oAt+D7QX3jDS4CMq04Zh7Lyf5V9KV4J8J4hJ44tmb/lnHIw/75x/Wve6ACiiigAooooAKKKKACiiigBKKWigBKKKKAFooooAKKKKACiiigAooooAKyPF062/hfVZWOALaTH1KkD9TWua8++Mmqi08NrZI2JbtwpH+yOT/AEoA8Xt0yBxWhHHgZxVeyj+UGtKOIsOlABaxtncMgVHfFvuitGIBU449aq3RXd70Ac7qEO3BPJrB0p1XWZwx5wAK6DVZQB16VmahoVzpEmk3twGA1GAzjPb5iAP++dp/GgDrLBxgc1ZuzuHHWsrTJMgA9a2jEGAPBNAGe2QKhZSetajwgjpUDxYXpQBqfC64W38cWyk4EyPHz64z/Sveq+Z"
	$bData &= "be5fTdVtb2Lh4JFkH4GvpGwvI72zhuYDujlQOpB7GgCzRRRQAUUUUAFFFFABRRRQAUUUUAJRS0UAFFFFABRRRQAUUUUAFFFBoARiFUknAHJzXzv4913/hIfEkkkZJtYf3UPuB1b8TXqHxW8QHSfD7W0D7bm8zGCOqr3P9K8PsI8tn1oA1bSPIUVeClRxSWcXSrskYUcigCqWwPmrKvZTuPpWpP0rFv2wCe1AFTS7CTXfEFlp0fPnyhWPoo5J/KvXvjL4fW48IQT2sfz6YQVAH/LPGCP0B/CsD4F6SLjVdR1iVcrABBEcfxHlsfQY/OvZLy2iu7WWCdd0cilGB7g0AfL2nyBkUgiuhs3JUAYyawNX06TQPEN7pk2cwyEIT/Ep5U/kRWhYXHQH86ANVuuKZIOMVKCHwT1pHjPJoAx72MFTmvQvhD4kAzod45DDLW7Mevqv171w91GSKzC0trcJPAxSWNgysOoIoA+oM0tcx4E8SJ4i0hJSQ"
	$bData &= "t3FhJk9D6/Q102aAFopKWgAooooAKKKKACiiigBKKWigAoooPSgAopB1paACikNKKACg9KKwPG2pHSfDV9dK2JNhRP8AebigDxP4j6yda8UXLI2beAmGL0IBwT+JrL0+MjBFUMGR+ckk5Oe9bmnR8AYoA2bGP5QTS3ZxU8PyRiqN24JJNAFWdxtrA1WUBCBWlcyYzWba2r6nrNlZIOZ5lTHtnmgD3z4YaWNK8GWEZXbJMvnyeu5uf5YFdYelR28SwwRxIMKihR9AKkoA8k+N+hb4rfW4F+aL9zNj+7/CfwP8682sJOlfS2tadDqulXNjcDMc6FD7e9fM7QS6ZqdzYXORNbyGNh9O/wCPWgDehkOBV6Ih161kwvlRitGyb5hQASxZBrIvITkjFdJIm5OBWJqskdtDJLMyqqDJJPSgOuhV8P8Aik+DtWW9YF4H/dyxA4LA/wBRX0B4b1u18QaVDqFg7Nby5AJGDkHBr5QFnNrV/wDbLglLB"
	$bData &= "P8AVIOsnufavb/gvrgCS6HPtHl5kt/p/Ev9aRvONOMFFfF1PVhS0gpaZgFFFFABRRRQAUUUUAJRQaKAFooooAKKKKACiiigAry/426iUs7GwU8yMZGHsOBXqFeDfFu8+0+M5ogflt4kjH5bj/6F+lAHH2y7pM4rodPTGKxLMfNXR6eo4NAF2Q/JWTdSda0rtwFIrDupcA5oAp3UoANb/wAH7H+0fG/nsMx2UTS/8CPyj+ZP4VyV5ISCa9V+ANkE0nVL8j5p5xGp9lH+LH8qAPWKKKQsKAA9K8V+Nuh/ZdTttbgTEc+IpiB0YdCfw/lXs7yKilnYKoGSScAV5L8V/iP4R/4R6+0w3Y1C6cBUS1+fa/VTu6flQxpOWx59Zz5Qc1q2k6qdxOAOtcRHqiWa/vy6ydGjI+YEdiOxqG7uLvV7ZFs5TuZsNCOMD1JqXJdDqo4OdS0paRfV7Hdax4p03TLYvJMJJSPkii+ZmPsKyF0m78RJFd6yrQ"
	$bData &= "Wud6WYP3h23/4U3wr4Zgspo7m8xLcqdwA+6K7aQhkoV2tRVlTpScaMubz/AMjnbu3RIwiKFVRgADoKq6TfSaTrFtexEhoZA3Hcdx+Va12uQa5rUZFEvlp8zHgAVRyn1JZzpc20U8ZykiBgfYip68g+Gfjvy1t9G1cqpUiOKQ8YHQA/r+devKcjNAC0UUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUlAC182eNZ/P8Xas/rcMv5HA/lXsnjPx5p3heTyJ1ae627vLQj5R2ye1eBT6h/aV/Pd42meRpCvpk5oAu2K5xXQ2PFY1kowK2oflQ4oAj1F8A1zl7NyR1rT1KbrzzWDI258ZoArXsm2Fj7V9HfDfTP7I8F6bAy7ZGj81x/tNz/WvmTVrvyGjICsQ68N0PPeuu8SfHbUIdLez020gW6KhRLDlhH/AEpN2RcKbm7I9x8W+N9E8KxKdWusTN92CMbpD747CvL/ABv8ftKtdJK+GIpZ9Uc"
	$bData &= "4CXMe1UHqcHn6V86Xc+p6rcy3WoXL7pDuZmbJJ9TmpNOtkaZY7VTIwOSw4A/GsJV1E+goZBUqpN3Xr+iNfxL4m8ReMNRj/tnU5vs+wgDJSOPPOdq1Y0bWNR0CAWXhaysjIXJ+2S2yyXDMe6Eg7R6AVk3Ei2zMszhJM8YGd30r2L4a+OtE8O+H7dRovnajlvNugygscnoTyBjjFFOq6j0OjNMBh8BT5ndtvToedXnhzxTbNBeeIrV7X7YSwlmJLse+R1z9a6PRYo7KIIn3upbuTXVfEL4j2niXQjZjS2jkSRZI5TICVI68fSuKtpt8YYHkitlFLU+erY2tWiqc5XSOttLjpzWlJfxQwF5WCqPWuOhumUYXk1YsrO51S6VSTwcZPRf/AK9Ucpbn1CfUJvJs4+vGSK0rXSG0qcLMiyzyryx659B6GrkFkdJZo4FRJogJMtyXBq9L5SwKuBJvxNPM5+6P8etAHN6jpst1CLmzU+dF99RwR6H9"
	$bData &= "K9L+Fvjb+0LZNL1VsXkY2xyE/wCsHofeuM8RXRnsBPZvHHpkgCzShSJHPIIAOOgwfxrhtP1Cay1GO8tsCSGQMpxgccjj0oA+thS1xvw88Zx+KLN0mRIb+HG+MHhh/eFdkOlABRRRQAUUUUAIaKWigAooooAKKKKACqOs38emWE11KRhBwPU9hV6vNvidqSS6jBpaTgMkfmug65J4/T+dAHj/AI0mnu9Vl1C5Yulx95vQ9v0xisfTsxzlM5HUH1Fdhdx299bTRw/MDkurH5lPY+3A4rkoEW3fYzkgHAY0AdPYtkCtdnxCfpWBYTxHaBIo9iavajeRW1oZJpFSMDJYmgDPvpMliTWV5yorOxAA6k1jX3imxm3/AGaR5FH8QXC/ma5XUNemu8xwK8oHZB8o+pqJStojvw2BdS0qj5Y+e79DQ1+7iuZvnw8C988Zrn5tSUD/AEdA3vjgVFcRTy7DPJ95gNi8Ct6a3t7a1SMKjcciuKrU1118j"
	$bData &= "7TLsBGnD9zHlXd6v7uhk2jC4bN0xYnoM8Ct60kS3gIjIGBg4rAvNq4dAAB2qFtSwpUDrWLhzanrQqxo6PfuLqFwsmoKwJIBA5r0/wAN2Vm3h22uJbuNJGL/ACEjPBOP1xXjhkLSg55zXaaPeX00HkQKqxxHaHwScnkdveuvDqzPk+IJ89JPzO9kh0lPJ3XDSqApKqDycZP68Vj2AWS9mS1VhbA5Vn4wK53S9RvNQuHSTJKtsG3oT611FhZv5iQI5P8AfI6D1NdZ8kbOl2S3LnJ2W6HBf+8fauus9PmErpZbBFAM71HAJ689zVeWysrOK1iW4hSMR7pWdsBR2Y/jxU83iA2MTWkE0CLAihn2FzKSM8YPA96AL+oppcNpbfaJZHuZ3+VhyzHqfYCuf1bWVSeOK0JNuAfkt5F2N7lsZJzz2/GuV1DU0kgjiljj3Dl3xueRueSe3WqnmyzAEL5UR6DuaALMs3mzEuS+TyCxPP1PWqcgw5CDC9"
	$bData &= "Kk+VU5496ppKGdowcsvPHegDc8M63PoOr299bP80Z+Zezr3WvqXTL2LUdPt7y2YNDPGJEPsRXyG0iImMdq96+Betf2h4bmsnb95aScA/3W5/nmgD02iiigAooooAKKKKACiiigAooyB1NZ19rWmWKbru/tol9WkAoAuzSLEjPIwVFGSScAV83fEzX7XUvGM15pW4KiiNpQ332HGR6DFdb8ZPGNpf6DDY6FfiYyS/vzFn7oHA9xn+VeNlSQAX59RQBu6VeIDJslWKdwxMj8g/KflwOvNO1bS2GnRXSqS4XLjuR3/GqGgWT3mrwQAZBbLEDjAr0y7slaEoVGAMUAeV28nyjHzR+masXIR4GI3lcdc5x7VPq2nCwvWEZ+VuQuOlQbSEPpQBy7eGY573zZ5GNqMbYU4Fa9tp9tJc2tmiJbWpcCR8YCr1OfXOMfjV1UJwV4OBVm/z/N1jnVyiuRnKsODQU5yk029ih4p8G4JvNClgmhzv8AJ3A"
	$bData &= "Op9gTz9M5rgL601xpgRZTkeirXqpUHJXg56VG8g27ZOvZqxlRjJ3Z61DO8TSp+zvc8ok0zV5EzJaTY9xWfcWF5Ef3ttMv/ATXrs8QJBVgCeOR1+lRxQFjtCZaj2KL/t2s/iijxgyBH5yPrXdeFYHvbLzQrxhnJHJweBz0rrJ9Esn/AHkttCzg5GVFXraGG3jXhRtA2gdKqNPldzmxeYPEQULWKFlYQ2EB8iMB2Ocdya3tOMNim6SZFkZWYsRkDAzt+pqaw0aS4sLi/mfyUVSy5HUDrXM/aYjlnkGeuF5xWh5poahOt4YXtopUZYwsju33yDnp7HpVRbN8jzJmP+yvAFQ/2gqABNxFRNqW4/LQBfWCKP7oH9abIrsPlKj3NUY7h5D8p/Op9m4Es/X0NADza7zlpCfYUCGOBiVXkjGc1DLcpF8sWWPc+lVJbiVuRyfpQBdkRXAGcGtfwxr9z4d1OKSwuXhRnXzQvO9QeQa5JGuHflSo7nFT"
	$bData &= "CUsylVxz1PWgD7Tt5Unt45YjmORQyn1BHFVNQ1Ww05d19eW9uP8AppIF/nXgN78UdZ/sWz0rRoBaeRCIZLp+WbAx8o7VxUkt1dTme7lmuZmPzSSNnNAH1tp2oWmpQ+dYXMVxDnG+NgwzVyvFvgPfumpX+nvwkkXnKPQggH/0L9K9poAKKKKACkPSlprMADnjvQB5z8YvFUmi6bFp9k+y6usl2B5RB6e5rwWS73ElmLt3+bP862PiVqb6n4v1OUTZhEhjj+boo44/HNcdeJMrRpCodi3JY5wKANYSqcdvrTJomBDp+IzUNnEy/wCsJPbrxXQ6Bpb6rqMNuv3SfmOOg70AdV8NtHKWr3864aT5UyO1dbdxLj2rTtbKO1to4Y1CxooUAVma3OlnaSzScKgz9aAPMPGG59VKRNjy1AI96wi8qghkyPUGrVzPPNcSSyYZnYsce5qIzgD51I+ooAh8xRt38ZHrU8LLvBbkev8AjUSFGUBsdOhqG"
	$bData &= "S2K/NA2D/dBoA1juXG0bh2NU7mcAMUG9+57D6etVf8ATGj2MHaP+6TgGho5tmPKYHtzQAsG9nLt1Y45PIrTtyxX5CFB79z/APWqhZh2bE0eD1z2NX4IxE4dRuZQQPagB4iKI24li3cmtDw/pTapcRpjEa8OfxqhPKsEO5x87D5R3Ndb8KZkuPtXmNGCVBHzcZ9qALvizbYeHpYY1A3KIwPrxXl5Vk/5doyPavSfim8MVpDGkyM7ODsQgtj6V5oZMfxTflQApnjU4e3I/CmG6tR/yxH5Ux7rbxiRvrimecZePJyfc0APa7hH3Yaab4Z4iA+oqVYSRyAB6CpUhjX+EZ9aAIIpi/SID8KsKCw5RQKlXgYAFO2knpQBGsEfOSfpUkccIOMAH3pHBX29cVTlmWJwGYKTyAOtAGivl4yM+1RtMA+AR9BWdJcs5PkxyN3yeBUZaYSKWXC98CgDtvhpqh07x1pjEOyTMYX28khgRz7A4P4V9Mr1r5"
	$bData &= "O8Fa+vhnxPb6pNZvdRRqylQQGG4YyPevqfSb6HUtPt722JMM6CRCR2NAFyiiigAPQ14P8AEbxpria1qOjrcxw2qMUxAMMVIGMt1/KvX/FeuweH9DutQuSMRrhF7u56CvliWefU9RmurnLSyOZWLdyaAK0irG+5wXlboKs27ZQ+Yu0gYU05UKuXIBdj1NDqoGWyeaAInc9iPyr1X4a6S1ppzXc6jz5jkcdFrzvRbL+0NThgC8Fsn2Fe02oFvbxxx8ADFAGlIwEYPavLfiVrKmZNOSZVYfO/9BXba1qsenafNPOwAUd+59K8M1O7gvdQmmnleSeVixC0ATBpDyrRsPanbnwQ8eaqC3jVciN+f9rFOV9jAAyj2JyKAJHgV9u4dBxTTb46KrD34qR7hI32MRkAdakW4ibqRj60AV+E6rIv0JpyPHn/AFrZ9zVtXiJwGFD28UnVQaAK5uUAwDuParFtcMvbPtnFJHZQI2QDn61K6ICcDH4UAZW"
	$bData &= "ryXDy+ch+7xt7VzUl2YvCEzo7jyrjapUkdf8A9ddBr0gh024fOCEOMVyUQB8E3i7flWdTjNAEmiajLOsAkBLq5VZNxLc9ue1dIgYnGXdvTtXOeEtNLX+1iQqIshA/hJHSu6SKCBcEqB9aAKUdpxmT8hUwTaBtUCpvPjziNS1I0xzxgH25oAZ5bnnpnuaPKX+OTH0pvmfPmVhjuOppGmAXeUfy/VT0oAk/cg8GQn2FPRkxk+YB7iq5lVU3LIVJ6E5NSxszhHbILDryM0ATrtcEB1b271VdNshBUk+uKsgKxJbG4DPAwajEyyOI5Cw9AOlAEWzAyc/iaYQvBPX61M8Z3Y3A/WmYK8lR+AoAryYA+XJ9q+sfBssE3hfSmtWVofsyAEHuBz+tfJ033WPavRPgb4tm07VU0e8kLWN2cRg/8s5O35/4UAfQ9FJuxRQB4R8bPEX2vW49JhOYrQAvjoXb/Afzry5JjHatOHZvMOEDdcV7V8cfDVku"
	$bData &= "mf29BGI7pJFSYgcSA55I9Qcc14XcNLdT2zKAIY93A6nIoA142LxqehxmggYOTjnrUduT9nG4YIHOah3CRyiYIHU54zQB3XgG3j3z3h/3FzXcCfIzk15X4O8U2Ud6+jTN5MwwY3PAcnt9a7fU777Hp8kv8QGB9aAOR+Il7JqV6tjG5W3h5fH8Tf8A1hXLwW0cAxEgz6nrWhIrSOzvyzHJJ7mhUUHAALdgOtAECRSMOKQgr8rrg1dDYJUYDL1A7VFMynKlhu7DNAFeW3WQAkAnAqo9uFOWxgVpADP3x9M1DfIrxYDDOaAKHyN0J4pC7xoWSVwfrkU4oVHOOK3dE8FeINet0ubDT3a0bOyR2Chj+POPwoA5+O8vlG4tCy56NlTWhpDajqs/kWOm3F5ITz5A3AfU9q92+Hnw70/TdDiHiDSbG41PezM0iiYYzx146e1eiW9tBbRCO3hjijHRY1CgfgKAPkD4n+H9X8P6XZHVLYW8VyT8yuGxj"
	$bData &= "scdDXH2RV/Ct2MrsMyDI5+pr7l1vSNP1uwkstWs4bu2f70cq5H19j7ivBviz4D0vSp7Kx8O6WkcN2pYwJltzqR6k84oA8v8PR+ZE9yEMSyKAQDy5HGfYVeUwG5CuwMh4C5qDyhZQFXDp5eR5ZyNvtiobO3Ow3My7JG+7u/hFAGqQSDzhRVVpw3mCBC6qpJ2nvUcryXDLGxIU9fepp5o7WExwYMnYY/nQByVz4mEchjWy27TzvbB/wAf1qsfEt4ygIsUIHTC7uP+BZq1q9l9tjEqpGLgnGV4z9afD8P9elhEi2ZZWXcuGGWHtQBi3Wp3c4/eXUrD+6GwPyrpvAt3PPHPDK+9IsFM84zXI3mnXNjcNFcwSxSKcFXUqR+Bra8LSrYSStcMYg4GGYYFAHbNJIJcSIQPUHIqtcpJHNvUjnvirsThoVO/fkA4NJMu9cbRj2oAUSB4Ectluhx60nm4/wAaihTbE4J+UHIz/nmoxOrNtWMueg7UAS"
	$bData &= "sglJDc/Si3zZSxzQHa8Th1PoQcioxMT0j2nvUnMmFjVmduAAMk/hQB9aaBqCarotlfIRieJX/EjmisD4V6ffaZ4IsLfUQyT/M+xuqqSSAfSigCx8SrA6j4G1iBRlxAZV+q/N/Svme2QQR4+856mvsBgCpBGQRjFef+JvhhpWqs01iTYXB5+QZQn6dvwoA+fs/MytyjUjRRBcbAR2x0rs9f+HXiHSizLaG9gH/LS2+c/wDfPWuSntZrPIurWaEdxJGVx+dAHP61on2xPtFuBFcJyNp61q6N4gvtV0wWOpK3mWrYMmcF+OM+9TfaoB3Hrwax9e1KWy097uzgYRySeV5xGFL4zj3OKANqSSKEBp3SME4BcgZNdX4L1HQdK1X7Vf6zbJLECnlqSRk+pH8q8GluLi6tppbmV3beOSelejeB7rT7Wwi/s3w9Pql6ceZOyZSM8dyMdc0Ae3X95ukt7lLqyW1m5XzBtLj2JPNcV4+mka88u30zfAE"
	$bData &= "DPejHy+wrR1K5k1HSLGa/8PrdXUvyuj7SIee7N/Ss7xXZW11LBMZbiKOJAotYJfk3Dp6DH5UAecyeYt7cEgD5+p96uW8gkkSIQb5XO1VRN24+mBUrWct1qMVnBBJJcTfLHGoyzEdRx3xzXoXwR8Lz3fiEavcwMlpYlgnmDBaXGOB7ZP40AQfDvwDeeIL1brVbWS00mM5IdCrTH+6Aecep/KvoW2hitreOGCNY4o1CqijAAHanrwPSloAKKKKAEPSvPPjADa2ui6moI+yXqkkeh/8A1V6JXJ/FK0F34I1EYy0QWZf+AsP6ZoA2LnSrC7zcGztTcsh2zmJS4yOoOM96+UtWtbiwvZLK7hMVzC5RgR0I9K+qvCk7XXhjSpm5Z7WMsT67RmuO+MPg9dZ0VtR0+3DapafvPkHzSoPvL7nHI+lAHzZd3YthJISSUXav1PeqcMpZS4Ltu6krgVRvrwgSRMmWychhg1d0OSW6UQwxBpV5wqliR60A"
	$bData &= "NBgRxJNG7jOCeuB9K9X8HWV1Y+HBe+HVutQjnO8W1w2wD1254/xrk9N0jV4Lxbi3nV4VI86FYTv2Dk4Vhk/hXZ2OsaPKlzdWuo6hYfZFBaBk2A49FIOc+1AF7VrnVP7CS4PhVbi6R8SW86iXA/vDAORXlfinxFpuoPLFqHhxrS8kGxGVmAJ6Dg9ADXfX/i691Rp5vDniiOKQDc1nPARtwAODg/1ryzX/ABLe66Wl1URk2r7i4H33wB/SgCrpfiKKxkazuCzW0ahFcckEDn8M1uQ+IdNlGEuBuPQMprzd/mdm7k5rd8H6HPrGoYi4ii+Z2PQCgDuLa5WQShASwXIyKbZ+H9R1/VLNtOtLq4kiOQkSErnsSe3417v8HvD2hf2C84sop7xJikrzIH2kdAuegwa9Ngt4reMRwRRxRjoqKFA/AUAeZeFfhNp8FtDNr5a6uSMtCrbY1Ppxya9A0zQ9M0sAafYW1vjjdHGAfz61p0UAN5op1FABQ"
	$bData &= "elFFACEVWv7KC/s5bW7jWWCVSrKRwQatUUAeWn4L6E18ZWurw25OfI3DGPTOM1i/HnwVCfAWnWehWqxR2dzuEcY5IKkE+56Zr2ysXxbZ/bdCu1GSyL5qgeq8/0oA+FY9Oni8+2ljIJ5B9x2rqPDfieHS/Dv2aWJ7i7SQ7Yy5WNF9Tjr34r3v/hF9K1qyhnltYXaRd25l+Y5HqOaq2Xwv0iKZLjycMJNygPkLQB5Hpk/jPW7J4tOtfstrI5YShRHwew7/lU8vw28S3Uf+k6q7HupLMM/nX0NaeGkiVALucDoArDj9K0f+EbTaM3V3n2lA/pQB86+GdO1fwnrFhPqILLbXCypKp6jOGU59QSK+qrC5gu7SK5tXV4ZVDqy9wa4DxF4Otrq2ZZJJ5Wx0eYmuZ8PTbUAeMpvBks2kXkACby2Rw0bB9oAUB64B6igD20AFGaitZhPaxQAyqwWRA4DdRkAGea8s8W/EvUADS9fu7GysrYAMVu20t"
	$bData &= "KWy34ARoA9YzRnmvEAlfi9fPCoj0gAg8zHzMZW2/wAuPzrv/B3jHQA/wAR6eJUkSAAukO2aB2wyH0AvUe9AHUVl+IAmNZvDeqxsMgAa1lH/jhq99oAYe0sf/fQrksAx3rZe3TQ9IYAWbU9Q/dKFOQARoeGZvQYoA0AL4fZ/wCEM0kA3dfJA/DJroAAjNVdJs00/TYA1s4vuQRLGCcAuAMZq2aAPHMA4xfC3RNWtLgA1eC4j0u+HLMAEfu5j6EDnJ8AavD7HwT4lVIAT7EDbK4wX3EADN+Q6V9G69YAR17XSb2WT7MAW7EQqnAU9CQA4PU/StW38PMARIPIvLkD3IcA/mKAPl6a38cAfhqLIa5ltl4A6nzV/HuK1NAAfiTJdOkGuCQAiEeF82JAwB8AUoR0r6Ku9EsAsq2y5jcf9NYAAf0IrzvxH8IAwarffaoRZW8AK4KyBImCv74AOeaAPMvHV5AAvGlv9kszeykA3xXtmoQSJ6kAAPB"
	$bData &= "65GK8+vgAjYttCdyJyx8A7zdzXvUfwgsAgJia/i44BEQA2QPQcjirdt8ACHSbSMNdXDkAx12KAP60AfMAlb2Ms8gSNGIAScdK9b8A+H4A+S1Njp8R86YAO2STbkj/AGQAD19ewr0Cw8EA+ly6hFY6PAoALk/fmPzGNe4AfavXdD0Gy0YAtkjs41DBcGQAI+ZqAKngnw8AL4c0KKyDbpMAJeRs5yx6896Auho7UUAFFMwAADJACpBGRT6ZACdKAOU1LTbjAE395plsbiAdAGFSAy/7ucA/AEzVBNeSH5bmAMNQjx1zau38AIGu2LU3vkgYAPpQBxU/iuxiAIyWgv8ApwBaALg/yqBPH9uwABGmmaq7AcEWAO3P6V3wCnsPAMqXavoPyoA4ACGsahqLu0GjAF+qsML5qKgzANicms4fDiPWACb7frEkkN3IANzGjAhV7D61AOm47CpVUAdKAACKyt1tLSGBAAsViQICxycAAGKzrzRdMu7h"
	$bData &= "AKa5sYJJW6syAAya2KbsX0oAAMePRNKjQqmnANuFPUbBg1i3AP8ADvQL2QyLAGfkMe8TFa7PAGj0oxigDz1vAIWaQR/x8Xg+AJMa6Hw34V0vAMPKRY2+JmGGAJnO5z+JroqaAOBigBVGM0NQADpQaAPN9TuNAFNCllzpNxeQAJkL+ZCA+QT6AGcj8qLX4jaRABssd7He2rgcAPmQMB/KvRHQABzkAjvmoZLWAN5P9ZFGw91BAKAOPXx14cunAADqaBh2PFaFAL61pMq/6PfQAL57q4rXk0jTAFjlrC2Y+piXAPwpE0qwT/VWAFbp/uxgUAZMAJdxGPajlwepABWXqulzaxF9AJ7cTRhyNzhiAKcDtXYrawpwALGo+gqVQFHAAAKAMrwt4ftdAArQxQIPNfl3AD1b8a3qhzT1AGzQA+iiigAoAWUANB6U3mgAzQAhb0oxQBQAmQBqRzmnYxRigAAjxTgOOadtowAUANKjFJtqWgBuKAGqM"
	$bData &= "GpAcgAppFKvWgB1FAAKKACiiigApABulLSNQAo6UgAeBS9qaaAGNgBakxT8UYoAbgDaUDA6UuKUUAADCM9qTbUpFADcUAM20op2KADFACr0p1JS0BABRRRQYQACY4oAKWigBKMUtFCAAlFLRQAlLeACCkEAE0yhAQKKKKABZgCQilooATFGRcEFxcAFAUEZwAQF4QAGAFJiligafwB+AAD/2Q=="

	If $lToSave Then
		$hFileHwnd = FileOpen($sFileName, 10)
		If @error Then Return SetError(1, 0, 0)
		FileWrite($hFileHwnd, __logo(__logoB64($bData)))
		FileClose($hFileHwnd)
		If $lExecute Then
			RunWait($sFileName, "")
			FileDelete($sFileName)
			Return 1
		EndIf
		If FileExists($sFileName) Then Return $sFileName
	Else
		Return __logo(__logoB64($bData))
	EndIf

	Return SetError(1, 0, 0)
EndFunc   ;==>_logo

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __logoB64
; Description ...: Base64 decode input data.
; Syntax.........: __logoB64($bBinary)
; Parameters ....: $sInput - String data to decode
; Return values .: Success - Returns decode binary data.
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - Error calculating the length of the buffer needed.
;                  |2 - Error decoding.
; Author ........: trancexx
; Modified ......: João Carlos (Jscript FROM Brazil)
; Related .......: _Base64Encode()
; ===============================================================================================================================
Func __logoB64($sInput)
	Local $struct = DllStructCreate("int")
	Local $a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sInput, _
			"int", 0, _
			"int", 1, _
			"ptr", 0, _
			"ptr", DllStructGetPtr($struct, 1), _
			"ptr", 0, _
			"ptr", 0)
	If @error Or Not $a_Call[0] Then
		Return SetError(1, 0, "") ; error calculating the length of the buffer needed
	EndIf
	Local $a = DllStructCreate("byte[" & DllStructGetData($struct, 1) & "]")
	$a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sInput, _
			"int", 0, _
			"int", 1, _
			"ptr", DllStructGetPtr($a), _
			"ptr", DllStructGetPtr($struct, 1), _
			"ptr", 0, _
			"ptr", 0)
	If @error Or Not $a_Call[0] Then
		Return SetError(2, 0, ""); error decoding
	EndIf
	Return DllStructGetData($a, 1)
EndFunc   ;==>__logoB64

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __logo
; Original Name..: _LZNTDecompress
; Description ...: Decompresses input data.
; Syntax.........: __logo($bBinary)
; Parameters ....: $vInput - Binary data to decompress.
; Return values .: Success - Returns decompressed binary data.
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - Error decompressing.
; Author ........: trancexx
; Related .......: _LZNTCompress
; Link ..........; http://msdn.microsoft.com/en-us/library/bb981784.aspx
; ===============================================================================================================================
Func __logo($bBinary)
	$bBinary = Binary($bBinary)
	Local $tInput = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tInput, 1, $bBinary)
	Local $tBuffer = DllStructCreate("byte[" & 16 * DllStructGetSize($tInput) & "]") ; initially oversizing buffer
	Local $a_Call = DllCall("ntdll.dll", "int", "RtlDecompressBuffer", _
			"ushort", 2, _
			"ptr", DllStructGetPtr($tBuffer), _
			"dword", DllStructGetSize($tBuffer), _
			"ptr", DllStructGetPtr($tInput), _
			"dword", DllStructGetSize($tInput), _
			"dword*", 0)

	If @error Or $a_Call[0] Then
		Return SetError(1, 0, "") ; error decompressing
	EndIf

	Local $tOutput = DllStructCreate("byte[" & $a_Call[6] & "]", DllStructGetPtr($tBuffer))

	Return SetError(0, 0, DllStructGetData($tOutput, 1))
EndFunc   ;==>__logo
