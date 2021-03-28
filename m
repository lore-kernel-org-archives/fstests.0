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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB953C433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9812D6196B
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 18:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhC1Suu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 14:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhC1SuR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 14:50:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2B3C061756
        for <fstests@vger.kernel.org>; Sun, 28 Mar 2021 11:50:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j9so8918979wrx.12
        for <fstests@vger.kernel.org>; Sun, 28 Mar 2021 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=JRwPo4qGLE0+ZRelKkpFxkcw0R8SROV3JLH8rOJV2B0=;
        b=Kpg0StvCLyfpbWG0mRBvllAMotJftr26vLPxIj5U17jMroBWRjALpiSKqSCvGyPhej
         f8qDYnD7wru4HAdmTzoN74sRm4NlJ6JivPKLi54DqqR2x0zy2Rgw5gVSYjuE70WSuNNg
         YCc4JIrGweJg39/uTkLTzjiO7P/j1TJVX/sHiSRwW8rfNuhKqsyBQC+/fThaT+1GTBG6
         /FRXB5p4AnMaSJ+W5vYdEbEPrc0VmTIREQcQ3OuPTg2tcczfIQCcHRDU2UBNT3YEB96J
         JrXyBHZ9cOYLFD3VHeCSyaGixzvDUx/YwgoDTP2QaZ/Tvbcxvnh6jx6Tn5G0Xm5watpY
         Xb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=JRwPo4qGLE0+ZRelKkpFxkcw0R8SROV3JLH8rOJV2B0=;
        b=LU9bkJYB6U5kx26D3ovYP2kah1WSxfY/CSLAoCI0eL20PywDbiHt39DY572wGWSCl6
         SrXaHWh3Xgok8G+5esWlimpDybWKX1NhvM5ocNYrznhF0gOnxk0/3L6bt4Sxp7HxUEws
         NKWVpgeGKBI5hiBaqnb0gv37kjl7DSot5uSrppQCZWulhZe+/WK3t6BAkIsSBSjRMM8k
         HlsP4Cf0TIfGhX8lWkWeu5ui5nJYs16/bKHC+Lh4yqWAhH7A9PFXuL95g+GfpsZPa0fO
         kqUl7YkwbSGiUmlQoM6bpgaIPrCbh3scJ6FNqocVl4KRjuCWo4sU8nWtfMpcNwi3c4zI
         HdPg==
X-Gm-Message-State: AOAM533h6euCx0hbgy6pArNCq8qCKUjXLB7zEzR3pQf2YLlT6d2CuFAT
        8NiIay6InWaWXQ1wiIzRD3nCRQij3DyLyw==
X-Google-Smtp-Source: ABdhPJwsDSjwQoAw4WTkT3ZqG0ti47WjAE56pe31SrVABc1HYlPLhlZrkUftQolvRfvYikVr9lpYQw==
X-Received: by 2002:adf:a1d8:: with SMTP id v24mr24344587wrv.378.1616957411365;
        Sun, 28 Mar 2021 11:50:11 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id q207sm22572392wme.36.2021.03.28.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 11:50:10 -0700 (PDT)
Message-ID: <6060cfe2.1c69fb81.9566e.87b7@mx.google.com>
Date:   Mon, 29 Mar 2021 02:50:06 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 9c912ab71be3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2kUG6OTijfaz"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--2kUG6OTijfaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're 5 new xfs tests added in this update, and only
xfs/539 fails with v5.12-rc4 kernel & latest xfsprogs for-next branch. There's
also one btrfs test and some random fixes & improvements.

We're having more patches recently, and more new tests are being added, please
help report and/or send bug fixes if you hit any problems. Thanks a lot!

Thanks,
Eryu

The new head of the master branch is commit:

9c912ab71be3 xfs: test the xfs_db ls command

New commits:

André Almeida (2):
      [4243ee6a3d02] common: Escape SCRATCH_DEV variable
      [1fc1737959c9] generic/556: Fix rename test

Darrick J. Wong (10):
      [15bb2505e50c] xfs/{010,030}: update repair output to deal with inobtcount feature
      [d65111a674b2] xfs/122: embiggen struct xfs_agi size for inobtcount feature
      [404d9f2b50ab] populate: create block devices when pre-populating filesystems
      [77166a85ef6e] common/populate: create fifos when pre-populating filesystems
      [7be083b14212] common/populate: change how we describe cached populated images
      [4acd3ddd8ea5] xfs: test rtalloc alignment and math errors
      [47361c65427d] common/rc: refactor _require_{ext2,tmpfs} helpers
      [210089cfa003] generic: test a deadlock in xfs_rename when whiteing out files
      [7cf9f15eef2e] xfs: test the xfs_db path command
      [9c912ab71be3] xfs: test the xfs_db ls command

Filipe Manana (1):
      [175bb55960ba] btrfs: add test for send/receive with file capabilities set

Johannes Thumshirn (1):
      [939acb650757] common/rc: don't rely on /proc/partitions for device size

Pavel Reichl (1):
      [973865af3c7d] xfs: no excessive warnings about dprecated mount options on remount


Code Diffstat:

 common/populate       |  22 ++++++++--
 common/rc             |  27 ++++--------
 tests/btrfs/235       | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/235.out   |  17 ++++++++
 tests/btrfs/group     |   1 +
 tests/generic/556     |   4 +-
 tests/generic/556.out |   2 +-
 tests/generic/631     | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/631.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/025     |   2 +-
 tests/overlay/106     |   2 +-
 tests/overlay/107     |   2 +-
 tests/overlay/108     |   2 +-
 tests/overlay/109     |   2 +-
 tests/xfs/010         |   3 +-
 tests/xfs/030         |   2 +
 tests/xfs/049         |   2 +-
 tests/xfs/122.out     |   2 +-
 tests/xfs/146         | 102 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/146.out     |   2 +
 tests/xfs/147         |  68 ++++++++++++++++++++++++++++++
 tests/xfs/147.out     |   9 ++++
 tests/xfs/150         |  98 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/150.out     |  19 +++++++++
 tests/xfs/151         | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/151.out     |  27 ++++++++++++
 tests/xfs/539         |  87 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/539.out     |   2 +
 tests/xfs/group       |   5 +++
 30 files changed, 808 insertions(+), 34 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--2kUG6OTijfaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmBgz7EACgkQJlKqKVyP
52PAGRAAz/7YDFt2l1UG/5Qwo85/C4A+Tel8ef6/w4rfZjuNxCURpFFSXE/rcSwO
uj0aIxrMcq1llKRJ5jhQaXFZjh5eb98ZtKlLjx2oTk/hdORTOmtDg4es8bwJp4IP
3neNI3Ms+XnGpLZmjN0I3XwsPSe7LIFY4WYqcTZ8uaU5PPfeoPFlG/sjlIj7eE7R
k7tPbf3H0UIaoLVVJTyJ2UsKOD8iIn+pxIxr0mDbn4aAAjoN94N+OSHYHwlQrGSp
9IErSHCPde0cLbBMerb92843u0h69hFRw25wjSAYNg31UvFiZa4MyLUPSHQArYcs
uCEPxTVUAsylFRtXSAAWpB23ZKVzqaLKkIG5ix1z/ySYzA1jRJGroxJhKnFVOsQ6
k3txB0O6UuBhFjYXYGEfKcseTeVUhlp1A7WVmniesKDoslN0r16dl7Cqis/afWoQ
58jWQxaVSApqyP+oICKUnbzCqOfxxmYNQdvkiPaoq63XdfaF8h5q99NVC7UDa373
W0PkJ8QkJ+lcQFfzPmta2lWwnLjN6s1P/Fd+sI4paPdQ4+AGvdvWKOjqu8AChFPT
eaYQ6PPi3qtNO0LMbfmWhhAICJrjL3ElaWO76lnnoSniPYtY47Ve1HRt+vY4N9f/
6XYl8vJBeg75rcjOMuept15xyAvaWv5cw5HKQ+AjHIg8y8yhPhg=
=jat6
-----END PGP SIGNATURE-----

--2kUG6OTijfaz--
