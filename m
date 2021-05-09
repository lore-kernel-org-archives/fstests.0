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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC97C433B4
	for <linux-fstests@archiver.kernel.org>; Sun,  9 May 2021 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5C461006
	for <linux-fstests@archiver.kernel.org>; Sun,  9 May 2021 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhEIQIT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 May 2021 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhEIQIS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 May 2021 12:08:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4891BC061573
        for <fstests@vger.kernel.org>; Sun,  9 May 2021 09:07:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so1107820wmq.0
        for <fstests@vger.kernel.org>; Sun, 09 May 2021 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=tMA/4c+u+TMK2fVdYY7NoELWKa5ho1Egdz9zB22mVVc=;
        b=DIe0J7kO3dHGIleKOAwyrj4Tfh8AyYa0yTInP9P779EY2WMCwiXnM23rtpKhC48+ja
         rG12+UHCpoXCrsd9HybN27+MfJU9KerLSG/PJ7ihToxAkukLpYLv/Z0ovSR0V+t0Nf8W
         Y+xahYqnJNNWfCFkphtEo4rgphuOBlTqetfZq250OO1nVDWMpioX7j0nEyjTl2BboJLQ
         CX48AE7rYWcucmxCeOJuZrVH1w2oN7UZqMWrYnkzpDXA71jLcDtXeUFh4rUErWxZVKFP
         TOFhsDK3ItviIJCrLBOAR5fRw4gLhT6S2LmZ4i6V43dUF1Wdaiy4XHywDh0ibqWyyZHX
         GDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=tMA/4c+u+TMK2fVdYY7NoELWKa5ho1Egdz9zB22mVVc=;
        b=kL4jKp/nMMsObAfcj5tHlGRjkQk5fDBFg4C6w446/tXG2s5XVdSGpLd1hj7kida+0s
         FafTW9OLvIDSYt4jLiW8u+lH4lmeeepYou7d9hlRS94kIcFr8oIkmMK/YG0KGOuG41e/
         WbcSL72lxpQER+4Ypn/pHLnKhsUOHdo8kGEa4X7yEMWkJUmh8Kmf5G3KCpincI+5iIzC
         axkrgMY1CWtDH7mibFWGDulQ5+YM96KLRsthykqRi+aIznxB19C4XpxlS0chPLO2ODU0
         JGXF/zHgBhxliWIZOwR1fS2GWb+6HCmnt4BFJKuXZTIvglarzwl1tQp2bISv0V5218T0
         Pzpg==
X-Gm-Message-State: AOAM530u540nDZbS+zCWMeHmo7tri30US1jr2H1CRN6MIFcEn5WJh70O
        03bwZMeAvYW2m/gOrjt31ERkWefhB3U=
X-Google-Smtp-Source: ABdhPJxZbUmKZxdJc7uEnlBme/VpKiO/QE9ozsifleN4Tw4BsVhYou+9c/ExU3XhNdXyXKtgOByumQ==
X-Received: by 2002:a05:600c:b54:: with SMTP id k20mr22008753wmr.189.1620576432445;
        Sun, 09 May 2021 09:07:12 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id n12sm14166218wmq.29.2021.05.09.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 09:07:07 -0700 (PDT)
Message-ID: <609808ab.1c69fb81.d5286.17d5@mx.google.com>
Date:   Mon, 10 May 2021 00:07:02 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 1c18b9ec2fcc
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E2pep4znuEMc"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--E2pep4znuEMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is another fairly big update that most of the
updates are bug fixes. There're also new tests for xfs and btrfs, and currently
btrfs/236 fails with latest mainline kernel. xfs also got one test removed, as
xfs/419 is no longer valid.

And again, many thanks to Brian Foster, who helped review more than 10 patches!

There're still some review backlogs in my to-review queue, as I was absent the
week before last week, hopefully I could catch up in the comming week.

Thanks,
Eryu

The new head of the master branch is commit:

1c18b9ec2fcc xfs/49[12]: skip pre-lazysbcount filesystems

New commits:

Amir Goldstein (1):
      [6159ae7faf4c] overlay/065: Adapt test to relaxed rules

Boyang Xue (1):
      [69db2233f357] generic/563: tolerate small reads in "write -> read/write" sub-test

Darrick J. Wong (10):
      [2837d7c32d70] xfs: test upgrading filesystem to bigtime
      [9abb8f44ca6c] xfs/419: remove irrelevant swapfile test
      [2c70e8f8dd39] common/rc: relax xfs swapfile support checks
      [7987c994ee5c] xfs/010: filter out bad finobt levels complaint
      [4da76bfa4b3d] xfs: test what happens when we reset the root dir and it has xattrs
      [46d917f2e805] xfs/276: remove unnecessary mkfs golden output
      [e48c1f054f3f] generic/{094,225}: fix argument to _require_file_block_size_equals_fs_block_size
      [eb8d229ff7da] generic/449: always fill up the data device
      [d00cc974c777] xfs/004: don't fail test due to realtime files
      [1c18b9ec2fcc] xfs/49[12]: skip pre-lazysbcount filesystems

Filipe Manana (1):
      [05dc92277171] btrfs: test fsync after rename and link with cow and nocow writes

Jan Kara (1):
      [d599c768cb33] common: Fix recovery tests for tmpfs

Jinhui Huang (1):
      [e3a972a75247] xfs/153: add _require_idmapped_mounts check

Johannes Thumshirn (1):
      [0a095db5ef77] btrfs: add test for zone auto reclaim

Naohiro Aota (1):
      [a6dbebcb19e9] common/rc: introduce zone check commands

Pavel Reichl (1):
      [91c239fae998] generic/192: fix instability on exFAT

Shreeya Patel (1):
      [2461e8901c9c] generic/631: Add a check for extended attributes

Xiaoli Feng (1):
      [adf7f3620ca6] common/rc: not run swapfile test for DAX

Yang Xu (4):
      [51b3e9ece6c8] src: Fix an error for the loop initialization declaration
      [aea877f8979e] src/idmapped-mounts: use renameat instead of renameat2
      [b0a58bbe13c9] src/idmapped-mounts: Remove useless header file
      [6be48523d41b] generic/631: remove useless nfs_export=off


Code Diffstat:

 common/config                         |   1 +
 common/rc                             |  74 +++++++++--
 common/xfs                            |  28 +++++
 src/detached_mounts_propagation.c     |   4 +-
 src/idmapped-mounts/idmapped-mounts.c | 224 +++++++++++++++++-----------------
 src/idmapped-mounts/mount-idmapped.c  |  11 +-
 tests/btrfs/236                       | 199 ++++++++++++++++++++++++++++++
 tests/btrfs/236.out                   |   5 +
 tests/btrfs/237                       | 103 ++++++++++++++++
 tests/btrfs/237.out                   |   2 +
 tests/btrfs/group                     |   2 +
 tests/generic/094                     |   2 +-
 tests/generic/192                     |   7 +-
 tests/generic/225                     |   2 +-
 tests/generic/449                     |   5 +
 tests/generic/563                     |  20 +--
 tests/generic/631                     |   4 +-
 tests/overlay/065                     |   5 +-
 tests/xfs/004                         |   4 +
 tests/xfs/010                         |   1 +
 tests/xfs/153                         |   1 +
 tests/xfs/160                         | 117 ++++++++++++++++++
 tests/xfs/160.out                     |  29 +++++
 tests/xfs/161                         | 157 ++++++++++++++++++++++++
 tests/xfs/161.out                     |   6 +
 tests/xfs/162                         |  63 ++++++++++
 tests/xfs/162.out                     |   7 ++
 tests/xfs/276                         |   2 +-
 tests/xfs/419                         |  58 ---------
 tests/xfs/419.out                     |   5 -
 tests/xfs/491                         |   4 +
 tests/xfs/492                         |   4 +
 tests/xfs/group                       |   4 +-
 33 files changed, 952 insertions(+), 208 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--E2pep4znuEMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmCYA08ACgkQJlKqKVyP
52Modg//f2QK/+ttB3Lw8RcfCTGy8QDyKaJfatffa2bGMiU2JF9MCB8shOUIdltK
XQYkFC2T+ATKOx+9TCoGsv+uuKkOkcIQ69sXv3fg7VyUNhRvf2kdFiZ9A/NqAE2g
HhQiVtMfeouFpP7xq/+8SjzRfJ52DCPmxgC+jtfJ9U6IUtNkAn113V+1oPjTj48e
GWqWaMuLVBRRxbGZk45W0bKBl5v8KKspP6EkWMEndDy11fGjrH7WwpXcztO730vc
bdQ+NshfhNk2AIP42QaQ2uWZRSSQhfcEq4s9DnEgQH3cDaycArOI/E87+u2Bo9JU
eT5hZiYe9AFgGHEei2cQG+mn/iAEB/h2nBOqetT3Oq5sA0Q58mGoDgniXioWQl5s
4wi7n+t0sFaec7VWc1D9QqkdfTMEuaRvLFZ6/5sZ2u+JE6GxtVfMwa6qp8NFbvMP
9/wIljljlZsjvSlM9XWbZLZkeZz0UC4DfUvUkH2zvl35/REp6IqkU/jEkyCsXkTk
o07jBlKvRZct90ThRVJGwrcnIDZ2gNGsDH5lRI/b0HelSR5yO54Wfxq+Zs4K8rnf
yVWz0wjLm9jVRwUVjVAVP216G5fA3nvm8tMT1xVx4q+B5aQzzBhQGUvbjmuf890Y
OfyvzRJ4mMPXPgVtuelcWvajenZHBRfdBuG7GL14b4zbDF2HcCs=
=hvW2
-----END PGP SIGNATURE-----

--E2pep4znuEMc--
