Received: from mail-pf1-f177.google.com ([209.85.210.177]:44130 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbfCaPzx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Mar 2019 11:55:53 -0400
Received: by mail-pf1-f177.google.com with SMTP id y13so3291235pfm.11
        for <fstests@vger.kernel.org>; Sun, 31 Mar 2019 08:55:53 -0700 (PDT)
Message-ID: <5ca0e307.1c69fb81.ab5e6.d2e3@mx.google.com>
Date: Sun, 31 Mar 2019 23:55:41 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to b591875529d1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="D1zjKAuQUFIL"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--D1zjKAuQUFIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal new test & bug fix update. New test
generic/536 currently fails on XFS, and generic/537 fails on ext4/XFS/btrfs if
your $SCRATCH_DEV supports TRIM.

Also, many thanks to Darrick J. Wong, Filipe Manana and Anand Jain for
reviewing patches!

Thanks,
Eryu

The new head of the master branch is commit:

b591875529d1 fsx: fix errors due to unsupported FIDEDUPERANGE

New commits:

Brian Foster (1):
      [fae1d350f9ee] generic: test stale data exposure after writeback crash

Darrick J. Wong (1):
      [8a011c00b524] generic: prohibit fstrim on journalled filesystems with norecovery

Jan Kara (1):
      [b591875529d1] fsx: fix errors due to unsupported FIDEDUPERANGE

Nikolay Borisov (3):
      [2d103d8ab814] fstests: Add missing call to _scratch_dev_pool_put
      [63b0ee123266] fstests: Verify that removed device has its superblocks deleted
      [a7bab01554fb] generic/077: Don't delete $seqres.full file after test

Zorro Lang (1):
      [b0ef2879a774] xfs/065: make sure SCRATCH_DEV is unmount before mkfs


Code Diffstat:

 ltp/fsx.c             |  3 ++-
 tests/btrfs/148       |  2 ++
 tests/btrfs/184       | 63 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/184.out   |  2 ++
 tests/btrfs/group     |  1 +
 tests/generic/077     |  1 -
 tests/generic/536     | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/536.out |  3 +++
 tests/generic/537     | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/537.out |  4 +++
 tests/generic/group   |  2 ++
 tests/xfs/065         |  1 +
 12 files changed, 219 insertions(+), 2 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--D1zjKAuQUFIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcoOLgAAoJECZSqilcj+djkgQP/imo/fYi0zK1bYylM0yLgnHO
DMDIWd76IR08vPgGiq7A4Hc7vgqIS1iVqZp3zc7LYyeKoZ8Zx5wwf2WBJMbB3ZDL
cKQkomMIWFRvurHTKRsc+YvHAKQj+F0N2Wb2e0CYw/H0weF6MuqxbgJRtoCD6tSm
U3DTrd/g75MErc7wXWCMSTLfz5/EVy5S4W3Q89aGUb51mCqLPfPybR2zsnJm1Ks6
pU1QybwLUZ7ccGJfnGTIGolmDRDcuGuS5JgReaNVWv2xBs36J1XSxe+g1+SOaRKP
feeZRUb3+LTObZMHSYOzxlXM18yx84fsRKdLcbOR6tznnyXBm2xF8NlnHE6joOhV
Chvy+eOa59xKOlcOQLaGnF11OtCyht//0ytF9bTZBNlm0sYPQ7zdlnzmwzvszCSM
Pj5ySubRrVxhdm/mdhl/OS/7yhpHXQXCNAWw8mdMdrbhYJzKnQ+2xE3erNAOa4LT
ySLVjJE/0eF9J4nvzUrk5H99q/szHSe0P4MznjuI/RlgQWbgkdTF8Gs7QPJTTrAy
HaoVAKZ6Lyc9On2F8rRFjeaw19y3oMV2FpE1CfDJ2Seizy2vHtVaFZVMiM+kpEhj
1L5FlyrL3/1Ot95BP3ezX2uXhBNwahQu2Wb11JkQg0P1JXht6TMePYz+4vOORuvu
7/b3J/ueQ+Zc5Xmm646b
=RhwC
-----END PGP SIGNATURE-----

--D1zjKAuQUFIL--
