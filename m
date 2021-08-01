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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61AC4338F
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Aug 2021 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED37610A1
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Aug 2021 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhHAQd0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Aug 2021 12:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhHAQdZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Aug 2021 12:33:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B851EC06175F
        for <fstests@vger.kernel.org>; Sun,  1 Aug 2021 09:33:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so9549305wmb.5
        for <fstests@vger.kernel.org>; Sun, 01 Aug 2021 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=gVNgcnOKmCzG+1PivWsHrK73XD0f7wtc22FJ3LR8Elw=;
        b=P4pDJ9sm17ujign+s5UH+en72m7GqfECKogDhlE8Qt/yZNLJjZkPSJ7XRyhinM0BTr
         gZKVl+unlUgWi+BxYZEaxwtlM6024NAIBrqD3c2rtlZC3ht1d8h50ZhLX0Bo0P9PBrY/
         MfEPxIPTUtpvPtMXpQA8vSaXpiBfu+aOgMKWWa6cSfWRDXVj8bWTcAtcR9NVHzKmWhUU
         1QZQ+2z4rzQv2O4JuSMjWwi4CgFg50CmYbl4bCe68ZJp9twfecs0wUA6PUG+nQcMny2B
         ORfXyA8msKh4h7JDpN87GtRTUUMmuLNR0CHc4Tw46mmfilV9e45oqm67G77mRQnbWWHz
         t5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=gVNgcnOKmCzG+1PivWsHrK73XD0f7wtc22FJ3LR8Elw=;
        b=tbnEcpU2w/8Oa02xZ7z/n/0njF49DGjlkftvLn/Sk0i+XiV3xuqKlMOuAvvi2s6KLt
         VHiu3PN0TRe6ny6Yg6deUk79/KO8XIibz57RWP2TCSSMWwcdAnDv4FrlnTxVeL+0A7XG
         GiNFAvnTX53yqBjwlVi9joMTaCK+eB8EcaCKrXeNnlrOA0soDEugjY6VJ8oqQ/w/W7yp
         RcD6FFDT17ls20PHfyPLrvldHN6y5UgL7In2wBTYAwW6lpGrREcJwaYDtkUsBRYq8blV
         RUJP/FEgggHI97YQ28IdT8hPghUArrjd58DpV53g2Y04XtTx/yS4iTcY2d9XebPFFYQa
         msQw==
X-Gm-Message-State: AOAM533y932BdS5WPwtgMtbNEmfYESWZwmvX1eAGCYTuK2rKTRtRtb6K
        RiXx22t6OfEs0FvBk9NzmHf6XJos8wM=
X-Google-Smtp-Source: ABdhPJxGRETQXiiWhIrEyeaApZjb7+s/nQZDo88DeSTJOa34h5PQcKHoysP1/amt2xJTd4IbVAOHnQ==
X-Received: by 2002:a05:600c:2e4a:: with SMTP id q10mr12960941wmf.133.1627835594970;
        Sun, 01 Aug 2021 09:33:14 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id c16sm8355032wru.82.2021.08.01.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 09:33:14 -0700 (PDT)
Message-ID: <6106ccca.1c69fb81.9e665.4ba1@mx.google.com>
Date:   Mon, 02 Aug 2021 00:33:10 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to c0135a6f0457
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rBWRyF3mwzet"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--rBWRyF3mwzet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in the 64k blocksize fixes from
Ritesh Harjani, and the random fixes from Darric J. Wong. There're also 3 new
tests added, and currently generic/640 fails on btrfs with latest v5.14-rc3
kernel, and overlay/078 fails as well.

There're still some review backlogs. The other patches from Darrick, which add
new regression tests for xfs, may need some help from XFS folks.

Thanks,
Eryu

The new head of the master branch is commit:

c0135a6f0457 common/attr: Reduce MAX_ATTRS to leave some overhead for 64K blocksize

New commits:

Amir Goldstein (1):
      [793ad50d595b] overlay: add test for copy up of lower file attributes

Darrick J. Wong (6):
      [a8b4f1be7d40] misc: tag all tests that examine crash recovery in a loop
      [5a501c2635de] xfs/106: fix golden output regression in quota off test
      [057869ad38ae] check: don't leave the scratch filesystem mounted after _notrun
      [7446ce37eac4] check: back off the OOM score adjustment to -500
      [4fdd27ce193e] xfs/530: skip test if user MKFS_OPTIONS screw up formatting
      [6d8a6d743a7d] xfs/007: fix regressions on V4 filesystems

Dave Chinner (1):
      [80395bbcdb6b] tools: add a dm-logwrites replay tool

Filipe Manana (1):
      [e52ceab66d76] generic: test for file loss after mix of rename, fsync and inode eviction

Luis Chamberlain (2):
      [96eefa4a7dbb] common/config: disable udevadm settle if CONFIG_NET is disabled
      [8bd9c9700849] common/scsi_debug: use udevadm settle instead of sleeping

Ritesh Harjani (6):
      [edc78b9897b9] ext4/003: Fix this test on 64K platform for dax config
      [9567432e3ac9] ext4/027: Correct the right code of block and inode bitmap
      [2a8ee2afe5fe] ext4/306: Add -b blocksize parameter too to avoid failure with DAX config
      [1d0af6eb4a2f] ext4/022: exclude this test for dax config on 64KB pagesize platform
      [04d6fca959cf] common/attr: Cleanup end of line whitespaces issues
      [c0135a6f0457] common/attr: Reduce MAX_ATTRS to leave some overhead for 64K blocksize

Zorro Lang (1):
      [b030dd07324f] generic: test small swapfile without page-aligned contiguous blocks


Code Diffstat:

 check                    |   6 +-
 common/attr              |  57 ++++++++++++++++---
 common/config            |   9 ++-
 common/dmlogwrites       |   8 +--
 common/scsi_debug        |   4 +-
 tests/btrfs/172          |   2 +-
 tests/btrfs/190          |   2 +-
 tests/btrfs/192          |   2 +-
 tests/btrfs/206          |   2 +-
 tests/ext4/003           |   3 +-
 tests/ext4/022           |   7 ++-
 tests/ext4/027           |   4 +-
 tests/ext4/306           |   5 +-
 tests/generic/019        |   2 +-
 tests/generic/388        |   2 +-
 tests/generic/455        |   2 +-
 tests/generic/457        |   2 +-
 tests/generic/475        |   2 +-
 tests/generic/482        |  20 ++++++-
 tests/generic/640        | 101 +++++++++++++++++++++++++++++++++
 tests/generic/640.out    |   2 +
 tests/generic/641        |  77 +++++++++++++++++++++++++
 tests/generic/641.out    |   2 +
 tests/overlay/078        | 145 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/078.out    |   2 +
 tests/xfs/007            |  19 ++++++-
 tests/xfs/057            |   2 +-
 tests/xfs/106            |   1 +
 tests/xfs/106.out        |   5 ++
 tests/xfs/530            |  14 ++++-
 tools/dm-logwrite-replay | 113 ++++++++++++++++++++++++++++++++++++
 31 files changed, 588 insertions(+), 36 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--rBWRyF3mwzet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmEGzJQACgkQJlKqKVyP
52OV5g/8Cldixs/+sltoS/bVSS55SAvftIXWjnN+u4iA4BCM6x0fYyo5sv1K4YxF
9dIzulCWf5pMy45k9fNMy1FKvdoG0u8FW/X3t61Aybv9V0sCcmEhngxPhI/RXkly
lRVxD+b8GnLjHWJ76bhSZs8xqGNAqjP8tMagu5WpwDqut7tDvZwnP+yVyyB56r6P
/4HbIIDWT8hhMdKUbXDCzLSC/c5Sb+xbO6OjEZj1LBunHaaByVLYlWP5FWqJmTcA
wkPachkJQEP8yOJeH9f0D4VnsFyqD/6Eq2JRDkHJ+gUjXRaT/JI6ywsjjDCpEWkt
/ZVJJHag8nfqSLOJ8FIyIFCcABZgD2WJee7oHGmyCrEhcO0IRgw+B5YnAPNDVIzB
9f15q0BRnrRv3Howl22gfdr8Fut4Nr4WyxG1vUpHZtr8VttKEej/f2pqrGT3vBGq
6r1jeBiaoNXpxWzC0Cp9aHqN5hHThuM0OTfk1SDYTyXslQ2zDfqJiNBC3mztX+Wb
LfvLONG1Q0GX6XWee61izJBtqqlYUl+FbMrxMSYrScdqjHoIGUZzC5SyG1FznJzI
A+ydQE6Nru7j0TB0sMNPzyVAbayv0fqpRK6R483Xy6GYHdqjZLQtgG3GtuaeN4tU
Lfjf/MtpItj6m3AyU2dmzt5XsPBJ2KVgCiajOlNL8k+NKZ+kSko=
=GaaU
-----END PGP SIGNATURE-----

--rBWRyF3mwzet--
