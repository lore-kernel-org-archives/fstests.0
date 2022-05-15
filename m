Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18BBC433FE
	for <linux-fstests@archiver.kernel.org>; Sun, 15 May 2022 05:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiEOFnW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 May 2022 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiEOFnW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 May 2022 01:43:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A28369FE
        for <fstests@vger.kernel.org>; Sat, 14 May 2022 22:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 881A5B8068E
        for <fstests@vger.kernel.org>; Sun, 15 May 2022 05:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66CCC385B8;
        Sun, 15 May 2022 05:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652593398;
        bh=YFfPZbhf7FSIa5knw31LGLBIZycuE7hSKn9JJdeXFY0=;
        h=Date:From:To:Subject:From;
        b=fWNZcu2mwkpgxtGYUF2Y82oNX9xW1TMmohW7kkO9luQswWAsz8MboWs/cEHZ8Df8g
         6HE2UOtoVXzo2PXOwgupBMbYPrE0bYHv86Q+vOAJrE7eqoYt2lL/KgDODE6VsFWv8O
         6/hudSrUs72XW8hJkIAESdVNpXRUvpM6DiblUa88fcyHgbSM9dLBQV3SD7oOFRuufP
         XVvhWjUyWPsNYpUo0p4l1cOBgj6ZCeDvj9M4j5fHXze66n/lDX4af974mJLfMuFNc1
         5+wPSYqRxRKQFyGhOin1ezEbdz+gVJ9HXeKaG/2fULDLSMFRg4pKD2s24f35++I9tK
         +7ColyakbKwKQ==
Date:   Sun, 15 May 2022 13:43:15 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 781bb995a149
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1C1PqXMnO05"
Content-Disposition: inline
Message-Id: <20220515054317.C66CCC385B8@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--k1C1PqXMnO05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.05.15 release.

There're two improvements:
1) A big change from Christian is the whole src/idmapped-mounts refactoring, so
if have old related patches, please rebase on the latest for-next. Thanks!
2) Overlay testing supports tmpfs to be its basefs now.

A change on ext4/053 cause a new failure. Don't worry, it's not a kernel
regression, and will be fixed by:
https://lore.kernel.org/r/20220510183232.172615-1-ebiggers@kernel.org

Thanks,
Zorro

The new head of the for-next branch is commit:

781bb995a149 vfs/idmapped-mounts: remove invalid test

New commits ([U]pdate, [N]ew) :

Baokun Li (1):
(U)      [92fb58afaa2f] common: xfstests support overlay+tmpfs

Christian Brauner (13):
(U)      [90c001261171] idmapped-mounts: make all tests set their required feature flags
(U)      [4cacbf7ae101] src: rename idmapped-mounts folder
(U)      [3607df35e440] src/vfs: rename idmapped-mounts.c file
(U)      [2d642516a73f] vfstest: rename struct t_idmapped_mounts
(U)      [836c87fb1e7b] utils: add missing global.h include
(U)      [e5f0de862eaa] utils: add struct vfstest_info
(U)      [6631d37ef388] utils: move helpers into utils
(U)      [c688623db6b5] missing: move sys_execveat() to missing.h
(U)      [0a26b226d838] utils: add struct test_suite
(U)      [48fdc9dd7dac] vfstest: split idmapped mount tests into separate suite
(U)      [3bc939bccca5] vfstest: split out btrfs idmapped mounts test
(U)      [a05df8ab47c5] vfstest: split out remaining idmapped mount tests
(U)      [781bb995a149] vfs/idmapped-mounts: remove invalid test

Eric Biggers (1):
(U)      [b03323c1d990] ext4/053: fix the rejected mount option testing

Filipe Manana (1):
(N)      [93db14575cd0] generic: test fsync of directory with renamed symlink

Gabriel Krisman Bertazi (1):
(U)      [7a2adb8f44e5] casefold: Fix expansion of seqres variable

Yang Xu (1):
(U)      [653da5b66160] generic/68[3-7]: Add separate sgid stripping sub-tests


Code Diffstat:

 .gitignore                                    |     4 +-
 common/casefold                               |     4 +-
 common/config                                 |    12 +-
 common/overlay                                |     2 +-
 common/rc                                     |    71 +-
 src/Makefile                                  |     2 +-
 src/detached_mounts_propagation.c             |     2 +-
 src/feature.c                                 |     2 +-
 src/idmapped-mounts/idmapped-mounts.c         | 14625 ------------------------
 src/idmapped-mounts/utils.c                   |   425 -
 src/idmapped-mounts/utils.h                   |   130 -
 src/{idmapped-mounts => vfs}/Makefile         |    14 +-
 src/vfs/btrfs-idmapped-mounts.c               |  3854 +++++++
 src/vfs/btrfs-idmapped-mounts.h               |    15 +
 src/vfs/idmapped-mounts.c                     |  7747 +++++++++++++
 src/vfs/idmapped-mounts.h                     |    18 +
 src/{idmapped-mounts => vfs}/missing.h        |    11 +
 src/{idmapped-mounts => vfs}/mount-idmapped.c |     0
 src/vfs/utils.c                               |  1050 ++
 src/vfs/utils.h                               |   373 +
 src/vfs/vfstest.c                             |  2073 ++++
 tests/btrfs/245                               |     2 +-
 tests/ext4/053                                |   148 +-
 tests/generic/633                             |     2 +-
 tests/generic/644                             |     2 +-
 tests/generic/645                             |     2 +-
 tests/generic/656                             |     2 +-
 tests/generic/683                             |    69 +-
 tests/generic/683.out                         |    16 +
 tests/generic/684                             |    69 +-
 tests/generic/684.out                         |    16 +
 tests/generic/685                             |    69 +-
 tests/generic/685.out                         |    16 +
 tests/generic/686                             |    69 +-
 tests/generic/686.out                         |    16 +
 tests/generic/687                             |    69 +-
 tests/generic/687.out                         |    16 +
 tests/generic/689                             |     4 +-
 tests/generic/690                             |    90 +
 tests/generic/690.out                         |     2 +
 tests/xfs/152                                 |     4 +-
 tests/xfs/153                                 |     2 +-
 42 files changed, 15668 insertions(+), 15451 deletions(-)
--
Zorro Lang
zlang@kernel.org

--k1C1PqXMnO05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKAkq0ACgkQlNbPkfr2
tMypeA//eYN9ReK1qSwDKGXexXXa1kfwFHwuJ08xXKiWzNBAELjWc3szT4VFvLqV
4XAJ1/SOOrdn+DHykmNknBnop3jRJA3Zevkd9jTu42tUz4C/k+SzStl/s5fcc0sX
9C97585sGH1Hm7w1U5Y7Zb8R7wVfo5Mi5CSTGvzPnu8A3vbthU/HQF1UC+HTxwHy
pM0m6sv7H/DbuVBBLAseuAwLvn11zyCD/5HiJCD9D6PGJRvY4RsRCFKxSCRpRDQj
OUBJx1FiD+XlGUpg2SPFYKsdelKarCjYbR4WfuUOeCThHSzZvfDbWa9EWafquGjA
s/m0e5CNrcTwdWd0ga9S+XIsqOk5TxyKM7RReBf7IudqcrUpEE0RSLqA6kKHFLcw
EsDdtc+pJ4o0dBl6ypaRmbEaQelWmTXU1NfLWCQeyNvDmlSa9gNDrVkVnIUuxZ10
+4JmQ90mr+bVn4nSwukEvQEGR9jWcm6Jiof43ECMypdaT1LFbEU0bijitwDfu5Ms
O9hfc2AssZK8h8b10zBP7SgJhCt9ilVZtGv1du1NDEwhiA5ene2JHjbMGWzsIzKr
nzNiWo4/x8XEtmO1NwjIrEh936iP5UpXWm/W7cgMj0P2yKxhzRndnQrIDSRlZ39p
cNruYvBePy/RSABey3WJ55kyKaj5TOpAnphcmq2BSM0dNNfvftI=
=zsSt
-----END PGP SIGNATURE-----

--k1C1PqXMnO05--
