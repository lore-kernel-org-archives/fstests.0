Received: from mail-pl1-f195.google.com ([209.85.214.195]:45529 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJGWj3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Oct 2018 18:39:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id y15-v6so8925464plr.12
        for <fstests@vger.kernel.org>; Sun, 07 Oct 2018 08:31:51 -0700 (PDT)
Message-ID: <5bba26e5.1c69fb81.86b01.9020@mx.google.com>
Date: Sun, 07 Oct 2018 23:31:42 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to c85c46531b4f
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8KmEtuT3Cb5O"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--8KmEtuT3Cb5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. I'm mainly pulling in the _scratch_mkfs_sized fixes for
btrfs from Anand Jain in this update, which increase the filesystem size
created to 256M so that btrfs is not in mixed mode.

Note that the new btrfs/172 test would fail with current Linus tree.

Many thanks to those who helped review and test patches!

Thanks,
Eryu

The new head of the master branch is commit:

c85c46531b4f generic/387: fix _scratch_mkfs_sized option for btrfs

New commits:

Anand Jain (6):
      [4c2c678cd56a] btrfs: test unaligned punch hole at ENOSPC
      [50c1905c2795] btrfs: _scratch_mkfs_sized fix min size without mixed option
      [36a371bdf8bc] generic/015: fix to test the default non-mixed mode
      [626231c289b8] generic/083: fix btrfs fs size for default mode
      [96621a053236] generic/449: fix fs size for _scratch_mkfs_sized for btrfs
      [c85c46531b4f] generic/387: fix _scratch_mkfs_sized option for btrfs

Chao Yu (1):
      [f6abb65ebcee] common/quota: adapt _require_prjquota() for f2fs

Eric Sandeen (1):
      [1895cf6b659e] xfs/122: add struct xfs_unmount_log_format


Code Diffstat:

 common/quota        |  7 +++++
 common/rc           |  5 +++-
 tests/btrfs/172     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/172.out |  2 ++
 tests/btrfs/group   |  1 +
 tests/generic/015   |  8 +++---
 tests/generic/083   |  2 +-
 tests/generic/387   |  3 ++-
 tests/generic/449   |  4 +--
 tests/xfs/122.out   |  1 +
 10 files changed, 96 insertions(+), 10 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--8KmEtuT3Cb5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbuiZiAAoJECZSqilcj+djZGYQAMf+wwRorUlIC01SP6KdnAPa
Rtm29DgsV7OpzAkeF+4P8rPoxPkWRRSFJOK4Cpo+v9tg60/6xirJFsrWwCttnJst
hajSrZMFT0yo1qGtuArVpcaw+G6tTLXazZVNDMfWmRyk6owuv08/57CpVyz1BSSI
4jcch4vjDgwIsPk43p1Be0LMmfy0x7TocEdwhILsr95FyJoJ7OJQ3hF/L3U8nGY5
oW9W4+zAshtka7MFdaPrpxG01sVpu1XgkLLuY5l3RRJJZHmZ5NbgGnmsmISSxhnD
hT/zOAlnl9TreHzXEYYupnaUald8xQ/1LqwxXREzqcSnOkpEs/2DqAcc5k5wAtPm
BrmOdaG5NRFQidFI7FrXcUXhPGgWybjPtMXFyl6Xt0N/DrzhNyZnrHfyIlaSkpXd
ChPoI4+GVaj56EzDFT+PMm6jGMKwPqHXEjUnx4ZLQ48DLIqNkV66UOHtQU5ugQYm
/tGnbia3s917m7p9eZESOJ9ShVYMzpaBHemJ5eYBQWo55mMbHxmTWKecV0nbDQ9M
fW5Tik2QFZkIH2+QblXA7atLdDI2rc8s2AVw9Mx3i+UPCbVhWsoYuIeGRlR8iLY3
6ABJg2SO5OwwJMA2l1HI+RMsEFZR6bPY+Z3DTykYVw8pXIcQE0GW4NJPgSoFBogq
b+t/3XPnmrgeHz2bToR+
=rmMc
-----END PGP SIGNATURE-----

--8KmEtuT3Cb5O--
