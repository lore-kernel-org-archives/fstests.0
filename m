Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED7BC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 22 May 2022 14:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346465AbiEVOjE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 May 2022 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiEVOjD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 May 2022 10:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F723A728
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 07:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31FCF60FD7
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 14:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA22C385AA;
        Sun, 22 May 2022 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653230341;
        bh=yN8IcQbYScj4sysiPlpW3CEu4G9jdUk1V4k0aU3Iyiw=;
        h=Date:From:To:Subject:From;
        b=sM9WdZjcXAFDYLEN3ygjSr1esqFQuOGalBFPyI0KSdK3iOoueQjVeGJlXctTbAKIz
         z4yQd/+3VGVnMfM0eBKvjFT0s3oGPUw666BgOe3xjejrqlh10npbj2Su/UcyZrZDQI
         ONIy3wdzM901Za8HacFxbEa2NV+PzGUb+qnuDpJ1Ct0D1XGjLIAppHDJWd3Qd1I72p
         0i1Gu3U8GEnqZcJ74pKCt1gXFSGSipRZTMKYI0eol8fLaecnfHw/nhIS+4VGV6BqaQ
         wfvqlhTArmLLRnVSrlNd2zywu04dsgoi3I4hO7AZt7LyRXYpQtkxpItjBNBeUc4vWW
         mAK1L24Oaa6MA==
Date:   Sun, 22 May 2022 22:38:58 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merged v2022.05.15 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aGfGARQwsaqV"
Content-Disposition: inline
Message-Id: <20220522143901.1DA22C385AA@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--aGfGARQwsaqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.05.15 version (merged from for-next).

Note: we've noticed that there's a small regression issue since v2022.05.08,
which cause xfstests/new command can't find a proper new case number. This
issue has been fixed in v2022.05.22 (for-next branch).

Thanks,
Zorro

The new head of the master branch is commit:

781bb995a149 vfs/idmapped-mounts: remove invalid test

New commits:

Baokun Li (1):
      [92fb58afaa2f] common: xfstests support overlay+tmpfs

Christian Brauner (13):
      [90c001261171] idmapped-mounts: make all tests set their required feature flags
      [4cacbf7ae101] src: rename idmapped-mounts folder
      [3607df35e440] src/vfs: rename idmapped-mounts.c file
      [2d642516a73f] vfstest: rename struct t_idmapped_mounts
      [836c87fb1e7b] utils: add missing global.h include
      [e5f0de862eaa] utils: add struct vfstest_info
      [6631d37ef388] utils: move helpers into utils
      [c688623db6b5] missing: move sys_execveat() to missing.h
      [0a26b226d838] utils: add struct test_suite
      [48fdc9dd7dac] vfstest: split idmapped mount tests into separate suite
      [3bc939bccca5] vfstest: split out btrfs idmapped mounts test
      [a05df8ab47c5] vfstest: split out remaining idmapped mount tests
      [781bb995a149] vfs/idmapped-mounts: remove invalid test

Eric Biggers (1):
      [b03323c1d990] ext4/053: fix the rejected mount option testing

Filipe Manana (1):
      [93db14575cd0] generic: test fsync of directory with renamed symlink

Gabriel Krisman Bertazi (1):
      [7a2adb8f44e5] casefold: Fix expansion of seqres variable

Yang Xu (1):
      [653da5b66160] generic/68[3-7]: Add separate sgid stripping sub-tests


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

--aGfGARQwsaqV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKKSq4ACgkQlNbPkfr2
tMwtfw/6AuCIrGIr8CPX0VJBGSdjNY/j+lbzGVX2YxSvgjgNX/Jb5XB44cEPqGxk
QaTP9gjyGYSuUFKaIrf4ubypj9eAYFObyNzk0aZ0+j6SK6+4uoj+yR19SWNd4FUf
VAM1kfCPs+cVXz/NJGWJiPzm3KRiz5njviKZRTLPVEqg/5vCIeSP3SQHFXEnpXhF
E7eiBjJQiXxdxGUaSYh5DGhGPHk+IlxgWJEsr6/+y2pftkv6vdAPhU8yBfh2XBBy
MLmgPtmb0JvEqjV9YeCAlNZSv1h8rlgdAQMEaUzOq7y/eO1N989ktd8B1xHmq3OB
jmoifwSQIBLFFjEY56VxmqmPrncZR9grdOEcQrpXMgJpHIwP+ZIWA4URTSiHAzzx
xSn6mUFu66i0WFsVNg0/D/N08T1DTDa0d31VCOgyLW62Sk0dWDYkK5zrc28Zie53
ap47LqL360iFO+w6X+if+3oOTg6urU+71i2NFYy064iMS2W8Yx3d/oWJEbqby8z/
rDjOmUt77NVHLHmAkhbYuQljNG4NGggbcFfwTl/QYvU1VdVn2k8peSnwPQ5FWyG+
QKN81y2qcg3G3POUegUs7DCPEaPHfdGxqHGy43Ux3rxUM6jFg69KPvOcb2EIFKK7
x1AQXULnartaAxrGKwjRK5zr0VQjs0bpXhocmcSU/2oA+5AztY8=
=/bRS
-----END PGP SIGNATURE-----

--aGfGARQwsaqV--
