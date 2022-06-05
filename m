Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E10C433EF
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Jun 2022 09:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbiFEJzs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Jun 2022 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiFEJzr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Jun 2022 05:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8A25C0
        for <fstests@vger.kernel.org>; Sun,  5 Jun 2022 02:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A70B80B74
        for <fstests@vger.kernel.org>; Sun,  5 Jun 2022 09:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE24C385A5;
        Sun,  5 Jun 2022 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654422944;
        bh=ogDdjwEd21cLWHq0sZpClMs9DPw7SaUYIqX5WVxi9fA=;
        h=Date:From:To:Subject:From;
        b=RCDDS9HXujVeOB1jrdNrl/KGqD8auuIdoXp3ej+KzJpNOGMJhuCJDWtB/BgM7mj3t
         c/WxMDt6Q2HXRWfKVKzI608gdCyml+MNTU33JWe7HEXTzM2Gulx70JSfpkZcU2mBDy
         ROJCZfJAx8TfHpRokgRyox9oyKOGNP71fHoHls9lu3Agi6GVi7sYLnS9fO6kg9pLox
         gLcwKf2FA1pdGJx0LZMnt4yVQeeWJfeFfBfFHKVrSDVas8ot4bQS5qRMkxzGl+kNeM
         09LOSh01ConkiffwoDV78T7jnOltxxFcmn25YRQy89fyVFHAdoBs9YDG0lWtp33msC
         ZkTiKq8lKOeRA==
Date:   Sun, 05 Jun 2022 17:55:40 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.05.29 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FjQ04r05TODI"
Content-Disposition: inline
Message-Id: <20220605095543.3BE24C385A5@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--FjQ04r05TODI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.05.29 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

d3cc66012a28 btrfs: test direct I/O read repair with interleaved corrupted sectors

New commits:

Amir Goldstein (1):
      [4fb72cffd9e3] xfs: annotate fix commits for upcoming 5.10.y backports

Christoph Hellwig (10):
      [68da7b2ab804] btrfs: add a helpers for read repair testing
      [b6daf3447d4d] btrfs/140: use common read repair helpers
      [bd9306394f2c] btrfs/141: use common read repair helpers
      [0baec6a82ada] btrfs/142: use common read repair helpers
      [9106f321f91a] btrfs/143: use common read repair helpers
      [ebb554efcbf7] btrfs/157: use _btrfs_get_first_logical
      [cd87ca221a32] btrfs/215: use _btrfs_get_first_logical
      [94b0abc48f77] btrfs: test repair with sectors corrupted in multiple mirrors
      [fa1bcba58824] btrfs: test buffered I/O read repair with interleaved corrupted sectors
      [d3cc66012a28] btrfs: test direct I/O read repair with interleaved corrupted sectors

Darrick J. Wong (1):
      [a8812199578b] xfs/545: check for fallocate support before running test

Luís Henriques (2):
      [96ca82d8e5d8] ceph/002: fix test expected output
      [e57024a30588] ceph/001: skip metrics check if no copyfrom mount option is used

Zorro Lang (2):
      [61775fb9e1ab] common: source base fs specific common file
      [7eb01db2b776] tests: remove redundant common/$FSTYP importing


Code Diffstat:

 common/btrfs        |  75 ++++++++++++++++++++++++++++++++++++
 common/config       |  60 +++++++++++++++++++++++++++++
 common/overlay      |   4 ++
 common/rc           |  49 +----------------------
 tests/btrfs/140     |  13 +------
 tests/btrfs/141     |  15 +-------
 tests/btrfs/142     |  10 ++---
 tests/btrfs/143     |  10 ++---
 tests/btrfs/157     |   2 +-
 tests/btrfs/177     |   1 -
 tests/btrfs/215     |   2 +-
 tests/btrfs/258     |   1 -
 tests/btrfs/259     |   1 -
 tests/btrfs/265     |  85 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/265.out |  75 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/266     |  93 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/266.out | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/267     |  93 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/267.out | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/001      |   6 ++-
 tests/ceph/002.out  |   2 +-
 tests/generic/623   |   3 ++
 tests/generic/631   |   2 +
 tests/generic/646   |   3 ++
 tests/generic/649   |   3 ++
 tests/xfs/145       |   3 ++
 tests/xfs/177       |   2 +
 tests/xfs/422       |   1 -
 tests/xfs/423       |   1 -
 tests/xfs/513       |   3 ++
 tests/xfs/517       |   1 -
 tests/xfs/539       |   7 +++-
 tests/xfs/542       |   3 ++
 tests/xfs/545       |   1 +
 34 files changed, 750 insertions(+), 98 deletions(-)
--
Zorro Lang
zlang@kernel.org

--FjQ04r05TODI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKcfWEACgkQlNbPkfr2
tMyAERAArWKcQOOb1hZgl7F6mhMFAnV5HOYI2HwbWEUek3844RQMZEUX6kZSC/nL
7YUFIhkxxb7xMTDFql4RAFE8u/yAU6+0ainyrvvxY53vv+oL/SInGyQOkB+g1ojW
K+YtaBU4LkjzSTt4QOHcxQzdogJI6+uYXWRu+nb0zg7NISOD5ogcSTh0FSH7wAxE
Xz/rIX0csrsMAOUNkptcWBVzTQ1G4Y60PNduUkdG9bi6RoJiYrZjaExdUkcJB2Ud
fM/ZfoJC+f26ApAwDk4yWV9QyLDXvH8tsWUUdT6WcA+RlJ2Zd2BJaNZG2wYIeZK7
FF/3Eaa7tHSfS6awbqZw3N+yXruqOVF/VDo5jqqFgSWa11tuM+a68gfuVSPJdiWm
l2ZlJFD2AWDO/n5cwBvFsyIEM5sc5PY/L8d/1dJ0Oy8lj81wLiXRpYT4M7Ba9jiI
oIq4fPmy3CwnhT2FqFCWrBfdqLOcVYK6fBMENw6nAwy29cc6OGxyBw5Z9sKX8UOd
kTmkObF4kFwDPpZOt4uqFXVstOw9u7DtUcQabo64xg+0JKwC/QDni+WlUO/Q6X0k
h6Rmr7ZhOk1G42fMeh85ldCLPHOIr8jaawwTmrs7txhxS75lMsZ4JSPDpV+cdpwB
LwYwUNCBa4ZwVpGS5bzisItzsQ4VTLWWv4XY5ShbMdWVEbZsbGI=
=OBpC
-----END PGP SIGNATURE-----

--FjQ04r05TODI--
