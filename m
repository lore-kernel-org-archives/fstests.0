Return-Path: <SRS0=8raW=DZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74748C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Oct 2020 11:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DED21582
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Oct 2020 11:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXiTynjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgJRLpX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Oct 2020 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRLpX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Oct 2020 07:45:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B326BC061755
        for <fstests@vger.kernel.org>; Sun, 18 Oct 2020 04:45:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 10so4303433pfp.5
        for <fstests@vger.kernel.org>; Sun, 18 Oct 2020 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=qCNQ4MJxsWAcweciTBEqAPU23SMB2lW6Iue/QEmMFuU=;
        b=OXiTynjT1oqeaUN9YG5fSl0mZ0frZVXz+kG8/JNYcFVwegxryZ6j/g7kXERahhAyNW
         gkcCVQfGUvMQhouT1jZW55njVWWcJL3ajqrFyi09YiUO/j7oiuXEKdxkV4+OvqBLfEY6
         C5skV71+ehvnztT8QkM+XlMOfP7HZJ+1Jq2P01FDIofl8sVOJjvF0oPSussMk10PeTXP
         i8WCG/2ZBoFnaJbLSaZOgIp51Jev6n/axrYlivkAMI0Xtb291wl72RmjM1w4CjQifVwH
         z01mvNRKm/6Wi3v5DVUEEFBMWoCEj6ZGJToUHKuZtKUNlXKjT0SgKPpsvEpx64ABZ6gF
         aAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=qCNQ4MJxsWAcweciTBEqAPU23SMB2lW6Iue/QEmMFuU=;
        b=PHGrVLci6FybbXfHuwJoDYvwC7W6nELhjdupmaMEMvjR65FzSof9ARcN3dV6OoMT82
         eO63BVQW+YQ7Wtnv4AUejzyZ9PRQVOX9jQtsY2oMMwES0iiDJ6+tWPzqhqHWabOD5QO8
         E8JV7Tz5WGsgOVf5QLUpZriRluOiazEC1mWqgTHbplPMeu0p3cSShkHToVVHRzE3Gamd
         ko/dRHf5pMMMpK4TEGIthaKrFWPAZ7FwiL2bLYUVhqi+F+d+6IcN6/UeZo5zYEkJF5pD
         TlU7kXPPcNrriNZzaf4DLpcm/UsXZx7hWqHH1IMw3fc8bBlBsse4zrojL7cZ5+DenV5+
         EsdQ==
X-Gm-Message-State: AOAM533Am4+sLhQQ1nSSmMRhiA5g/OS4qfEJPNyaOacS55w/45BnZ7Ih
        GAZ3ClD/3KmLCDiqiAH+SF51oBcAgel9Eg==
X-Google-Smtp-Source: ABdhPJxYp/kF+9MhqPPTYfmU2YwN+HNQvlHP5L0gwyE6APwOkfbpTb/Deh5T+7qHqngZ/fDUAvbWFA==
X-Received: by 2002:aa7:9391:0:b029:152:1ce5:ec27 with SMTP id t17-20020aa793910000b02901521ce5ec27mr12399445pfe.57.1603021520665;
        Sun, 18 Oct 2020 04:45:20 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id 63sm2958830pfv.25.2020.10.18.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 04:45:19 -0700 (PDT)
Message-ID: <5f8c2acf.1c69fb81.21192.5c7d@mx.google.com>
Date:   Sun, 18 Oct 2020 19:45:16 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 61e4eead3cf4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kksrSQB9ttqt"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--kksrSQB9ttqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update is a small one, there's one new btrfs test,
which should pass with latest v5.9 kernel, and other patches are minor bug
fixes and improvements.

Thanks,
Eryu

The new head of the master branch is commit:

61e4eead3cf4 fstests: drop check.log and check.time into section specific results dir

New commits:

Filipe Manana (1):
      [2b5cf241ec58] fstests: add a filter for the new getcap output

Josef Bacik (1):
      [61e4eead3cf4] fstests: drop check.log and check.time into section specific results dir

Sidong Yang (1):
      [e82cfa708103] btrfs: Add new test for qgroup assign functionality

Yang Xu (1):
      [64e86f445494] xfs/521: use _try_scratch_mount instead of _scratch_mount


Code Diffstat:

 check                 |  28 +++++++++---
 common/filter         |  28 ++++++++++++
 common/rc             |   6 +++
 tests/btrfs/214       |  16 +++----
 tests/btrfs/224       | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/224.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/generic/093     |   4 +-
 tests/generic/093.out |   2 +-
 tests/generic/513     |   4 +-
 tests/overlay/064     |   4 +-
 tests/overlay/064.out |   4 +-
 tests/xfs/296         |   4 +-
 tests/xfs/296.out     |   4 +-
 tests/xfs/521         |   2 +-
 15 files changed, 195 insertions(+), 29 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--kksrSQB9ttqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl+MKlYACgkQJlKqKVyP
52PMzA/+O1leUf6OdQTxDC3yU777ZZRe+Hso4l8edjuxygYtW6BlTwbqHtMuQTLF
op1DYVB43xrkpzZZQZnlIY8ezFQgjbi8BS2cARbDVc1vBsUHlewra1ngh7518FA0
rWk7X9x5FJ9I6GkDvG728NFcpStYQ2bxIqjl+wK4Q2wztWXTN2JZQFzN2FQnV0FB
zEkmGUbVhjbGaYMXT6oSeLUR977wxxzPSRDeYh0ilL5kjnViyp96qWGxJC/JwbG0
lBhnBdY7+s/r/YzNhiF89sNq0HFep/QmWEIAZnCBYMBI1vJNnljk6prBBp9YAoTC
LNjrflQ/YYvJUeFItwXYHL9k8X+n6ixKmujqoWsZplCwVYcme0Kx4f3WVodvLKDV
PfFXuNDdvHFd1cvxmuItLIBs/+25PdOFGH3VNW2T1BjURaGIB6NKBJO3lZJfSypr
kK2vsF8CvKkUDh6O207KQIwguH+A4oF3jcyGcdg3VCQ53lLyyT8yeTBzx5JrZ7Fc
s85fLyMFlTCCon+GV27qElm6Rutkt9LKzD1T04Z5EU4Gn88SRokTbpKslrYXWpZa
fglAB0gq8OT+vBMrUK2OWpeT5YWdhVNLfwTSqa2NdU2FUm/wI16UcaCWeucJ4mj2
znQQnsNyun6l36XeApGEILzNFNMpp8xC2uu+XW4w8Djvz87RSjs=
=7QPn
-----END PGP SIGNATURE-----

--kksrSQB9ttqt--
