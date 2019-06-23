Received: from mail-pl1-f194.google.com ([209.85.214.194]:43611 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWNjt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jun 2019 09:39:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so5349010plb.10
        for <fstests@vger.kernel.org>; Sun, 23 Jun 2019 06:39:49 -0700 (PDT)
Message-ID: <5d0f8124.1c69fb81.46c03.e7cb@mx.google.com>
Date: Sun, 23 Jun 2019 21:39:43 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to d864b9cb5de2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ziQ3pgwlsbsn"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ziQ3pgwlsbsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal new test & bugfix update, which adds
one new test alone with some random fixes & improvements.

Just note that new test generic/557 currently fails on btrfs.

Thanks,
Eryu

The new head of the master branch is commit:

d864b9cb5de2 generic/059: also test that the file's mtime and ctime are updated

New commits:

Amir Goldstein (1):
      [6b98121773c6] overlay: fix _scratch_remount with xfs_info 5.0.0

Darrick J. Wong (1):
      [03a2da5879c0] dump: _cleanup_dump should only check the scratch fs if the test required it

Filipe Manana (2):
      [c132cd4de91b] generic: test dir fsync after deleting dentry post eviction of its inode
      [d864b9cb5de2] generic/059: also test that the file's mtime and ctime are updated

Murphy Zhou (1):
      [de36c063fcfb] generic/532: document the kernel commit


Code Diffstat:

 common/dump           |  2 +-
 common/overlay        |  5 ++++
 tests/generic/059     | 18 ++++++++++++
 tests/generic/532     |  3 +-
 tests/generic/557     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/557.out |  2 ++
 tests/generic/group   |  1 +
 7 files changed, 108 insertions(+), 2 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--ziQ3pgwlsbsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJdD4CwAAoJECZSqilcj+djIIEQAItQVMb5/O0Z46lRdBRBsI7R
+YinET3Aj4W/3HiZFaacd7bY0xJOVnA0F2w1onNHGiI1lgJmsHD7MOGS4eT1CXNe
x982UwS6roitrRiWWHTVKaE150BjhfOy9MX+sShbuhMrzIXkOXIPWT1p0xCEgY44
dva5a95IubJr1xFc+yWJLm3SPCers/39daeqb5bxoRcPovUeUMtBliaelHcP4djf
nkTfDuUwdzzbrfUUp9AK8a7wsO/UMPuUubkl8PzLkQbM+j77AsMg2FmgqD4mEXOA
Na0XwLOre2U4Qq1J1FzCNXKrsQpo6jJw9r8QV0SjHgejBoo/PA3p0lkEZvQ+ydpI
OkvW4uRn2SpS306+PSmtVPOL9a7H34yb2pmyNhsCBDoH/VkH1NT8YXqwhISrLRX+
1OWmNrfgvmOI8GV95omJ2YGCsuQZLRgNEVrcdCEM59YAfza5PSFc7XSZOMQVF0QF
JVCiJoQJlQ25LSbedwJYtJbHaLlIyM7GzGFCfMZHukrdLgy4un7Q3ztYpituMK4H
KbxakfSdwIx6/12PX7Lagn5ZPwgFcL+cANBqXG/6RGNIiBMFP1sV2iTSdK+l98Gx
nKV7lsm2bWmVBQNdk+6OPZQpeiSHmg1nnRR6+Tuaf0Gct/BsnH0b5CWzB9/x3jR/
EE3aEcCm/p98D9VmC0Dw
=uic0
-----END PGP SIGNATURE-----

--ziQ3pgwlsbsn--
