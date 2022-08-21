Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0379DC00140
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Aug 2022 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiHUPXZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiHUPXX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Aug 2022 11:23:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8B114F
        for <fstests@vger.kernel.org>; Sun, 21 Aug 2022 08:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F89CB80923
        for <fstests@vger.kernel.org>; Sun, 21 Aug 2022 15:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BABBC433D6;
        Sun, 21 Aug 2022 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661095399;
        bh=tLo9VCQZ/U9rfw6DLay/A8+0U1RH1Vu/EoZuyUCBYdo=;
        h=Date:From:To:Subject:From;
        b=QZJGmiV0a66ESnzPfdOca7rcZjwfsLfC763LLTVIJlFhisX0UdxnIdPOlZa/kWE4v
         ICJY5imv6wO1NrNhF7l5Zj7GdHM4nbW764RgPlLJ24U50czgPcLkeqtNVtAU7yn/bv
         jEz3ukbmP5tOJyly5u0GW8Ov8cfDlLwVlCnNuh7oow245SNb+NjPUo4fI+huz3+d+m
         70y7p1TthWnbcrZf1pvcvqD8kklCxX2KLHf4O4g9x95Z5fHnFL5dQpOvshGTTfHU6K
         hoGDvsa0BhurNqcoFzkOxhk2l7sRbsQCxJJlYx9HsUh+fyLXddAf3WFPSU2oLYGcnY
         MIfELt4LYrEBA==
Date:   Sun, 21 Aug 2022 23:23:15 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to bf1ef26900ee
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oM5WfWmbbI5V"
Content-Disposition: inline
Message-Id: <20220821152318.9BABBC433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--oM5WfWmbbI5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.08.21 release.

Release note:
1. There're two new cases this release, btrfs/277 for a btrfs new feature,
   generic/694 for a known issue of exfat fs. So both of them generally
   won't break downstream linux testing.

2. A big change from Darrick on dmerror improve, help it support external log
   and rt device, and help ext4 part support external logdev better, and move
   ext4 specific helper into common/ext4 file (which is just created in this
   release). Thanks Darrick, and inform ext4 folks.

Thanks for all your contribution, and more details see below.

Thanks,
Zorro

The new head of the for-next branch is commit:

bf1ef26900ee src/t_ofd_locks.c: Reset errno to zero

New commits ([N]ew, [U]pdate:

Boris Burkov (1):
[N]      [192f5297b54f] fstests: add btrfs fs-verity send/recv test

Darrick J. Wong (7):
[U]      [04307f499d13] xfs/{015,042,076}: fix mkfs failures with nrext64=1
[U]      [67afd5c74246] common/rc: move ext4-specific helpers into a separate common/ext4 file
[U]      [e88c0d38eeda] common/rc: move XFS-specific parts of _scratch_options into common/xfs
[U]      [92caf7ebe14d] common/ext4: provide custom ext4 scratch fs options
[U]      [acf0424671ff] dmerror: support external log and realtime devices
[U]      [49272aacac85] common: refactor fail_make_request boilerplate
[U]      [6049ccca12ab] fail_make_request: teach helpers about external devices

Pavel Reichl (1):
[N]      [87d9aea81007] generic: test i_blocks for large files

Wang Yugui (1):
[U]      [c9734480a1dd] fstests: add missing _require_scratch

Yang Xu (1):
[U]      [bf1ef26900ee] src/t_ofd_locks.c: Reset errno to zero


Code Diffstat:

 common/config            |   4 +
 common/dmerror           | 163 +++++++++++++++++++++++++++++++++++++--
 common/ext4              | 193 +++++++++++++++++++++++++++++++++++++++++++++++
 common/fail_make_request |  63 ++++++++++++++++
 common/rc                | 193 ++++-------------------------------------------
 common/xfs               |  23 ++++++
 src/t_ofd_locks.c        |   2 +
 tests/btrfs/088          |  14 ++--
 tests/btrfs/150          |  13 ++--
 tests/btrfs/202          |   1 +
 tests/btrfs/215          |   1 +
 tests/btrfs/268          |   1 +
 tests/btrfs/269          |   1 +
 tests/btrfs/270          |   1 +
 tests/btrfs/277          | 115 ++++++++++++++++++++++++++++
 tests/btrfs/277.out      |  59 +++++++++++++++
 tests/generic/019        |  40 ++--------
 tests/generic/441        |   2 +-
 tests/generic/487        |   2 +-
 tests/generic/694        |  47 ++++++++++++
 tests/generic/694.out    |   2 +
 tests/xfs/015            |   4 +-
 tests/xfs/042            |  14 ++--
 tests/xfs/042.out        |   4 +-
 tests/xfs/076            |   2 +-
 25 files changed, 711 insertions(+), 253 deletions(-)
--
Zorro Lang
zlang@kernel.org

--oM5WfWmbbI5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmMCTb8ACgkQlNbPkfr2
tMxdeQ/+JbX3x59+Jn8EsUHj8BFvDP3YvIfEM2ERo8Yq59DJANAqoGZY5Rhmdxat
709Cz/oGe7pm2+r/2iPyTcNyh7lYvOLMpIAscWr/MzdlCsGthWEsgYSdht9plTNr
yW7LNVI6H7Gkppu84vgE1OUoPhUu1YSCq5IweQEdthJW5AWG0GLeRnXvEtRZD2/M
Z1zU0DiUuiZJwog3XEbjGVP6ZcFTqb8bD34zrZkZTdnbkXomf9J0maw0rSLDsCxi
xlgHZoTJjTVxVVd8Kv5hVB7hnjGvjZXGcNIc4OHEdYsZvVYuS+dwsMm4nZ/yhBAF
kb/N6MXreOYvZQz/phuTlXu8xIO3tnOvLqU9lf75+gVSc30BrzVMkjeoOp1436GZ
iIiFo0iqsUd6E1sC4GkGkelNI4vSTKRVkpQeiBuuEKzK+LaabdvU3b/7IFM8Oi/t
lSNAxdmcbHk8REsWeB6tBkDlkQ0oub8dpmH5RslGEpOKGgqYy9PjRd4Hz/AWao92
PGU7aO5AxJrgeFMRHc0xTMWoLm/c4gxtZhHawEeNTgs6EPuQlgNSuoQaYJjSvboG
vK6C6XwvPF24uan/5K50Di3GhgD5X9nei2/MfMyuKVYGNbxUYbI0TLAz+7eLjGju
gKqUJzk1gCx1o9DgYMY0mCKSKm2qiWujw2dkttyx9yb3NYhmDyE=
=HBqK
-----END PGP SIGNATURE-----

--oM5WfWmbbI5V--
