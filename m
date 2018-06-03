Received: from mail-pf0-f194.google.com ([209.85.192.194]:33231 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeFCOwO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Jun 2018 10:52:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so3144621pfi.0
        for <fstests@vger.kernel.org>; Sun, 03 Jun 2018 07:52:14 -0700 (PDT)
Message-ID: <5b14009c.1c69fb81.3b61c.ca85@mx.google.com>
Date: Sun, 03 Jun 2018 22:52:07 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 5dff991a5264
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1hy7vOq7ZYi8"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--1hy7vOq7ZYi8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a large update as well, we have 4 new btrfs
seed device tests and one new ext4 resize test and one new overlay
metadata-only copyup test. There're also several bug-fixes and cleanups.

New faiilures I've noticed in this update:
- ext4/033 fails on current Linus tree, the fix should be in ext4 tree already,
  but please note that some e2fsprogs patches are needed to fix the test
  failure with 1k block size ext4 even with the kernel patch applied

Thanks,
Eryu

The new head of the master branch is commit:

5dff991a5264 overlay: Add tests for overlay metadata only copy up feature

New commits:

Anand Jain (5):
      [549016e8205b] btrfs: add seed sprout functionality test
      [0eb4d0944665] btrfs: nested seed device test
      [a281d39579a4] btrfs: seed device replace test
      [f3a33a9dda1e] btrfs: seed device delete test
      [144c8463d38b] btrfs: introduce btrfs/volume group

Dave Chinner (1):
      [c4f104cdf420] fstests: get rid of set_prog_path

Jan Kara (7):
      [141bd37a3685] fstests: Make ./new work for non-root user
      [828f12b965d9] dmhugedisk: Allow specifying of chunk size
      [678c3f477d0d] ext4: Test for s_inodes_count overflow during fs resize
      [90b383e215ba] xfs/310: Cleanup
      [042fcd24dbbe] ext4/032: Fix up resize2fs usage
      [5a111436bb88] ext4/010: Fixup resize2fs and dumpe2fs usage
      [41b082680737] ext4/306: Fixup resize2fs usage

Mark Fasheh (1):
      [2f194e4e820e] generic/009: don't run for btrfs if PAGE_SIZE > 4096

Theodore Ts'o (1):
      [72ec5e2ff70c] fstests: update the punch, collapse, insert, and zero groups

Vivek Goyal (1):
      [5dff991a5264] overlay: Add tests for overlay metadata only copy up feature


Code Diffstat:

 check                 |  15 +--
 common/config         | 179 +++++++++++++++----------------
 common/dmhugedisk     |   7 +-
 common/dump           |   6 +-
 common/overlay        |   1 +
 common/rc             |  27 +----
 common/test_names     |  12 +++
 new                   |   5 +-
 tests/btrfs/085       |   2 -
 tests/btrfs/161       |  91 ++++++++++++++++
 tests/btrfs/161.out   |   9 ++
 tests/btrfs/162       | 103 ++++++++++++++++++
 tests/btrfs/162.out   |   9 ++
 tests/btrfs/163       | 112 +++++++++++++++++++
 tests/btrfs/163.out   |   9 ++
 tests/btrfs/164       | 111 +++++++++++++++++++
 tests/btrfs/164.out   |   9 ++
 tests/btrfs/group     |  40 +++----
 tests/ext4/010        |  10 +-
 tests/ext4/032        |   3 +-
 tests/ext4/033        | 123 +++++++++++++++++++++
 tests/ext4/033.out    |   6 ++
 tests/ext4/306        |   3 +-
 tests/ext4/group      |   1 +
 tests/generic/009     |   8 +-
 tests/generic/group   |  10 +-
 tests/overlay/060     | 289 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/060.out |  42 ++++++++
 tests/overlay/group   |   1 +
 tests/xfs/310         |   6 +-
 tests/xfs/446         |   1 -
 tests/xfs/group       |  12 +--
 32 files changed, 1083 insertions(+), 179 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--1hy7vOq7ZYi8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbFABEAAoJECZSqilcj+djNuMP/RT7T5ftR0j2RuLiAi7JCT7T
JVxDTWPFHPLU92XVKQn6THCPxPaki2ixjkEXDVDzM2+gXjoTm0uG0tP++GSST80Q
ue71NHc0+F4WdgVTRi98tHu0V+aiDiev7bSfBhzIbuadJ/qyw6OtZ7hA187AekLe
R69i6S+MvY1G/jLIGV0yHP3fJy3tDkBHYT0s4qfGjiCVNQimpB4gmMQ3/j423YZz
FYiJKMcC8Vjy+o0WjzzrF6UmTP1al8T9peWe9BrGij8xgDcoUzgdlzcaYikQycqw
B9UeEQ7fYlMrImH+oYDYUdAwhnmIkROKuqPqeKt/Suhfqm5Ybufip/C1BoooP8+7
d0QRXW1wqvEy7xCxLMJm6cbXmCWvOc+ufUJM401Wk04cz8+h6E63ambofpAaQIIp
qtJJ8v1cQbnsZ+mZsg15pX9Pdb0JFW8NaPMwFeQHPiapYd2wROk9On1pyIekyd6p
OXPF5rRLLOvH8DiYmyfB37ouN22HPB9G0ZZrVsSNPvELTNoqA0CHYGkDN8khBqzj
lyjNh+9uPzvB75KX/ZsJq6STpy8XmOH08cIhH9lDPoNUHnekFFk6lrCPmrR0zYiO
RvG/nI729/DSyN2rDoMTzcqPjAzO+aqIv+iesuadxT9BL7pyRDY9Nwa5t+IIwTwj
SoW8D5WRGFQhZ/3iiNG8
=C354
-----END PGP SIGNATURE-----

--1hy7vOq7ZYi8--
