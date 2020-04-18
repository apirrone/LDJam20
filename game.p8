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
#include main.p8

__gfx__
bb4444bbbbbbbbbbbb4444bbbb4444bbbb4444bbbbbbbbbbbb4444bbbb4444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b4455555bb4444bbb4455555b4455555b4444445bb4444bbb4444445b4444445bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b5556565b4455555b5556565b5556565b5444555b4444445b5444555b5444555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bff55555b5556565bff55555bff55555bf4444fbb5444555bf4444fbbf4444fbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbffffbbbff55555bbffffbbbbffffbbbbffffbbbf4444fbbbffffbbbbffffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b777777bb7ffff7bb777777bb777777bb777777bb7ffff7bb777777bb777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7777777777777777777777777777777777777777777777777777777777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
ff7777ffff7777ffff7777ffff7777ffff7777ffff7777ffff7777ffff7777ffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
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
bb5555bbbbbbbbbbbb5555bbbb5555bbbb5555bbbbbbbbbbbb5555bbbb5555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b555555bbb5555bbb555555bb555555bb555555bbb5555bbb555555bb555555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
555cfc55b555555b555cfc55555cfc5555555555b555555b5555555555555555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
55ffff55555cfc5555ffff5555ffff5555555555555555555555555555555555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
55f88f5555ffff5555f88f5555f88f5555555555555555555555555555555555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
5777677555f88f55577767755777677555555555555555555555557557755575bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7777677757776775777767777777677777555557575555757755577777755777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7776677777766777777667777776677777755777777557777775577777775777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7777677777776777777767777777677777777777777777777777777777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
ff7667ffff7667ffff7667ffff7667ffff7777ffff7777ffff7777ffff7777ffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbb7777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb7777bbbb7777bbbb7744bbbb4477bbbb7777bbbb7777bbbb7744bbbb4477bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb4444bbbb4444bbbb44444bb44444bbbb4444bbbb4444bbbb44444bb44444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b444444bb444444bb444bbbbbbbb444bb444444bb444444bb444bbbbbbbb444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb44444bbbbbbbbbbb44444bbb44444bbb44444bbbbbbbbbbb44444bbb44444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b44fff4bbb44444bb44fff4bb44fff4bb444444bbb44444bb444444bb444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
44fcfcfbb44fff4b44fcfcfb44fcfcfbb444444bb444444bb444444bb444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
44fffffb44fcfcfb44fffffb44fffffbb44444fbb444444bb44444fbb44444fbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
44f22fbb44fffffb44f22fbb44f22fbb4444ffbbb44444fb4444ffbbb444ffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
4417711b44f22fbb4417711b4417711b4441111b4444ffbb4441111b4441111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
4417711144177111441771114417711144111111444111114411111144111111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
1117711144177111111771111117711111111111441111111111111111111111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
1117711111177111111771111117711111111111111111111111111111111111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
1155551111555511115555111155551111555511115555111155551111555511bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
ff1111ffff1111ffff1111ffff1111ffff1111ffff1111ffff1111ffff1111ffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbb1111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb1111bbbb1111bbbb1115bbbb5111bbbb1111bbbb1111bbbb1115bbbb5111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb5115bbbb5115bbbb51555bb55515bbbb5115bbbb5115bbbb51555bb55515bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b555555bb555555bb555bbbbbbbb555bb555555bb555555bb555bbbbbbbb555bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
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
dddddddd0000000000000000dddd00000000000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd7777777777775577ddd055555555050d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd0000000000001550dd0000000000550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d33ddd3d6336663666661555dd0555555550500d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333d3333333633344445554dd0585585580050d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d333333d6333333645544454dd0000000000550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d333333d6333333645544555dd0555555550500d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333433333334333345544444dd05b55b55b0050d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d3d44d3d0000000000000000dd0000000000550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddd44ddd0000000000000000dd0555555550500d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddd44ddd0000000000000000dd0595595590050d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddd44ddd0000000000000000dd0000000000550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d555555d0000000000000000dd0555555550550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d555555d0000000000000000dd0555555550550d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d555555d0000000000000000dd055555555050dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dd5555dd0000000000000000dd00000000000ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000077000000000000000000000000000000000000ccccccccbbbbbbbb000ccc0000000000001111005665566500000000000000000000000000000000
000777770007706000000101006006000000000000000000ccccccccbb7bbb7b00ccccc007777000011771105566665500000000000000000000000000000000
ffffffff06077060000cc000006666000007777000000555c7cccc7cbb77b77b0cc777cc07777660111117115665566500022000000220000000000000000000
ffffffff0600006000c00c10000660005555555500555000c77c7c7cbbb777bb0cc7cccc07777770111777115555555500288200002332000000000000000000
ffffffff0600006000ccc000000660005815555555000000cc7c7c7cbbb77bbb0cc777cc07777770117117115588885500288200002332000000000000000000
ffffffff0600006001c01000006666005555555555577777cc77777cbb77b7bb0cccc7cc07777770cc1771cc5585585500022000000220000000000000000000
ffffffff06666660101cc000006006005555555555555555ccc7c7ccbb7bb77b0cc777c0077777700cc11cc05888888500000000000000000000000000000000
000000000000000000000000000000000000000000000000ccccccccbbbbbbbb00cccc000000000000cccc005888888500000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0080800080800000808080000000000080808080808000008080808080000000808080808000000000000000000000008000008080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99a19b9999a29ca199a19b9999a29c9999999999999999999999999999998080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80b08a80919288b080b08a809192888080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80808a808080888080808a809082888080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
808094998b99958080808a808192888080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808096869999958080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9999999985808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808088808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
808080808d808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808088808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808088808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808088808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
808080808d808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808088808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9999999995808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010a00002c1002d1002c1002f1002c1002d1002e1002c1002a1002b10009000100000d100111000f100131000d1000d1000f100101000e1000d1000e1000f000156001560015600156001560015600146000d000
