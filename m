Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:53361 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852AbcBUVvK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 21 Feb 2016 16:51:10 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aXbu2-0006n4-Ik
	for fstests@vger.kernel.org; Mon, 22 Feb 2016 08:50:54 +1100
Date: Mon, 22 Feb 2016 08:50:54 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to fdf1c15
Message-ID: <20160221215054.GC14668@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

fdf1c15 gitignore: add src/test-nextquota

New Commits:

Anand Jain (2):
      [131df72] btrfs/011: use replace_options
      [8ce9d6f] fstests: btrfs/011 add debug logs to seqres.full

Christoph Hellwig (1):
      [b744118] common: fix _require_fs_space on remote file systems

Darrick J. Wong (3):
      [0041979] generic/304: fix high offset
      [f9ff240] punch-alternating: use the block size reported by the fs fo=
r punching
      [d172db2] xfs/24[356]: check for -c switch to xfs_io bmap command

Eryu Guan (2):
      [eea42b9] generic/072: limit max cpu number to 8
      [b741135] ext4: test partial blocksize defrag integrity issue

Filipe Manana (4):
      [73beac7] generic/158: test dedupe with destination offset past EOF
      [180cb85] btrfs: test directory fsync after deleting snapshots
      [72da527] generic: test directory fsync after rename operation
      [e2d8666] generic: test file fsync after rename operation

Hugh Dickins (6):
      [27dc8f1] common: _scratch_mkfs_sized() for tmpfs
      [93a14f9] generic: use mount point instead of device name
      [a8e24c8] generic/009: require fiemap
      [6912082] generic/079,277: require chattr, not xattrs
      [0276fe7] xfstests: add executable permission to tests
      [99fd47b] xfstests: increase tmpfs memory size

Junho Ryu (2):
      [4a5cda8] xfstests: do not unmount tmpfs during remount
      [6aceb27] generic/053: do not unmount before calling _check_scratch_f=
s()

Theodore Ts'o (7):
      [9345c0c] ext4/001: add output variant for nodelalloc mounts
      [b424812] check: avoid spurious complaints that tests/$FSTYP/group do=
es not exist
      [9d220d1] generic: add _require_odirect to generic/113 and generic/214
      [76c21d6] Rename _scratch_mount to _scratch_cycle_mount
      [dddae98] Rename _test_mount to _test_cycle_mount
      [56ff01f] xfstests: remove _need_to_be_root
      [fdf1c15] gitignore: add src/test-nextquota

Zorro Lang (2):
      [ea61a6a] xfs: change return value check to golden image check
      [08aac97] xfs: new test default user/group quota


Code Diffstat:

 .gitignore                    |   1 +
 README                        |   4 -
 check                         |   6 +
 common/config                 |   4 +-
 common/defrag                 |   2 +-
 common/dump                   |   2 -
 common/rc                     |  80 ++++++++---
 src/punch-alternating.c       |   7 +-
 tests/btrfs/001               |   6 +-
 tests/btrfs/002               |   1 -
 tests/btrfs/003               |   1 -
 tests/btrfs/004               |   1 -
 tests/btrfs/005               |   2 +-
 tests/btrfs/007               |   1 -
 tests/btrfs/011               |  19 ++-
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
 tests/btrfs/118               |  86 +++++++++++
 tests/btrfs/118.out           |   2 +
 tests/btrfs/group             |   1 +
 tests/ext4/001.cfg            |   2 +
 tests/ext4/001.out.nodelalloc | 337 ++++++++++++++++++++++++++++++++++++++=
++++++
 tests/ext4/020                |  87 ++++++++++++
 tests/ext4/020.out            |   6 +
 tests/ext4/271                |   1 -
 tests/ext4/301                |   1 -
 tests/ext4/302                |   1 -
 tests/ext4/303                |   1 -
 tests/ext4/304                |   1 -
 tests/ext4/307                |   1 -
 tests/ext4/308                |   1 -
 tests/ext4/group              |   1 +
 tests/f2fs/001                |   2 +-
 tests/generic/003             |  20 ++-
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
 tests/generic/072             |   4 +
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
 tests/generic/134             |   4 +-
 tests/generic/135             |  19 +--
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
 tests/generic/158             |  10 +-
 tests/generic/158.out         |   6 +-
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
 tests/generic/304.out         |   2 +-
 tests/generic/305             |   4 +-
 tests/generic/306             |   3 +-
 tests/generic/307             |   4 +-
 tests/generic/311             |   1 -
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
 tests/generic/335             |  96 +++++++++++++
 tests/generic/335.out         |  19 +++
 tests/generic/336             |  96 +++++++++++++
 tests/generic/336.out         |  17 +++
 tests/generic/group           |   2 +
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
 tests/xfs/133                 |  20 +--
 tests/xfs/133.out             |   7 +
 tests/xfs/138                 |  26 ++--
 tests/xfs/138.out             |  12 ++
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
 tests/xfs/243                 |   3 +-
 tests/xfs/245                 |   3 +-
 tests/xfs/246                 |   1 +
 tests/xfs/248                 |   4 +-
 tests/xfs/249                 |   4 +-
 tests/xfs/251                 |   4 +-
 tests/xfs/254                 |   4 +-
 tests/xfs/255                 |   4 +-
 tests/xfs/256                 |   4 +-
 tests/xfs/257                 |   4 +-
 tests/xfs/258                 |   4 +-
 tests/xfs/260                 | 119 ++++++++++++++++
 tests/xfs/260.out             |  31 ++++
 tests/xfs/group               |   1 +
 358 files changed, 1415 insertions(+), 595 deletions(-)
 mode change 100644 =3D> 100755 tests/btrfs/026
 mode change 100644 =3D> 100755 tests/btrfs/104
 mode change 100644 =3D> 100755 tests/btrfs/114
 create mode 100755 tests/btrfs/118
 create mode 100644 tests/btrfs/118.out
 create mode 100644 tests/ext4/001.out.nodelalloc
 create mode 100755 tests/ext4/020
 create mode 100644 tests/ext4/020.out
 mode change 100644 =3D> 100755 tests/generic/058
 mode change 100644 =3D> 100755 tests/generic/060
 mode change 100644 =3D> 100755 tests/generic/061
 mode change 100644 =3D> 100755 tests/generic/063
 mode change 100644 =3D> 100755 tests/generic/092
 mode change 100644 =3D> 100755 tests/generic/094
 mode change 100644 =3D> 100755 tests/generic/103
 create mode 100755 tests/generic/335
 create mode 100644 tests/generic/335.out
 create mode 100755 tests/generic/336
 create mode 100644 tests/generic/336.out
 mode change 100644 =3D> 100755 tests/xfs/140
 create mode 100755 tests/xfs/260
 create mode 100644 tests/xfs/260.out
--=20
Dave Chinner
david@fromorbit.com

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWyjE9AAoJEK3oKUf0dfodJ+IP/AiaVXdNJ1XRjGGU80lR6/I1
810yRB36gvPe0VZBfIzOntfqBU3AG8cvKtMi1eOPuZ9AIVm5hqY23s6vPluKeXaF
p3rXwde18xA4sUhVIbrBkFXOdGJko1SJDxfBei9/i5A+2MLc/XJcgrb2V5b8Uq2N
/GSfK5LqsF1j16E1HUBnGKG5BEPEtPtz4NhwU5ANhFYsjUKrrq2Do9222Q8JZSH3
aIG22rUXJT5XrTgV6JFCaIQjjifHkAo1xP171uGbHjDpHs70Q6KFNcnyiJ8sMBlK
LnchytKkcBtdcAtY33DdJzIzmTQ2ug48nM1ENxLiDRFNne0TU1fO2Qiaz1N+3u5S
CyyKIRjltzZ4OsIRPioatxsJ4NrQ4fhoWOla0/mQxv/qvcJunGIuezitD8jAZO6o
mAbUgomOvNdo3ExU1TfeU9yWJQj2HPdNmpqQ9SAQKOzCr6hGTiAN8VOT0zfHnHAQ
PEu4yWMEVShQTsjp2eE6QsHhB1sRN7mQFcTyuNlGzgDRiGL2eRchfw79SoZFgkZs
/VIEigy4r8jesn0WZLOunhmpI4ErHtSEvu4qQo042AEFts6yyblWhxDie7NQ6TW+
W0l4cw9zy1bhQz+yNorK0hBbMMkItoovV1SgdCio9b0EUBInKlVSixlOi7cDwPGO
2ymgoajLWDvTTE6fEf8B
=ny9e
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
