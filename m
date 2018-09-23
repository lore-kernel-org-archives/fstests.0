Received: from mail-pg1-f172.google.com ([209.85.215.172]:34235 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeIWUzm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Sep 2018 16:55:42 -0400
Received: by mail-pg1-f172.google.com with SMTP id d19-v6so8084089pgv.1
        for <fstests@vger.kernel.org>; Sun, 23 Sep 2018 07:57:57 -0700 (PDT)
Message-ID: <5ba7a9f4.1c69fb81.f7dc3.af33@mx.google.com>
Date: Sun, 23 Sep 2018 22:57:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 3c48a2ca2078
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Hw53HtBde3Ck"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Hw53HtBde3Ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The punch hole tests are updated to work with 64k
extent, many thanks to Anand Jain's contribution and Chandan Rajendra's
testing! Also Amir fixed the kmemleak dection to suppress the EBUSY error on
v4.19-rc3 kernel.

The _test_generic_punch() rework is tested with all possible block sizes on
ppc64le and x86_64 hardwares, so it should not introduce any new failure, but
if you find bugs, please report bug and/or contribute fixes.

Thanks,
Eryu

The new head of the master branch is commit:

3c48a2ca2078 fstests: fix _test_generic_punch() to fit 64k extent

New commits:

Amir Goldstein (1):
      [b55879ea9dbd] common/rc: fix check for disabled kmemleak

Anand Jain (1):
      [3c48a2ca2078] fstests: fix _test_generic_punch() to fit 64k extent


Code Diffstat:

 common/punch                  |  13 +-
 common/rc                     |  15 +-
 tests/ext4/001.out.default    | 472 ++++++++++++++++++++---------------------
 tests/ext4/001.out.nodelalloc | 476 +++++++++++++++++++++---------------------
 tests/ext4/001.out.nozero     | 472 ++++++++++++++++++++---------------------
 tests/generic/009             |   9 -
 tests/generic/009.out         | 472 ++++++++++++++++++++---------------------
 tests/generic/012.out         |  68 +++---
 tests/generic/016.out         |  68 +++---
 tests/generic/021.out         |  68 +++---
 tests/generic/022.out         |  68 +++---
 tests/generic/058.out         | 124 +++++------
 tests/generic/060.out         | 124 +++++------
 tests/generic/061.out         | 128 ++++++------
 tests/generic/063.out         | 128 ++++++------
 tests/generic/255.out         | 452 +++++++++++++++++++--------------------
 tests/generic/316.out         | 224 ++++++++++----------
 tests/xfs/242.out             | 114 +++++-----
 tests/xfs/252.out             | 452 +++++++++++++++++++--------------------
 19 files changed, 1968 insertions(+), 1979 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Hw53HtBde3Ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbp6TgAAoJECZSqilcj+djxnIP/itA+TK3g1TwdhHzVd5G4C4v
8vuq7r8fVeTaa28MMQvw7YpowZ37w5vpWFZhcgsMgA9nYqezGvso4hpEZal2KYNV
sRI3ZRONv3M2TuxHtn7zl1SBq6z6njCgHJDf/dSW2AlWCgh8zEb8Iw+hClisMNYR
bSNwYdMIh1fzIMvM9o/pTAXngzH2pJZbu5h4elQTXTHtFKKt4BI1MuhZuhBEiRHz
m7MnhEZfxeLyMDT3FNSgSuKmVK8MjQxNJxbf2PatdUBSC3Kkrk1UqWK4RFDmwvER
DwUwfTBK/ac6Yc7cp3NKXwz4SaQdHfONasHTAHOteO1bUYsy8gKAi+eaaDvEpN7J
1wmrXbXnL54L5jpPcoJ8R5P1svvVh/9vDPip1qy7NXIKnH0Df3zsebAcqtJ4ixhS
v5tyluYPcNFQEnLw7e2tMI7YXI3tnIsqB1c4IJ9F+5dXlRCNi8EAZ8TyyGFYfogX
66qkpykNDSKSbJSyJFJhrF5PHAd1X6n0fWBT+hkgkICOAFD7pPlkimH1CPPQ4MlV
CNEhoN0scM6nxG/NXGjmv2vpCSY4WDornB9f+G46vda4JDmew3XHuUKk9puWL/q3
7FjpOzgJXzBQeghP9vTQCd5CecmW75Q1OKSwEpf1qSvOdyyQbvUHDr7g0wJQYmUV
Smay51dG/dbtcmO1ilXr
=yFzi
-----END PGP SIGNATURE-----

--Hw53HtBde3Ck--
