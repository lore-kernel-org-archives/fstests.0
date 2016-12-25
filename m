Received: from mx1.redhat.com ([209.132.183.28]:48934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbcLYK4q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 25 Dec 2016 05:56:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6C754E4F2
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2016 10:56:45 +0000 (UTC)
Received: from localhost (vpn1-7-91.pek2.redhat.com [10.72.7.91])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBPAui3g012338
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2016 05:56:45 -0500
Message-Id: <201612251056.uBPAui3g012338@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sun, 25 Dec 2016 18:56:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 7ee1d97c799b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s1qCufHgLkto"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--s1qCufHgLkto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively large update. Notably, fs
encryption tests from Eric Biggers have been merged. But these tests won't run
now, as set|get_policy commands are not in xfs_io yet. _scratch_mkfs has also
been updated so that, besides xfs and ext4, other filesystems are able to
handle mkfs option conflicts between $MKFS_OPTIONS and options specified in
tests. There're also new generic and overlay tests, one btrfs test is removed.

New failures I've noticed in this update:
- generic/399 fails on ext4, it's a known fs encryption bug (if you tested with
  set|get_policy xfs_io patch applied manually)
- generic/400 fails on XFS, there's a patch from Eric Sandeen to fix it in XFS
- generic/401 fails on NFSv4 (NFSv3 passes the filetype test) as NFSv4 reports
  filetype of . and .. as DT_UNKNOWN, while reports filetype of other files
  correctly

Thanks,
Eryu

The new head of the master branch is commit:

7ee1d97c799b generic: test correct d_type values

New commits:

Amir Goldstein (3):
      [9aead226d330] common/rc: factor out _supports_filetype() helper
      [d0d42a38211c] common/rc: add generic file type support check
      [7ee1d97c799b] generic: test correct d_type values

Eric Biggers (6):
      [3419026f0719] encrypt: add utilities for testing filesystem encryption
      [b8f280fcdb67] generic: test setting and getting encryption policies
      [88d1c426f4ea] generic: test validation of encryption policy structure
      [758175fad3c6] generic: test encrypted file access
      [0f7a9791309e] generic: test enforcement of one encryption policy per tree
      [716691159e4f] generic: test for weaknesses in filesystem encryption

Eric Sandeen (3):
      [3cbd329a14bd] generic: test GETNEXTQUOTA near INT_MAX
      [a4f96daeb1c8] generic/244: remove extra junk
      [3b3191806f67] common: add _require_getnextquota helper

Eryu Guan (1):
      [596a068bf130] fstests: teach _scratch_mkfs to handle mkfs option conflicts

Qu Wenruo (1):
      [312e7ce2da53] btrfs/047: Remove test since upstream don't accept stream-version

Theodore Ts'o (1):
      [030fd2aea20f] overlay: stress test changes to top and bottom layers simultaneously


Code Diffstat:

 .gitignore            |   1 +
 common/btrfs          |  14 ----
 common/config         |   2 +
 common/encrypt        | 146 +++++++++++++++++++++++++++++++++
 common/quota          |  10 +++
 common/rc             | 220 ++++++++++++++++++++++++++++++--------------------
 common/xfs            |  47 +++--------
 src/Makefile          |   2 +-
 src/t_dir_type.c      | 108 +++++++++++++++++++++++++
 src/test-nextquota.c  |  37 +++++----
 tests/btrfs/028       |   2 +-
 tests/btrfs/047       | 120 ---------------------------
 tests/btrfs/047.out   |  35 --------
 tests/btrfs/121       |   2 +-
 tests/btrfs/122       |   2 +-
 tests/btrfs/123       |   2 +-
 tests/btrfs/126       |   2 +-
 tests/btrfs/group     |   1 -
 tests/generic/244     |  12 +--
 tests/generic/395     | 135 +++++++++++++++++++++++++++++++
 tests/generic/395.out |  43 ++++++++++
 tests/generic/396     |  82 +++++++++++++++++++
 tests/generic/396.out |  18 +++++
 tests/generic/397     | 144 +++++++++++++++++++++++++++++++++
 tests/generic/397.out |  13 +++
 tests/generic/398     | 158 ++++++++++++++++++++++++++++++++++++
 tests/generic/398.out |  45 +++++++++++
 tests/generic/399     | 166 +++++++++++++++++++++++++++++++++++++
 tests/generic/399.out |   3 +
 tests/generic/400     |  89 ++++++++++++++++++++
 tests/generic/400.out |   8 ++
 tests/generic/401     |  95 ++++++++++++++++++++++
 tests/generic/401.out |   9 +++
 tests/generic/group   |   7 ++
 tests/overlay/019     |  95 ++++++++++++++++++++++
 tests/overlay/019.out |   2 +
 tests/overlay/group   |   1 +
 37 files changed, 1554 insertions(+), 324 deletions(-)
--
Eryu Guan
eguan@redhat.com

--s1qCufHgLkto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYX6RGAAoJECZSqilcj+djyV8QAKeyewRg+lLuk6XfjYo/YfRE
1oz0JMkRhZrX6stYaIphYtfqzKE+aqKZ6/9ZGgeE5E0nledzr+vOPf44lld5TK15
Bfhf8TXPyUl9QiOWS1IaUwAqteSC1Q30xH5HKs2wUsMZHV2CoGw7XzrIxR+jYais
Uf1lPJ/rSg0YLW4pHdqcs6bXsPflynPvizX3bFUgIVMJ7lhijaQF7smySxLLtnA2
9zqg5+S6X/FakgzKfL4DozOzZlNuPwsFutOeikvAJ2bmZ3SIdQStqDEXdgdhht2z
upQsyMLLoh61z9lT+LxKQPYQxYDmW0cesdJ7M2YgyfUh2xFBV+BDSADMxs0MKZn3
/Ra0ZzLKw9Eh/xxJZyPyrnubtd3Y2lAENkXMmLSOKmwMdk8+CgHWeWXqKLAaQ7SQ
U8TNmQ/+LeXAXl3DvenjIznelBWM4N5QmT+rQPY/krFihBJuOzUuhZau9RVB4uZ/
WDGZAQdXBsJbqLaJz5mS6UKkvt60iYd0Y0DnLtKxgJiDSK8kngjtEeNFaLoAQ03/
91+7p/WiDGC6f9DhnSxr289rnGXXqJLgm5ZgtQQsGil9SZ95I88d6VkriRFAnaW+
2vvZcOKXqFJsa9EmQstZixnFWN8xLq2jobeOr5lgL7VQGVmmELbnrL3A29lPJtys
+tO6LyPWPxUefBnhravF
=sDAJ
-----END PGP SIGNATURE-----

--s1qCufHgLkto--
