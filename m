Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0CC433EF
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Jul 2022 14:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiGCOWT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCOWS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Jul 2022 10:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73582DF0
        for <fstests@vger.kernel.org>; Sun,  3 Jul 2022 07:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD9D60F91
        for <fstests@vger.kernel.org>; Sun,  3 Jul 2022 14:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A651CC341C6;
        Sun,  3 Jul 2022 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656858136;
        bh=wbawilauQIIg/ZeSUGrz+7pRjLjGwbW1bHdHwR2is70=;
        h=Date:From:To:Subject:From;
        b=lzbgs7weF14y1xwDfPSTHv+Jkv2ZCefoEW378Xv6r1geiYsI1fH/1EZVc5F7Eo+6s
         GbPcJjoO/NGpXOlp5ZUz28QblOjVz+xQRbpIyJVywMX4hBvFYSVPcTFjwWwegs/rkk
         KIFC5prFt938NrNYRbs8CnPQ5o1KjM5rZiaeZXPc13UWOHmhrZ/M5jvMmbb8r+ND3n
         z1Ma6PstFU0I+ZDOeGGUbNUHOAxOdDkPmhQUzYeJZ1GyhHCi4qoqBDVFHFTscEnf2u
         quhY1t+9GuTQ+gqMbdgeDg3/cMVAWJtLBUIUaqZQx1BJhk6h1rBip0wL9RBZGsWrbP
         OTEmb29uqnyMw==
Date:   Sun, 03 Jul 2022 22:22:13 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 5834a0aab2c6
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SsFZU3TujWpP"
Content-Disposition: inline
Message-Id: <20220703142215.A651CC341C6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--SsFZU3TujWpP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.07.03 release.


This release contains some fix/improving and 6 new cases for btrfs, xfs and ceph
  -- btrfs/268, btrfs/269, btrfs/270, xfs/082, xfs/144 and ceph/005.

More details refer to below.

Thanks,
Zorro

The new head of the for-next branch is commit:

5834a0aab2c6 xfs: test xfs_copy doesn't do cached read before libxfs_mount

New commits ([N]ew, [U]pdate):

Christoph Hellwig (4):
[U]      [c4d2eeedf7f6] btrfs: fix the_btrfs_get_physical invocation in btrfs-map-logical
[N]      [9de4ecd461d7] btrfs; add a test for impossible repair cases
[N]      [504e5bcfdaf0] btrfs: test checker pattern corruption on raid10
[N]      [6cbe7d91062d] btrfs: test read repair on a corrupted compressed extent

Darrick J. Wong (6):
[U]      [e861a30255c9] seek_sanity_test: fix allocation unit detection on XFS realtime
[U]      [36f382f991ef] check: document mkfs.xfs reliance on fstests exports
[U]      [f0eb9b8d4a68] xfs/109: handle larger minimum filesystem size
[U]      [a176070de75c] xfs/166: fix golden output failures when multipage folios enabled
[N]      [10d5efecc0e0] xfs: test mkfs.xfs sizing of internal logs that
[N]      [5834a0aab2c6] xfs: test xfs_copy doesn't do cached read before libxfs_mount

Luís Henriques (1):
[N]      [56171bcb41d4] ceph/005: verify correct statfs behaviour with quotas

Theodore Ts'o (7):
[U]      [f30169ce7341] ext4/050: support indirect as well as extent mapped journals
[U]      [b60038cc226a] ext4/044: skip test if the file system does not have a journal
[U]      [1800121a017d] ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
[U]      [172b13b8e5c1] ext4/054: skip test if the dax mount option is enabled
[U]      [9ac1dd12cd05] ext4/055: skip test if dax mount option is used
[U]      [0a7a16123a67] ext4/035: skip this test if the scratch device does not support 1k block sizes
[U]      [9d14711da549] ext4: create file systems with the encrypt feature as necessary


Code Diffstat:

 check                  |  3 ++
 common/btrfs           |  2 +-
 common/rc              | 16 ++++++++++
 src/seek_sanity_test.c | 12 +++++++-
 tests/btrfs/268        | 62 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/268.out    |  7 +++++
 tests/btrfs/269        | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/269.out    | 41 ++++++++++++++++++++++++++
 tests/btrfs/270        | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/270.out    | 41 ++++++++++++++++++++++++++
 tests/ceph/005         | 39 +++++++++++++++++++++++++
 tests/ceph/005.out     |  4 +++
 tests/ext4/003         |  6 +++-
 tests/ext4/035         |  9 +++++-
 tests/ext4/044         |  1 +
 tests/ext4/045         |  2 +-
 tests/ext4/050         | 58 ++++--------------------------------
 tests/ext4/054         |  5 ++--
 tests/ext4/055         |  1 +
 tests/ext4/306         |  5 +++-
 tests/generic/260      |  3 ++
 tests/xfs/082          | 38 ++++++++++++++++++++++++
 tests/xfs/082.out      |  3 ++
 tests/xfs/109          |  2 +-
 tests/xfs/144          | 51 ++++++++++++++++++++++++++++++++
 tests/xfs/144.out      |  2 ++
 tests/xfs/166          | 19 +++++++++---
 27 files changed, 517 insertions(+), 67 deletions(-)
--
Zorro Lang
zlang@kernel.org

--SsFZU3TujWpP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLBpewACgkQlNbPkfr2
tMyTHBAAlv+q1Is7GgDbC9bQio7b1SqfUbRRqY8X8rm43aXjf5AExGe4/firejRv
cJ8bpDVv5yR4EpURKSWMUbQLvSuRHJxskfQNYKRtqfkrcmcfuINEPI3xIQkfC8q/
PFAWviXoJA5OM8/iFfWZOXwiaYd8FesJ059J42UUgFXoJpsjFrZ4u5t3JAT0v+ER
UFeiHA8YLPziCuV+Buo9met51ZFtoR5aCD6ZUWWzLp04g2Zu+lOjmpxjVT0D8WBl
o+ROylamafYOIiBU0wBOeNKWlp98Wn/zFFzAnkpRtmznyEtVBG6Xsxw4125v2Rmk
8SuaWyJD57QJZTyv/0UNqhooc3YvcGq/aKMYzNy9ZbbtN7u99anK6pFW89gFvHht
5zpaGtc/tNhn7EZ2o+/6pSYzUCXaoNfHApCbbS/GDdR8+lJIQhgqd2oB0mjZqI6P
MD2eI/wNsnNQmEayvReb6yWRS8/3vMKsQwwIA2GajN/lJuSy2Kd5Lf7JZRb8ueOx
4PDZMoO0itX/dEAYIYq7x9xQzjkcKKkKJgCx+wJdGdndnyZWcup5ZuGmiVPqn+6y
1WsIYa7FlS45mRHENkDRj52XjGt7P21ZCE1fNu5lmNCmfdgGYoeqzg6/IFlkRnUe
KEfIRJo+XZyCWQD0g4JdJAtLpwZK482cjestkG4GAmqhR79bP2c=
=1mTk
-----END PGP SIGNATURE-----

--SsFZU3TujWpP--
