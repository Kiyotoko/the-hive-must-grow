pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- game
-- by leo, ella and karl

#include utils.lua
#include map.lua
#include player.lua
#include buildings.lua
#include ui.lua
#include main.lua

__gfx__
ffffffffffffffffffffffffffffffffffffffffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
f777fffffffffffffff33fffffffffffffffffffbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb11bbbb11bbbb11bbbbb
f70077fffff33fffff3333ffff66dfffffffffffbbbbbbbbbbbbbbbbbbbbbbbbb222222bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb1441111551111441bbbb
f700007fff3311ffff1133ffff6677f7f66d77f7bbbbb3bbbbbbbb3bbbb0abbb29944992bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb144666d55d666441bbbb
ff7007fff13333fffff11ffffa0a70a0f66a70a0b3bb3bbbbb3bb3bbbbbbbbb277aaaaaa2bbbbbbbbbbbb0abb222222bbbbbba0bbbbb1441111551111441bbbb
ff70707ff113331fff3111fffa0a0aaffa0a0aafbb3b3bbbbb3b3bbbbbbbbb299944449992bbbbbbbbbbbbbb29944992bbbbbbbbbbbb1441bbb55bbb1441bbbb
fff7f707fff111ffff3331fff9090ffff9090fffbbbbbbbbbbbbbbbbbbbbb277aaaaaaaaaa2bbba0bbbbbb2277aaaaaa22bbbbbbbbbb1441bbb55bbb1441bbbb
ffffff77fffffffff333333fffffffffffffffffbbbbbbbbbbbbbbbbbbbbb299aaaaaaaa992bbbbbbbbbb29999444499992bbbbbbbbb1421bbb55bbb1241bbbb
00000000fffffffff111333f0000000000000000bbbbbbbbbbbbbbbbbbbb2999994444999992bbbbbbbb2999aaaaaaaa9992bbbbbbbb1421bb1551bb1241bbbb
00000000ffffffffff1113ff0066d00000000000bbbbbbbbbbbbbbbbbbbb277aaaaaaaaaaaa2bbbbbbb299999944449999992bbbbbbb1221111551111221bbbb
00000000ffffffffff1221ff00667707066d7707bbbbbbbbbbbbbbbbbbbb29aaaaaaaaaaaa92bbbbbbb277aaaaaaaaaaaaaa2bbbbbbb12211115111112211bbb
00000000fffffffffff44fff0a0a70a0066a70a0bbbbbbbbbbbbbbbbbbbb299aaaaaaaaaa992bbbbbbb29aaaaaaaaaaaaaa92bbbbbb1d21111115111112dd1bb
00000000fffffffffff44fff0a0a0aa00a0a0aa0bbbb3bbbbb3bbbbbbbb299994444444499992bbbbbb299aaaaaaaaaaaa992bbbbbb1d21111151111112dd1bb
00000000fffffffffff44fff0909000009090000bb3b3bbbbb3b3bbbbbb277aaaaaaaaaaaaaa2bbbbb29999944444444999992bbbbb1d611111111111166d1bb
00000000ffffffffff4224ff0009090000090900b333333bb333333bbbb277aaaaaaaaaaaaaa2bbbbb277aaaaaaaaaaaaaaaa2bbbbbb1d6611111111166d1bbb
00000000ffffffffffffffff0000000000000000bbbbbbbbbbbbbbbbbbbb29aaaaaaaaaaaa92bbbbbbb29aaaaaaaaaaaaaa92bbbbbbb16dd666666666ddd1bbb
0000000000000000bbbb0bbbbbbb0bbbbbbbbbbbbbbbbb1bbbbbbbbbbbbb29994444444499928998bbb299994444444499992998bbbb1666dddddddd666d1bbb
0000000000000000bbb0a0bbb000400bbbb0bbbbbbbbb1e1bbb1bbbbbbbb277aaaaaaaaaaaa2b88bbbb277aaaaaaaaaaaaaa288bbbbb16666d6666d6666d1bbb
0000000000000000bb09a0bb04404040bb040b0bbbb11ee1bb181bbbbbbbb299aaaaaaaa992bb33bbbbb2999aaaaaaaa9992b33bbbb316666d6666d666dd13bb
0000000000000000bb09a0bbb0404420bbb04040bb1e13e1b18881bbbb33332222222222223333bbbb3ee3222222222222333ccbbb3316666d6666ddddd13333
0000000000000000b099a0bbb024400bbb004220b1aee331b1a83e1bbbbeebbbbb33333bbbbbbccbbbeaaebbbb33333bbbbbc99cb33331166666ddddd1133333
0000000000000000b099aa0bbb0220bbb04420031a9a38311a9aeee1bbeaaebbbbbbbbaabbbbc99cbbeaaebbbbbbbbaabbbbbccbbbb3333111111111133333bb
0000000000000000bb0990bbbb0220bb0420033bb1a38881b1a33e1bbbbeebbbbbbbbba9aabbb33bbbbeebbbbbbbbba9aabbb33bbbbbb33333333333333bbbbb
0000000000000000bbb00bbbbbb0033b00033bbbbb11111bbb1111bbbbb33bbbbbbbbbb39abbbbbbbbb33bbbbbbbbbb39abbbbbbbbbbbbbbb333333bbbbbbbbb
000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbb1bbbbbbbbbbbbbbbbbbb22bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000000000000000000000bbbbbbbbbbbbbbbbbb1bb1bbbb1c111bbbbbbbb22222bb2bb2bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000000000000000000000bbbbbbbbbbbb00bbb1a11c1bb1cdc881bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000000000000000000000bb000bbbbb00660b1a9accc1b1ec1881bbbbbbbb222bbb222bbbbbbbbbbbbbb2222bbb2222bbbbbbbbbb111bbbb11bbbb111bbbb
000000000000000000000000b06660bbb066dd0bb1a8ccc11e8e1881bbbbbbb26662226662bbba0bbbbbbbbb222bbb222bbbbbbbbbb144411115511114441bbb
000000000000000000000000b06dd0bbb06ddd0bb1888c1bb1e31331bbbbbb2770099900772bbbbbbbbbbbb26662226662bbbbbbbbb1444666d55d6664441bbb
000000000000000000000000bb00033bbb000033b138831bb1331331b0abbb2700099900072bbbbbbbb0ab2770099900772ba0bbbbb144411115511114441bbb
000000000000000000000000bbb33bbbbbbb33bbbb1111bbbb11b11bbbbbbbb20009990002bbbbbbbbbbbb2700099900072bbbbbbbb14441bbb55bbb14441bbb
000000000000000000aa00000000000000000000bbbbbbbbbbbbbbbbb11111b2e99aa99e2b11111bbbbbbbb20009990002bbbbbbbbb14421bbb55bbb12241bbb
0000000000000000000000000000000000000000bbb11bbbbb1bbbbbb1cccc12999aaaaa21cccc1bbb111112e999a99e2b1111bbbbb14421bb1551bb12241bbb
0000000000000000000000000000000000000000bb1881bbb1c111bbb1cccc20000aa0002ccccc1bbb1cccc29999aaaa21ccc1bbbbb122211115511112221bbb
0000000000000000000000000000000000000000b188881b1cdcaa1bb1cccc200000000002cccc1bbb1cccc00000a0002cccc1bbbbb1222111151111122211bb
0000000000000000000000000000000000000000bb1881bbb1ca99a1bb1ccc299990099992cccc1bbb1cccc00000000002ccc1bbbb1d2211111151111112dd1b
0000000000000000000000000000000000000000bb1331bbb131aa1bbbb1c29999999aaaaa2cc1bbbbb11c299999999999cc1bbbbb1d2211111511111112dd1b
0000000000000000000000000000000000000000bb1331bbb131331bbbbb12999aaaaaaaaaa21bbbbbbbb1299aaaaaaaaa21bbbbbb1d66111111111111166d1b
0000000000000000000000000000000000000000bbb11bbbbb1b11bbbbbbb2999aaaaaaaaa02bbbbbbbbbb299aaaaaaaaa2bbbbbbbb1dd66111111111666d1bb
0000000000000000000000000000000000000000bbbbbbbbbbbbbbbba0bb20000aaaaa000002bbbbbba0b2000aaaaa00002bbbbbbbb166dd666666666dddd1bb
0000000000000000000000000000000000000000bbbbbbbbbbb1bbbbbbbb20000000000000a2bbbbbbbbb20000000000002bbbbbbbb16666dddddddd6666d1bb
0000000000000000000000000000000000000000bbbbbbbbbb1a11bbbbb299999000009999aa2bbbbbbb2999900000999992bbbbbb3166666d6666d6666dd13b
0000000000000000000000000000000000000000bbbbbbbbb1a9ae1bbbb29999999999aaaaaa2bbbbbbb2999999999aaaaa2bbbb333166666d6666dddddd1333
0000000000000000000000000000000000000000bbbbbbbb183aeee1bbb2999aaaaaaaaaaaaa2bbbbbbb299aaaaaaaaaaaa2bbbb333311166666ddddd1113333
0000000000000000000000000000000000000000bbbbbbbb18833e1bb333299aaaaaaaaaaaa2333bbb33329aaaaaaaaaaa2333bbbb333331111111111333333b
0000000000000000000000000000000000000000bbbbbbbb1833331bbb33329aaaaaaaaaa22333bbbbb3332aaaaaaaaaa2333bbbbbbb3333333333333333bbbb
0000000000000000000000000000000000000000bbbbbbbbb11111bbbbb333222222222223333bbbbbbb3332222222222333bbbbbbbbbb33333333333bbbbbbb
00000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000fffffffffff444ffffffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffffff4444ffffffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000fffffffff444444fffffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffff444444444fffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffff444444444444ffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000fffff44442222224444fffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000fffffff222ee2ee22fffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffff2eeeeeee2fffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffff226606622fffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffff266060662fffffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000fffffffff6666606ffffffff000000000044440000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000fffffffff2662662ffffffff000000000040040000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffffff22222fffffffff000000000424424000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ffffffffff22222fffffffff000000000444444000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000444444400000000000000000244442888888888000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000044444000000000000000000222222cccccccc0000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000444444400000000000000000888888888888800000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000022222220000000000000000ccccccccccccc000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004222222224000000000000888888888888800000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000002444444444420000000000ccccccccccccc000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000022224444444444222000000888888888888880000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020000
0100000000000000000000000000000001010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000001010101010101010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000
__map__
0d0e0f3d3e3f0708090a0b0c1102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e1f4d4e4f1718191a1b1c0112000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d2e2f5d5e5f2728292a2b2c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6768698788893738393a3b3c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7778798a8b8c4748494a4b4c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000005758595a5b5c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002b3602b3602b3602b36015520105200e5200c5200c5300c5300c5300d7300d7300f73010720127201472015720177201a7201f42024410274102a4102d410304103041031410304102e4102471020710
000100000f2101021011210122101421015210172101b2101e210251102b1103012036120360203402032020310202e0202c0102b010290102501021010200101d0101b0101a0101a01018010170101501014010
00020000295702b5712d5712f57131570335703657038560385603956039547385473854738547385471f7401e7401d7301c7301b7301a7201972017721167211572114722127121171210712107100f7100d710
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0020000018a5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
