Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124FAC43334
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Jun 2022 10:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245368AbiFEKNA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Jun 2022 06:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245335AbiFEKM7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Jun 2022 06:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4E6249
        for <fstests@vger.kernel.org>; Sun,  5 Jun 2022 03:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4769960F01
        for <fstests@vger.kernel.org>; Sun,  5 Jun 2022 10:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B536C385A5;
        Sun,  5 Jun 2022 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654423975;
        bh=t0G17P5N+Je8TqTmDmYOHSL93Mv9vxzqj0dPIExOF+A=;
        h=Date:From:To:Subject:From;
        b=gpVTMStAlrWru5vievkx86E7TTpV/bpnimV3Ca4+TmP+z1DvzDBC01Plr6+00PF5/
         6YyNTUWWEAeKQEaJN+yFJGM32e01d29hBvEWQw5Y/s0nmP/EMHO/zdeg6tLwxnJ4qt
         uJBLCVxSUeOlCZwG9dkR03lSoEBBbMH2JxogD8+td2QFekCY4OhGBmPoVDzx6BWfy9
         mMoVC4aCXX9TQS3U8oIC5H9+T7JdR+95QZitQyQfXYIdLUhxOCCXZ2SqHrIemLcQia
         kybkn47AVzUqWLn9M8xdITJZNmR6i/OFiZtiX2X0jphOUPB7oH3uE37VeOlMCc2SL+
         fUyl8faadkgqA==
Date:   Sun, 05 Jun 2022 18:12:53 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 568ac9fffeb6
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d8jRStldt4Nq"
Content-Disposition: inline
Message-Id: <20220605101255.4B536C385A5@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--d8jRStldt4Nq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.06.05 release.

Note:
1) The ext4/053 add more testing, old kernel(<5.19) might hit some new failures.
2) A new test case xfs/018 covers latest XFS log attribute replaying changes. To runt it, you need CONFIG_XFS_DEBUG, and 5.19 kernel and xfsprogs

Thanks,
Zorro

The new head of the for-next branch is commit:

568ac9fffeb6 xfs/189: systemd monitoring of /etc/fstab sucks

New commits ([N]ew, [U]pdate):

Allison Henderson (1):
[N]      [b475a5a251b4] fstests: Add Log Attribute Replay test

Chao Yu (1):
[U]      [d9d729cf021a] generic: adjust strict SPO recovery testcases for f2fs

Dave Chinner (7):
[U]      [41ff2ea0434c] README: document _begin_fstests better
[U]      [e35f87e97507] generic/081: don't run on DAX capable devices
[U]      [e75ea385432e] generic/038: kill background threads on interrupt
[U]      [2066988abf20] xfs/538: fix fsstress scaling
[U]      [4c76d0ba2b48] xfs/070: filter the bad sb magic number error
[U]      [01dc3329bcc0] xfs/167: adjust runtime with TIME_FACTOR
[U]      [568ac9fffeb6] xfs/189: systemd monitoring of /etc/fstab sucks

Eric Biggers (1):
[U]      [03a72544ad16] ext4/053: update the test_dummy_encryption tests

Liu Yiding (1):
[U]      [bc0373ef244e] common/rc: Fix _require_batched_discard to skip test correctly

Zorro Lang (4):
[U]      [10d2fe7908a3] generic/139: require 512 bytes to be the minimum dio size
[U]      [78af5961e41e] generic/506: call _require_quota before _qmount
[U]      [568648f14515] generic/591: remove redundant output from golden image
[U]      [627e079a5fb8] generic/591: use proper sector size


Code Diffstat:

 README                |  40 ++++++++---
 common/rc             |  55 ++++++++++-----
 common/repair         |   1 +
 src/splice-test.c     |  39 +++++++----
 tests/ext4/053        |  35 ++++++----
 tests/generic/038     |  16 +++--
 tests/generic/139     |   2 +-
 tests/generic/342     |   5 ++
 tests/generic/502     |   5 ++
 tests/generic/506     |   1 +
 tests/generic/526     |   5 ++
 tests/generic/527     |   5 ++
 tests/generic/591     |   6 +-
 tests/generic/591.out |   2 -
 tests/xfs/018         | 181 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/018.out     | 168 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/167         |   6 +-
 tests/xfs/189         |  26 +++++++-
 tests/xfs/538         |  36 +++++-----
 tests/xfs/538.out     |   3 +-
 20 files changed, 548 insertions(+), 89 deletions(-)
--
Zorro Lang
zlang@kernel.org

--d8jRStldt4Nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKcgWMACgkQlNbPkfr2
tMyMMBAAyNBZYO/GDPyKgq0OfFr+c0GXujkD0wVrcR8kafmp7lkUHvOqwbq65zhI
iQozIGFrCd+Q48SSZhZoZxkyzcAn8Fziu9NCfM6nB8m33BqWvQEWeFChQdmkXE+L
JgmGWWnl1MzcvnUcJlZKl50Fzvgr9RbiXLjCj6BndqdyxVkG13hSDuvOUCPNLy0r
neaB07SZ7I7AgWCD/XOEltBrucpMThCC6BCEzOxDPOwY2AzoKNz7i0jRy9D/lVbu
QysVXgr9HA4z0vuS6Wz7dk3jiw3piga+AOOJHBXuBQJBxEQOVv7iFWnfVY5r7DgU
qLalt9YbhfR3TF7a9HH2n5CuNsksvWivRgl4TDTzXgB9xMOPamNjDoHhjH2XxVGG
6e03hv0YDKfR7K6lcWpHGKtgRAjYGYr6S4knHSTf830cftd7CRskTXjLI/9rhF4Z
C6P88MRa+eyfqHXC7/Wu0lnjdsbp4yeUOR+hMonKKHLNstJigHAZOfAyMtINaOKK
mydA0IdYGirgbR67ZTBK6s4j+NlPYEwKb+A88z/Vk6hE4pnPEZBHd6lViM8jdhEE
jnYe+HlTEGpwzj9V6Keoq5aq5nKp1u+kH6F/5qGpZ5bkfEwlvWmL5tJOAhwBIknR
Xiho2X3rCO4h19XjTPINu/OJ4aPqKS2o3c1lSUnBqC/Z/Li3fdc=
=s59r
-----END PGP SIGNATURE-----

--d8jRStldt4Nq--
