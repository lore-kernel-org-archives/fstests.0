Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A3C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jun 2022 10:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiFLKGa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Jun 2022 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFLKG3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Jun 2022 06:06:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0B5046F
        for <fstests@vger.kernel.org>; Sun, 12 Jun 2022 03:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00876B8077B
        for <fstests@vger.kernel.org>; Sun, 12 Jun 2022 10:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7D3C34115;
        Sun, 12 Jun 2022 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655028385;
        bh=UobiYFzMfHtC6wo5gbEnPU6rBdL9fvsF+sX4VuXYKqs=;
        h=Date:From:To:Subject:From;
        b=qDO0+gtlmZVVdAPwJQiP2CCt5m4u59OX4arpKq4UHIqyg/00oya4lkqyIPeAmnFM7
         FC0gOKQFw17BKC2qIok+4DzSYrfYMdiHt6PZotyg33NlPyRxecV8+xis2UFwB5Frma
         sYdtkd1YXgKvd9FZueptTiHQGln0jcu0rrOR9RQZpSfL5oIf4rH5hgIAn/V89FZmDF
         tq9hkgaHbEa9BX1ZVhQIXHZuPJelnpUbOw+g9rAiJ+3dbx+UJ+MfS/SIpCUcpxyYwM
         5n1BR8UBJosaTXGIMgW6Y6nJ9Tp31qfuKxppjqWNqIdyo8HzrsmJvEHIaIHoXZV+6c
         cKMHU+HzElEFQ==
Date:   Sun, 12 Jun 2022 18:06:17 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.06.05 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DFcp2XjZXEQR"
Content-Disposition: inline
Message-Id: <20220612100625.1E7D3C34115@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--DFcp2XjZXEQR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.06.05 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

568ac9fffeb6 xfs/189: systemd monitoring of /etc/fstab sucks

New commits:

Allison Henderson (1):
      [b475a5a251b4] fstests: Add Log Attribute Replay test

Chao Yu (1):
      [d9d729cf021a] generic: adjust strict SPO recovery testcases for f2fs

Dave Chinner (7):
      [41ff2ea0434c] README: document _begin_fstests better
      [e35f87e97507] generic/081: don't run on DAX capable devices
      [e75ea385432e] generic/038: kill background threads on interrupt
      [2066988abf20] xfs/538: fix fsstress scaling
      [4c76d0ba2b48] xfs/070: filter the bad sb magic number error
      [01dc3329bcc0] xfs/167: adjust runtime with TIME_FACTOR
      [568ac9fffeb6] xfs/189: systemd monitoring of /etc/fstab sucks

Eric Biggers (1):
      [03a72544ad16] ext4/053: update the test_dummy_encryption tests

Liu Yiding (1):
      [bc0373ef244e] common/rc: Fix _require_batched_discard to skip test correctly

Zorro Lang (4):
      [10d2fe7908a3] generic/139: require 512 bytes to be the minimum dio size
      [78af5961e41e] generic/506: call _require_quota before _qmount
      [568648f14515] generic/591: remove redundant output from golden image
      [627e079a5fb8] generic/591: use proper sector size


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

--DFcp2XjZXEQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKludEACgkQlNbPkfr2
tMwwxRAAzaQ6wOY1STKm2Qh3aX4eq+7agdUlmY2jfpn9NvrwqfUn1YohP/tF/Kc6
5zpbqDoYi48KG8TQko8dmIuyMX07bqTAXip3AMwqqJTCAqazRGP/6QLMo+DztuYq
Uons7owTfdEVeDQO30GzSc1Wm4TRTooULfRxe4YP7bzMLwPKx/YsA6dD5HWp/NHQ
QrCj2+8qbrB5M1ZdpSa7i3j2DEmyuTdXRR1FaWvc7zpCgL6sWiAsiXAv+Z6mHq0n
Ne9uRvwcyoBhshnzgmVtN0+gADwEcAy48gsXaDXZAH+mzN3NzTFU2FFkqvyRfSxU
i+JfGwR7Oil5P3PAvJQEyn5SVEnOu7GbWY7F910fk2cUdzEqEa4NtK2jjtDeHKsb
E82SWhmoxKD//EH2NUk0Afx4aisk1xHAAOw2VCcdMt2Bb7kFuxErWM6VhLMN8fOH
jitdTwneBeYccCac79pLPKRxIX4dD4Yyb0Ut8Z3XsSW0uwxG9k+rV4IBBWwQoH9C
QNORX6DemxuSuJWrUIqG+wQXR84QgzYDxeSqTZ2mqpFNhHZ5iDcyHgH67aUvCwv7
+Aao/lNbyjH6Y0F/4EpI+Jp9IRvwlRIX9vBVysObqWZLxKD0+Q3Krx0qru2ulQgX
2yxlFDX0MNZfh+q0Y0tB5xRWsY2Q7Hgpzm3qwdpXuD4SGkwlals=
=4lCw
-----END PGP SIGNATURE-----

--DFcp2XjZXEQR--
