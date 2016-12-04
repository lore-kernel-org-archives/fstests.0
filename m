Received: from mx1.redhat.com ([209.132.183.28]:58928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750701AbcLDGxD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 4 Dec 2016 01:53:03 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7CB481138
        for <fstests@vger.kernel.org>; Sun,  4 Dec 2016 06:53:02 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uB46r0hD006674
        for <fstests@vger.kernel.org>; Sun, 4 Dec 2016 01:53:01 -0500
Date: Sun, 4 Dec 2016 14:53:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to adcc60c6bf6a
Message-ID: <20161204065300.GM29149@eguan.usersys.redhat.com>
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

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is the first time I push updates to
kernel.org repo directly. Thanks to Dave and Eric for helping me on
this!

This update contains patches in the last two weeks. The most notable
changes are the common/rc split, Dave split XFS and btrfs specific
functions to common/xfs and common/btrfs seperately, there should not be
any functional changes by this split. But You may have to rebase your
pending patches on your local repo against new master head.

Also, there're new generic and overlayfs tests, and two test updates
caused by fs behavior changes (see below for details), and some other
small fixes and improvements.

Thanks to all who has contributed to this update! And my apologies for
the patch review backlog, I was busier than I expected last week.

New failure I noticed in this update:
- overlay/016 is a new case that fails on current Linus tree (4.9-rc7)
- generic/182 fails on reflink XFS, there's a behavior change pending in XFS
  list
- ext4/001 fails on DAX mount, this is also a behavior change pending in ext4
  tree

Thanks,
Eryu

The new head of the master branch is commit:

adcc60c6bf6a build: allow building with latest xfslibs on 32-bit Linux

New commits:

Amir Goldstein (1):
      [d04d4bc07dc5] overlay: test ro/rw fd data inconsistecies

Darrick J. Wong (1):
      [738938aab26f] generic/182: retain existing btrfs behavior when len == 0

Dave Chinner (4):
      [37d78d97f657] check: add brief result summaries
      [3d7ed77c6817] generic/095: add iomap_dio_rw() to the dmesg filter
      [7d4f483f1bd2] common: split XFS functions from common/rc
      [c3aba25afa87] common: split Btrfs functions from common/rc

Eric Biggers (1):
      [adcc60c6bf6a] build: allow building with latest xfslibs on 32-bit Linux

Filipe Manana (1):
      [47038bbea58b] btrfs/124-5: add missing umount for raid5 tests

J. Bruce Fields (2):
      [0240a9c12f61] README: Document fstests mailing list
      [64ea47a87e9a] src/dirstress: Allow ESTALE as well as ENOENT

Jaegeuk Kim (2):
      [c74b1f84f93a] generic: check inode metadata on f{data}sync after power-cut
      [9520450542b3] generic: check some inline truncation behaviors

Jan Kara (1):
      [79a1c3808292] ext4/001: Fixup file layout with DAX


Code Diffstat:

 README                |   6 +
 check                 | 114 +++---
 common/btrfs          | 330 +++++++++++++++++
 common/rc             | 957 +-------------------------------------------------
 common/xfs            | 610 ++++++++++++++++++++++++++++++++
 m4/package_xfslibs.m4 |  11 +-
 src/dirstress.c       |  10 +-
 tests/btrfs/124       |   1 +
 tests/btrfs/125       |   1 +
 tests/ext4/001.cfg    |   2 +-
 tests/generic/095     |   4 +-
 tests/generic/182     |   6 +-
 tests/generic/182.out |   2 -
 tests/generic/392     | 135 +++++++
 tests/generic/392.out |  11 +
 tests/generic/393     | 128 +++++++
 tests/generic/393.out |  45 +++
 tests/generic/group   |   2 +
 tests/overlay/016     |  98 ++++++
 tests/overlay/016.out |  12 +
 tests/overlay/group   |   1 +
 21 files changed, 1468 insertions(+), 1018 deletions(-)
--
Eryu Guan
eguan@redhat.com

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJYQ71MAAoJECZSqilcj+djwlYP/ROEo8VhOfocxGZhazED/CGn
DsCjOf08hKrjB8dYYNlzxr5kWqH1jnZGvYHLyC61OsY7TUdz5is6lKX2aZodWETT
m94uTKPNM2GFmdvvmkvRpoT0Bf7aTECgGLGKr35EIviHJJ/IoXrZa6Gjy8uPF+Vz
DgKUbgrH2W8+F+NGYSnILcCIfC2IfLPx1s/3FzMckVED0lreW6jGx4+VMJxpI11K
XpV/Ikg+cNCEadoM6foNMdA8eHoRND87Hr5LapYcPUVcDB+JapZu6yvTuZB13s12
5VO7Q0iA9PZs1zRWYPdAjVw8HvfTxUn52mZfX/aviToYRetoWGAemtp38Xpbz1+j
Y49PJgzfCAL8m20eRC+fzhH09rLcOzU/K4GE+MUyYhhAxuvonWobavOMnMfSfDAa
/eOkpBcI8b1CSnwNpvHZh6xtNU5OtJ+wP8TEiijEFa/ZQmBG0bjONTBodc9Sw4KA
ynGi1nKwVt7AiGhryZxSwTvpzbVU019zme+Ho+5vyqj3fFzO1erKmtWbbSjWaYA/
dIEXHyI+AK1AjQ4vMso3dzDRJaIHsUw7nNf7tQSaPavUUey664oKlkCAuW0Wffwj
MlnwnPEnWK+nUw9e8BPX5qHqbdgheKr3+8C63P+jtXH0izYS5emFZ/KBA5ZqWBo4
5DUBlBoOwegSf9stJ54D
=GagG
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
