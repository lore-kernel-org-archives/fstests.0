Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22261C00140
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jul 2022 14:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiGaOkd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jul 2022 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGaOkc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jul 2022 10:40:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEFD260A
        for <fstests@vger.kernel.org>; Sun, 31 Jul 2022 07:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55B28B80D60
        for <fstests@vger.kernel.org>; Sun, 31 Jul 2022 14:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750E8C433D6;
        Sun, 31 Jul 2022 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659278429;
        bh=oTvnMS0sPFgAmt4URrdBGN7X6M3OACIvaKHzFGlpz8I=;
        h=Date:From:To:Subject:From;
        b=ewVN/UyH+48GX4NztdyXo1YWtLQKdxPXjy1zi0R39V9DaKf0XjMWHIjAEr0pmGpst
         S8b/10JxIswHRtDs6ZIPFSW97ENlEO55jLVpohTt+ntE4CiYrBS4EKvkOrI7QXwsbQ
         5hMjDcfYW74Kf20tTwElo8wQerf4t0Ksi2+dIp3bMOxc8HmSOLzijzLL/XV2rbmAom
         WsQFAs9ejg2kbxxlkq0t34NhRZOhporby1TAzPcsAyhN9ouWGwARHEOPGDvmB21f5e
         OUti/z95G6zGZRG6KzmKf8ZI9NhAkTXN5qcIPshc+5GIMp5fhuTh3IuaInWgyegqif
         FxpKDgYWfVHqw==
Date:   Sun, 31 Jul 2022 22:40:25 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to b91889d79e1d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jDe5d4tWqpGW"
Content-Disposition: inline
Message-Id: <20220731144028.750E8C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--jDe5d4tWqpGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.07.31 release.

Release Notes:
1) There're 5 new cases this week -- btrfs/261, ext4/058, ext4/059, xfs/533 and
   xfs/549, where both ext4 new cases will trigger kernel BUG/crash on linux
   version < 5.19-rc3, then break fstests running, so remind that for downstream
   kernel testing.
2) This release fixes a small regression issue on nfs, which was brought in last
   week. More details refer to commit b91889d79e1d. So I'd like *not* to update
   master branch (to v2022.07.24) this week, to avoid this regression (and other
   secondary cause:). If everything goes well next week, I'll update it as usual.

More details see below.

Thanks,
Zorro

The new head of the for-next branch is commit:

b91889d79e1d seek_sanity_test: use XFS ioctls to determine file allocation unit size

New commits:

Darrick J. Wong (3):
[U]      [50f6d4641036] dmlogwrites: skip generic tests when external logdev in use
[U]      [91f2a0f472e6] common/rc: wait for udev before creating dm targets
[U]      [b91889d79e1d] seek_sanity_test: use XFS ioctls to determine file allocation unit size

Naohiro Aota (1):
[U]      [2925f3b7f773] btrfs/253: skip on zoned mode as we cannot change the chunk size

Qu Wenruo (1):
[N]      [9347bb488cde] btrfs: add test case to make sure btrfs can handle one corrupted device

Sun Ke (2):
[N]      [88ac8622fae1] ext4: set 256 blocks in a block group then apply io pressure
[N]      [affcc6dd6735] ext4: resize an ext4 which resize_inode feature is disabled but has reserved GDT blocks.

Yang Xu (4):
[U]      [196721f3b730] xfs/270: Fix syntax error
[N]      [b994a3bc4395] xfs: test xfs_db whether still can get corrupted field value
[N]      [b7962b76ec24] xfs: test mkfs.xfs whether terminate getsubopt arrays properly
[U]      [8a74eaaebe2a] xfs/191: Add missing xfsprogs commit


Code Diffstat:

 common/rc              | 13 ++++++++
 src/seek_sanity_test.c | 36 +++++++++++++++------
 tests/btrfs/253        |  2 ++
 tests/btrfs/261        | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out    |  2 ++
 tests/ext4/058         | 33 +++++++++++++++++++
 tests/ext4/058.out     |  2 ++
 tests/ext4/059         | 41 ++++++++++++++++++++++++
 tests/ext4/059.out     |  2 ++
 tests/generic/455      |  1 +
 tests/generic/457      |  1 +
 tests/generic/470      |  1 +
 tests/generic/482      |  1 +
 tests/xfs/191          |  7 ++--
 tests/xfs/270          |  6 ++--
 tests/xfs/533          | 34 ++++++++++++++++++++
 tests/xfs/533.out      |  5 +++
 tests/xfs/549          | 29 +++++++++++++++++
 tests/xfs/549.out      |  2 ++
 19 files changed, 292 insertions(+), 13 deletions(-)
--
Zorro Lang
zlang@kernel.org

--jDe5d4tWqpGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLmlCYACgkQlNbPkfr2
tMzzfg/+MVwHwiiFJToPD09Cl9p+VEQg/GNVNrefhULhxtTY5+0Dg+UaWMJP/R5o
0l1aXWW3UQcIUi0yGpAbyhIFOJwtM5LtMQDUtIpx8bvK6/emuZzOgMEODbZkU7vY
DRG29hlu9zf988nV8VJoZe+Zy9d+jeRX/Yzl/s+8u8nQ/4F9tjMIjOYSHb5FbB9B
XSCZb5cODQ/7NmDBCB0IrBl1Be9eM6uGUIQkiprao/x7qrAeFPlqabSSfmDB4DBZ
Iav3IYbY/aClgEKd4EnupV6J30FwQFOC5wCFrfpFRYB3J9m0+YoB1oQF9314942Q
2pGLme0KtMku32xmiL6o+2Lvtu6dGaTBLbf+zRtrjxIES6vmXHJNRUCV/jcQj1Cm
nbh44zAHQq73hDBPuLz34f1uvJ0omkdSFRMNm8V8N6dNeoRuMgOrqhxWUuUX0sFP
y2B5FfA34G9v9w31AUwGR0oh1c9z8Ec2Qq8Wd3kpBZmJNjWa7esWgHCnIhiccm4K
PO4SFYphwdk7VHGMKD7jTzmnNsXieiDJPBaC/Sq8k8Ju0oAkzFjw7CTzsmM9fs+n
KbHhgq9MTKtxzPT4gfoCuA+DYfWpD6NRmZW2T1RXqTo+VFYg7gGMi2gNQT4gcEsE
tCqBFJyEU3Q+yW2rE8+Gpzh9HACIIlBMNB8B5ka+Rm/MwFKxkds=
=iXne
-----END PGP SIGNATURE-----

--jDe5d4tWqpGW--
