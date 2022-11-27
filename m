Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6467AC4321E
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Nov 2022 13:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiK0NP7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Nov 2022 08:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiK0NP6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Nov 2022 08:15:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CAEEE16
        for <fstests@vger.kernel.org>; Sun, 27 Nov 2022 05:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D169160DC4
        for <fstests@vger.kernel.org>; Sun, 27 Nov 2022 13:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FC8C433C1;
        Sun, 27 Nov 2022 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669554956;
        bh=QLmsOF2OcjQg8HMQCQDfFDtFzGit/dBrOxAKiMdbDis=;
        h=Date:From:To:Subject:From;
        b=klML3KnoG1qEIlxgd4gJKcuAZ8vnD5D5k21WAD91Fa8t5aXH6b71dSm+GaQu0FJGx
         0OoA+g+pZ/ZISjVmpzR1OZsQASHgRfZz0B8+1Bqssb4pdDnIe50PXqJuyWYv1TYP1S
         Y8Q7HHqAcol6S0o8mH9beUZe58bWl9OA9adoTcz+NpBiNAZDwtq2jCP20LSgVyZmwH
         Tj24spLe2xOSUFLfVjqE61O4Hywpm2JXs2OrE26Xd4SCa56SEKuASmjcsyMqZ+9/XE
         yg17EvMgY0RQ3ZsutLaWRt4Oak8d+F8jMURcaFHvGGPSEtWG5w2VduwwSMzZ9SENt2
         Jcb9HBiKemgUQ==
Date:   Sun, 27 Nov 2022 21:15:53 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.11.06 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Xf8DSUW8xnn4"
Content-Disposition: inline
Message-Id: <20221127131555.C3FC8C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--Xf8DSUW8xnn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.11.06 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

41f2bbdec5fa generic: add missing $FSX_AVOID to fsx invocations

New commits:

Darrick J. Wong (1):
      [1b3f0e1b6c9e] xfs: test xfs_scrub phase 6 media error reporting

Eric Biggers (3):
      [7f7f3261a3cc] common/verity: fix _fsv_have_hash_algorithm() with required signatures
      [b0442d18aa88] generic/577: add missing file removal before empty file test
      [6994e033aba2] tests: fix some tests for systems with fs.verity.require_signatures=1

Eric Whitney (1):
      [41f2bbdec5fa] generic: add missing $FSX_AVOID to fsx invocations

Filipe Manana (3):
      [2450821c9b15] common/punch: fix flags printing for filter _filter_fiemap_flags
      [cea2bae85f1d] btrfs: test that fiemap reports extent as not shared after deleting file
      [cb404cfcae51] btrfs: test fiemap reports extent as not shared after COWing it in snapshot

Xiao Yang (1):
      [1dd7395623cb] common/config: Make test and scratch devices use the same mount options

Yang Xu (1):
      [1d4080ce7a6b] fstests: Add more related cases to perms group


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

--Xf8DSUW8xnn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmODYtUACgkQlNbPkfr2
tMxRixAAq/+qyVRFle4XTDak2JGZVU1OUb+0da9jlot3I8dGVJRT9p8BFO3WM4SF
JFVBf9SYQnG4jq3NhnAjkJGoARJ1LJfT/Rbk4I+S7O8yF3k4OcWVixqjJQBzYeYA
xBt0illh3GFUU8GhO8lO8jnLl8QuoB3MQYEss6kZOaZsiHI6iDF0k+2n2EJyWpHA
NkouWJAQ1p0cQp6pAVjNgZa3bQLEBg2eVRMNWDsf5+eaWMXUNIcNZsZZ/jMyjino
gRBsVaxBbxcJQR1u6qaBPp2npK1/ssnwXEOFaqhZGvtrtqhDvswpFyKijtlCwnFj
UR+CXUHbgetCU5XDy/nNyAlVMCzWKc9EwtY/AUMycA6/kdUC+sqZ8Gw2DbMMhalk
wiF3CfEpobhYMyJwlqo3j3DS2/mt/ehsuFxH3yJOgordGWq0SQr1uyqTjTlPAQ01
4DoVCXf6OrvJsAzecaEs9+RGAMI4QwYwYjBzWW+j15S9fskjc15/2S22pxCcFI0u
bjxVUEV+VOPfANvv7x5U3qc0f9hLxkD/B8yATDp5pdik17CGqH5da4gI34zXgxuY
RuLNziQSVdaSbCPsWEXg8mFFpJIHwk9lYZLIZtu152f0g+xXSOffvxmEGB9RmiO5
YMfkCXDEohvrT2sYJWkoYAPHyDMbaN1qtkgOEbzX3AtwMOvEH44=
=v2ub
-----END PGP SIGNATURE-----

--Xf8DSUW8xnn4--
