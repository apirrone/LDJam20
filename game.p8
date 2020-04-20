pico-8 cartridge // http://www.pico-8.com
version 21
__lua__


#include drawable.p8
#include character.p8
#include animation.p8
#include ticketsView.p8
#include mapView.p8
#include pcView.p8
#include pcMenus.p8
#include mainMenuView.p8
#include main.p8

__gfx__
bb4444bbbb4444bbbb4444bbbb4444bbbb4444bbbbbbbbbbbb4444bbbb4444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b4455555b4455555b4455555b4455555b4444445bb4444bbb4444445b4444445bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b5556565b5556565b5556565b5556565b5444555b4444445b5444555b5444555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bff55555bff55555bff55555bff55555bf4444fbb5444555bf4444fbbf4444fbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbffffbbb7ffff7bbbffffbbbbffffbbbbffffbbbf4444fbbbffffbbbbffffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b777777b77777777b777777bb777777bb777777bb7ffff7bb777777bb777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
77777777ff7777ff777777777777777777777777777777777777777777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
ff7777ffbbbbbbbbff7777ffff7777ffff7777ffff7777ffff7777ffff7777ffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
ff7777ffff7777ffff7777ffff7777ffff7777ffff7777ffff7777ffff7777ffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
ff5555ffff5555ffbb5555ffff5555bbff5555ffff5555ffbb5555ffff5555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb1111bbbb1111bbbb1115bbbb5111bbbb1111bbbb1111bbbb1115bbbb5111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb5115bbbb5115bbbb51555bb55515bbbb5115bbbb5115bbbb51555bb55515bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b555555bb555555bb555bbbbbbbb555bb555555bb555555bb555bbbbbbbb555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb66666bbbbbbbbbbb66666bbb66666bbb66666bbbbbbbbbbb66666bbb66666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b66fff66bb66666bb66fff66b66fff66b6666666bb66666bb6666666b6666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bffcfcfbb66fff66bffcfcfbbffcfcfbb666666bb6666666b666666bb666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bffffffbbffcfcfbbffffffbbffffffbbf6666fbb666666bbf6666fbbf6666fbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbf22fbbbffffffbbbf22fbbbbf22fbbbbffffbbbf6666fbbbffffbbbbffffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b117871bb1f22f1bb117871bb117871bb111111bb1ffff1bb111111bb111111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
1111811111118111111181111111811111111111111111111111111111111111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
1111811111118111111181111111811111111111111111111111111111111111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
1111811111118111771181111111817711111111111111117711111111111177bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7755557777555577ff555577775555ff7755557777555577ff555577775555ffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
ff1111ffff1111ffbb1111ffff1111bbff1111ffff1111ffbb1111ffff1111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb1111bbbb1111bbbb1115bbbb5111bbbb1111bbbb1111bbbb1111bbbb1111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb5115bbbb5115bbbb51555bb55515bbbb1111bbbb1111bbbb11555bb55511bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b555555bb555555bb555bbbbbbbb555bb555555bb555555bb555bbbbbbbb555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb5555bbbbbbbbbbbb5555bbbb5555bbbb5555bbbbbbbbbbbb5555bbbb5555bb1111111111111111111111111111111111111111111111111111111111111111
b555555bbb5555bbb555555bb555555bb555555bbb5555bbb555555bb555555b1111111111111111111111111111111111111111000000111100000000111111
555cfc55b555555b555cfc55555cfc5555555555b555555b55555555555555551110111110111111111111111111111111111110888888011088888888011111
55ffff55555cfc5555ffff5555ffff55555555555555555555555555555555551107011107011111111111111111111111111111008800111100088000111111
55f88f5555ffff5555f88f5555f88f55555555555555555555555555555555551107011070111111111111111111111111111111108801111111088011111111
5777677555f88f555777677557776775555555555555555555555575577555751107010701111111111111111111111111111111108801111111088011111111
77776777577767757777677777776777775555575755557577555777777557771107007011111111111111111111111111111111108801111111088011111111
77766777777667777776677777766777777557777775577777755777777757771107770111111111111111111111111111111111108801111111088011111111
77776777777767777777677777776777777777777777777777777777777777771107701111111000111110001111000001111111108801111111088011111111
ff7667ffff7667ffff7667ffff7667ffff7777ffff7777ffff7777ffff7777ff1107770111110777011107770110777770111111108801111111088011111111
bb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bb1107007011107000701070007010700007011111108801111111088011111111
bb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bb1107010701107777011077770110701107011111108801111111088011111111
bb7777bbbb7777bbbb7744bbbb4477bbbb7777bbbb7777bbbb7744bbbb4477bb1107011070107000111070001110700007011111008800111011088011011111
bb4444bbbb4444bbbb44444bb44444bbbb4444bbbb4444bbbb44444bb44444bb1107011107010777701107777010777770111110888888010801088010801111
b444444bb444444bb444bbbbbbbb444bb444444bb444444bb444bbbbbbbb444b1110111110111000011110000110700001111111000000111011100111011111
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb1111111111111111111111111110701111111111111111111111111111111111
bb44444bbbbbbbbbbb44444bbb44444bbb44444bbbbbbbbbbb44444bbb44444b1111111111111111111111111110701111111111111111111111111111111111
b44fff4bbb44444bb44fff4bb44fff4bb444444bbb44444bb444444bb444444b1111111114444111111111111110701111111111111111111111111111111111
44fcfcfbb44fff4b44fcfcfb44fcfcfbb444444bb444444bb444444bb444444b1111111144555551111111111110701111111111111111111111111111111111
44fffffb44fcfcfb44fffffb44fffffbb44444fbb444444bb44444fbb44444fb1111111155565651111111111110701111111111111111111111111111111011
44f22fbb44fffffb44f22fbb44f22fbb4444ffbbb44444fb4444ffbbb444ffbb11111111ff555551111111111111011111111111111111111111111111110701
4417711b44f22fbb4417711b4417711b4441111b4444ffbb4441111b4441111b111111111ffff111111111111111111111111111111111111111111111110701
44177111441771114417711144177111441111114441111144111111441111111111111177777711111111111111111111110111101111111111111111110701
11177111441771111117711111177111111111114411111111111111111111111111111777777771f11111111111111111107011070111111111111111110701
11177111111771111117711111177111111111111111111111111111111111111111111ff7777fffff1111111111000011107011101110111011110001110701
11555511115555111155551111555511115555111155551111555511115555111111111ff7777fffff1111111110777701107011070107010701107770110701
ff1111ffff1111ffff1111ffff1111ffff1111ffff1111ffff1111ffff1111ff1111111ff5555111111111111107000701107011070107010701070007011011
bb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bb111111111dddd111111111111107010701107011070110707011077770111111
bb1111bbbb1111bbbb1115bbbb5111bbbb1111bbbb1111bbbb1115bbbb5111bb111111111dddd111111111111107000701107011070110707011070001111011
bb5115bbbb5115bbbb51555bb55515bbbb5115bbbb5115bbbb51555bb55515bb111111111dddd111111111111110777770107011070111070111107777010701
b555555bb555555bb555bbbbbbbb555bb555555bb555555bb555bbbbbbbb555b1111111115dd5111111111111111000001110111101111101111110000111011
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb1111111155555511111111111111111111111111111111111111111111111111
ddddddddff1111ffdddddddddddddddddddddd0000dddddddddddd0000ddddddd070dddd66666666dddd070dddddddddddddd0dddd0ddddd0000000000000000
dddddddddd1111dddddd55ddddddddddddddd077770dddddddddd077770dddddd070dddd66666666dddd070d0dddddd0dddddddddddddddd0000000000000000
ddddddddd444111ddddd155ddddddddddddd07000070ddddddddd600006dddddd070dddd66666666dddd070d6dddddd6dddddddddddddddd0000000000000000
dddddddddd44411ddddd1555d33ddd3ddddd07066070ddddddddd666666dddddd070dddd66666666dddd070d6dddddd6dddddddddddddddd0000000000000000
ddddddddddd55111444455543333d333dddd07066070ddddddddd666666dddddd070dddd66666666dddd070d6dddddd6dddddddddddddddd0000000000000000
dddddddddddd5ddd45544454d333333ddddd07066070ddddddddd666666dddddd070dddd66666666dddd070d6dddddd6dddddddddddddddd0000000000000000
ddddddddd555555d45544555d333333ddddd07066070ddddddddd666666dddddd070dddd66666666dddd070d6dddddd6dddddddddddddddd0000000000000000
ddddddddd5d5dd5d4554444433343333dddd07066070ddddddddd666666dddddd070dddd66666666dddd070d6dddddd6ddddd0dddd0ddddd0000000000000000
dd66666ddddddddd45544555d3d44d3ddddd07000070dddddddd070dd070dddd0070000000000000000007000000000000000000000000000000000000000000
d66fff66dddddddd44444655ddd44ddddddd60777706dddddddd606dd606dddd7777777777777777777777777777777777777777000000000000000000000000
dffcfcfdd444444d44444655ddd44ddddddd66000066dddddddd666dd666dddd0000000000000000000000000000070000700000000000000000000000000000
dffffffddd4444dd44444444ddd44ddddddd66666666dddddddd666dd666dddd6666666666666666666666666666070660706666000000000000000000000000
ddf22fddddd55ddd4dddddd4d555555ddddd66666666dddddddd666dd666dddd6666666666666666666666666666070660706666000000000000000000000000
d117871ddddd5ddd4dddddd4d555555ddddd66666666dddddddd666dd666dddd6666666666666666666666666666070660706666000000000000000000000000
11118111d555555d4dddddd4d555555ddddd66666666dddddddd666dd666dddd6666666666666666666666666666070660706666000000000000000000000000
11118111d5d5dd5d4dddddd4dd5555dddddd66666666dddddddd666dd666dddd6666666666666666666666666666070660706666000000000000000000000000
dddddddd0000000000000000dddd00000000000d0000000000000000000000000070dddd00000000000000000000000000000000000000000000000000000000
dddddddd7777777777775577ddd055555555050d0000000000000000000000007770dddd77777777777777770000000000000000000000000000000000000000
dddddddd0000000000001550dd0000000000550d0000000000000000000000000070dddd00000000000000000000000000000000000000000000000000000000
d33ddd3d6336663666661555dd0555555550500d0000000000000000000000006070dddd66666666666666660000000000000000000000000000000000000000
3333d3333333633344445554dd0585585580050d0000000000000000000000006070dddd66666776688666660000000000000000000000000000000000000000
d333333d6333333645544454dd0000000000550d0000000000000000000000006070dddd66666776688666d60000000000000000000000000000000000000000
d333333d6333333645544555dd0555555550500d0000000000000000000000006070dddd66666776666666d60000000000000000000000000000000000000000
333433333334333345544444dd05b55b55b0050d0000000000000000000000006070dddd66666666666666660000000000000000000000000000000000000000
d3d44d3d0000000000000000dd0000000000550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddd44ddd0000000000000000dd0555555550500d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddd44ddd0000000000000000dd0595595590050d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddd44ddd0000000000000000dd0000000000550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d555555d0000000000000000dd0555555550550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d555555d0000000000000000dd0555555550550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d555555d0000000000000000dd055555555050dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dd5555dd0000000000000000dd00000000000ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbb77bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccc33333333bbbcccbbbbbbbbbbbb1111bb56655665bbbbbbbbbbbbbbbbc8bbbbbb00000000
bbb77777bbb77b6bbbbbb1b1bb6bb6bbbbbbbbbbbbbbbbbbcccccccc33733373bbcccccbb7777bbbb117711b55666655bbbbbbbbbbbbbbbbccbbbbb800000000
ffffffffb6b77b6bbbbccbbbbb6666bbbbb7777bbbbbb555c7cccc7c33773773bcc777ccb777766b1111171156655665bbb22bbbbbb22bbbbbb3bb1800000000
ffffffffb6bbbb6bbbcbbc1bbbb66bbb55555555bb555bbbc77c7c7c33377733bcc7ccccb777777b1117771155555555bb2882bbbb2332bbbbb32b1800000000
ffffffffb6bbbb6bbbcccbbbbbb66bbb5815555555bbbbbbcc7c7c7c33377333bcc777ccb777777b1171171155888855bb2882bbbb2332bbbba32c1800000000
ffffffffb6bbbb6bb1cb1bbbbb6666bb5555555555577777cc77777c33773733bcccc7ccb777777bcc1771cc55855855bbb22bbbbbb22bbbbba32c1800000000
ffffffffb666666b1b1ccbbbbb6bb6bb5555555555555555ccc7c7cc33733773bcc777cbb777777bbcc11ccb58888885bbbbbbbbbbbbbbbbbba32c1800000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccc33333333bbccccbbbbbbbbbbbbccccbb58888885bbbbbbbbbbbbbbbbb555555500000000
bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbb0bbb0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb60060b60060bbbbbb0b0bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb60600060600000bbbb0bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb60060b60060bbbbbb0b0bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbb0bbb0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777755777777777777777777777777777777777777777777777755777777777777777777777777777777777777777777
00000000000000000000000000000000000015500070000000000000000000000000000000000000000015500070000000000000000000000000000000000000
63366636666666666666666666666666666615556070666663366636666666666666666666666666666615556070666663366636666666666666666666666666
33336333666666666666677666666666444455546070666633336333666666666886666666666666444455546070666633336333666666666666677666666666
6333333666666666666667766666666645544454607066666333333666666666688666d666666666455444546070666663333336666666666666677666666666
6333333666666666666667766666666645544555607066666333333666666666666666d666666666455445556070666663333336666666666666677666666666
33343333666666666666666666666666455444446070666633343333666666666666666666666666455444446070666633343333666666666666666666666666
d3d44d3ddddddddddddddddddddddddd45544555d070ddddd3d44d3ddddddddddddddddddddddddd45544555d070ddddd3d44d3ddddddddddddddddddddddddd
ddd44ddddddddddddddddddddddddddd44444655d070ddddddd44ddddddddddddddddddddddddddd44444655d070ddddddd44ddddddddddddddddddddddddddd
ddd44dddddddddddddddddddd444444d44444655d070ddddddd44dddddddddddddddddddd444444d44444655d070ddddddd44dddddddddddddddddddd444444d
ddd44ddddddddddddddddddddd4444dd44444444d070ddddddd44ddddddddddddddddddddd4444dd44444444d070ddddddd44ddddddddddddddddddddd4444dd
d555555dddddddddddddddddddd55ddd4dddddd4d070ddddd555555dddddddddddddddddddd55ddd4dddddd4d070ddddd555555dddddddddddddddddddd55ddd
d555555ddddddddddddddddddddd5ddd4dddddd4d070ddddd555555ddddddddddddddddddddd5ddd4dddddd4d070ddddd555555ddddddddddddddddddddd5ddd
d555555dddddddddddddddddd555555d4dddddd4d070ddddd555555dddddddddddddddddd555555d4dddddd4d070ddddd555555dddddddddddddddddd555555d
dd5555ddddddddddddddddddd5d5dd5d4dddddd4d070dddddd5555ddddddddddddddddddd5d5dd5d4dddddd4d070dddddd5555ddddddddddddddddddd5d5dd5d
ddddddddddddddddddddddddddddddddddddddddd070ddddddddddddddddddddddddddddddddddddddddddddd070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddd55ddd070dddddddddddddddddddddddddddddddddddddddd55ddd070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddd155dd070dddddddddddddddddddddddddddddddddddddddd155dd070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddd1555d070dddddddddddddddddddddddddddddddddddddddd1555d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd44445554d070dddddddddddddddddddddddddddddddddddd44445554d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544454d070dddddddddddddddddddddddddddddddddddd45544454d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544444d070dddddddddddddddddddddddddddddddddddd45544444d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd44444655d070dddddddddddddddddddddddddddddddddddd44444655d070dddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddd444444d44444655d070ddddddddddddddddddddddddddddd444444d44444655d070ddddddddddddddddddddddddddddd444444d
dddddddddddddddddddddddddd4444dd44444444d070dddddddddddddddddddddddddddddd4444dd44444444d070dddddddddddddddddddddddddddddd4444dd
ddddddddddddddddddddddddddd55ddd4dddddd4d070ddddddddddddddddddddddddddddddd55ddd4dddddd4d070ddddddddddddddddddddddddddddddd55ddd
dddddddddddddddddddddddddddd5ddd4dddddd4d070dddddddddddddddddddddddddddddddd5ddd4dddddd4d070dddddddddddddddddddddddddddddddd5ddd
ddddddddddddddddddddddddd555555d4dddddd4d070ddddddddddddddddddddddddddddd555555d4dddddd4d070ddddddddddddddddddddddddddddd555555d
ddddddddddddddddddddddddd5d5dd5d4dddddd4d070ddddddddddddddddddddddddddddd5d5dd5d4dddddd4d070ddddddddddddddddddddddddddddd5d5dd5d
00000000dddddddd0000000000000000000000000070000000000000dddddddd0000000000000000000000000070000000000000dddddddd0000000000000000
777777770dddddd077777777777777777777777777777777777777770dddddd077777777777777777777777777777777777777770dddddd07777777777777777
000000006dddddd600000000000000000000000000000000000000006dddddd600000000000000000000000000000000000000006dddddd60000000000000000
666666666dddddd666666666666666666666666666666666666666666dddddd666666666666666666666666666666666666666666dddddd66666666666666666
666666666dddddd666666666666666666666666666666666666666666dddddd666666666666666666666666666666666666666666dddddd66666666666666666
666666666dddddd666666666666666666666666666666666666666666dddddd666666666666666666666666666666666666666666dddddd66666666666666666
666666666dddddd666666666666666666666666666666666666666666dddddd666666666666666666666666666666666666666666dddddd66666666666666666
666666666dddddd666666666666666666666666666666666666666666dddddd666666666666666666666666666666666666666666dddddd66666666666666666
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd4444dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd4455555dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd5556565dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddff55555dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
00000000dddddddd0000000000000000000000000000000000000000ddddddffff00000000000000000000000000000000000000dddddddd0000000000000000
777777770dddddd077777777777777777777557777777777777777770dddd77777777777777777777777557777777777777777770dddddd07777777777777777
000000006dddddd600000000000000000000155000700000000000006ddd777777770000000000000000155000700000000000006dddddd60000000000000000
633666366dddddd666666666666666666666155560706666633666366dddff7777ff6666666666666666155560706666666666666dddddd66666666666666666
333363336dddddd666666666666666664444555460706666333363336dddff7777ff6666666667764444555460706666666666666dddddd66666677666666666
633333366dddddd666666666666666664554445460706666633333366dddff5555ff6666666667764554445460706666666666666dddddd66666677666666666
633333366dddddd666666666666666664554455560706666633333366ddddd1111666666666667764554455560706666666666666dddddd66666677666666666
333433336dddddd666666666666666664554444460706666333433336ddddd1111666666666666664554444460706666666666666dddddd66666666666666666
d3d44d3ddddddddddddddddddddddddd45544555d070ddddd3d44d3ddddddd1111dddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd
ddd44ddddddddddddddddddddddddddd44444655d070ddddddd44ddddddddfffffffdddddddddddd44444655d070dddddddddddddddddddddddddddddddddddd
ddd44dddddddddddddddddddd444444d44444655d070ddddddd44ddddddddf55555fddddd444444d44444655d070ddddddddddddddddddddddddddddd444444d
ddd44ddddddddddddddddddddd4444dd44444444d070ddddddd44ddddddddfffffffdddddd4444dd44444444d070dddddddddddddddddddddddddddddd4444dd
d555555dddddddddddddddddddd55ddd4dddddd4d070ddddd555555dddddddddddddddddddd55ddd4dddddd4d070ddddddddddddddddddddddddddddddd55ddd
d555555ddddddddddddddddddddd5ddd4dddddd4d070ddddd555555ddddddddddddddddddddd5ddd4dddddd4d070dddddddddddddddddddddddddddddddd5ddd
d555555dddddddddddddddddd555555d4dddddd4d070ddddd555555dddddddddddddddddd555555d4dddddd4d070ddddddddddddddddddddddddddddd555555d
dd5555ddddddddddddddddddd5d5dd5d4dddddd4d070dddddd5555ddddddddddddddddddd5d5dd5d4dddddd4d070ddddddddddddddddddddddddddddd5d5dd5d
ddddddddddddddddddddddddddddddddddddddddd070ddddddddddddddddddddddddddddddddddddddddddddd070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddd55ddd070dddddddddddddddddddddddddddddddddddddddd55ddd070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddd155dd070dddddddddddddddddddddddddddddddddddddddd155dd070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddd1555d070dddddddddddddddddddddddddddddddddddddddd1555d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd44445554d070dddddddddddddddddddddddddddddddddddd44445554d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544454d070dddddddddddddddddddddddddddddddddddd45544454d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544444d070dddddddddddddddddddddddddddddddddddd45544444d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddd44444655d070dddddddddddddddddddddddddddddddddddd44444655d070dddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddd444444d44444655d070ddddddddddddddddddddddddddddd444444d44444655d070ddddddddddddddddddddddddddddd444444d
dddddddddddddddddddddddddd4444dd44444444d070dddddddddddddddddddddddddddddd4444dd44444444d070dddddddddddddddddddddddddddddd4444dd
ddddddddddddddddddddddddddd55ddd4dddddd4d070ddddddddddddddddddddddddddddddd55ddd4dddddd4d070ddddddddddddddddddddddddddddddd55ddd
dddddddddddddddddddddddddddd5ddd4dddddd4d070dddddddddddddddddddddddddddddddd5ddd4dddddd4d070dddddddddddddddddddddddddddddddd5ddd
ddddddddddddddddddddddddd555555d4dddddd4d070ddddddddddddddddddddddddddddd555555d4dddddd4d070ddddddddddddddddddddddddddddd555555d
ddddddddddddddddddddddddd5d5dd5d4dddddd4d070ddddddddddddddddddddddddddddd5d5dd5d4dddddd4d070ddddddddddddddddddddddddddddd5d5dd5d
00000000000000000000000000000000000000000070000000000000000000000000000000000000000000000070000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777775577777777777777777777777777777777777777777777775577
00000000000000000000000000000000007000000000000000000000000000000000000000001550007000000000000000000000000000000000000000001550
66666666666666666666666666666666607066666666666666666666666666666666666666661555607066666666666663366636666666666666666666661555
66666666666666666666666666666666607066666666666666666666666667766666666644445554607066666666666633336333688666666666666644445554
66666666666666666666666666666666607066666666666666666666666667766666666645544454607066666666666663333336688666d66666666645544454
66666666666666666666666666666666607066666666666666666666666667766666666645544555607066666666666663333336666666d66666666645544555
66666666666666666666666666666666607066666666666666666666666666666666666645544444607066666666666633343333666666666666666645544444
dddddddddddddddddddd00000000000dd070dddddddddddddddddddddddddddddddddddd45544555d070ddddddddddddd3d44d3ddddddddddddddddd45544555
ddddddddddddddddddd055555555050dd070dddddddddddddddddddddddddddddddddddd44444655d070ddddddddddddddd44ddddddddddddddddddd44444655
dddddddddddddddddd0000000000550dd070ddddddddddddddddddddddddddddd444444d44444655d070ddddddddddddddd44dddddddddddd444444d44444655
dddddddddddddddddd0555555550500dd070dddddddddddddddddddddddddddddd4444dd44444444d070ddddddddddddddd44ddddddddddddd4444dd44444444
dddddddddddddddddd0585585580050dd070ddddddddddddddddddddddddddddddd55ddd4dddddd4d070ddddddddddddd555555dddddddddddd55ddd4dddddd4
dddddddddddddddddd0000000000550dd070dddddddddddddddddddddddddddddddd5ddd4dddddd4d070ddddddddddddd555555ddddddddddddd5ddd4dddddd4
dddddddddddddddddd0555555550500dd070ddddddddddddddddddddddddddddd555555d4dddddd4d070ddddddddddddd555555dddddddddd555555d4dddddd4
dddddddddddddddddd0505505500050dd070ddddddddddddddddddddddddddddd5d5dd5d4dddddd4d070dddddddddddddd5555ddddddddddd5d5dd5d4dddddd4
dddddddddddddddddd0000000000550dd070ddddddddddddddddddddddddddddddddddddddddddddd070dddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddd0555555550500dd070dddddddddddddddddddddddddddddddddddddddd55ddd070dddddddddddddddddddddddddddddddddddddddd55dd
dddddddddddddddddd0595595590050dd070dddddddddddddddddddddddddddddddddddddddd155dd070dddddddddddddddddddddddddddddddddddddddd155d
dddddddddddddddddd0000000000550dd070dddddddddddddddddddddddddddddddddddddddd1555d070dddddddddddddddddddddddddddddddddddddddd1555
dddddddddddddddddd0555555550550dd070dddddddddddddddddddddddddddddddddddd44445554d070dddddddddddddddddddddddddddddddddddd44445554
dddddddddddddddddd0555555550550dd070dddddddddddddddddddddddddddddddddddd45544454d070dddddddddddddddddddddddddddddddddddd45544454
dddddddddddddddddd055555555050ddd070dddddddddddddddddddddddddddddddddddd45544555d070dddddddddddddddddddddddddddddddddddd45544555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555ff5f5f55ff5f5f55555fff5fff55ff5f5f5fff5fff55ff555555fffff55555555555555555555555fff5ff55fff5fff5fff5fff55ff5fff555555fffff555
55f555f5f5f5f5f5f555555f555f55f555f5f5f5555f55f5555f55ff555ff55555555555555555555555f55f5f55f55f555f5f5f5f5f5555f555f55ff5f5ff55
55fff5fff5f5f5f5f555555f555f55f555ff55ff555f55fff55555ff5f5ff55555555555555555555555f55f5f55f55ff55ff55fff5f5555f555555fff5fff55
5555f5f5f5f5f5fff555555f555f55f555f5f5f5555f5555f55f55ff555ff55555555555555555555555f55f5f55f55f555f5f5f5f5f5555f555f55ff5f5ff55
55ff55f5f5ff55fff555555f55fff55ff5f5f5fff55f55ff5555555fffff55555555555555555555555fff5f5f55f55fff5f5f5f5f55ff55f5555555fffff555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0080c000808000008080800000000000802080808080000080808080800000008080c0808000000080808000000000008000008080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
a199a999a29ca199aa99a29ca199a999a29ca1aa9999a29ca1999999a29ca1999999a29ca1999999a29ca1999999a29ca1999999a2858080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b08080919288b08080919288b08080919288b08080919288b08080919288b08080919288b08080919288b08080919288b080809192888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808082888080808082888080808082888080808082888080808082888080808082888080808082888080808082888080808082888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080809192888080809192888080809192888080809192888080809192888080809192888080809192888080809192888080809192888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
998b99999998998b99999998998b99999998998b99999998998b99999998998b99999998998b99999998998b99999998998b999999a88080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a18b9999a29ca18b99a9a29c998ba999a29ca18b99a9a285808080808084a18baa99a29ca18ba9a9a29ca18ba999a29ca18b99aaa2a88080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b08080919288b08080919288808080919288b0808091928880808080808ab08080919288b08080919288b08080919288b080809192888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80808080828880808080828880808080828880808080828880808080808a8080808082888080808082888080808082888080808082888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80808091928880808091928880808091928880808091928880808080808a8080809192888080809192888080809192888080809192888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
999999999c9899a999a29c98a1aa99a29c989999aa99a2a8808080808094999999999b989999aa999c9899999b999998999c999999a88080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080a3a48880808091928880b08091928880808080919288808080808080808080808a8080808080888080808a8080808088808082888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080b3b48880808080828880808080828880808080808288808080808080808080808a8080808080888080808a8080808088809192888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
808080808880808091928880808091928880808080919288808080808080808080808a8080808080888080808a8080808088808080888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
998b9999988b99999999988b99999999988b9999999999958080808080808080808094998b999999988b99999a99998b9998998b99a88080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080888080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999958080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b6b6b6000000a6a60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010a0000371303714037150371503216032170321703217030170301703017030170301703017037170371603714037120321203212032120321203211032110321001560015600156001560015600146000d000
__music__
00 00424344

