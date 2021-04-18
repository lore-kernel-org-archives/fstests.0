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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F13C433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A60961042
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhDRNDM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Apr 2021 09:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRNDL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Apr 2021 09:03:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C66C06174A
        for <fstests@vger.kernel.org>; Sun, 18 Apr 2021 06:02:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e5so2526662wrg.7
        for <fstests@vger.kernel.org>; Sun, 18 Apr 2021 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=ts7Gxyf44lzpAVbI5c6hl4tGy25aIpK6YCB86ic/oA8=;
        b=W02GVttLq2XNyVFOlwJdqbdkvoquuFyzghmA8kauRDkhr0a82hVw5GWHLHXFqS8Gbo
         3xNHl5c9GnY+FOs+5NEg21tBpFOydPD4XfpT4fmCGrZuh+PAsArAFmywEMrSjLcIUEns
         Qv/sDun/7Yn8KDZf4/kn0vL66T1GtU3Lj0FGAa4PeHOIFUWGtHaP415UGyw2bsDMwVoF
         xd9qBzI5fginaBtJ565GZmxyr4TMeWE8HZn355yWJuFTgeGi0yPgo22RUACj5shzJPal
         EdQudgUD3D4n86UU78QrIueARay67h7+2vg70kq0AYrndXEKmYgcUpl4OHZUareWgezC
         9vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=ts7Gxyf44lzpAVbI5c6hl4tGy25aIpK6YCB86ic/oA8=;
        b=uUpRSAYWe1CS9ndkFv8odUidXyVDMGpAbuzfVKz5z02pjo1TyZn5sDZQx88wcJ/Fl/
         jsW4s/OJQ1oUMhWhaRLZDZP1Vcx+djNfG53wBXnh4QBCDCuSMR/pDImWHa6Fey+1AXP/
         PgB5w2HzyOnXvR3M3fIYz/dpSIx+hduXRxzC8cswzSJS2bWf8bEAGN32G+ZuhqbhUlgn
         2t54x8B0NTpoAuJfdwWNWuSfL1b9IfIVRkc4T+rsup8mdByzummzc6EBhEHDlT3XkJE0
         tidEp9tbeQJU7GOT33OVo2csEFDBt8p6SIfJhP2SPEy3ra/VTYB9nCFH91NfTR1gKY0O
         RncQ==
X-Gm-Message-State: AOAM532wfLewNtYTDLUKZdWNwSvtDuqQE62zvh1LpsiI/W2PEBOFMA+j
        NJBzTDXsmaVkMgUmoRjebAM6fwT36N+rVg==
X-Google-Smtp-Source: ABdhPJxdaDwiK+sdmARGc84jx66VFmF3TECOe4u+UCw1DJ4TJ8aIReQdVCaspV02iINI83P7nC4xdg==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr9245974wrb.234.1618750961591;
        Sun, 18 Apr 2021 06:02:41 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id f25sm18626860wrd.43.2021.04.18.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 06:02:40 -0700 (PDT)
Message-ID: <607c2df0.1c69fb81.67e78.ac79@mx.google.com>
Date:   Sun, 18 Apr 2021 21:02:36 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 15510d3a2081
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="P7l8OSjBOuva"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--P7l8OSjBOuva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The idmapped mount tests from Christian Brauner are
merged in this update, many thanks to Christian for the 10+ rounds of revision!
Other updates are various random fixes from Darrick J. Wong, Pavel Reichl and
Sun Ke, thanks a lot!

Thanks,
Eryu

The new head of the master branch is commit:

15510d3a2081 generic/003: Amend the test for exfat

New commits:

Christian Brauner (6):
      [a7f90c1433f3] generic: add test for detached mount propagation
      [0d1af68e1a9d] generic: add fstests for idmapped mounts
      [bacf9b2d6d61] common/rc: add _scratch_{u}mount_idmapped() helpers
      [56908a2eb566] common/quota: move _qsetup() helper to common code
      [8a0c1200c1b3] xfs: quotas and idmapped mounts
      [c188f26b2b7d] xfs: quotas on idmapped mounts

Darrick J. Wong (8):
      [f7a8c5c4ad1e] xfs/506: fix regression on freshly quotachecked filesystem
      [d57433fc9941] generic/563: selectively remove the io cgroup controller
      [4e9ffa131685] xfs/521,530: refactor scratch fs check
      [c25b43fbe789] common/dump: filter out xfs_restore messages about fallocate failures
      [552a0cdd65d0] misc: replace more open-coded _scratch_xfs_db calls
      [a2330d65ff55] generic/620: fix order of require_scratch calls
      [97dd2c3a6a0d] generic/{094,225}: skip test when the xfs rt extent size is larger than 1 fsb
      [08de8433acde] xfs/305: make sure that fsstress is still running when we quotaoff

Pavel Reichl (3):
      [0c95c8acb82d] common: hide permision warning from mkswap for exfat
      [08e93fa7cae1] generic/554: hide permision warning on exfat
      [15510d3a2081] generic/003: Amend the test for exfat

Sun Ke (1):
      [718f490a718f] generic/591: add _require_odirect


Code Diffstat:

 .gitignore                            |    3 +
 README                                |    5 +-
 common/dump                           |    1 +
 common/quota                          |   20 +
 common/rc                             |   92 +-
 common/repair                         |    2 +-
 configure.ac                          |    2 +
 include/builddefs.in                  |    1 +
 m4/Makefile                           |    1 +
 m4/package_libcap.m4                  |    4 +
 src/Makefile                          |    8 +-
 src/detached_mounts_propagation.c     |  189 +
 src/feature.c                         |   40 +-
 src/idmapped-mounts/Makefile          |   40 +
 src/idmapped-mounts/idmapped-mounts.c | 8916 +++++++++++++++++++++++++++++++++
 src/idmapped-mounts/missing.h         |  151 +
 src/idmapped-mounts/mount-idmapped.c  |  431 ++
 src/idmapped-mounts/utils.c           |  134 +
 src/idmapped-mounts/utils.h           |   30 +
 tests/generic/003                     |   29 +-
 tests/generic/094                     |    5 +
 tests/generic/225                     |    5 +
 tests/generic/554                     |    3 +-
 tests/generic/563                     |    7 +-
 tests/generic/591                     |    1 +
 tests/generic/620                     |    2 +-
 tests/generic/632                     |   46 +
 tests/generic/632.out                 |    2 +
 tests/generic/633                     |   42 +
 tests/generic/633.out                 |    2 +
 tests/generic/group                   |    2 +
 tests/xfs/030                         |    2 +-
 tests/xfs/050                         |   19 -
 tests/xfs/083                         |    2 +-
 tests/xfs/152                         |  377 ++
 tests/xfs/152.out                     |  657 +++
 tests/xfs/153                         |  212 +
 tests/xfs/153.out                     |  129 +
 tests/xfs/299                         |   19 -
 tests/xfs/305                         |    2 +-
 tests/xfs/506                         |    1 +
 tests/xfs/521                         |    2 +-
 tests/xfs/530                         |    2 +-
 tests/xfs/group                       |    2 +
 44 files changed, 11577 insertions(+), 65 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--P7l8OSjBOuva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmB8LagACgkQJlKqKVyP
52MRsg/+MlyBwOlx7qts76pWNZN38TFNqwKbtKey83BN9ZFz5fqVnN1PhcXNf5CZ
YLGT+irW2/zwLgy65b0vGBaAdV9JGEAIVw/Nedua9yfp3jh9LzZD3gdJ5SND7bFA
NF/Nl2ujVkYEYx0y1Oj09sul2thD9EBlOFiBpzf7gW9C+x4oHfYthourxKgq4k5L
3v310vocuLmWVN8S0Dk9eHSVT4XX7KDpdJJC/UReptm3741saEjOFvnlc069pZhj
Jw2lKkGcG3Seug8KHIZesH6aBmGweDhd7B7rmXu+kAXxlVHiLYKVpc+xesX9Rnh1
/NUSOiRylTtnLudlvEAhiMhjODatpzE+eI2cOaC10jyspxuY2tLTun3hEM0j2E1n
fLVsYs30XK5cqq7K6ujIkJ6xU/QmTpQe9o+1AcMw3CAelcXjJog/768Nn+DN8wkS
olhwJjBFe4UzMxlN/5v820s4w5KmwGm2CZvU3ESRIsr3eqxXe1Mx1MCzv+n5tSHs
D01cET8/w30/WVPaP8jq3ECwQAKjSozak1QbomZPtyYoNl3WMYaMw4ahbfUUO+aD
63oQfnalkDDUCHG+YS5WxObNF5lu7+SlJQYrUR/fYJLNH/agL9HJWziKKRPaMBnB
703zVfxAtOLY3L3i3x5yxkm8wcj5ci+CByKtCcpLSeyUCF99aek=
=7amG
-----END PGP SIGNATURE-----

--P7l8OSjBOuva--
