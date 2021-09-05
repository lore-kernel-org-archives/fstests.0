Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F67C433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Sep 2021 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025C760F51
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Sep 2021 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhIEPcr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Sep 2021 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEPcr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Sep 2021 11:32:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4907C061575
        for <fstests@vger.kernel.org>; Sun,  5 Sep 2021 08:31:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso3166434wmb.2
        for <fstests@vger.kernel.org>; Sun, 05 Sep 2021 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=KWp1KEvzoysnkVGOESp3Rb0umBg8F9dciL/F0kA8Fq4=;
        b=WOeGui7DS5ELNK1/0OwUSVp1Lx+OLT05ET7trVWBS2gw8PphPPokUjgJ6E7HpDLUQM
         3w78AVXLn3GuQaE6gtvRnufoqCdslOFgme6kjuCw28QfQOKR7QYu2TndoRbyv0oyws6V
         tDKW1u0gFbyjDaMYg5o+6WwjR12mI6TV9FKcb7ZUehen+YzbvV1JpU/RgqNjUkR4WQg3
         z9KYFLWUk1xsfZGWBnK7suqordrSntUEPzDjfx56L4aAaMYzYK98seLGxIJEmCM5qG0T
         apOnYTt+1xV4kmjHnBQM3cP/5Pa8XGbJ5gKHongvGrfuI4FX153vP0f9oqKRsjd+dUJv
         CjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=KWp1KEvzoysnkVGOESp3Rb0umBg8F9dciL/F0kA8Fq4=;
        b=LR5EfUCWe2VO8wcykVKvTu4oMnI/9NHUvdUIuFPuuMOmvoERNKXndvuK5ZMQk+VRRx
         pxFYVsRZXBwkasjxE/WllAAWs+ZZEDu/HfopTIyVkt0ODaTltYcpEkH1LUWCcq7fKBbG
         CKt20h4d6yN+izR38SLbE+re/0aec06paIqr6dFYmyahXHplNx4E3PCG8Homjo3y6Gxe
         DcspwaENn/XXdJKCnYhYkOINQD9L1QD+FJGzAf1seRNxNsFm7ElxLoy1Vl3nBSxLa07z
         nHbsj8i6P6mUmVAYZIk2TGn7tEt3uw9h5ynUeAOoLQLbECNDvjvfohzEdG+/zTIBu4cY
         f7fg==
X-Gm-Message-State: AOAM531TalDmNus5nnlbAuU1+i/KaQFVyJYPq2QQb1Wgsx+3LEckcL6i
        xVnZIHF4GHcHBhnTLgSMd6/D1QBfQQc=
X-Google-Smtp-Source: ABdhPJx+g5sp6hyVroOxkuYsW+y8/bUQXCKb2G2A6nvQx+slNqMOcbzG5GyZ6Qg1uTVs11b3KEdPiA==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr7501927wmr.35.1630855902093;
        Sun, 05 Sep 2021 08:31:42 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id q13sm4798159wmj.46.2021.09.05.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 08:31:41 -0700 (PDT)
Message-ID: <6134e2dd.1c69fb81.7d410.682f@mx.google.com>
Date:   Sun, 05 Sep 2021 23:31:37 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to c6c74bb116bd
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RI9Ly2gDKcwz"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--RI9Ly2gDKcwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is mainly a bug-fix update, and most of the bugs
were introduced recently, my apology for not catching some of the obvious bugs
on review..

One notable change is that we finally dropped xfs_check in
_check_xfs_filesystem, unless you have FORCE_XFS_CHECK_PROG=yes set.

The two new tests are btrfs/247 and generic/648, and currently generic/648
fails on btrfs with latest v5.14 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

c6c74bb116bd xfs/449: filter out deprecation warnings from mkfs

New commits:

Darrick J. Wong (4):
      [591c8fb57d07] common/xfs: skip xfs_check unless the test runner forces us to
      [a468c7ebc3c0] generic/643: fix weird problems on 64k-page arm systems
      [0c4a002cf954] generic: test shutdowns of a nested filesystem
      [c6c74bb116bd] xfs/449: filter out deprecation warnings from mkfs

Dave Chinner (2):
      [6d2f9108631d] generic/081: clean up snapshot devices correctly
      [a1b220feba1d] fstests: which has been deprecated by Debian

Nikolay Borisov (2):
      [83bc5abe4a02] common/renameat2: Make _rename_tests_source_dest take flags as 4th arguement
      [281b2bd374e2] btrfs: test for rename/exchange behavior between subvolumes

Xiong Zhou (1):
      [1506607a5c2b] common/rc: fix MKSWAP_PROG quoting

Yang Xu (4):
      [e5ccb25d0129] src/idmapped-mounts: Fix an error for the loop initialization declaration
      [feee8000cb94] configure.ac: Fix uncorrect detection because of linux/btrfs.h
      [94252bca893a] idmapped-mounts: Use renameat instead of renameat2
      [83f9f983d95a] idmapped-mounts: Fix build error because of undefined reallocarray


Code Diffstat:

 README                                |   4 +
 common/rc                             |  29 +++++++-
 common/renameat2                      |   5 +-
 common/xfs                            |  12 ++-
 configure.ac                          |  41 ++++++++--
 src/fill2fs                           |   2 +-
 src/idmapped-mounts/idmapped-mounts.c |  58 ++++++++-------
 src/idmapped-mounts/utils.c           |   3 +-
 tests/btrfs/247                       |  60 +++++++++++++++
 tests/btrfs/247.out                   |  54 ++++++++++++++
 tests/ext4/006                        |   2 +-
 tests/generic/081                     |   2 +
 tests/generic/128                     |   2 +-
 tests/generic/452                     |   2 +-
 tests/generic/643                     |  33 ++++++---
 tests/generic/643.out                 |   2 +-
 tests/generic/648                     | 136 ++++++++++++++++++++++++++++++++++
 tests/generic/648.out                 |   2 +
 tests/xfs/293                         |   2 +-
 tests/xfs/449                         |   2 +-
 tests/xfs/505                         |   2 +-
 tests/xfs/514                         |   2 +-
 tests/xfs/515                         |   2 +-
 23 files changed, 394 insertions(+), 65 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--RI9Ly2gDKcwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmE04psACgkQJlKqKVyP
52OwZRAAo29VWcvClZAwXP2bEjlCnS1ugNnEg3spd+A6fz/8RKSOlnA/1V/D6VC8
hL5mOwIDO1Rj+veidJfvgmsa9PhDwB5M9Bwvj+l+B7skPsQaC6jG2QRG5GOtJ5n0
07ftmyQTbiY5B7dlum8PxsPGj9ZhPi4aXx+uK3Fv/ow6vsynyBOu9Tbj5IFU4S/4
+e+o4DhVdVdvlWoX/vWejJjrSG6IdPislQlCBCzU3NeAuPXWtHJWCczZtGOcVEQP
aprQEiky/eU3NGR0Xb6nBUNshPq1dYzSVAggpCnJ89uvRfwOnl6QMHAoqnstnYGV
vtTV/VEGPW0HViGv1kTGESH6PQvcm2/77XCXCaAL+q8xMMFgWLQoQrh7vkqZx71B
HS7cjpFcG5HL+d5RsGnM16Dgp1creUGKeumd4tcqByvlcB6ZkG0bhUtpooHztdjS
pb6e1DPqVFNZHgAW50jxifbaWMlzfN1pX8GGAnc9mF+NLDLMM9NwUWivGKcGVe3P
KHWhMdactEMP7fRAPtkkYDII3Po2pKJTUpIFXil36pb0jyl+CyDnNUGiq+7n7XcY
Jp5MwmgPXC5ggvbP5WcUmRMNyOIMWuDLknuGuegZdx+9CGQYHtN/3Xldrwhs0cuR
Vz8TJFo3wuAhKc2kId56BcMnk1yJ7mMv/aGr56FYdbbhnQTb++A=
=61FW
-----END PGP SIGNATURE-----

--RI9Ly2gDKcwz--
