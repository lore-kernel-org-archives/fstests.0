Received: from mail-pl0-f53.google.com ([209.85.160.53]:38216 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeEMMaC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 May 2018 08:30:02 -0400
Received: by mail-pl0-f53.google.com with SMTP id c11-v6so5810114plr.5
        for <fstests@vger.kernel.org>; Sun, 13 May 2018 05:30:02 -0700 (PDT)
Message-ID: <5af82fc8.1c69fb81.4f68f.3d7e@mx.google.com>
Date: Sun, 13 May 2018 20:29:57 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to bb8de58ca1d0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H4IHxtBdJ42m"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--H4IHxtBdJ42m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively big update, there're 5 new tests
and several cleanups and improvements, e.g. removing unused code, removing
'dangerous' group from a few tests. 

But there should be no new failures introduced by this update.

Thanks,
Eryu

The new head of the master branch is commit:

bb8de58ca1d0 btrfs: add test for seeing unseen fsync errors on newly open files

New commits:

Amir Goldstein (4):
      [12a986fe876d] overlay/049: update fix commit id
      [5509684db3b7] overlay: test multiple origin references to the same lower file
      [c29a70330fdf] common/rc: decouple xfs_io flink check from xfs_io -T check
      [b3c907888d56] generic/{159,160}: require chattr instead of lsattr

Darrick J. Wong (1):
      [331edc6af659] xfs: checkbashisms in all script files

Dave Chinner (3):
      [46199319f61f] fstests: remove old electric fence support
      [f3851ad630ba] fstests: many dangerous+auto tests are not dangerous anymore
      [272ddcdd191e] xfs: test inobt/on disk free state mismatches

Jeff Layton (2):
      [22a147a1ad7b] generic: test for seeing unseen fsync errors on newly open files
      [bb8de58ca1d0] btrfs: add test for seeing unseen fsync errors on newly open files


Code Diffstat:

 check                 |   7 +---
 common/log            |   1 -
 common/rc             |  38 ++++++------------
 common/xfs            |   9 ++---
 soak                  |   6 +--
 tests/btrfs/058       |   4 +-
 tests/btrfs/160       | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/160.out   |   5 +++
 tests/btrfs/group     |   1 +
 tests/generic/004     |   1 +
 tests/generic/159     |   2 +-
 tests/generic/160     |   2 +-
 tests/generic/389     |   1 +
 tests/generic/487     | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/487.out |   5 +++
 tests/generic/group   |  15 ++++----
 tests/overlay/049     |   4 +-
 tests/overlay/059     | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/059.out |   2 +
 tests/overlay/group   |   1 +
 tests/xfs/132         |  73 +++++++++++++++++++++++++++++++++++
 tests/xfs/132.out     |  26 +++++++++++++
 tests/xfs/446         |  52 +++++++++++++++++++++++++
 tests/xfs/446.out     |   2 +
 tests/xfs/group       |  18 +++++----
 tools/auto-qa         |   1 -
 26 files changed, 527 insertions(+), 63 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--H4IHxtBdJ42m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJa+C9qAAoJECZSqilcj+djPJ4P/jfL2wgV4w7DDoPQn+uzWbeY
N4e7U0+eHwyzDZm00w7hkwjrB9dkDdaoyZ1lNFpcTZfe2fp3ONg1kmZckIjmvn/r
r4+jaPTHfGXahmGUCDxblj/nlLNHKxoRS5QkjWRPCEGQk8wW7h2Sh1FQthdoxNAf
P6s57d7BZh32Qb6+GIexarv7A/5yjsaBAnyqjCMj9RuhMfwIsf6S67gId6eLrTGz
1T6RxVxIWO6M/QhH1WJuRUJRkWIMR2ANk9ScRIlZCBgp6P1jVKtPtwUUIs50cfnS
VRmAnbXnGJYdW/7TnJY/FO2zWunL4lCtlQIWP+oWC1sLwfErbpxdmJ8gji9V2nVW
YQ/7wjJeqBDN9Z6fc38ViexmjncV1b8bbi6QDb2NjDBES8BMjdFvaZ3/5AHsH0IS
1ehqyip+FsUp6YH1JELq2LMsKKjlFSvB2RrQFap/A8H6LdGMQTwHCBRuxvJXc+Co
5pEmuQNq38qtr80v7J/ANzhvSKPDLVq9uMIgvTecy1uAcwjUoE6paIhrPheKn44+
HfHN2mlczsesXnnxkTUjoNYYL29O4UFNJdnSEPdnsRNag3WsgvA74bYHT/ULjvUJ
vnbxeC7xE0e2OkAZ5pDUu/X6L+aimV+tP62/rIN8zMVIRFG6x50itOSVgXIQ6tRe
G5PROa0ZQEYAYpo/VlcP
=K1VW
-----END PGP SIGNATURE-----

--H4IHxtBdJ42m--
