Received: from mail-pf1-f193.google.com ([209.85.210.193]:36653 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBRKc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Dec 2018 12:10:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so5168138pfc.3
        for <fstests@vger.kernel.org>; Sun, 02 Dec 2018 09:10:28 -0800 (PST)
Message-ID: <5c041202.1c69fb81.ce73c.02e7@mx.google.com>
Date: Mon, 03 Dec 2018 01:10:21 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to fd532405deaf
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6QU4zmhAizy8"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--6QU4zmhAizy8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the first piece of the
CrashMonkey tests from Jayashree Mohan, many thanks to Jayashree for the test
and to Filipe Manana and others for reviewing and providing review comments!
The new test currently fails on btrfs, but the fix is pending on btrfs list.

I didn't pick up the {clone, copy, dedupe}_range addition to fsx/fsstress
patchset, but I think they're ready to go (except the fsx long soak tests).
Darrick, please feel free to just resend the long soak tests if there're no
further updates to the series.

Thanks,
Eryu

The new head of the master branch is commit:

fd532405deaf fstest: CrashMonkey 'hard link' tests ported to xfstest

New commits:

Jayashree (1):
      [fd532405deaf] fstest: CrashMonkey 'hard link' tests ported to xfstest

Xiao Yang (1):
      [8f399f01d1e4] ext4/002: Fix obsolete TEST_DEV/TEST_DIR in _check_ext4_eof_flag()


Code Diffstat:

 tests/ext4/002        |  10 +--
 tests/generic/520     | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/520.out |  75 ++++++++++++++++++++
 tests/generic/group   |   1 +
 4 files changed, 265 insertions(+), 5 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--6QU4zmhAizy8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcBBHGAAoJECZSqilcj+djadoP+wacsQ9TySs3iWCkjHm/OX63
mxGB75zJctqpGR9s+bLoCqH1GI41d0WA/0gjHqT6cKJyo9n0XfxCMsoL7Y/MOcbY
Np4o3jO6/0p4Z4juTVj5JUT7kfdZhx71sj04hGjuV3a+bo5u22ZVyi3xkbGK6NrN
Zfn8RttCGqlGTdYQW047Jrk5yCBMlAJpMVocHvBsoNJt00deXSXJE5bKSzEKgun1
bno9LV6T9rDSIyCcRW+VlBs5Ks+UhYXgsmzxj1Q6JpDXOul0QCuKQn4c8vFq3s/6
plIqK93nV9bjuETetdsUum5yCA8JeL1GyQpp2jjfLUWdiRCNNyT/A+dhY+Wb8Io2
nIGlmZuOTlOXU7/J3kQlnZcSpa0AXKBFQDoXm5TbeHeJjEs3kFafFmoMaVQvQtf3
ed1RNN1JOi29b5TOfo8fukNrvsZz26bXUJP66CdAk00I2EuNcZ3eYTX2J86CnMw4
kDTHdQEa8WQuhxbYJcRP1qoj+rsfmxMu5ofelXBJYkg7G5juRxAEnw6ZiOKUcjbn
10OezWt2VBirSvodVPL/XaO1bSPfZ8hNfvsZVK/IbThrmOzmgMEPjUWSN9TiUU/q
+eE3G8uf4ai9b/HAHP4iD1iuJH4UtO/ho1zr8Y08VhMc9WucOxKd2mA0G39YShmC
5QtCfSqqlrCVOhmyOk0z
=bdnv
-----END PGP SIGNATURE-----

--6QU4zmhAizy8--
