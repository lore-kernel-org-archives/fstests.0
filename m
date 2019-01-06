Received: from mail-pf1-f173.google.com ([209.85.210.173]:41195 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfAFO46 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Jan 2019 09:56:58 -0500
Received: by mail-pf1-f173.google.com with SMTP id b7so20568128pfi.8
        for <fstests@vger.kernel.org>; Sun, 06 Jan 2019 06:56:57 -0800 (PST)
Message-ID: <5c321737.1c69fb81.b9424.ce58@mx.google.com>
Date: Sun, 06 Jan 2019 22:56:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to f3a1213c2494
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8LuwmWxjGtLd"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--8LuwmWxjGtLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a bugfix-only update, and notably we reverted
the RESULT_BASE fix in kmemleak support (sorry for suggesting a wrong fix), it
turns that it's the kmemleak infrastracture that needs to be fixed (I'll look
into it next week).

Thanks,
Eryu

The new head of the master branch is commit:

f3a1213c2494 Revert "common/config: create $RESULT_BASE before dumping kmemleak leaks"

New commits:

Hou Tao (3):
      [46c1a950e375] xfs: only set XFS_MKFS_HAS_NO_META_SUPPORT for XFS
      [2408f208c106] fsx: check ENOSYS in test_copy_range() & test_fallocate()
      [e18876187ce7] generic/131: wait until the server is ready or timeout

Nikolay Borisov (1):
      [f3a1213c2494] Revert "common/config: create $RESULT_BASE before dumping kmemleak leaks"

Zorro Lang (2):
      [6dbca6feb9ff] generic/474: shift target directory to a sub-dir of SCRATCH_MNT
      [b0c8dbccf438] xfs/139-140: skip testing on large scratch dev


Code Diffstat:

 check             |  7 +++++++
 common/config     | 23 ++++++++++-------------
 ltp/fsx.c         |  5 +++--
 tests/generic/131 | 21 ++++++++++++++++++---
 tests/generic/474 | 12 ++++++++----
 tests/xfs/139     |  3 +++
 tests/xfs/140     |  3 +++
 7 files changed, 52 insertions(+), 22 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--8LuwmWxjGtLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcMha0AAoJECZSqilcj+djrrEQAKAaDJXtUy9eFIN4luxqVtHI
M2doUVkJQfbLFURK0VRiPP+iMX+YA8XITvmhNOWB98NnTHBSpWEo5nHXTojI+QbF
OuLEJyDOKBjiH9wACwI18zW9OPruMm5tFuubvDLSIjFaEutM7D015lhP2lw7TfGl
gyRUKC6vzZPSOf9qSavYjSET79tmu9Nc0PvePaECx7VNHTtLujMIDYIG90zxwIj5
y42g4G0cum8ktux1AVp9crS+njL767c8HBK2PYJoQMkCYJi3RSIx5BynTpZ8RsMg
yaBHIwZysLNmeDIbPg62mJ5kImN0QgfCPrURCBf83VZ0Ana9AwPoIw32L5uop/JQ
6XrMdE3sC+usBgy5vLD15eJAvInS2oC5wgLa62nLK3d5gKEOSXyhiWhhUEwpJcO5
JV0Iywpt/5Be76MST7bKWRIiFz5XqB5a5vskkUnxi3ZhA5la68eDgSXB25Je8lOH
2PrZaQl2cjGtuG0RzFs4QXwEfomiOfitQMbZPcHA+oE3IijPE1hAZgm776cpUsXs
uzDQc4ebU9DgpgGFMbOZSdAiLV3ofCs3EorDMzKzce8vmSziiVpYwQdtWZYOVjUU
EmpdWWdB2yKG8uhKmZgJGFS1At1aQnUfppt2LeB0UC9fORQoZYJULOX92aJWv1Pj
UHG2dwA/Fk+awVbH/XB+
=lmMy
-----END PGP SIGNATURE-----

--8LuwmWxjGtLd--
