Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87127C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Apr 2022 16:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiDQQGG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Apr 2022 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiDQQGG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Apr 2022 12:06:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D3647A
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 09:03:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h186-20020a1c21c3000000b0038ccb70e239so142771wmh.3
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=bYgXSBMSWEUzQHGCkjJhwUjqvHy4V2/zu2Y1PBWO47Y=;
        b=d7O1lXZlVA5z8M7/J5wBUNT3b0YX2fq/atvKc88IG4FloL6xCf63h6rIB67pwj5V+O
         Pqm7HEoVmhsJMZEZCg5MhAYzwlJ2QpJYjeRgvE+FRolCgmqSPRDpSGi18hMjpVtlAWFi
         cOD5Z3Fhcre3tKld8ds/nXmjIDHa5IKUMysu4jW19wS3I56Uqnb89XkpfvvkwCbhSnEG
         BolA0XT7JO5bgQqrqeGyngovbw/s112z51T9KvE/Jz6Xi4TVImKT2TCVhY8Iqzc6gUU6
         r67O5YbSmpK9YOK/Wuv8fQlgnXGH9gyRLOwhIZBvHTZd8BbHsAwkLuASmxNY9yejsTyw
         kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=bYgXSBMSWEUzQHGCkjJhwUjqvHy4V2/zu2Y1PBWO47Y=;
        b=SC87Ae8yK38J05QCDRytOvxUDnGbvHQ9M77IliYkxJJWO213mIcUL55U6NhfLlVqFW
         e+V3TfTPEl75j+8ipBf8csmo0+tcZ2rInaZKDOUaGrvHPLQouS+t3FBQxUTdEqa2f3mn
         GcTzR//wJ02Uj7Y993HVChq8NVXUMrd54dg8psu1k/iQAGNE4sObSvL3HhodWMnJ0j3U
         fsiEBccPUxOJg3mw24CgO1eWmYlBtdYAtyicLon3Xce+QrZboLLLvwh9j9ufW78RZwxn
         lf0DMc14JKdplUsos3koMHMR7yj5Nak56zBRN7QK7JOCK70KpFRq8ZR4QA/G/a7Jri+/
         vnIA==
X-Gm-Message-State: AOAM5303FZZY6n7QwclG9mfgiVRToJEM2BidBGZX4OydDm7+rp0XErHk
        v22mIww56Yih+sx9oKhippQhS4TezII=
X-Google-Smtp-Source: ABdhPJzrhX2FNlKCAnNx0VPr+drywW9nBWwQMi1TZ+KuP406Xn0KdgIP5Vwhl41XFeZ+nGUqQe0PGg==
X-Received: by 2002:a7b:c5d6:0:b0:381:4127:84d3 with SMTP id n22-20020a7bc5d6000000b00381412784d3mr11506509wmk.24.1650211408322;
        Sun, 17 Apr 2022 09:03:28 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b0038ed39dbf00sm10475334wmb.0.2022.04.17.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 09:03:27 -0700 (PDT)
Message-ID: <625c3a4f.1c69fb81.8064a.a089@mx.google.com>
Date:   Mon, 18 Apr 2022 00:03:24 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to fbc6486be09c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QiRzngJrxP1N"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--QiRzngJrxP1N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. And again, most of the commits in this update are
random bug-fixes. There're three new generic tests added as well, and they
should all pass on latest v5.18-rc2 kernel (and latest xfsprogs for xfs).

And you may already see the discussions on the new maintainership in list,
Zorro Lang will step on the new maintainer role, and we're going through the
transfer right now. We'll send another announce email when all things done.

Thanks,
Eryu

The new head of the master branch is commit:

fbc6486be09c generic: test that renaming into a directory fails with EDQUOT

New commits:

Darrick J. Wong (7):
      [c025dcf35b47] xfs/507: add test to auto group
      [d7ac035cfeec] xfs/187: don't rely on FSCOUNTS for free space data
      [86e537edb41d] common/rc: let xfs_scrub tell us about its unicode checker
      [82047ce7cd46] xfs: test mkfs.xfs config file stack corruption issues
      [e75da9ebde72] xfs/216: handle larger log sizes
      [48029933892b] generic: test that linking into a directory fails with EDQUOT
      [fbc6486be09c] generic: test that renaming into a directory fails with EDQUOT

Dave Chinner (1):
      [b560e18c6216] generic/019: kill background processes on interrupt

David Disseldorp (4):
      [73aa648ce176] generic/020: move MAX_ATTRS and MAX_ATTRVAL_SIZE logic
      [dc76e4ec19a8] generic/020: add and use _attr_get_max()
      [a59e1f79f4e5] generic/020: fix max_attrval_size for XFS, UDF, Btrfs and NFS
      [9c6b2ebe2b6b] generic/020: fix max_attrval_size output filter

Eric Biggers (1):
      [16676f2f2c3b] common/encrypt: use a sub-keyring within the session keyring

Eric Whitney (1):
      [ca53ba1e74eb] common/filter: extend _filter_xfs_io to match -nan

Filipe Manana (1):
      [c4cefb1c5ecd] common/rc: fix _try_scratch_mount() and _test_mount() when mount fails

Liu Yiding (1):
      [d26e6be1290c] common/rc: Skip virtiofs when _require_exportfs

Luís Henriques (1):
      [0ab8b3ac61ff] ceph/001: add extra check for remote object copies

Zorro Lang (2):
      [daa0c0146c7d] fstests: replace hexdump with od command
      [0b11a5ecb8e5] fstests: test dirty pipe vulnerability issue of CVE-2022-0847


Code Diffstat:

 .gitignore                             |   1 +
 common/attr                            |  75 ---
 common/ceph                            |  10 +
 common/encrypt                         |  55 +-
 common/filter                          |   6 +-
 common/rc                              |  40 ++
 src/Makefile                           |   2 +-
 src/splice2pipe.c                      | 158 ++++++
 tests/ceph/001                         |  66 +++
 tests/ceph/002                         |   2 +-
 tests/ceph/002.out                     |   8 +-
 tests/ext4/024                         |   2 +-
 tests/f2fs/001                         |   4 +-
 tests/f2fs/001.out                     |  16 +-
 tests/generic/019                      |   8 +-
 tests/generic/020                      | 116 +++-
 tests/generic/020.out                  |   2 +-
 tests/generic/029                      |  12 +-
 tests/generic/029.out                  |  68 +--
 tests/generic/030                      |  12 +-
 tests/generic/030.out                  |  48 +-
 tests/generic/031                      |   4 +-
 tests/generic/031.out                  |  16 +-
 tests/generic/032                      |   2 +-
 tests/generic/032.out                  |   4 +-
 tests/generic/033                      |   2 +-
 tests/generic/033.out                  |   4 +-
 tests/generic/042                      |   4 +-
 tests/generic/086                      |   2 +-
 tests/generic/086.out                  |  14 +-
 tests/generic/397                      |   2 +-
 tests/generic/398                      |   2 +-
 tests/generic/399                      |   2 +-
 tests/generic/404                      |   2 +-
 tests/generic/404.out                  | 996 ++++++++++++++++-----------------
 tests/generic/419                      |   2 +-
 tests/generic/421                      |   2 +-
 tests/generic/429                      |   2 +-
 tests/generic/435                      |   2 +-
 tests/generic/440                      |   2 +-
 tests/generic/536                      |   4 +-
 tests/generic/567                      |   4 +-
 tests/generic/567.out                  |  16 +-
 tests/generic/576                      |   2 +-
 tests/generic/593                      |  13 +-
 tests/generic/612                      |   4 +-
 tests/generic/612.out                  |   8 +-
 tests/generic/639                      |   2 +-
 tests/generic/639.out                  |   4 +-
 tests/generic/680                      |  48 ++
 tests/generic/680.out                  |   9 +
 tests/generic/681                      |  67 +++
 tests/generic/681.out                  |   3 +
 tests/generic/682                      |  71 +++
 tests/generic/682.out                  |   3 +
 tests/xfs/187                          |   2 +-
 tests/xfs/216                          |  19 +
 tests/xfs/216.cfg                      |   2 +
 tests/xfs/216.out.64mblog              |  10 +
 tests/xfs/{216.out => 216.out.classic} |   0
 tests/xfs/507                          |   6 +-
 tests/xfs/543                          |  68 +++
 tests/xfs/543.out                      |   2 +
 63 files changed, 1390 insertions(+), 754 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--QiRzngJrxP1N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmJcOfgACgkQJlKqKVyP
52M/2w//a8ISaKk0mJZKhvCh612nLxkr4/qIAcT3awtfBXf9eFGOVWvxY8bfToQM
47aZzKU0+oVYoEfBYgV/qCWTMkcicJCvlzIPfSTXMw+Z+6ax+TdF9QhMmpgqKSRL
PiEWkn2LJma7mMuhbCUpkWjqg+V3nMEvFaYOUgV0p+okMXR39Bvx1akQPP9ZS7Zr
1KtEBv6XAo5ncMCWUul61SSi2P4INPV20AEILdL9baYfQCThFFDFuTNLkcBOPzTC
DZ+bnE2wFUv0tl4JdnztudQND+BFewDLYm+txh48rhhCTEOFAOGbNhAsRNzRi7US
6tnbWg3PuCpMbvKBd9VnelmsypgIEoiQx6anplD+JOrP5X9bS4gwfTAob19Alv9c
w8mY+3J3dBh3BZngufJRzKwfWFUY4LD1noFjhKP5RTRDCv6I2YOvX7wWyRhbxL1R
Bo2cHe3pizdw4e4fSZq1S+Utx0OsTkaZV5qYoe2BHtybwO5D6CceAT5/PoxFmCBq
karK/JxWpfuyihDaapUV3A4QfrTy5VkOC39YgSqW0TGAdUryFr1UYjKL93rMDtNQ
+xcHZCpCzTxlft1JGhsJqv5HPYjp6N5ETJGP3LkyE9oro3QDgqrHIQloVZs38bWN
Qww9u3nq6qSAYogcc7B6oIh/P//E8ZhmIlQ6mz9GQTf1jmGBJu0=
=weoC
-----END PGP SIGNATURE-----

--QiRzngJrxP1N--
