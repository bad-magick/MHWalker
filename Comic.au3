#include-once

#include <Array.au3>

Global $relief[151]

;151
$relief[0] = "Dividing by 0..."
$relief[1] = "Making cookies..."
$relief[2] = "I know kung-fu..."
$relief[3] = "No. I am your father..."
$relief[4] = "What are you doing, Dave?"
$relief[5] = "Aren't you sick of this game yet?"
$relief[6] = "Extrapolating the meaning of life..."
$relief[7] = "Reporting you to Nexon (j/k)..."
$relief[8] = "I'm hungry..."
$relief[9] = "Downloading porn..."
$relief[10] = "Having a 3-way with Evie and Fiona..."
$relief[11] = "The last thing I want to do is get you banned, but it is on the list..."
$relief[13] = "Nom nom nom..."
$relief[14] = "Fighting for peace is like fucking for virginity..."
$relief[15] = "Crowded elevators smell different to midgets..."
$relief[16] = "Killing in the name of..."
$relief[17] = "If the world didn't suck, we'd all fall off..."
$relief[18] = "Jesus loves you. I think you're an asshole..."
$relief[19] = "Does this rag smell like chloroform to you?"
$relief[20] = "With sufficient thrust, pigs fly just fine..."
$relief[21] = "Bring me a toolshed, for I am hungry..."
$relief[22] = "Fighting for peace is like fucking for virginity..."
$relief[23] = "Evies are OP..."
$relief[24] = "Logging into your Facebook (j/k)..."
$relief[25] = "Peanut butter jelly time...."
$relief[26] = "Fiona makes me horney..."
$relief[27] = "Fuck this game, let's go get a beer..."
$relief[28] = "My God! It's full of stars..."
$relief[29] = "Scottie, beam me up..."
$relief[30] = "Never underestimate the power of stupid people in large groups..."
$relief[31] = "Lottery: A tax on people who are bad at math..."
$relief[32] = "You can do more with a kind word and a gun than with just a kind word..."
$relief[33] = "Never test the depth of the water with both feet..."
$relief[34] = "Always remember you're unique, just like everyone else..."
$relief[35] = "A bartender is just a pharmacist with a limited inventory..."
$relief[37] = "Don’t hate me because I m good. Hate me because I know it!!"
$relief[38] = "Friction is a drag..."
$relief[39] = "Money is the root of all wealth..."
$relief[40] = "Always be sincere, even if you don't mean it..."
$relief[41] = "Bad spellers of the world untie!!!"
$relief[42] = "If practice makes perfect, and nobody's perfect, why practice?"
$relief[43] = "It is bad luck to be superstitious..."
$relief[44] = "If Fed Ex and UPS were to merge, would they call it Fed UP?"
$relief[45] = "I believe five out of four people have trouble with fractions..."
$relief[46] = "You never really learn to swear until you learn to drive..."
$relief[47] = "Clones are people two..."
$relief[48] = "If you can't be kind, at least have the decency to be vague..."
$relief[49] = "How do I set my laser printer on stun?"
$relief[50] = "How is it possible to have a civil war?"
$relief[51] = "Atheism is a nonprophet organization..."
$relief[52] = "They call it PMS because MadCow Disease was already taken..."
$relief[53] = "The trouble with life is there's no background music..."
$relief[54] = "The original point and click interface was a Smith and Wesson..."
$relief[55] = "I smile because I don't know what the hell is going on..."
$relief[56] = "Eagles may soar, but weasels don't get sucked into jet engines..."
$relief[57] = "Quantum Mechanics: The dreams stuff is made of..."
$relief[58] = "I started out with nothing and still have most of it left..."
$relief[59] = "Sarcasm is just one more service we offer..."
$relief[60] = "To All You Virgins: Thanks For Nothing!"
$relief[61] = "If you're too open minded, your brains will fall out..."
$relief[62] = "Artificial intelligence is no match for natural stupidity..."
$relief[63] = "Eat well, stay fit, die anyway..."
$relief[64] = "A balanced diet is a cookie in each hand..."
$relief[65] = "Shin: a device for finding furniture in the dark..."
$relief[66] = "Join the Army, meet interesting people, then kill them..."
$relief[67] = "All those who believe in psychokinesis raise my hand..."
$relief[68] = "Help Wanted: Telepath. You know where to apply..."
$relief[69] = "All computers wait at the same speed..."
$relief[70] = "I doubt, therefore I might be..."
$relief[71] = "If you try to fail, and succeed, which have you done?"
$relief[72] = "My job is secure. No one else wants it..."
$relief[73] = "Talk is cheap because supply exceeds demand..."
$relief[74] = "Conclusion: the place where you got tired of thinking..."
$relief[75] = "People who live in stone houses shouldn't throw glasses..."
$relief[76] = "Don't judge a book by its movie..."
$relief[77] = "A slug is just a snail with a housing problem..."
$relief[78] = "I like doing my own thing, except when I can get a date..."
$relief[79] = "Police take Hide and Seek really seriously..."
$relief[80] = "It's far easier to be flexible when you're spineless..."
$relief[81] = "Celebrate Amelia Earhart Day. Get lost..."
$relief[82] = "My money keeps unfollowing me..."
$relief[83] = "Evolutionists do it with increasing complexity..."
$relief[84] = "Life is like a box of chocolates..."
$relief[85] = "Can I get a witness up in here?"
$relief[86] = "Zyarga is one sexy beast..."
$relief[87] = "Having a 3-way with Tieve and Shayla..."
$relief[88] = "Dolores' smile scares me..."
$relief[89] = "There are 3 redhead females in Colhen..."
$relief[90] = "Ellis was annoying, I'm glad he's dead..."
$relief[91] = "Marcus Vindictus was the name of a character in a Mel Brooks movie..."
$relief[92] = "I ate a baby..."
$relief[93] = "BUCK FUTTER!!"
$relief[94] = "My name is Bond... James Bond..."
$relief[95] = "It’s tough to be such a sex symbol..."
$relief[96] = "I'm actually quite pleasant until I'm awake..."
$relief[97] = "A premature ejaculation is an incomplete thought..."
$relief[98] = "Watch out, I know karate... and 7 other Japanese words..."
$relief[99] = "Alcohol doesn't solve any problems. Then again, neither does milk..."
$relief[100] = "If my house is clean, that means Vindictus is broken..."
$relief[101] = "Do fish ever get thirsy?"
$relief[102] = "If you see a bomb technician running, try to keep up..."
$relief[103] = "The best part about my job is that the chair spins..."
$relief[104] = "I'm a nobody, nobody is perfect, therefore I'm perfect..."
$relief[105] = "I've got to sit down and work out where I stand..."
$relief[106] = "Where there's a will, I want to be in it..."
$relief[107] = "I am free of all prejudices. I hate everyone equally..."
$relief[108] = "Complex problems have simple, easy to understand wrong answers..."
$relief[109] = "Pull my finger..."
$relief[110] = "Nobody dies a virgin, because life fucks us all..."
$relief[111] = "A fine is a tax for doing wrong. A tax is a fine for doing well..."
$relief[112] = "Love: is looking someone in the eyes after you've cummed on their face..."
$relief[113] = "Premature Ejaculation Help Group Starts at 9... Come early..."
$relief[114] = "How many Xzibits would Xzibit exhibit if Xzibit could exhibit Xzibits?"
$relief[115] = "You were born as an original. Don't die as a copy..."
$relief[116] = "A bug in the code is worth two in the documentation..."
$relief[117] = "A computer scientist is someone who fixes things that aren't broken..."
$relief[118] = "Willyoupleasehelpmefixmykeyboard?Thespacebarisbroken!"
$relief[119] = "A Life? Cool! Where can I download one of those from?"
$relief[120] = "A program is never finished until the programmer dies..."
$relief[121] = "As far as I know, MHWalker has never had an undetected error..."
$relief[122] = "Computers are not intelligent. They only think they are..."
$relief[123] = "Computers make very fast, very accurate mistakes..."
$relief[124] = "Don't hit the keys so hard, it hurts..."
$relief[125] = "Error: Problem exists between keyboard and chair..."
$relief[126] = "Ever notice how fast Windows runs? Neither did I..."
$relief[127] = "I'm writing a book. I've got the page numbers done..."
$relief[128] = "Math problems? Call 1-800-[(10x)(ln(13e))]-[sin(xy)/2.362x]"
$relief[129] = "To err is human, but to really fuck things up requires a computer..."
$relief[130] = "The letter ""B"" is unlucky because it looks like scrunched up 13..."
$relief[131] = "I could use a banana bread pastromi cottage cheese sandwich..."
$relief[132] = "I always order a club sandwich, even though I'm not a member..."
$relief[133] = "I saw a wino eating grapes. I said, ""Dude, you have to wait""..."
$relief[134] = "I haven't slept for 10 days, because that would be too long..."
$relief[135] = "A severed foot is the ultimate stocking stuffer..."
$relief[136] = "I used to do drugs. I still do, but I used to, too..."
$relief[137] = "I'm against picketing, but I don't know how to show it..."
$relief[138] = "I play sports...no I don't, what the fuck?"
$relief[139] = "If carrots got you drunk, rabbits would be fucked up..."
$relief[140] = "Is a hippopotamus a hippopotamus or just a really cool opotamus?"
$relief[141] = "My girl works at Hooters, in the kitchen..."
$relief[142] = "NyQuil on the rocks, for when you're feeling sick but sociable..."
$relief[143] = "I have a vest. If I had my arms cut off, it would be a jacket..."
$relief[144] = "I had one anchovy, that's why I didn't have two anchovies..."
$relief[145] = "I think Pringles original intention was to make tennis balls..."
$relief[146] = "This shirt is ""dry-clean only"", which means it's dirty..."
$relief[147] = "I wish I could play little league now, I'd kick some fuckin' ass..."
$relief[148] = "I don't have a microwave, just a clock that occasionally cooks shit..."
$relief[149] = "An escalator can never break, it can only become stairs..."
$relief[150] = "Ride ze shoopuf?"

;17 - 10/29/2011
_ArrayAdd($relief, "The power of Christ compels you, bitch!")
_ArrayAdd($relief, "Rock lobster!")
_ArrayAdd($relief, "Giggidy-giggidy-giggidy-giggidy!")
_ArrayAdd($relief, "Fat chicks need lovin too, but they gotta pay for it...")
_ArrayAdd($relief, "I'm addicted to boobies...")
_ArrayAdd($relief, "When I was a kid my parents moved a lot, but I always found them...")
_ArrayAdd($relief, "My wife made me join a bridge club. I jump off next Tuesday...")
_ArrayAdd($relief, "I was so ugly my mother used to feed me with a sling shot...")
_ArrayAdd($relief, "Sex is dirty only if it's done right...")
_ArrayAdd($relief, "Sex isn't good unless it leaves emotional scars...")
_ArrayAdd($relief, "Anal sex is for assholes...")
_ArrayAdd($relief, "Everyone in favor of birth control has already been born...")
_ArrayAdd($relief, "You really have to hand it to the blind prostitute...")
_ArrayAdd($relief, "Are you into casual sex, or should I dress up?")
_ArrayAdd($relief, "Out of my mind. Back in five minutes...")
_ArrayAdd($relief, "Important Message: Conserve your toilet paper, use both sides...")
_ArrayAdd($relief, "Beer is proof that God loves us and wants us to be happy...")
_ArrayAdd($relief, "I remixed a remix, and it was back to normal...")

;12 - 10/31/2011
_ArrayAdd($relief, "Everyone is entitled to be stupid, but some abuse the privledge...")
_ArrayAdd($relief, "The secret to creativity is knowing how to hide your sources...")
_ArrayAdd($relief, "Today is the tomorrow you worried about yesterday...")
_ArrayAdd($relief, "I can resist everything except temptation...")
_ArrayAdd($relief, "Every rule has an exception. Even this one...")
_ArrayAdd($relief, "Better a witty fool than a foolish wit...")
_ArrayAdd($relief, "Save a tree, eat a beaver...")
_ArrayAdd($relief, "Save a mouse, eat a pussy...")
_ArrayAdd($relief, "Use the force...")
_ArrayAdd($relief, "If at first you don't succeed, pay someone else to do it for you...")
_ArrayAdd($relief, "Energizer Bunny arrested - charged with battery!")
_ArrayAdd($relief, "Le sens commun n'est pas si commun...")

;40 - 11/07/2011
_ArrayAdd($relief, "Save the whales. Collect the whole set...")
_ArrayAdd($relief, "A day without sunshine is like, night...")
_ArrayAdd($relief, "On the other hand, you have different fingers...")
_ArrayAdd($relief, "I just got lost in thought. It was unfamiliar territory...")
_ArrayAdd($relief, "42.7 percent of all statistics are made up on the spot...")
_ArrayAdd($relief, "99 percent of lawyers give the rest a bad name...")
_ArrayAdd($relief, "I feel like I'm diagonally parked in a parallel universe...")
_ArrayAdd($relief, "Honk if you love peace and quiet...")
_ArrayAdd($relief, "Remember: half the people you know are below average...")
_ArrayAdd($relief, "Nothing is foolproof to a talented fool...")
_ArrayAdd($relief, "He who laughs last thinks slowest...")
_ArrayAdd($relief, "For every action there is an equal and opposite criticism...")
_ArrayAdd($relief, "Bills travel through the mail at twice the speed of checks...")
_ArrayAdd($relief, "No one is listening until you make a mistake...")
_ArrayAdd($relief, "Two wrongs are only the beginning...")
_ArrayAdd($relief, "A clear conscience is usually the sign of a bad memory...")
_ArrayAdd($relief, "Change is inevitable except from vending machines...")
_ArrayAdd($relief, "Why are there 5 syllables in the word ""monosyllabic""?")
_ArrayAdd($relief, "If Jesus was Jewish why does he have a Mexican name?")
_ArrayAdd($relief, "Any book worth banning is a book worth reading...")
_ArrayAdd($relief, "Never hit a man with glasses. Hit him with a baseball bat...")
_ArrayAdd($relief, "Ignorance killed the cat. Curiosity was framed...")
_ArrayAdd($relief, "Gravity is a myth, the Earth sucks...")
_ArrayAdd($relief, "Life's a whore and I'm broke...")
_ArrayAdd($relief, "Madness takes its toll. Please have exact change...")
_ArrayAdd($relief, "The gene pool could use a little chlorine...")
_ArrayAdd($relief, "What is originality? Undetected plagiarism...")
_ArrayAdd($relief, "Consistency is the last resort of the unimaginative...")
_ArrayAdd($relief, "Life is sexually transmitted...")
_ArrayAdd($relief, "Always remember to pillage BEFORE you burn...")
_ArrayAdd($relief, "Others often better express myself...")
_ArrayAdd($relief, "Make it idiot-proof and someone will make a better idiot...")
_ArrayAdd($relief, "A flashlight is a case for holding dead batteries...")
_ArrayAdd($relief, "Hard work has a future payoff. Laziness pays off now...")
_ArrayAdd($relief, "A good scapegoat is hard to find...")
_ArrayAdd($relief, "Give me ambiguity or give me something else...")
_ArrayAdd($relief, "If we aren't supposed to eat animals, why are they made of meat?")
_ArrayAdd($relief, "Why is it called tourist season if we can't shoot at them?")
_ArrayAdd($relief, "God spelled backward is dog. Conincidence? I think not...")
_ArrayAdd($relief, "Hukt on fonix werkt fer me...")

;28 - 11/07/2011
_ArrayAdd($relief, "Regarding apathy, I have no opinion...")
_ArrayAdd($relief, "I have the body of a god....Buddha!")
_ArrayAdd($relief, "No matter where you go, there you are...")
_ArrayAdd($relief, "A friend in need is a pain in the ass...")
_ArrayAdd($relief, "I used to contain myself, but I escaped...")
_ArrayAdd($relief, "Dust: mud with the juice squeezed out...")
_ArrayAdd($relief, "Innuendo: Italian suppository...")
_ArrayAdd($relief, "Skeleton: a bunch of bones with the person scraped off...")
_ArrayAdd($relief, "Be Alert! The world needs more lerts...")
_ArrayAdd($relief, "If all is not lost, where is it?")
_ArrayAdd($relief, "Procrastinate now!")
_ArrayAdd($relief, "A synonym is a word you use in place of one you can't spell...")
_ArrayAdd($relief, "Jesus is coming. Look busy!")
_ArrayAdd($relief, "Where are we going? And why am I in this handbasket?")
_ArrayAdd($relief, "Cancer cures smoking...")
_ArrayAdd($relief, "Eschew obfuscation...")
_ArrayAdd($relief, "Ambivalent? Well, yes and no...")
_ArrayAdd($relief, "Heck is where people go who don't believe in Gosh...")
_ArrayAdd($relief, "Vegetarian: Indian word for ""lousy hunter.""")
_ArrayAdd($relief, "3 out of 4 people make up 75% of the population...")
_ArrayAdd($relief, "Drugs lead to nowhere, but it's the scenic route...")
_ArrayAdd($relief, "Chaos, panic and disorder--my work here is done...")
_ArrayAdd($relief, "I still miss my Ex, but my aim is improving...")
_ArrayAdd($relief, "Unicorns aren't mythical. Virgins are...")
_ArrayAdd($relief, "My wife's other car is a broom...")
_ArrayAdd($relief, "Chastity is curable, if detected early...")
_ArrayAdd($relief, "Sex on television can't hurt you, unless you fall off...")
_ArrayAdd($relief, "If you smoke after sex, you're doing it too fast...")

;15 - 11/14/2011
_ArrayAdd($relief, "I want to be your dominated love slave...")
_ArrayAdd($relief, "Yee-haw!")
_ArrayAdd($relief, "Take my advice: don't listen to me...")
_ArrayAdd($relief, "I'm walking the intensive care unit dressed as the grim reaper...")
_ArrayAdd($relief, "What flavor of milkshake brings all the boys to the yard?")
_ArrayAdd($relief, "MHWalker is filmed before a live studio audience...")
_ArrayAdd($relief, "What if the honkey-pokey really is what it's all about?")
_ArrayAdd($relief, "I am the walrus! Coo-coo-ka-choo!")
_ArrayAdd($relief, "I love the bitch in you...")
_ArrayAdd($relief, "Nuts on your chest: chestnuts; Nuts on your chin: cocksucker...")
_ArrayAdd($relief, "Anal drippage is shitty...")
_ArrayAdd($relief, "Dicks are like fish: toss the small ones, mount the big ones...")
_ArrayAdd($relief, "May the wind at your back never be your own...")
_ArrayAdd($relief, "Old age and trechery will overcome youth and skill...")
_ArrayAdd($relief, "I like Macs... no I don't, what the fuck?")

;10 - 11/16/2011
_ArrayAdd($relief, "Jees if you love Honkus...")
_ArrayAdd($relief, "I listen to the voices in my head and do what they tell me...")
_ArrayAdd($relief, "You're living proof that cowboys humped buffalo...")
_ArrayAdd($relief, "Hands up, Motherstickers! This is a fuck-up!")
_ArrayAdd($relief, "You looked better on Facebook...")
_ArrayAdd($relief, "Jesus Saves, and only takes half damage...")
_ArrayAdd($relief, "I'm not a stalker, I'm just curious...")
_ArrayAdd($relief, "Be nice to nerds, you'll probably end up working for one...")
_ArrayAdd($relief, "Darwin loves you...")
_ArrayAdd($relief, "Dear God: Save us from your followers...")

;_ArrayAdd($relief, "")











