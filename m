Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E5EC4332F
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Oct 2022 12:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJIMiY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Oct 2022 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJIMiX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Oct 2022 08:38:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878EE2AE34
        for <fstests@vger.kernel.org>; Sun,  9 Oct 2022 05:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E5AAACE0AE6
        for <fstests@vger.kernel.org>; Sun,  9 Oct 2022 12:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EB2C433D6;
        Sun,  9 Oct 2022 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665319099;
        bh=ELOnEhshKTCC6fpMEy6zzS9MmKPkxAxgiApaQspwufk=;
        h=Date:From:To:Subject:From;
        b=prljI80CToP9QsG4wOruJkfQleJ0uhTJpAK1dIJm4QWeeGN92FDFh/Ep9vkUwPVlq
         gmk7092BLnRsYW2l2W0zyu1ybiMNPzZBcVwI3WELoiLMSdC7BK1ElCeXqirrhaYoTf
         7ZyBjbhIaCBmBz/CIV/gqWdMJ6vAqi551US2lPW8gGesp9B7h3wmGhJ1A8ZzU3EW0Y
         90js7R6I+ENZE3oo7T29m/6Qqyychnw1NpmUfnQrsU2yIOgMOYFoAwq7XFTRNN4l4E
         Zof421AkQ7TQWEXUSfLYmbN+4DVHleXxkQP69lmoc0avc9l4oCwU1kb5EujqJkrpD5
         9m0iGzObvKV3g==
Date:   Sun, 09 Oct 2022 20:38:15 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 3b5cb74c0331
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="leCHI6aKLKgL"
Content-Disposition: inline
Message-Id: <20221009123818.C1EB2C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--leCHI6aKLKgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.10.09 release.

Release notes:
1) There're 2 new btrfs specific cases -- btrfs/273 and btrfs/276. The former is
   a known regression test, the later is a new testing coverage but don't have
   known bug/fix for it.
2) A new common file (common/zoned) is added in fstests, welcome more zoned block
   device related testing add helpers into this file.

Thanks for all your contribution! More details refor to below.

Thanks,
Zorro

The new head of the for-next branch is commit:

3b5cb74c0331 common/populate: fix _xfs_metadump usage in _scratch_populate_cached

New commits ([N]ew file/test, [U]pdate):

Darrick J. Wong (6):
[U]      [41914271ff11] generic/092: skip test if file allocation unit isn't aligned
[U]      [7bac64cc78dd] xfs/114: fix missing reflink requires
[U]      [62d628f7bb71] xfs/229: do not _xfs_force_bdev on TEST_DIR
[U]      [a2d5043aca59] xfs/128: try to force file allocation behavior
[U]      [796546224dee] common/populate: don't metadump xfs filesystems twice
[U]      [3b5cb74c0331] common/populate: fix _xfs_metadump usage in _scratch_populate_cached

Filipe Manana (1):
[N]      [8088eb0a46cc] btrfs: test fiemap on large file with extents shared through a snapshot

Naohiro Aota (2):
[N]      [18b44df21afc] common: introduce zone_capacity() to return a zone capacity
[N]      [dcf2ada66e2d] btrfs: test active zone tracking

Pavel Reichl (2):
[U]      [ce018e24f0a5] cleanup: remove left files after test finishes
[U]      [b57788fbe2cd] generic/299: skip test early if falloc is not supported


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

--leCHI6aKLKgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNCwIwACgkQlNbPkfr2
tMwm1w//aWgeySxH+FnRMw3nGDM6PzpN9WQNmwJ4txa0DIUFKcffESjCoDwjDvEr
FidWInyfJ2oJLAYrkKLKPzoXE0kCV69rGByy6XXiFbLmMyQthM8v/L//mYsMPF63
ncISRuChses1OrAiL07wvZ7A8zsOKPKLwVo3gEftEMEdUnWyUymvF9PafZwX63DW
EencqnxRId9Flg22uipIqtuKDj9bSMtiHT3Ba0d6+2J0eo+44x5nW/7cjIZ1/ZMO
y7y7K8i7AQxAqfigUAn3ZunJbYxIFymrmgQa70C3CJ6x+R/GmDSJFnzGoVcA2Fd8
4hjOsblPckLvr0DmoZg7YHfPnLbRbpAUjsYbEbtr7LgCdYNDBf3XTFc1MqX67/ZT
cJPCQ4/wcWe2nAblJYCloCSTUrISZNBgOYtV0kaDHt/fxPWjmDvdptx7L+uzItqj
U+MqtRdF3MlIz3IQb+BaF3kV0o4zFFcnK6iJfG6Fq8a+nc1WNcOkxjtd+uThRVYy
6v0HEbQu8Sx7ZdvZbcvuEqm36e4gwSJ1qbIgVXLN0por9PGp0FNAQ8uGTbFMO69F
7lJRJp42lsz3AGtFJfw3DDTqGOmwnG38VEnBR5RZgNZOIc2SsGI0sdGHWhLdptAs
75CPoQzu9Za8zJXKAIL58yD1SD+k/70UpuQC2T0NK2vh9jDCH5o=
=cbz+
-----END PGP SIGNATURE-----

--leCHI6aKLKgL--
