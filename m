Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78118C43334
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jun 2022 10:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiFLKsz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Jun 2022 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiFLKsy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Jun 2022 06:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFD1C13F
        for <fstests@vger.kernel.org>; Sun, 12 Jun 2022 03:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C0C60B0D
        for <fstests@vger.kernel.org>; Sun, 12 Jun 2022 10:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35B7C34115;
        Sun, 12 Jun 2022 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655030932;
        bh=CCJY0nVNy6wwBHEqcQnnlUMospSLdfj1EzuwmMjepTE=;
        h=Date:From:To:Subject:From;
        b=qJTnRXSIAFzavmle5btxDRya28prA0F2AVJAaeU3U58ygDguJXnIULS2MHkZEebST
         OY3KqQR+Dt1ybMFht2fsGcJmlJihOYfO/4Y70w9QnImK2AjxSqLdlTRmM7bhMDhmcE
         jKO2riLc41N0lRakH5GspDF80/tdeXUC6IcogpaDJ4VV9pcm3C7kG75Z5FGM1xpK9P
         /lwgmCsVMQ9aMg/PGTgSJ/S8Pn5whB3GVYjech0s07TggdRb2ED2R/CL3BEmFYrpes
         pfrVMZ41yya662u9I7tXOUyxXaoOXNuBoAEU6Ix17iLDuRgKynD1qL2pbcss8nKBIF
         qDbNGF42fhIVQ==
Date:   Sun, 12 Jun 2022 18:48:44 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 0882b0913eae
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WkscD3Jz6Lp0"
Content-Disposition: inline
Message-Id: <20220612104851.A35B7C34115@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--WkscD3Jz6Lp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.06.12 release.

This week we don't have many changes, but have 3 new test cases as xfs/081,
xfs/547 and xfs/548. The xfs/081 covers an old bug fix on linux v5.16, so
it won't break new kernel, but might cause testing hang on kernel without
this fix. The x/547 and x/548 cover a new xfs feature on later kernel 5.19
or 5.20, so they won't break your current test.

Thanks,
Zorro

The new head of the for-next branch is commit:

0882b0913eae xfs: Verify correctness of upgrading an fs to support large extent counters

New commits ([N]ew, [U]pdate):

Chandan Babu R (4):
[U]      [5bb78c56ef59] xfs/270: Fix ro mount failure when nrext64 option is enabled
[U]      [63b956a156ea] common/xfs: Add helper to check if nrext64 option is supported
[N]      [9b448f06fe21] xfs: Verify that the correct inode extent counters are updated with/without nrext64
[N]      [0882b0913eae] xfs: Verify correctness of upgrading an fs to support large extent counters

Naohiro Aota (1):
[U]      [3493b8dc8b3d] btrfs/220: zoned: skip nodatacow mount option for zoned btrfs

Zorro Lang (2):
[U]      [085faee2742c] xfs: corrupted xattr should not block removexattr
[N]      [e937e23d2021] common/filter: filter out extra mount error output


Code Diffstat:

 common/filter     |  13 ++++++-
 common/xfs        |  12 ++++++
 tests/btrfs/220   |  18 +++++----
 tests/xfs/081     |  80 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/081.out |   2 +
 tests/xfs/154     |   2 +-
 tests/xfs/154.out |   2 +-
 tests/xfs/158     |   2 +-
 tests/xfs/158.out |   2 +-
 tests/xfs/270     |  26 ++++++++++++-
 tests/xfs/270.out |   1 -
 tests/xfs/547     |  92 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/547.out |  13 +++++++
 tests/xfs/548     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/548.out |  12 ++++++
 15 files changed, 372 insertions(+), 17 deletions(-)
--
Zorro Lang
zlang@kernel.org

--WkscD3Jz6Lp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKlxIIACgkQlNbPkfr2
tMzMTBAAsJlkkPlrveR/1LPro660xUu/nEfvONTZojqKRJtPRyT98ngCA0zq17Am
GyANnGGQXmeh+Bci3IXUqSITWqMNS8oBiLkBJdbybLFbBe3da/aul1LHtsMKlLfC
XhEX1hEtGtKPqbqadZauOC0AtVOxos/U674DXH1h9db1YTT25AM/GSZGKDfIVZv/
LqJxSy+b7+cQq+wOHCC+cmE1qI7M8d/zoCWOALKxDFR1kRRQjwLn76giIsJ2VyYq
3sJ/+LuBP45hnO6Ewb/6uzXP9OdJRJ1Ss9Yaw9b39/0xcbdh6qlzTmnhcgJ2o9NA
R6LYlkAMQnnwBck3BNhNRUTSRgIQKMI653o3GWR7R9Gh4jLLx9jTL4A8MVAterWo
B1sJ7Gn3DA0vp8qu7BLjbPJgrXXnZXH1BBisxs4wOjrrFAdnhRvW0zNUCl0PgBOi
4JZzj2itufIav4qCfidVyP7N2Xh3ui6b9OkPG0zCG+rBjC+oAhD3h19904G9xY3H
Jy1m/H3ksb9ush2j8uv5PIq3/W0Sr1eUsaGpygK+RfYjQh2QMsZ0oXlQMrFwy2Bz
0hrNBHQh+yjBALWxnl0f94sn4J3a6zPxm2c1Cr34uV4NeaGk+vkcf6fKQyXIUO9H
qEIMXWdstZyidwjkh7/v13fwN3602cYjtkJ+LdhVVrXjIhu2izg=
=HIPG
-----END PGP SIGNATURE-----

--WkscD3Jz6Lp0--
