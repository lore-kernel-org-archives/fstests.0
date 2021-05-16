Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C0C433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 16 May 2021 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A3961139
	for <linux-fstests@archiver.kernel.org>; Sun, 16 May 2021 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhEPRDX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 May 2021 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEPRDX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 May 2021 13:03:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC92C061573
        for <fstests@vger.kernel.org>; Sun, 16 May 2021 10:02:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3825832wmh.4
        for <fstests@vger.kernel.org>; Sun, 16 May 2021 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=9/NsGY3dKwyBFLa7e5HHd+wP+Tf+6Q9UxRHHLTVepxM=;
        b=r3HZ7WLS95VQtnoUZXTNvje+rOdc/w4+AkMT4HYdBG92M31pNsOGthH82YXgEixNui
         oYDj39se+L1CLZe6+Gs7ACHKHYsqTP3OGszzbdDlwkysj0w9BFkmHwEtVqkiGGols0Es
         KsfFW4mWFSBqGluksUSculA16+CiPb6AtQPQDQkd3BMMNQmT7d4YJJ1K2ZyUu9tlrT+Z
         vh8UBWRQTUEVWGN7030JjXRpLPC/gvRhdtl2D9wgHxbkrUv9zDJyVFFzW/WMy7bRw8lu
         4sDFm5jE+GBJ6qryeAurs3a86Q32+hAFSWKvNmrgsogSGJA1CQ5urRcUT8K1xUHAMvhI
         TiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=9/NsGY3dKwyBFLa7e5HHd+wP+Tf+6Q9UxRHHLTVepxM=;
        b=BTtRqRdSErRBAFd8Aghwdm2ineWaQnxx3QUQ1xw0KHSJe9j7vTgSh7tX+Q2D0lAM2H
         atOpLfMGiD0Ksqbce6I1JyRf2v2lt1B2PaNdswQ+WAoEobLWnrfYMRgbLt5/yClBFYPz
         QYqwYOAMdm0lV9S3xm2i3cldiCAZWdrYAfmYvA/JxYivoWj7EC1LfZB5gWVIHJA3Rprk
         IGj5dkZMlwnTBNymkRhlnNcTLF9IA/e2Pd+0AQAvzTFCh6iOSvyBfWwLasR6FDoBjlEG
         MnlnjCy/rIUz3X9Wa6bkj+WNpyXpZyFVEcASVfOQ12OxEDDQV4ebUuOxsYeLg46TgrK4
         OSHw==
X-Gm-Message-State: AOAM530EMO7mniNVMsEqbSymgO5QZd+i7gynn4x2dVOHf4ZAV7TB4Z3D
        H56Q//7ILCMZWJSBNiCU97TZdZrpWwM=
X-Google-Smtp-Source: ABdhPJwm8mJBn4fQB9QsA4fLn/uKRaw2UsAH/OLNDVSaYPOV8cze0I4uQUPfyRUTsPPYdleqaQGX3Q==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr18732696wmk.90.1621184525008;
        Sun, 16 May 2021 10:02:05 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id y5sm14097691wrp.5.2021.05.16.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 10:02:03 -0700 (PDT)
Message-ID: <60a1500b.1c69fb81.613c3.983e@mx.google.com>
Date:   Mon, 17 May 2021 01:01:55 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 33bcdb836aeb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kdRStDqZoSEK"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--kdRStDqZoSEK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We have new tests and fixes to overlay, xfs and btrfs.
Notably the xfs shrinkfs tests have been merged. And the only new failure I've
seen is btrfs/239.

There're still some review backlogs, namely the idmapped mounts patches from
Christian Brauner, please be patient :)

Thanks,
Eryu

The new head of the master branch is commit:

33bcdb836aeb btrfs: test log replay after directory fsync and moving a child directory

New commits:

Amir Goldstein (5):
      [d8772f925f88] src/t_dir_offset2: Add an option to limit of buffer size
      [2c1329d636f1] src/t_dir_offset2: Add an option to find file by name
      [54494f02efee] src/t_dir_offset2: Add option to create or unlink file
      [2fd4a08b9351] generic: Test readdir of modified directrory
      [18d4e9c7bfdf] overlay: Test invalidate of readdir cache

Anand Jain (1):
      [fcd74c405bb6] btrfs: add fstrim test case on the sprout device

Darrick J. Wong (4):
      [3427d07e1f0a] xfs/122: add entries for structures added to 5.13
      [98dff757fc07] xfs: fix old fuzz test invocations of xfs_repair
      [0df636ef78dc] common: always pass -f to $DUMP_COMPRESSOR
      [d80489e7d588] fsx: fix backwards parameters in complaint about overly long copy

Filipe Manana (2):
      [c4fa3c076797] btrfs/187: fix test failure when using bash 5.0+ with debug enabled
      [33bcdb836aeb] btrfs: test log replay after directory fsync and moving a child directory

Gao Xiang (3):
      [8a44508c507a] common/xfs: add _require_scratch_xfs_shrink helper
      [ebc1ee176db9] xfs: basic functionality test for shrinking free space in the last AG
      [8cecbd6e7c70] xfs: stress test for shrinking free space in the last AG


Code Diffstat:

 common/rc             |   2 +-
 common/xfs            |  22 +++++-
 ltp/fsx.c             |   2 +-
 src/t_dir_offset2.c   | 113 ++++++++++++++++++++++++++--
 tests/btrfs/187       |  16 +++-
 tests/btrfs/238       |  79 ++++++++++++++++++++
 tests/btrfs/238.out   |   5 ++
 tests/btrfs/239       | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/239.out   |   5 ++
 tests/btrfs/group     |   2 +
 tests/generic/637     |  62 ++++++++++++++++
 tests/generic/637.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/077     | 117 +++++++++++++++++++++++++++++
 tests/overlay/077.out |   2 +
 tests/overlay/group   |   1 +
 tests/xfs/083         |   8 +-
 tests/xfs/085         |   2 +-
 tests/xfs/086         |   4 +-
 tests/xfs/087         |   2 +-
 tests/xfs/088         |   4 +-
 tests/xfs/089         |   4 +-
 tests/xfs/091         |   4 +-
 tests/xfs/093         |   2 +-
 tests/xfs/097         |   2 +-
 tests/xfs/099         |   4 +-
 tests/xfs/100         |   4 +-
 tests/xfs/101         |   4 +-
 tests/xfs/102         |   4 +-
 tests/xfs/105         |   4 +-
 tests/xfs/112         |   4 +-
 tests/xfs/113         |   4 +-
 tests/xfs/117         |   2 +-
 tests/xfs/120         |   2 +-
 tests/xfs/122.out     |   1 +
 tests/xfs/123         |   2 +-
 tests/xfs/124         |   4 +-
 tests/xfs/125         |   4 +-
 tests/xfs/126         |   4 +-
 tests/xfs/130         |   2 +-
 tests/xfs/163         |  73 +++++++++++++++++++
 tests/xfs/163.out     |   6 ++
 tests/xfs/168         | 122 +++++++++++++++++++++++++++++++
 tests/xfs/168.out     |   2 +
 tests/xfs/235         |   2 +-
 tests/xfs/group       |   2 +
 46 files changed, 865 insertions(+), 52 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--kdRStDqZoSEK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmChT8sACgkQJlKqKVyP
52MyTQ//X9SlBMGon28wDQPJXyn1JgHXZRzfxZn2UMk6kcD9d+ppGRvblkddy8+j
iUzQQ8Y7/7rl18IJoH2GBj0TOUAiDYD7EXTr8sSP8888Vm4nLwa1Z/PjrCDOX3Wq
V+I4N4ZKx09Ho7dhgGmViJw7Of6tfxrp+8q54BEiEfKu0nz0V9/deNvn4CLFeb/s
aI23h7vootO0IRL4f9BCVJRmc3WjOinJ4mteejKs6MG6gIdvRdLYU+72WD2GA1Sp
oby5ny0TxwUQ1n/TA2383+VttpL9mVSmGCwYJgOsjppOGc/RstD6s0rE9+/K+6JA
mtxSm8GtA4X7VexmcOS12bMGQSJC0GOorOzGwQtwVF+H1Dh/B/jvtNBxA59gPX7z
H6aGLtscKt8ehQJnm2kFKgtAJNOJPqSH/1pwFWPSgsGn3zAW4D1pqNFDN0BAX2bJ
PVaVHKSNqW9eg3AMpcBsJ/p5WHTVL4gpplNzZMeeuFRK1GXLpwOW+TIyzobywP1N
oeo85TtILV6ij/jMZX0Uegu5/b1i6SOu7qpF8F7H4RFcGwKyecbWr4XeISHf5hca
fR3qz2DtrGRLv/ydRsGnQTSGL4Ra/lbArrXmu/7hhX63wq63unNvdaiLTvFGa83q
iu7G51Oa6Bz0KOT0rhvVZ4XAmPFn7L/x6I3Mu79qU7O2gg0E/T8=
=ayvO
-----END PGP SIGNATURE-----

--kdRStDqZoSEK--
