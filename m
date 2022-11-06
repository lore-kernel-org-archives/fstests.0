Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE02C433FE
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Nov 2022 12:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiKFMk2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Nov 2022 07:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKFMk2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Nov 2022 07:40:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ECF2BF8
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 04:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9CF60C56
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 12:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF82CC433D6;
        Sun,  6 Nov 2022 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667738426;
        bh=NPdj3UX1D0nZFscW4G3qZT4uB9hgLVffqkR5qJy8z7k=;
        h=Date:From:To:Subject:From;
        b=gU6usIm6MupUjGPXIu9YoKMkn8f1wtGxPaEY1WD5eZwI735DhcFLuv4A7IQn3iw9q
         cmRNGSetyiW1y3BPuQwyLDYqW4A5HqHeaO146uWAJGjXTUuCvCU7tENkmWI+osrXWD
         2UFrSN8TfTvaTpS1fw1l/7mFEPnCyhyx6Xi5sBLmMD7gwxDQqa9pGV78+d/ExuvIq2
         0tfuG/F+7JizPUYHz8dbb02UmO/qwj6eGit/r1cQb/zMiCrJIqikb5vNypnuW8Ebhs
         rcH5DCBU8ZzMyTbHeIcfP9oURfsrKTUfU/up4y421pthxD3fhGIJH1dyES3sYSElrx
         Bwf1O4zuGVJ9g==
Date:   Sun, 06 Nov 2022 20:40:22 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 41f2bbdec5fa
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UScWBcuqUUP8"
Content-Disposition: inline
Message-Id: <20221106124025.DF82CC433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--UScWBcuqUUP8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.11.06 release.

Release note:
1) There're 3 new cases (xfs/556, btrfs/279 and btrfs/280) in this release.
   They don't panic/hang on old kernel generally.
2) A common/config change makes TEST_FS_MOUNT_OPTIONS and MOUNT_OPTIONS to be
   same by default. It might affect some fs which don't init them same, likes
   tmpfs, gfs2, reiserfs, f2fs, ceph, udf, overlay. I think this change makes
   sense, but if anyone find any issue from it, feel free to send email to us.
3) More cases are added into perms group.
4) Darrick add some new helpers for dmerror test.

More update and code improvement as below, thanks for all your contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

41f2bbdec5fa generic: add missing $FSX_AVOID to fsx invocations

New commits ([N]ew, [U]date):

Darrick J. Wong (1):
[N&U]    [1b3f0e1b6c9e] xfs: test xfs_scrub phase 6 media error reporting

Eric Biggers (3):
[U]      [7f7f3261a3cc] common/verity: fix _fsv_have_hash_algorithm() with required signatures
[U]      [b0442d18aa88] generic/577: add missing file removal before empty file test
[U]      [6994e033aba2] tests: fix some tests for systems with fs.verity.require_signatures=1
[U]
Eric Whitney (1):
[U]      [41f2bbdec5fa] generic: add missing $FSX_AVOID to fsx invocations

Filipe Manana (3):
[U]      [2450821c9b15] common/punch: fix flags printing for filter _filter_fiemap_flags
[N]      [cea2bae85f1d] btrfs: test that fiemap reports extent as not shared after deleting file
[N]      [cb404cfcae51] btrfs: test fiemap reports extent as not shared after COWing it in snapshot

Xiao Yang (1):
[U]      [1dd7395623cb] common/config: Make test and scratch devices use the same mount options

Yang Xu (1):
[U]      [1d4080ce7a6b] fstests: Add more related cases to perms group


Code Diffstat:

 common/config       |  65 ++++++++--------------
 common/dmerror      | 147 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/punch        |   2 +
 common/verity       |  58 +++++++++++++-------
 common/xfs          |   9 +++
 tests/btrfs/279     |  82 +++++++++++++++++++++++++++
 tests/btrfs/279.out |  39 +++++++++++++
 tests/btrfs/280     |  64 ++++++++++++++++++++++
 tests/btrfs/280.out |  21 +++++++
 tests/btrfs/290     |   9 +++
 tests/btrfs/291     |   2 +
 tests/generic/099   |   2 +-
 tests/generic/105   |   2 +-
 tests/generic/193   |   2 +-
 tests/generic/237   |   2 +-
 tests/generic/314   |   2 +-
 tests/generic/318   |   2 +-
 tests/generic/319   |   2 +-
 tests/generic/355   |   2 +-
 tests/generic/362   |   2 +-
 tests/generic/363   |   2 +-
 tests/generic/364   |   2 +-
 tests/generic/365   |   2 +-
 tests/generic/366   |   2 +-
 tests/generic/367   |   2 +-
 tests/generic/368   |   2 +-
 tests/generic/369   |   2 +-
 tests/generic/370   |   2 +-
 tests/generic/375   |   2 +-
 tests/generic/444   |   2 +-
 tests/generic/455   |   2 +-
 tests/generic/457   |   2 +-
 tests/generic/577   |   1 +
 tests/generic/624   |   8 +++
 tests/generic/673   |   2 +-
 tests/generic/674   |   2 +-
 tests/generic/683   |   2 +-
 tests/generic/684   |   2 +-
 tests/generic/685   |   2 +-
 tests/generic/686   |   2 +-
 tests/generic/687   |   2 +-
 tests/generic/692   |   8 +++
 tests/overlay/004   |   2 +-
 tests/overlay/008   |   2 +-
 tests/overlay/015   |   2 +-
 tests/overlay/023   |   2 +-
 tests/xfs/556       | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/556.out   |  12 ++++
 48 files changed, 652 insertions(+), 94 deletions(-)
--
Zorro Lang
zlang@kernel.org

--UScWBcuqUUP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNnqvgACgkQlNbPkfr2
tMzcgA//RcL6HPL1U0ApGf2Mlj4PBp6aEp+AvD1MQWO/OCYtWURHjhNvvItNQYca
/MXQ3dA6W1w9In9m9WPwK31TBR/SsUg20P2wT1SOLh+AxLhNWbJZQV/pcUqDQzmF
uzmSpT/bAhMsf1GfAbTXtuii2OeSBknWlrzbHVc0PAWNkOiqv6PVT3sbOuKKUTTT
2y7vTCnWp6gdYV2Tzu2nEJ8o0vjsWJfkcgkHTB+sd4MhwnGOzvoYO+HT7ZlWW3Ha
+MezScaag7dS0cpFkHjIUW2XrVg9NLWUsDij49HKUDJ1dxrusQ0JzFunE6Nt2vam
T0TNdTxFlbd76NXzBiOn79dBhLUfHhnEeywhYM6cFZbiLFjPgHgp/znKh1+YO/04
QN3oEbg6IxtBp1TECp9B1V56MlR2XOraKaufwNJMfBlzfMC8b7hWE4EI9wk44b1S
m2zCkaUYMMSB+arVC3zjFYIfTpm3wzRZ2rDgVIo+5Ynl9QDnWUInNkZt85wU3CXK
zhklBW/fuuCwHCbelfq9p8NpT1zuLwIa7rtIv+HMcW/LCT6Oyr7FKKjGXfqJwmTE
AMwX7XwYIpttgD+x1apBTS0CDEcz8UyutrwEsX+18OYRXR5+4+kz1SSOG2scytdV
0m4hfG1x9Bs+2EMFGOf6gh1/fRf4Z/UxI6gA7BXkSW1lJItA70s=
=cK+q
-----END PGP SIGNATURE-----

--UScWBcuqUUP8--
