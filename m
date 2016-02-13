Received: from imap.thunk.org ([74.207.234.97]:34541 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH-v3 00/16] tmpfs and other misc fixups for xfstests
Date: Sat, 13 Feb 2016 12:40:53 -0500
Message-Id: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The first and last patches in these series not related to tmpfs
support.  The first is a resed of a patch to fix ext4/001 to account
for different output if delayed allocation is turned off.  The last is
a cleanup patch to remove _need_to_be_root.

Hugh Dickins (7):
  common: _scratch_mkfs_sized() for tmpfs
  generic: use mount point instead of device name
  generic: require fiemap for generic/009
  xfstests: remove dependency on /proc/partitions for generic/312
  xfstests: generic/079 and generic/277 requires chattr, not xattrs
  xfstests: add executable permission to tests
  xfstests: increase tmpfs memory size

Junho Ryu (2):
  xfstests: do not unmount tmpfs during remount
  generic: do not unmount before calling _check_scratch_fs()

Theodore Ts'o (7):
  ext4/001: add output variant for nodelalloc mounts
  check: avoid spurious complaints that tests/$FSTYP/group does not
    exist
  generic: remove the generic/125 test
  generic: add _require_odirect to generic/113 and generic/214
  Rename _scratch_mount to _scratch_cycle_mount
  Rename _test_mount to _test_cycle_mount
  xfstests: remove _need_to_be_root

 README                        |   4 -
 check                         |   6 +
 common/config                 |   4 +-
 common/defrag                 |   2 +-
 common/dump                   |   2 -
 common/rc                     |  69 +++++++--
 tests/btrfs/001               |   6 +-
 tests/btrfs/002               |   1 -
 tests/btrfs/003               |   1 -
 tests/btrfs/004               |   1 -
 tests/btrfs/005               |   2 +-
 tests/btrfs/007               |   1 -
 tests/btrfs/011               |   1 -
 tests/btrfs/017               |   1 -
 tests/btrfs/025               |   1 -
 tests/btrfs/026               |   3 +-
 tests/btrfs/029               |   1 -
 tests/btrfs/030               |   1 -
 tests/btrfs/031               |   1 -
 tests/btrfs/034               |   1 -
 tests/btrfs/037               |   1 -
 tests/btrfs/038               |   1 -
 tests/btrfs/039               |   1 -
 tests/btrfs/040               |   1 -
 tests/btrfs/041               |   1 -
 tests/btrfs/043               |   1 -
 tests/btrfs/044               |   1 -
 tests/btrfs/045               |   1 -
 tests/btrfs/046               |   1 -
 tests/btrfs/047               |   1 -
 tests/btrfs/048               |   1 -
 tests/btrfs/049               |   1 -
 tests/btrfs/050               |   1 -
 tests/btrfs/051               |   1 -
 tests/btrfs/052               |   3 +-
 tests/btrfs/053               |   1 -
 tests/btrfs/054               |   1 -
 tests/btrfs/055               |   1 -
 tests/btrfs/056               |   1 -
 tests/btrfs/057               |   1 -
 tests/btrfs/058               |   1 -
 tests/btrfs/059               |   1 -
 tests/btrfs/076               |   1 -
 tests/btrfs/077               |   1 -
 tests/btrfs/078               |   1 -
 tests/btrfs/079               |   1 -
 tests/btrfs/080               |   1 -
 tests/btrfs/081               |   3 +-
 tests/btrfs/083               |   1 -
 tests/btrfs/084               |   1 -
 tests/btrfs/085               |   1 -
 tests/btrfs/086               |   1 -
 tests/btrfs/087               |   1 -
 tests/btrfs/088               |   3 +-
 tests/btrfs/089               |   1 -
 tests/btrfs/091               |   1 -
 tests/btrfs/092               |   1 -
 tests/btrfs/093               |   1 -
 tests/btrfs/094               |   1 -
 tests/btrfs/095               |   1 -
 tests/btrfs/096               |   1 -
 tests/btrfs/097               |   1 -
 tests/btrfs/098               |   1 -
 tests/btrfs/099               |   1 -
 tests/btrfs/100               |   1 -
 tests/btrfs/101               |   1 -
 tests/btrfs/102               |   3 +-
 tests/btrfs/103               |   3 +-
 tests/btrfs/104               |   3 +-
 tests/btrfs/105               |   3 +-
 tests/btrfs/106               |   3 +-
 tests/btrfs/107               |   1 -
 tests/btrfs/108               |   1 -
 tests/btrfs/109               |   1 -
 tests/btrfs/110               |   1 -
 tests/btrfs/111               |   1 -
 tests/btrfs/112               |   1 -
 tests/btrfs/113               |   1 -
 tests/btrfs/114               |   0
 tests/btrfs/116               |   1 -
 tests/btrfs/117               |   1 -
 tests/ext4/001.cfg            |   2 +
 tests/ext4/001.out.nodelalloc | 337 ++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/271                |   1 -
 tests/ext4/301                |   1 -
 tests/ext4/302                |   1 -
 tests/ext4/303                |   1 -
 tests/ext4/304                |   1 -
 tests/ext4/307                |   1 -
 tests/ext4/308                |   1 -
 tests/f2fs/001                |   2 +-
 tests/generic/003             |  20 +--
 tests/generic/009             |   2 +
 tests/generic/013             |   2 +-
 tests/generic/019             |   1 -
 tests/generic/026             |   1 -
 tests/generic/029             |   6 +-
 tests/generic/030             |   6 +-
 tests/generic/031             |   2 +-
 tests/generic/032             |   2 +-
 tests/generic/033             |   2 +-
 tests/generic/034             |   1 -
 tests/generic/037             |   1 -
 tests/generic/038             |   1 -
 tests/generic/039             |   1 -
 tests/generic/040             |   1 -
 tests/generic/041             |   1 -
 tests/generic/053             |   2 -
 tests/generic/053.out         |   2 -
 tests/generic/056             |   1 -
 tests/generic/057             |   1 -
 tests/generic/058             |   0
 tests/generic/059             |   1 -
 tests/generic/060             |   0
 tests/generic/061             |   0
 tests/generic/063             |   0
 tests/generic/065             |   1 -
 tests/generic/066             |   1 -
 tests/generic/071             |   3 +-
 tests/generic/073             |   1 -
 tests/generic/079             |   2 +-
 tests/generic/090             |   1 -
 tests/generic/092             |   0
 tests/generic/093             |   2 -
 tests/generic/094             |   0
 tests/generic/098             |   3 +-
 tests/generic/101             |   1 -
 tests/generic/102             |   1 -
 tests/generic/103             |   0
 tests/generic/104             |   1 -
 tests/generic/106             |   1 -
 tests/generic/107             |   1 -
 tests/generic/113             |   1 +
 tests/generic/116             |   4 +-
 tests/generic/118             |   4 +-
 tests/generic/119             |   6 +-
 tests/generic/121             |   4 +-
 tests/generic/122             |   4 +-
 tests/generic/125             |  68 ---------
 tests/generic/125.out         |   7 -
 tests/generic/134             |   4 +-
 tests/generic/135             |  17 +--
 tests/generic/136             |   4 +-
 tests/generic/137             |   2 +-
 tests/generic/138             |   4 +-
 tests/generic/139             |   4 +-
 tests/generic/140             |   4 +-
 tests/generic/142             |   6 +-
 tests/generic/143             |   6 +-
 tests/generic/144             |   4 +-
 tests/generic/145             |   4 +-
 tests/generic/146             |   4 +-
 tests/generic/147             |   4 +-
 tests/generic/148             |   4 +-
 tests/generic/149             |   4 +-
 tests/generic/150             |   2 +-
 tests/generic/151             |   6 +-
 tests/generic/152             |   6 +-
 tests/generic/153             |   8 +-
 tests/generic/154             |  10 +-
 tests/generic/155             |  10 +-
 tests/generic/156             |  12 +-
 tests/generic/161             |   2 +-
 tests/generic/162             |   2 +-
 tests/generic/163             |   2 +-
 tests/generic/164             |   2 +-
 tests/generic/165             |   2 +-
 tests/generic/166             |   2 +-
 tests/generic/167             |   2 +-
 tests/generic/168             |   2 +-
 tests/generic/169             |  20 +--
 tests/generic/169.out         |   6 +-
 tests/generic/170             |   2 +-
 tests/generic/171             |   2 +-
 tests/generic/172             |   2 +-
 tests/generic/173             |   2 +-
 tests/generic/174             |   2 +-
 tests/generic/175             |   2 +-
 tests/generic/176             |   2 +-
 tests/generic/177             |   1 -
 tests/generic/178             |   4 +-
 tests/generic/179             |   4 +-
 tests/generic/180             |   4 +-
 tests/generic/181             |   2 +-
 tests/generic/182             |   6 +-
 tests/generic/183             |   4 +-
 tests/generic/185             |   4 +-
 tests/generic/186             |   6 +-
 tests/generic/187             |   6 +-
 tests/generic/188             |   4 +-
 tests/generic/189             |   4 +-
 tests/generic/190             |   4 +-
 tests/generic/191             |   4 +-
 tests/generic/192             |   3 +-
 tests/generic/193             |   1 -
 tests/generic/194             |   4 +-
 tests/generic/195             |   4 +-
 tests/generic/196             |   4 +-
 tests/generic/197             |   4 +-
 tests/generic/199             |   4 +-
 tests/generic/200             |   4 +-
 tests/generic/201             |   2 +-
 tests/generic/202             |   4 +-
 tests/generic/203             |   4 +-
 tests/generic/205             |   4 +-
 tests/generic/206             |   4 +-
 tests/generic/214             |   1 +
 tests/generic/216             |   4 +-
 tests/generic/217             |   4 +-
 tests/generic/218             |   4 +-
 tests/generic/220             |   4 +-
 tests/generic/222             |   4 +-
 tests/generic/226             |   3 +-
 tests/generic/227             |   4 +-
 tests/generic/229             |   4 +-
 tests/generic/230             |   1 -
 tests/generic/231             |   1 -
 tests/generic/232             |   1 -
 tests/generic/233             |   1 -
 tests/generic/234             |   1 -
 tests/generic/235             |   1 -
 tests/generic/237             |   1 -
 tests/generic/238             |   4 +-
 tests/generic/242             |   4 +-
 tests/generic/243             |   4 +-
 tests/generic/253             |   6 +-
 tests/generic/254             |   6 +-
 tests/generic/258             |   3 +-
 tests/generic/259             |   6 +-
 tests/generic/261             |   6 +-
 tests/generic/262             |   6 +-
 tests/generic/264             |   6 +-
 tests/generic/265             |   1 -
 tests/generic/266             |   1 -
 tests/generic/267             |   1 -
 tests/generic/268             |   1 -
 tests/generic/269             |   1 -
 tests/generic/270             |   1 -
 tests/generic/271             |   1 -
 tests/generic/272             |   1 -
 tests/generic/273             |   2 +-
 tests/generic/276             |   1 -
 tests/generic/277             |   6 +-
 tests/generic/278             |   1 -
 tests/generic/279             |   1 -
 tests/generic/281             |   1 -
 tests/generic/282             |   1 -
 tests/generic/283             |   1 -
 tests/generic/284             |   4 +-
 tests/generic/287             |   4 +-
 tests/generic/289             |   4 +-
 tests/generic/290             |   4 +-
 tests/generic/291             |   4 +-
 tests/generic/292             |   4 +-
 tests/generic/293             |   4 +-
 tests/generic/295             |   4 +-
 tests/generic/296             |   4 +-
 tests/generic/299             |   1 -
 tests/generic/300             |   1 -
 tests/generic/301             |   4 +-
 tests/generic/302             |   4 +-
 tests/generic/303             |   2 +-
 tests/generic/304             |   2 +-
 tests/generic/305             |   4 +-
 tests/generic/306             |   3 +-
 tests/generic/307             |   4 +-
 tests/generic/311             |   1 -
 tests/generic/312             |  13 +-
 tests/generic/314             |   1 -
 tests/generic/317             |   4 +-
 tests/generic/318             |   4 +-
 tests/generic/319             |   1 -
 tests/generic/321             |   1 -
 tests/generic/322             |   1 -
 tests/generic/324             |   1 -
 tests/generic/325             |   1 -
 tests/generic/326             |   4 +-
 tests/generic/327             |   2 +-
 tests/generic/328             |   2 +-
 tests/generic/330             |   4 +-
 tests/generic/332             |   4 +-
 tests/generic/333             |   2 +-
 tests/generic/334             |   2 +-
 tests/generic/group           |   1 -
 tests/shared/002              |   1 -
 tests/shared/051              |   1 -
 tests/shared/272              |   1 -
 tests/xfs/003                 |   2 -
 tests/xfs/004                 |   1 -
 tests/xfs/067                 |   1 -
 tests/xfs/114                 |   1 -
 tests/xfs/127                 |   2 +-
 tests/xfs/128                 |   6 +-
 tests/xfs/132                 |  12 +-
 tests/xfs/139                 |   4 +-
 tests/xfs/140                 |   4 +-
 tests/xfs/180                 |   4 +-
 tests/xfs/182                 |   4 +-
 tests/xfs/184                 |   4 +-
 tests/xfs/189                 |   1 -
 tests/xfs/192                 |   4 +-
 tests/xfs/193                 |   4 +-
 tests/xfs/198                 |   4 +-
 tests/xfs/200                 |   4 +-
 tests/xfs/204                 |   4 +-
 tests/xfs/207                 |   8 +-
 tests/xfs/208                 |   4 +-
 tests/xfs/209                 |   2 +-
 tests/xfs/211                 |   4 +-
 tests/xfs/212                 |   4 +-
 tests/xfs/213                 |   4 +-
 tests/xfs/214                 |   4 +-
 tests/xfs/215                 |   4 +-
 tests/xfs/218                 |   4 +-
 tests/xfs/219                 |   4 +-
 tests/xfs/221                 |   4 +-
 tests/xfs/223                 |   4 +-
 tests/xfs/224                 |   4 +-
 tests/xfs/225                 |   4 +-
 tests/xfs/226                 |   4 +-
 tests/xfs/228                 |   4 +-
 tests/xfs/230                 |   4 +-
 tests/xfs/231                 |   2 +-
 tests/xfs/232                 |   2 +-
 tests/xfs/233                 |   2 +-
 tests/xfs/239                 |   4 +-
 tests/xfs/241                 |   4 +-
 tests/xfs/243                 |   2 +-
 tests/xfs/245                 |   2 +-
 tests/xfs/248                 |   4 +-
 tests/xfs/249                 |   4 +-
 tests/xfs/251                 |   4 +-
 tests/xfs/254                 |   4 +-
 tests/xfs/255                 |   4 +-
 tests/xfs/256                 |   4 +-
 tests/xfs/257                 |   4 +-
 tests/xfs/258                 |   4 +-
 337 files changed, 766 insertions(+), 640 deletions(-)
 mode change 100644 => 100755 tests/btrfs/026
 mode change 100644 => 100755 tests/btrfs/104
 mode change 100644 => 100755 tests/btrfs/114
 create mode 100644 tests/ext4/001.out.nodelalloc
 mode change 100644 => 100755 tests/generic/058
 mode change 100644 => 100755 tests/generic/060
 mode change 100644 => 100755 tests/generic/061
 mode change 100644 => 100755 tests/generic/063
 mode change 100644 => 100755 tests/generic/092
 mode change 100644 => 100755 tests/generic/094
 mode change 100644 => 100755 tests/generic/103
 delete mode 100755 tests/generic/125
 delete mode 100644 tests/generic/125.out
 mode change 100644 => 100755 tests/xfs/140

-- 
2.5.0

