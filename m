Received: from mx1.redhat.com ([209.132.183.28]:51338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdAOH37 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 15 Jan 2017 02:29:59 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 586798553C
        for <fstests@vger.kernel.org>; Sun, 15 Jan 2017 07:30:00 +0000 (UTC)
Received: from localhost (vpn1-5-176.pek2.redhat.com [10.72.5.176])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0F7TweA023923
        for <fstests@vger.kernel.org>; Sun, 15 Jan 2017 02:29:59 -0500
Message-Id: <201701150729.v0F7TweA023923@int-mx10.intmail.prod.int.phx2.redhat.com>
Date: Sun, 15 Jan 2017 15:29:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 600b4b2bba42
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dbIxupGwsGbf"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--dbIxupGwsGbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively big update that merges several
reflink test and fixes from Darrick. There're also new generic, xfs and ocfs2
tests, and bug fixes as usual.

Notably, we worked around the annoying "generic/081 pinning SCRATCH_DEV in use,
blocking all subsequent tests" issue, you can remove it from your "skip list"
now if there's any.

New failures I've noticed in this update:
- generic/403 fails on xfs, you may see extra "No such attribute" output. If
  you're testing overlayfs using XFS as underlying filesystem, you may see this
  failure as well
- generic/404 finsert test fails on ext4
- generic/38[3-6] fail again on ext2 and ext3, for details please see commit
  f722c48d4cd5 ("Revert "generic/38[3-6]: require project quota to be enabled
  on SCRATCH_DEV"")

Thanks,
Eryu

The new head of the master branch is commit:

600b4b2bba42 common/rc: use /bin/bash in _user_do()

New commits:

Amir Goldstein (1):
      [726f8c357f58] xfs: test handling of invalid inode modes

Brian Foster (1):
      [ef00dbcf5334] generic: racing getxattr requests against xattr add/remove

Christoph Hellwig (2):
      [1abe96278d4a] generic/081: hack around the lvm unmount race
      [600b4b2bba42] common/rc: use /bin/bash in _user_do()

Darrick J. Wong (7):
      [daedb4dc1313] ocfs2: test reflinking to inline data files
      [0bfb84110bfc] common: add leading underscore to get_block_size
      [3547db8e8440] ocfs2/reflink: fix file block size reporting
      [eaa652fbb293] reflink: fix quota tests to work properly
      [c4288aec3c97] reflink: make error reporting consistent when simulating EIO
      [959f80ec2460] dedupe: fix consistent error message prefixes for dedupe tests
      [466369dc92de] xfs/ext4: check negative inode size

David Disseldorp (2):
      [31da5626e998] xfs/188: add and use _require_xfs_mkfs_ciname
      [81b0eded2ee5] common: remove unused XFSPROGS_VERSION check

Eric Sandeen (2):
      [54c0f9cd4fbe] xfs/118: add to dangerous group
      [9ef7c4e3dcc0] xfs/010: explicitly allow corrupted write in xfs_db

Eryu Guan (1):
      [f722c48d4cd5] Revert "generic/38[3-6]: require project quota to be enabled on SCRATCH_DEV"

Roman Pen (1):
      [2504b26a3a71] generic: reproduce ext4 bugs in a shift extents logic


Code Diffstat:

 common/attr           |   4 +-
 common/config         |  15 --
 common/defrag         |   2 +-
 common/filter         |   4 +-
 common/punch          |   2 +-
 common/quota          |  10 +
 common/rc             |  27 ++-
 common/reflink        |   2 +-
 common/xfs            |   7 +
 tests/btrfs/012       |   2 +-
 tests/btrfs/017       |   2 +-
 tests/btrfs/052       |   2 +-
 tests/btrfs/055       |   2 +-
 tests/btrfs/056       |   2 +-
 tests/btrfs/094       |   2 +-
 tests/btrfs/095       |   2 +-
 tests/btrfs/096       |   2 +-
 tests/btrfs/097       |   2 +-
 tests/btrfs/098       |   2 +-
 tests/btrfs/103       |   2 +-
 tests/generic/017     |   2 +-
 tests/generic/064     |   2 +-
 tests/generic/081     |   2 +
 tests/generic/122     |   2 +-
 tests/generic/122.out |   2 +-
 tests/generic/136     |   2 +-
 tests/generic/136.out |   2 +-
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
 tests/generic/172     |   2 +-
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
 tests/generic/240     |   2 +-
 tests/generic/242     |   2 +-
 tests/generic/243     |   2 +-
 tests/generic/256     |   2 +-
 tests/generic/265     |   6 +-
 tests/generic/265.out |   1 -
 tests/generic/266     |   5 +-
 tests/generic/266.out |   1 -
 tests/generic/267     |   2 +-
 tests/generic/268     |   5 +-
 tests/generic/268.out |   1 -
 tests/generic/271     |   5 +-
 tests/generic/271.out |   1 -
 tests/generic/272     |   5 +-
 tests/generic/272.out |   1 -
 tests/generic/273     |   2 +-
 tests/generic/276     |   2 +-
 tests/generic/276.out |   1 -
 tests/generic/278     |   5 +-
 tests/generic/278.out |   1 -
 tests/generic/279     |   4 +-
 tests/generic/279.out |   1 -
 tests/generic/281     |   4 +-
 tests/generic/281.out |   1 -
 tests/generic/282     |   3 +-
 tests/generic/283     |   6 +-
 tests/generic/283.out |   1 -
 tests/generic/296     |   2 +-
 tests/generic/297     |   2 +-
 tests/generic/298     |   2 +-
 tests/generic/301     |   2 +-
 tests/generic/302     |   2 +-
 tests/generic/305     |  22 +--
 tests/generic/305.out |  30 +--
 tests/generic/308     |   2 +-
 tests/generic/326     |  22 +--
 tests/generic/326.out |  30 +--
 tests/generic/327     |  19 +-
 tests/generic/327.out |  12 +-
 tests/generic/328     |  29 ++-
 tests/generic/328.out |  28 +--
 tests/generic/374     |   2 +-
 tests/generic/374.out |   2 +-
 tests/generic/383     |   1 -
 tests/generic/384     |   2 +-
 tests/generic/385     |   2 +-
 tests/generic/386     |   2 +-
 tests/generic/391     |   2 +-
 tests/generic/403     |  85 +++++++++
 tests/generic/403.out |   2 +
 tests/generic/404     | 146 +++++++++++++++
 tests/generic/404.out | 499 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |   2 +
 tests/ocfs2/001       |  88 +++++++++
 tests/ocfs2/001.out   |  14 ++
 tests/ocfs2/Makefile  |  20 ++
 tests/ocfs2/group     |   1 +
 tests/shared/005      |  75 ++++++++
 tests/shared/005.out  |   5 +
 tests/shared/007      |  77 ++++++++
 tests/shared/007.out  |   5 +
 tests/shared/298      |   2 +-
 tests/shared/group    |   2 +
 tests/xfs/010         |   7 +-
 tests/xfs/127         |   2 +-
 tests/xfs/128         |   2 +-
 tests/xfs/129         |   2 +-
 tests/xfs/132         |   2 +-
 tests/xfs/133         |  75 ++++++++
 tests/xfs/133.out     |   5 +
 tests/xfs/134         |  77 ++++++++
 tests/xfs/134.out     |   5 +
 tests/xfs/139         |   2 +-
 tests/xfs/140         |   2 +-
 tests/xfs/169         |   2 +-
 tests/xfs/180         |   2 +-
 tests/xfs/182         |   2 +-
 tests/xfs/184         |   2 +-
 tests/xfs/188         |   6 +-
 tests/xfs/192         |   2 +-
 tests/xfs/193         |   2 +-
 tests/xfs/198         |   2 +-
 tests/xfs/200         |   2 +-
 tests/xfs/204         |   2 +-
 tests/xfs/208         |   2 +-
 tests/xfs/211         |   2 +-
 tests/xfs/213         |  22 +--
 tests/xfs/213.out     |  30 +--
 tests/xfs/214         |  22 +--
 tests/xfs/214.out     |  30 +--
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
 tests/xfs/236         |   2 +-
 tests/xfs/265         |   2 +-
 tests/xfs/309         |   2 +-
 tests/xfs/310         |   4 +-
 tests/xfs/328         |   2 +-
 tests/xfs/331         |   2 +-
 tests/xfs/335         |   2 +-
 tests/xfs/336         |   2 +-
 tests/xfs/337         |   2 +-
 tests/xfs/341         |   2 +-
 tests/xfs/342         |   2 +-
 tests/xfs/344         |   2 +-
 tests/xfs/345         |   2 +-
 tests/xfs/346         |   2 +-
 tests/xfs/347         |   2 +-
 tests/xfs/348         | 129 +++++++++++++
 tests/xfs/348.out     | 248 +++++++++++++++++++++++++
 tests/xfs/group       |   5 +-
 176 files changed, 1903 insertions(+), 327 deletions(-)
--
Eryu Guan
eguan@redhat.com

--dbIxupGwsGbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYeyHHAAoJECZSqilcj+djLRoQAIFo7EhrE5BaK39nql2MCMaK
eiYlG6tT3NRxu+UPFe+gCNVecYvo43T8MkBjLegg3Z/nPL1feW8nhBb+7eic0HnE
IgBQGyClAe8B/IHeFI/KwaGfsF9KVijYdrD1IGelWA+/sYSzTGv4LcdAD6xe+XLr
S23RVpqGLBMhmLlQuyZ6n1qbkJHW5zssot6aExHOSUmRVsiN9s0kDrvSUWxM6SU7
gVgT42lWti1QemrVLMbrevvnlGrETa2UV7XqGn8wm2wKL3AIXJVP9TiJ7/JR71Yb
IeXrIevwsWimQ3DOLflByRrT3iCaCHGl5xTpVTwT/uRGd2XwgcmF8tC4nNy8593t
b3zTv+lp9M98sKYRm8EzMG9s6eCdk3d6W/wa5p3FEQvXrq51hBwVz5la1WfN5t1W
+Y2VaoNArFRrxp+JeQ3JWvjjIa0Mxl3vbES/JAJ6mS7g7xU8G6ab8LflfUb1A1o8
fsPzLYz+Huww9TVg19HG59TNPwADYJC3CbwF2bb/6jqQSsyjzlMQvt5eeSh4m0oD
uAg16lDjRJxrtyyB5CDr+t1qMEYU057K7MbD6eRCBFqyVYBroKiPRsDDchV7jz5w
PCwC5gjajzyKNxFdRlegTzd2G/ASkR7w6W2sKsU1iGdRNKEwCXXsCoCm7KpGd80h
bi+hQzWQdJjuDwlR0jJZ
=zjT5
-----END PGP SIGNATURE-----

--dbIxupGwsGbf--
