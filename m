Received: from mail-pg1-f196.google.com ([209.85.215.196]:36470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfFIORw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jun 2019 10:17:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so3639787pgb.3
        for <fstests@vger.kernel.org>; Sun, 09 Jun 2019 07:17:51 -0700 (PDT)
Message-ID: <5cfd150e.1c69fb81.25895.40a6@mx.google.com>
Date: Sun, 09 Jun 2019 22:17:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 3a82f23e450c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JxXvqMeMWHlM"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--JxXvqMeMWHlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're two new copy_file_range(2) tests and one
generic data loss test in this update, along with some xfs and btrfs
enhancements.

You may see new failures like generic/553 and generic/554 on all filesystems,
and generic/552 on btrfs. The enhanced btrfs/163 test may hang on latest
kernel.

Thanks,
Eryu

The new head of the master branch is commit:

3a82f23e450c generic: copy_file_range swapfile test

New commits:

Amir Goldstein (3):
      [7a3a9f5754f5] generic: create copy_range group
      [61a838524a8e] generic: copy_file_range immutable file test
      [3a82f23e450c] generic: copy_file_range swapfile test

Darrick J. Wong (3):
      [80c49a927cc1] xfs/122: add new ioctl structures
      [edd56cc4274f] fstests: remove obsolete xfs ioctl typedef usage
      [8ca445c46ee1] check: try to insulate the test framework from oom killer

Filipe Manana (1):
      [d3665da45665] generic: test for data loss on fsync after evicting an inode and renaming it

Johannes Thumshirn (1):
      [18b7c53fd650] btrfs/048: add validation of compression options

Naohiro Aota (1):
      [18b5abf82429] btrfs/163: make readahead run on the seed device


Code Diffstat:

 check                               | 15 +++++-
 ltp/fsstress.c                      |  8 +--
 src/bstat.c                         |  6 +--
 src/bulkstat_unlink_test.c          |  8 +--
 src/bulkstat_unlink_test_modified.c | 10 ++--
 src/t_immutable.c                   | 12 ++---
 tests/btrfs/048                     | 13 +++++
 tests/btrfs/048.out                 | 11 +++++
 tests/btrfs/163                     |  2 +-
 tests/btrfs/163.out                 |  4 +-
 tests/generic/434                   |  2 +
 tests/generic/552                   | 98 +++++++++++++++++++++++++++++++++++++
 tests/generic/552.out               |  7 +++
 tests/generic/553                   | 59 ++++++++++++++++++++++
 tests/generic/553.out               |  5 ++
 tests/generic/554                   | 54 ++++++++++++++++++++
 tests/generic/554.out               |  4 ++
 tests/generic/group                 | 13 +++--
 tests/xfs/122.out                   |  4 ++
 19 files changed, 303 insertions(+), 32 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--JxXvqMeMWHlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJc/RSpAAoJECZSqilcj+djpFAP/0qwhJ5f8Q74n5tvTbMdo72t
J9nRrlqMctu5JedfToORXs3E31e07RfMaV2Rk3P7jGLp3IyW32MwDARuRG/gxjK6
Pc5nX/ABYmieZFXv3EEJnfptytflRfC2cyBBdzPkV2X6jlrVPSPjG0jnhouuumtK
btSr4saImmyMKtNRaH/+2iQbE/lnYjq5BDyJCubU3ZWubQXN5u3VK9qj5Q/1F8WC
hjhPZ0319xF+AOfAGUbCv1tfDFZYxmhubjQCalbZ0+PRTHTwub5UQ8o7PPBnqaA9
LpFzJ9CFQYkXfd1z9xNGyELxTZAgcf7emsjBJNAmgqqr729fePdQx1jDvib+SWLc
BzxobSNYHHJ1dt1P6xQBgdC+70f9wAXgod64b7U26BHzeLSzc5r82Ud/4MmPweAD
OLCP+IRsN0DShcFGIK3QQJOkNxy3iX+mBD3DbMf0DrOx2SVdcEn13+E44GPdi705
BnGoAvd2D3q/OIhtTc0Sx/YkiL6hpBkkFVjr4zWdSDmMxg7xPhjU2wFStDBOSyWO
C0KLi1inT9jIgE2MsrZNjYvwdFTP9uag6ocC5rbSeZNOsx5XydhHjyK/YNs8BdC9
GmQbacNSfn7gighXqUoh41WzlFSEpPMB0DW/pElwAVtBAy5VnLfaaFl19tj+Pme8
Sq9DFl0+R7zgb/kmyyDV
=GqDh
-----END PGP SIGNATURE-----

--JxXvqMeMWHlM--
