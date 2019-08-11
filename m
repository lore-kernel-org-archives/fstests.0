Received: from mail-pf1-f196.google.com ([209.85.210.196]:43386 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHKPi6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Aug 2019 11:38:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so727040pfn.10
        for <fstests@vger.kernel.org>; Sun, 11 Aug 2019 08:38:58 -0700 (PDT)
Message-ID: <5d503691.1c69fb81.273a3.bc5f@mx.google.com>
Date: Sun, 11 Aug 2019 23:38:43 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 8adf5e71df15
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tnmlJBmpbRJs"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--tnmlJBmpbRJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a bugfix-only update, and there should be no
new failures introduced.

Thanks,
Eryu

The new head of the master branch is commit:

8adf5e71df15 seek_sanity_test: Repair check for unwritten extent support

New commits:

Andreas Gruenbacher (2):
      [83318f266500] aio-dio-regress: code clarification
      [8adf5e71df15] seek_sanity_test: Repair check for unwritten extent support

Qu Wenruo (1):
      [1592be349386] log-writes: Handle unrecognized options to prevent segfault

Yong Sun (1):
      [c43a4c3fee71] xfs/097: always mkfs with finobt enabled


Code Diffstat:

 src/aio-dio-regress/aio-dio-subblock-eof-read.c |  4 +--
 src/log-writes/replay-log.c                     |  2 ++
 src/seek_sanity_test.c                          | 35 ++++++++++++++++---------
 tests/xfs/097                                   |  2 +-
 4 files changed, 28 insertions(+), 15 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--tnmlJBmpbRJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl1QNiMACgkQJlKqKVyP
52Ms5w//X14bSggvZeSDbTSBWe41o16VGnmtpam+no6l3fFt7947RAViW7JXweaD
zZQwrj4UGw77sxgWaq3At8hykVNQkuTHsH/pK7x457RSUhoBpeVn/7aaXrhcjjkU
QnKY6NAbWnc3WdnjOtcE+xV9zNU657KSRpzoqhEeDvryMWXZeFEuu9eeJH3PoOZS
zQ9rTP5WL1pFk2DhzGlwJCWwb+tdzyyEbCuWHnWSSKv+kfyGKZ4jR2jBQenMCYy4
QLQizJX9bJHbUa+QMtuuK7ErO5CL8Mp7Jc/1VLqWNEGmas728XTg3hohZ7kXQWrR
u1dnI/KbnM668Rq5XPFIesla4C5sshmPFg7noHuNZHpaStW9c4gffR67G5U2Y6En
or39yE8t4v2qvtlPlAyCUomWM9WJkN0Mz/SPgru3qCYmUHojihOFIMrhjdNPXYEi
1KIebfWJgfDB59+wXhrW/ZiqKcjxzm1JSvgaMGrxs6KxHvMnXKVwZyNt5QS9Zw3W
45qwoX19L6DTwwZVS4Jm+QRXVuz2xqit7zbQNQPZsKLu3XRgo55dBI+omy7C/MQv
KXpQoPWpg2gDFRQAtTtwlpuDb83+V+NO3rgaa6jCUggu1gAiU/BnLwyddf2m0DcD
I0e2nHKhEQwlggr8gtZ3s9HwnMOmB/eGd/iBlrJpuc0O34iUJdA=
=3Zkp
-----END PGP SIGNATURE-----

--tnmlJBmpbRJs--
