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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F3C433E0
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Feb 2021 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A2564E42
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Feb 2021 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBGQiY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Feb 2021 11:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhBGQiX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Feb 2021 11:38:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B208FC061756
        for <fstests@vger.kernel.org>; Sun,  7 Feb 2021 08:37:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my11so8288033pjb.1
        for <fstests@vger.kernel.org>; Sun, 07 Feb 2021 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=JOQ5IIAeOG+pK9LyeqCkjshgZRg1iVJvK4TP9m2nT6k=;
        b=FR+w+5zXs+TzlzfA86Gekz0SE7baqkikakC6zmpSMiY4oUNjK1l5NNnbQhXrS1JaKQ
         nBSyi1W50KBPyl7wZaVkIhAi0M9pixB5Q2lazNSWCxyuuM2UHjpAigqb6iY+67DwqgP2
         belBvSbvVgPhXDpORx9T32HOkV6ky3YVG5D6mzGxG/h6rpRai0OfYl6MOihJthjbI8dB
         LjVJdAEcs109Pevk+/wuHugU6yMjj86NiK45ilN3bLyRNHu15kTuHOqyNxLu7TBRL973
         EQaTXI1IbS3YNdY4fPC+m7r9FPRd9zv8ngXjWDQfZnksRwrK+DsFuqTatZhLpTR+sf1g
         inwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=JOQ5IIAeOG+pK9LyeqCkjshgZRg1iVJvK4TP9m2nT6k=;
        b=jXouBS0z5cwu/ZyCWSQlwQs1Zw3f7I53kWUdok1Q9k6JCOjH6HyUsxJ7+japrkDdeT
         vN+g7e1LYKDqjuHlUcaoXgqn7E4tm8aXPojlRcWhBsHS4pEDdyTcZBeUIrFJogiDhKsU
         BNh6ha+jWr/IxVPr70FyNOcClJc+jYi2sTxrIDsH4JZRUcMjIDSriujENCkejUoeEr+1
         0EhZcSXTFVhUSlV8mtjv+fVQAWGc2cRnjzwSDF0JpNusLScdgazqSthWTevwU3pCHhHL
         FeojeNiNHuSN6eJwwe48pbohjWvBftulyIMYDQoX5MeenGNgyalwnmd9kVApCvcOkkIw
         vveQ==
X-Gm-Message-State: AOAM532ca9vEYZPvuCmcVQNO0imqEwSYaFbJ6YA1KCa09lOfr2izha6F
        jkzOLv4UHE5/IAoyICpm+js7FCYD8qb/4w==
X-Google-Smtp-Source: ABdhPJxkLaLu7M2zMqy6/JtK0Okx1tRFinT3FNhMnK5M2i7JCEmVd+AH0NEvL/HDRserf0kmHlB1YA==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr9155797pju.206.1612715863015;
        Sun, 07 Feb 2021 08:37:43 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id t17sm17061307pgk.25.2021.02.07.08.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 08:37:41 -0800 (PST)
Message-ID: <60201755.1c69fb81.84c14.3cd2@mx.google.com>
Date:   Mon, 08 Feb 2021 00:37:35 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 08a617f21dca
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kX3St1lC2xX0"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--kX3St1lC2xX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There's one new test and some minor bug fixes. The new
xfs/527 test currently fails on latest v5.11-rc6 kernel when testing v4 XFS,
but should pass with crc-enabled XFS.

Thanks,
Eryu

The new head of the master branch is commit:

08a617f21dca xfs: test a regression in dquot type checking

New commits:

Darrick J. Wong (1):
      [08a617f21dca] xfs: test a regression in dquot type checking

Eric Sandeen (1):
      [d15b1721f284] ltp/fsstress: don't fail on io_uring ENOSYS

Sun Ke (1):
      [f961a4b9fe87] src/swapon.c: initiate p to NULL

Zorro Lang (1):
      [8e3d3c5815da] generic/095: don't silence fio error output


Code Diffstat:

 ltp/fsstress.c    | 17 ++++++++++++---
 src/swapon.c      |  2 +-
 tests/generic/095 |  5 ++++-
 tests/xfs/527     | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/527.out |  5 +++++
 tests/xfs/group   |  1 +
 6 files changed, 88 insertions(+), 5 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--kX3St1lC2xX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmAgFvoACgkQJlKqKVyP
52MCZhAAiVdzDV4O/vV7vz5UxFNAa6rK9qORS11MWd13DRCHzXAvcMinDRkBrlRo
G/B9707oPJFvq0D+lFWCDu5vHPHyarrKNgt96UxCOVhtKAXB66dpW9URnxYGfeaO
79cR/1CEC99TaAjXGE65QbT/Lo2rkkSe8DcFxednZsFO5SYpNDJGjblOeZMsmALu
ikfzZETsFptRiNW5ErWoqeK9O4wxdFI4VhS8YCBPi1FB94XrdmeclFBYfJR4B/nn
cQQE3H/HZSoQPGspH7PLY3p/pQN8NoNs4p56aSEIqKLR37MJtA9t6fa524yX+KaL
/l9B8ghL+oCKcsSQk24psmpElZafS1y8M2wBq0MfZlmsTxjSFR9Xyho611ge7iol
I7koZ7a2KnpLwfUO7Dncyfe61AVlQJm5nRjnGh9V53GT3GdMu8a37SRmwV50fmeB
hiBzDZswycwq0sIc8G3OHC21IpM/umqBfkUq3HEAQKSVO/aV/ImFiGlBOnTPyXVL
bErrT41jAsXPb6Gr5LUMtE1PmEYXKG4atZQX+pkNpzN1YP9A1Tv8OC5ptxRjEWEz
y8SOS/2lalVwijvaz7VcFjMWmAiidexj2tjVJpKifynXHJAtN2Du9EbfpvvSVDZJ
SKhKslQcvYs3E7FuPLqmtQrftr3Clohf0C94YKiPYAczpNbUjYM=
=s+hS
-----END PGP SIGNATURE-----

--kX3St1lC2xX0--
