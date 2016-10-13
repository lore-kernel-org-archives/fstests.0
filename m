Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:16538 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753693AbcJMU7x (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Oct 2016 16:59:53 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1bun5P-0006U3-JP
        for fstests@vger.kernel.org; Fri, 14 Oct 2016 07:58:43 +1100
Date: Fri, 14 Oct 2016 07:58:43 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to c61fa13e9451
Message-ID: <20161013205843.GR23194@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

It has taken me a little while to get to this - kernel merge windows
always seem to slow me down with, well, kernel stuff. I've been
running these updates all week so, as usual, Eryu has done a good
job in getting these updates to me.

Keep in mind that if you are testing the new XFS reflink code you'll
still need to pull from Darrick's current branch - there's a few
things in that branch that are needed to make the latest code pass
the majority of tests....

-Dave.

The new head of the master branch is commit:

c61fa13e9451 xfs: renumber tests after merge

New Commits:

Brian Foster (1):
      [d008c3a5f72a] generic: shutdown fs after log recovery

Darrick J. Wong (8):
      [41dfeb425ee4] xfs/122: decrease the log update done item sizes
      [961956168b7b] xfs/130: don't modify files after failed mount
      [c13342b75b7d] xfs/207,327: fsxattr no longer has the reflink flag
      [fff869cb9c49] fstests: use get_block_size helper
      [c08ebd092d89] xfs: fix $XFS_DB_PROG usage
      [f9da3861fcf7] xfs: more rmapbt tests
      [8144ddc4591f] xfs: test realtime rmapbt code
      [c6aa8a7666ec] xfs: check copy-on-write fragmentation

David Disseldorp (1):
      [3ea91b080b42] fsx: fix compiler warning due to bad prototype

Eric Sandeen (1):
      [f57e3c3b49cb] xfs: exercise and validate the xfs_io inode command

Eryu Guan (5):
      [dc913dcfcb98] generic/317: use id to get user id
      [5566a384858b] generic/052: use _check_scratch_fs not _xfs_check
      [2ad510c15e4c] xfs/287: fix wrong seq number in test
      [4053326a0c5f] generic/349,350,351: remove from quick group
      [c61fa13e9451] xfs: renumber tests after merge

Theodore Ts'o (1):
      [09b981f6ac2b] generic/361: require that file system uses a real bloc=
k device

Zorro Lang (1):
      [a5296288d631] xfs/032: test the next block size if mkfs fails


Code Diffstat:

 common/populate       | 100 ++++++++++++++++++++++++----------------------=
---
 common/rc             |  11 ++++--
 ltp/fsx.c             |  20 ++++------
 tests/generic/052     |   2 +-
 tests/generic/150     |   2 +-
 tests/generic/151     |   2 +-
 tests/generic/152     |   2 +-
 tests/generic/153     |   2 +-
 tests/generic/154     |   2 +-
 tests/generic/155     |   2 +-
 tests/generic/156     |   2 +-
 tests/generic/157     |   2 +-
 tests/generic/158     |   2 +-
 tests/generic/159     |   2 +-
 tests/generic/160     |   2 +-
 tests/generic/171     |   2 +-
 tests/generic/173     |   2 +-
 tests/generic/174     |   2 +-
 tests/generic/175     |   2 +-
 tests/generic/176     |   2 +-
 tests/generic/205     |   2 +-
 tests/generic/206     |   2 +-
 tests/generic/216     |   2 +-
 tests/generic/217     |   2 +-
 tests/generic/218     |   2 +-
 tests/generic/220     |   2 +-
 tests/generic/222     |   2 +-
 tests/generic/227     |   2 +-
 tests/generic/229     |   2 +-
 tests/generic/238     |   2 +-
 tests/generic/242     |   2 +-
 tests/generic/243     |   2 +-
 tests/generic/296     |   2 +-
 tests/generic/297     |   2 +-
 tests/generic/298     |   2 +-
 tests/generic/301     |   2 +-
 tests/generic/302     |   2 +-
 tests/generic/317     |   2 +-
 tests/generic/361     |   1 +
 tests/generic/388     |  89 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/388.out |   2 +
 tests/generic/group   |   7 ++--
 tests/xfs/001         |  16 ++++----
 tests/xfs/002         |   4 +-
 tests/xfs/032         |   5 +++
 tests/xfs/054         | 104 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 tests/xfs/054.out     |  13 +++++++
 tests/xfs/070         |   4 +-
 tests/xfs/077         |   6 +--
 tests/xfs/086         |   2 +-
 tests/xfs/087         |   2 +-
 tests/xfs/088         |   2 +-
 tests/xfs/089         |   2 +-
 tests/xfs/091         |   2 +-
 tests/xfs/093         |   2 +-
 tests/xfs/097         |   2 +-
 tests/xfs/098         |   4 +-
 tests/xfs/099         |   2 +-
 tests/xfs/100         |   4 +-
 tests/xfs/101         |   2 +-
 tests/xfs/102         |   4 +-
 tests/xfs/105         |   4 +-
 tests/xfs/111         |   2 +-
 tests/xfs/112         |   4 +-
 tests/xfs/113         |   4 +-
 tests/xfs/117         |   2 +-
 tests/xfs/120         |   2 +-
 tests/xfs/122.out     |   6 +--
 tests/xfs/123         |   2 +-
 tests/xfs/124         |  10 ++---
 tests/xfs/125         |   8 ++--
 tests/xfs/126         |  10 ++---
 tests/xfs/127         |   2 +-
 tests/xfs/128         |   2 +-
 tests/xfs/129         |   2 +-
 tests/xfs/130         |  13 +++----
 tests/xfs/130.out     |   1 -
 tests/xfs/132         |   2 +-
 tests/xfs/135         |   2 +-
 tests/xfs/137         |   6 +--
 tests/xfs/139         |   2 +-
 tests/xfs/140         |   2 +-
 tests/xfs/169         |   2 +-
 tests/xfs/179         |  10 ++---
 tests/xfs/180         |   2 +-
 tests/xfs/182         |   2 +-
 tests/xfs/184         |   2 +-
 tests/xfs/186         |   8 ++--
 tests/xfs/187         |  14 +++----
 tests/xfs/192         |   2 +-
 tests/xfs/193         |   2 +-
 tests/xfs/198         |   2 +-
 tests/xfs/200         |   2 +-
 tests/xfs/204         |   2 +-
 tests/xfs/207.out     |   4 +-
 tests/xfs/208         |   2 +-
 tests/xfs/211         |   2 +-
 tests/xfs/215         |   2 +-
 tests/xfs/218         |   2 +-
 tests/xfs/219         |   2 +-
 tests/xfs/221         |   2 +-
 tests/xfs/223         |   2 +-
 tests/xfs/224         |   2 +-
 tests/xfs/225         |   2 +-
 tests/xfs/226         |   2 +-
 tests/xfs/228         |   2 +-
 tests/xfs/230         |   2 +-
 tests/xfs/231         |   2 +-
 tests/xfs/232         |   2 +-
 tests/xfs/233         |   2 +-
 tests/xfs/234         |   2 +-
 tests/xfs/235         |   4 +-
 tests/xfs/236         |   2 +-
 tests/xfs/265         |   2 +-
 tests/xfs/287         |   7 ++--
 tests/xfs/298         |   2 +-
 tests/xfs/309         |   2 +-
 tests/xfs/310         |   4 +-
 tests/xfs/327.out     |   6 +--
 tests/xfs/328         |   2 +-
 tests/xfs/331         |  78 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/331.out     |   4 ++
 tests/xfs/332         |  92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/332.out     |  10 +++++
 tests/xfs/333         |  83 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/333.out     |   9 +++++
 tests/xfs/334         |  67 +++++++++++++++++++++++++++++++++
 tests/xfs/334.out     |   7 ++++
 tests/xfs/335         |  89 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/335.out     |   7 ++++
 tests/xfs/336         |  97 ++++++++++++++++++++++++++++++++++++++++++++++=
++
 tests/xfs/336.out     |   8 ++++
 tests/xfs/337         | 106 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/xfs/337.out     |  11 ++++++
 tests/xfs/338         |  75 +++++++++++++++++++++++++++++++++++++
 tests/xfs/338.out     |   7 ++++
 tests/xfs/339         |  83 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/339.out     |   9 +++++
 tests/xfs/340         |  80 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/340.out     |   7 ++++
 tests/xfs/341         |  98 ++++++++++++++++++++++++++++++++++++++++++++++=
++
 tests/xfs/341.out     |   7 ++++
 tests/xfs/342         |  99 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
 tests/xfs/342.out     |   7 ++++
 tests/xfs/343         |  81 ++++++++++++++++++++++++++++++++++++++++
 tests/xfs/343.out     |   6 +++
 tests/xfs/344         | 104 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 tests/xfs/344.out     |  10 +++++
 tests/xfs/345         | 102 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/xfs/345.out     |  10 +++++
 tests/xfs/346         | 107 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 tests/xfs/346.out     |  10 +++++
 tests/xfs/347         | 106 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/xfs/347.out     |  10 +++++
 tests/xfs/group       |  18 +++++++++
 155 files changed, 2151 insertions(+), 240 deletions(-)
 create mode 100755 tests/generic/388
 create mode 100644 tests/generic/388.out
 create mode 100755 tests/xfs/054
 create mode 100644 tests/xfs/054.out
 create mode 100755 tests/xfs/331
 create mode 100644 tests/xfs/331.out
 create mode 100755 tests/xfs/332
 create mode 100644 tests/xfs/332.out
 create mode 100755 tests/xfs/333
 create mode 100644 tests/xfs/333.out
 create mode 100755 tests/xfs/334
 create mode 100644 tests/xfs/334.out
 create mode 100755 tests/xfs/335
 create mode 100644 tests/xfs/335.out
 create mode 100755 tests/xfs/336
 create mode 100644 tests/xfs/336.out
 create mode 100755 tests/xfs/337
 create mode 100644 tests/xfs/337.out
 create mode 100755 tests/xfs/338
 create mode 100644 tests/xfs/338.out
 create mode 100755 tests/xfs/339
 create mode 100644 tests/xfs/339.out
 create mode 100755 tests/xfs/340
 create mode 100644 tests/xfs/340.out
 create mode 100755 tests/xfs/341
 create mode 100644 tests/xfs/341.out
 create mode 100755 tests/xfs/342
 create mode 100644 tests/xfs/342.out
 create mode 100755 tests/xfs/343
 create mode 100644 tests/xfs/343.out
 create mode 100755 tests/xfs/344
 create mode 100644 tests/xfs/344.out
 create mode 100755 tests/xfs/345
 create mode 100644 tests/xfs/345.out
 create mode 100755 tests/xfs/346
 create mode 100644 tests/xfs/346.out
 create mode 100755 tests/xfs/347
 create mode 100644 tests/xfs/347.out
--=20
Dave Chinner
david@fromorbit.com

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX//WDAAoJEK3oKUf0dfodlB0QAJ5PkFzyY7ZcxzXK5kq/y7GX
au4bV9DXfNJ/lMUaCX/34e6vrhNiHV702RSVYkTh7Jy/XcU/mNUz5f36U1dOriVP
SVNX2M/tHGepRvXq6C5C8m/iqbh/5xOxuO4S3gPuHiW4WRqUlGAUpbqIccrgqKMt
cd6dCfphesOgv7tlo4m0/8wVR/jfGLTpkA+394OB00+BbE0EweyQwVrtoVeT7VO0
qq2sko5v+b9R40qm+okyp72ZEYUeLoXjf1ebMBsCxRu2GTtqMkZUvZZq7RwPsyk0
upfZFGrAnavVUZ6D+OrS73hH80tnCiIo5/H0DVDImhOjnFyoiUNvcJJkKrkylMUT
EjEjiFoYvuayvCNwRaRXwOKWqJB0Al8qjRLMHslok1UCtVIXjyXK08oGKc8jCoZr
CmjWxmu1SEBwG4PlKgqGcvUFuMe+4+dOJH5sWUEsYwMcuGUs7l3+oEHyt9r2Zk3d
eKE87aWeOjETsG4BQ+xLmmWvz2w5CEYtBhGRUGqlWYidiLUpI2gBkukwetma1Qzs
XoKIhnqXCnUU4jJhlwIeZM+M+Lz+f4u2PwJgioQS0wqEWwHG33GMFPFn8itBlgiE
ljGvTeWjYwwsUPJzQBXxrFyoyUmm1E7aG61LdGfjY540EimF7VqulyyCSsTDbZt4
Hkvprb+cgANr0S7/ayeF
=ysr5
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
