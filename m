Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B380C4332F
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Nov 2022 12:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKFMZE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Nov 2022 07:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiKFMZD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Nov 2022 07:25:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE091E018
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 04:25:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A8C4B80B68
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 12:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B97BC433D6;
        Sun,  6 Nov 2022 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667737499;
        bh=20PIyCugyH586DQQAJ2U9SqNyPEaT4BVEYTLW2Qne3w=;
        h=Date:From:To:Subject:From;
        b=NOqHfrL9lQczRnC0OzSvbJhzmC99YxogFWzTDRV5EG0egcLVTkUKyVV+zrypZsVvT
         H1hk6nN0HNjCRjoXwt0yWtiOsIOIuPzKDPGPSCyEO5jIH3LCAhdLZXJYvvjabltB3E
         egl8D7Q7VKYlr4RHR2TnqSzKimiqbkqHd85f2TmDQxnUZr7P4rLgeLQZ5HCAIQYKiS
         f42vxJV/Io14SNqm9kKJE1iuJX4e2dSesTvGwcjiVG4L8iekFf61bFDy5q6fvgqqzG
         Gh6iWS+JjSS57D+DgZOzqoM/Fc8REnhqFQPb8W6evbfl6abIZRCPzC0mcJDzGIoMlD
         ewZMYNhP3wGYg==
Date:   Sun, 06 Nov 2022 20:24:55 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.10.30 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="I853PUtbUz6G"
Content-Disposition: inline
Message-Id: <20221106122459.4B97BC433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--I853PUtbUz6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.10.30 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

7d839ccc1a13 xfs: new test on xfs with corrupted sb_inopblock

New commits:

BingJing Chang (1):
      [12f644786574] btrfs: test incremental send for orphan inodes

Darrick J. Wong (5):
      [65f937954f5e] populate: unexport the metadump description text
      [3cfd47b936e9] xfs: refactor filesystem feature detection logic
      [e33f8bfd0d70] xfs: refactor filesystem directory block size extraction logic
      [898ace3b1835] xfs: refactor filesystem realtime geometry detection logic
      [1153cd05b987] common: simplify grep pipe sed interactions

Hironori Shiina (1):
      [1ffa16c57368] xfs: test for fixing wrong root inode number in dump

Lukas Czerner (1):
      [2df0aa04659b] tests: Add missing _require_odirect from generic tests

Xiubo Li (1):
      [b38f94bbe96e] encrypt: add ceph support

Zorro Lang (1):
      [7d839ccc1a13] xfs: new test on xfs with corrupted sb_inopblock


Code Diffstat:

 common/dump             |   2 +-
 common/encrypt          |   3 +
 common/ext4             |   9 ++
 common/populate         |  32 +++----
 common/rc               |   2 +-
 common/xfs              | 110 +++++++++++++++++++++---
 src/Makefile            |   2 +-
 src/fake-dump-rootino.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/278         | 218 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/278.out     |   3 +
 tests/generic/219       |   1 +
 tests/generic/446       |   1 +
 tests/generic/459       |   1 +
 tests/generic/569       |   1 +
 tests/generic/570       |   1 +
 tests/generic/587       |   1 +
 tests/xfs/097           |   2 +-
 tests/xfs/099           |   2 +-
 tests/xfs/100           |   2 +-
 tests/xfs/101           |   2 +-
 tests/xfs/102           |   2 +-
 tests/xfs/105           |   2 +-
 tests/xfs/112           |   2 +-
 tests/xfs/113           |   2 +-
 tests/xfs/146           |   2 +-
 tests/xfs/147           |   2 +-
 tests/xfs/151           |   3 +-
 tests/xfs/271           |   2 +-
 tests/xfs/307           |   2 +-
 tests/xfs/308           |   2 +-
 tests/xfs/348           |   2 +-
 tests/xfs/530           |   3 +-
 tests/xfs/554           |  75 ++++++++++++++++
 tests/xfs/554.out       |  40 +++++++++
 tests/xfs/555           |  32 +++++++
 tests/xfs/555.out       |   6 ++
 36 files changed, 748 insertions(+), 50 deletions(-)
--
Zorro Lang
zlang@kernel.org

--I853PUtbUz6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNnp2UACgkQlNbPkfr2
tMxh3BAApQxX6rWJHuPdtE+V2YR9SSq6t+bq88iW8de6wvyBQhGh9xMU1f2ENsgD
OYYSrLuETQyAyaYtL/PFtI70pBXQU1xC7INoLTZo/pc+6s9rKVzngiZ2uq5TJFuZ
oZjM6KkVyz/2euYeUZJhvpc8PrN6x7vmuxhYwjcbva8KLZYHuUXatRX3/yS/+NFJ
ut+BAwxIKo5JtPzEjuhiimV9CCzDs3C4A3HgEKNljKvJt1BQWrOngNOYae12kbq4
6EAmIwGwarishQMD78C/+jpRS2gFOGxghIeEOHeMdzT9o6Rf1wArZTRcy8eoBVYF
9hY2epe5KdismV8Bk77eimyO3AqC82U5b6ueC0ESBpnB9kf1dc3P/H7sqe6c14sM
FclPS00oa9WExAmhb2JQNMbwJlT65qsYFUHi5MXCLrXohSPaBsFTLTQ0QNh9cbS6
sCXea4Xpsj0ghI2LIjMazsg4RSw1BLjMBR0Br36tXnYjfPAdBfDCLaONSEpuDj83
DrOREYXCiyxg9yLausLC869S2z+uekuootSD62o6cgG6GBfjcSwL6QAlpbAtRJi8
2RjKf0lIzi8Upk/bRdIKoiDGyUqcGWKKp5t4X1pvmDdpdEK41mmethxs/jsdQHFT
qwBEEGWcpccK+kWyge/Q4VxbSKTNMcEG6EyJDESPinhGp4F6w3Y=
=d1lD
-----END PGP SIGNATURE-----

--I853PUtbUz6G--
