Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C458C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Oct 2022 12:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJPMGA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 Oct 2022 08:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJPMF7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2022 08:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8796A30565
        for <fstests@vger.kernel.org>; Sun, 16 Oct 2022 05:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45CE9B80B66
        for <fstests@vger.kernel.org>; Sun, 16 Oct 2022 12:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4AFC433C1;
        Sun, 16 Oct 2022 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665921955;
        bh=q+0vaSeXIwRgvp8hSQea0gSSA5dsVQ+ozPgsr2ZURn0=;
        h=Date:From:To:Subject:From;
        b=bDja5irfJlI/PADwnxc9Z6AatZ9NQVUmKmQu525jRW7KPPxvM1B3gsoZplphRlKHw
         uKRTvOmiQYVSI9aITYUclldJomhB4HDm1Y1L8OY55x8D8ZgEUvt8rmfpLix87LjSDP
         u5eOZZDHcY/JTZeGSIwLuAaNhktGyppjBzXoLMWo/sGWSC+sbTqljxe2qC+jLBCfyR
         62B1NBJF7AjgCn21uftWgLxHq6EgU3FKfJ1hOy3ZwJ7cepguxk+7BmcBCRcx9PTh39
         PNwrShrtiex0h7gHURYjyZWMkfN4UrTHhd2Rw9+N6iBZGxOyVj+gAg1MdtmTmXIfn0
         XgyTEHZtHRwkg==
Date:   Sun, 16 Oct 2022 20:05:52 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.10.09 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="N6IaWuslQ7X2"
Content-Disposition: inline
Message-Id: <20221016120554.9E4AFC433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--N6IaWuslQ7X2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.10.09 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

3b5cb74c0331 common/populate: fix _xfs_metadump usage in _scratch_populate_cached

New commits:

Darrick J. Wong (6):
      [41914271ff11] generic/092: skip test if file allocation unit isn't aligned
      [7bac64cc78dd] xfs/114: fix missing reflink requires
      [62d628f7bb71] xfs/229: do not _xfs_force_bdev on TEST_DIR
      [a2d5043aca59] xfs/128: try to force file allocation behavior
      [796546224dee] common/populate: don't metadump xfs filesystems twice
      [3b5cb74c0331] common/populate: fix _xfs_metadump usage in _scratch_populate_cached

Filipe Manana (1):
      [8088eb0a46cc] btrfs: test fiemap on large file with extents shared through a snapshot

Naohiro Aota (2):
      [18b44df21afc] common: introduce zone_capacity() to return a zone capacity
      [dcf2ada66e2d] btrfs: test active zone tracking

Pavel Reichl (2):
      [ce018e24f0a5] cleanup: remove left files after test finishes
      [b57788fbe2cd] generic/299: skip test early if falloc is not supported


Code Diffstat:

 common/filter       |  13 -----
 common/populate     |   3 +-
 common/rc           |   1 +
 common/xfs          |   3 ++
 common/zoned        |  39 ++++++++++++++
 tests/btrfs/237     |   8 +--
 tests/btrfs/273     | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/273.out |   2 +
 tests/btrfs/276     | 124 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/276.out |  16 ++++++
 tests/generic/092   |   6 +++
 tests/generic/285   |   2 +-
 tests/generic/299   |   2 +-
 tests/generic/394   |   2 +-
 tests/generic/436   |   2 +-
 tests/generic/445   |   2 +-
 tests/generic/448   |   2 +-
 tests/xfs/114       |   2 +
 tests/xfs/128       |  34 +++++++++++--
 tests/xfs/229       |   7 ++-
 20 files changed, 381 insertions(+), 32 deletions(-)
--
Zorro Lang
zlang@kernel.org

--N6IaWuslQ7X2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNL82oACgkQlNbPkfr2
tMwjsA/8CzMq2d9T6jnm2fPDVZutDABQvcMiKQ2ZvNbHXyfsx9x2CQzqTy+7qy3f
SHAIj+vKtRkyL0pAKjfWmSyREmNzZ5vP6/bqxSmTrX2psMdIRGbq0OJkaJkSm8Ox
INJ+XpbX6jcAfuX1klXEWkPKxiK8vywY3yIqQe0bykhiI7QelLs7jPvsigjDj7X9
xoCM5WNvQhEM8fsp75fv7Forv5BGWEmlVaPkdLhW+/dF4NWEbhY8RTstwoC3hp9Z
BlgLttQb27Wdx0t2EjzxSH17nd7/w2p+E84V7cZOcADD8IeSrAPKtxLkcCJzgCW2
uH8hzXycpQPt71zQFKSUj2G3iTbEXZ90en9/CZ63HMfrKoK4iFNdLo5uqSQTvOIX
zgS0B+1op1UF2ybNTSNEr6tnd3tmlVOCp3ozTkBPdD8ezJ8nnZJi59A5kfxuv56i
oTrt77agMwCKQc9N/XVIEQrYijf7migKhJA9EdioBzlEOlsVwHhs9685lb2KBc+5
w+sachvvy9Mr6z1vbaTICqdosu6HHoiK/AwD9lLHgUZPaDDUgXzIJR/cR5oDlSRK
NfJY9KNxs8uv8WG+JKFvIJkcLXFTNZ6L5JNzZtGvt227R3A0mvSMoTY5PXTC3lZ4
uQXJzRx19lSufbtpYnISd1vcGBMMc97lLR7a9V886ab5iUY72i0=
=0FuJ
-----END PGP SIGNATURE-----

--N6IaWuslQ7X2--
