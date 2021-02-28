Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145BAC433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Feb 2021 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82CF64E74
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Feb 2021 15:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB1PhB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Feb 2021 10:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhB1PhA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Feb 2021 10:37:00 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB1C06174A
        for <fstests@vger.kernel.org>; Sun, 28 Feb 2021 07:36:19 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t29so9733726pfg.11
        for <fstests@vger.kernel.org>; Sun, 28 Feb 2021 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=nGaRcPDxUr4iEkKjzIGYyv4O0x7S+AuAwxpno35rG2M=;
        b=SpX3JhtoEFA36DW0RaCZu43IGIwe3SzhXWD/P9fC2AOy0b5RgrHFVx+X+QfUqCEq3I
         p+9yDm/9W8sUFqBPzc5BywLuZaHWb+0ZMK9bdnYMtqlYLWkB03ueSDcEwwE0ssKKlqtT
         BSD77YOnpB8s8BKCgXwNsyTwMpwW9fIR3oE6Y/r+Qe2VJUpvbAXNZGcEXDZ2oyc2gMFH
         IiuPHS8iPyOL0VsU+pSG6MoorwHBTs5x3icpOFv1RdwSVCClEeP5gpYQOwrRi0gUlPp/
         cIWaREd1tMdNf3/2tB5e20OCLhejHuSTJpV3VRABVd1hnYfzOP5Uk0OAYHmUKl11x927
         qKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=nGaRcPDxUr4iEkKjzIGYyv4O0x7S+AuAwxpno35rG2M=;
        b=se960vZR2DiQWR8h+O8UMS9i7Y5NZKov/bQHFv8RT/t6n26SiTwFvprXKqFtiuo4Qu
         pTcvcNFu6qlq16eBwBI18Waot++ppsseXA8H7V5DR0ETc/ueu5Xzs5S5E/xIaIgG05gK
         xPd97oaTrot55cXdM/HhHC4xBL9/URuFdtNwhkDH9uvtax+tKt7sb05ZmGZNfFmMc/2M
         zbRlvQLkFywQ44GSf3pV5CiGiFJYU38768wQ9Lyzz5R7gKw7vIz//1v8FR24BWgvkpU9
         qKBV3FjnjSouAAk+80rmSCFxdOCxSFWmolkc76Byc/Yq+AGt65X4elFn9LnTKFMo6Os6
         /xrw==
X-Gm-Message-State: AOAM532X6b+j9oG/Uw5u8hUT4b6DsYOHD/PvExQBGjO6nRfLBt4kailZ
        D4G/SCkttQanZ6Wh9mYWWCW7ERsqZJ8=
X-Google-Smtp-Source: ABdhPJw+Tv1/LJK5zNQecnGGS3MmnSx+bnVPJjfcEI9n2x/earbVDzO7edNEUyV5b5OD9OYoSNfspw==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr10314448pgl.37.1614526578575;
        Sun, 28 Feb 2021 07:36:18 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id cv3sm11360576pjb.9.2021.02.28.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:36:17 -0800 (PST)
Message-ID: <603bb871.1c69fb81.384f0.9ddd@mx.google.com>
Date:   Sun, 28 Feb 2021 23:36:14 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 011bfb01f7f9
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n7TENUluxvjt"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--n7TENUluxvjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. It's been a long time since last update, my apologies!
This update mainly pulls in the immutable/append-only tests for overlayfs and
filestream test fixes for xfs. And only overlay/076 fails with latest v5.11+
kernel.

Currently there're still some review-backlogs pending in my workqueue.
Hopefully I can clear the backlogs in next two weeks.

Thanks,
Eryu

The new head of the master branch is commit:

011bfb01f7f9 generic: test mapped write after shutdown and failed writeback

New commits:

Amir Goldstein (5):
      [b8a84870b34a] overlay/030: Update comment w.r.t upstream kernel
      [ce4616c9b75b] src/t_immutable: factor out some helpers
      [8911efb91e5e] src/t_immutable: Allow setting flags on existing files
      [990feb5ac6a7] overlay: Test lost immutable/append-only flags on copy-up
      [8cbc48b460b6] overlay: Regression test for deadlock on directory ioctl

Brian Foster (1):
      [011bfb01f7f9] generic: test mapped write after shutdown and failed writeback

Chandan Babu R (1):
      [b13284d992aa] _scratch_mkfs_geom(): Filter out 'k' suffix from fs block size

Darrick J. Wong (2):
      [acb981a4e55b] xfs: fix filestreams tests when rtinherit=1
      [0ac0d8fbf9ca] common: remove _require_no_rtinherit

David Sterba (1):
      [48aa331f2181] src/splice-test.c: use memalign instead of aligned_alloc


Code Diffstat:

 common/filestreams    |   5 ++
 common/rc             |  12 +--
 src/splice-test.c     |   5 +-
 src/t_immutable.c     | 241 ++++++++++++++++++++++++++------------------------
 tests/generic/623     |  45 ++++++++++
 tests/generic/623.out |   4 +
 tests/generic/group   |   1 +
 tests/overlay/030     |   7 +-
 tests/overlay/075     |  92 +++++++++++++++++++
 tests/overlay/075.out |  11 +++
 tests/overlay/076     |  66 ++++++++++++++
 tests/overlay/076.out |   2 +
 tests/overlay/group   |   2 +
 tests/xfs/170         |   1 -
 tests/xfs/171         |   1 -
 tests/xfs/172         |   1 -
 tests/xfs/173         |   1 -
 tests/xfs/174         |   1 -
 tests/xfs/205         |   5 +-
 tests/xfs/306         |   5 +-
 tests/xfs/318         |   5 +-
 tests/xfs/444         |   6 +-
 tests/xfs/445         |   5 ++
 23 files changed, 382 insertions(+), 142 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--n7TENUluxvjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmA7uBAACgkQJlKqKVyP
52MrwRAAgEVjjfwezNgdNGU4YKHVBFZN0AIQayhu+MutGYnBT6C/3i9AAyBdR2rz
jogKq92Rj0dPnH/mem2ezLPym4Xt4ooukGq4MReSaaNWu5s1HNZudDZPimrju5vv
f13gOM3j+8TK8fZiw7twMjAhmrF2ME+1OtA+H2ov1dGcn3dS36z8KrCEvTEE6kn7
hU6Ir4WaDEiXgSOTu6vzl4o6uuqYApbeEvtXW2ek1eMzQMH26arxGPNpJQti2TNg
7cXs65LHByUcYLE+t/9oBzD3+C1M832N2I6YKNRjPejkGfJwKgAwc90cVdavozg/
BG5bhCROT7ogulhR0LUEE6raNNk6JWmzpNt843M47vicF0kcut6akjLNubjLBail
b0wm0b3MJGu7FXFqKp0DMSW6CP9+xtzPR+Nzu0NPZG/x20hN2I4h5tCaIGLSfBzu
Dc/4CS9jIy4slFnZqhIOltR5XhjUCsgFey4g3p2imrNUl3rD8ouQambVZq4/68C1
RGJtOAnRufSwtu0h4XgVAMIna8EvxtPWH71WhIALjUPKJCUuMrB4SA8w6H/cbcrE
UB+BmjPEt1Py1FJeo94DcfivgaulwkkpSE5pRhKFuK+gUT6yeEcFTzmXc86IfNKi
81u/SENym0P8F7Csl759jmBE8JnmP8uOnwX2PQyE8ng4rz1BvkE=
=+oJB
-----END PGP SIGNATURE-----

--n7TENUluxvjt--
