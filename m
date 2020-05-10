Return-Path: <SRS0=IDLK=6Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D4CC38A2A
	for <linux-fstests@archiver.kernel.org>; Sun, 10 May 2020 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98612080C
	for <linux-fstests@archiver.kernel.org>; Sun, 10 May 2020 16:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN+EmsDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEJQRD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 May 2020 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgEJQRC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 May 2020 12:17:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD065C061A0C
        for <fstests@vger.kernel.org>; Sun, 10 May 2020 09:17:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so6571079pjb.3
        for <fstests@vger.kernel.org>; Sun, 10 May 2020 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=b4Rqbkk2+IHNue2Rt3YbnvPGcwbpqRsfVJ0fGKOU+YE=;
        b=NN+EmsDltATk3jXFds5g5WBeO1rhCArvI3TaI2VLxTIx1CstMQea5C0sKdmowQVimi
         4+RnS5Ypz0pCyHCOgXOjF2RS0VJPKWX9FROgUTzNO4tGV8+US/uFqtMxSDtZXzL8Zfy+
         EetNQIVRmpySzQkOm5oJKNt1uOK0hHavKf5pXdoIlnnA/0wO2Hn70B9cMlNMI1Wfw2UJ
         SyAoKpsyZKx07/wXCA8TVWOBfVIaoEWEFxbBaz6fTqTxlxS7qL+ZixTIQ08/oroitVWK
         3uB/tmNwJlYd909995aLxW338evUUnGr6WiMrgQjjcEaIms3QPtk484XGgCcP8KVOqwo
         VKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=b4Rqbkk2+IHNue2Rt3YbnvPGcwbpqRsfVJ0fGKOU+YE=;
        b=J58wC2QvvBfJXladB1zJgN2q/bZmIrizWYcI81HiKHiSjtlpXz8kwwbhxs5PRAGXlY
         NBcBTSX2GYE8im4FC2IKPTHAYqnJdsp1gCx7xfR1iaUKSWoY0gpAegGwdUArr8apChaR
         XVSresGKBe4ZT/+x4/sUcWiyxsUcsRweoJr9aGh8xVEtSuBoYZx8pkdACcjNFdFqFXU2
         RnTAS6B1cvFnx2gVhBt0UIJhCigaf8WJBapGf6wSOEqenZakRRclR3OUbB/R1CW/RoYk
         Ear9b2RmcUzfpXKsN6VdwZl3HWafawx3N6U4/GunDGyUbEnNwDZUKlJrpXNrmdjF9nsr
         GjqA==
X-Gm-Message-State: AGi0PuZY7HcfrhXAS1RfxWAgoixmIbYdcHtwckpBDK3nW41LLG6jpNAX
        NeuXGvjvqNZCl/jdITEtsZipxvS/
X-Google-Smtp-Source: APiQypLi+Q1VkCCtDbtdp7xLDTkwyKhwqdp2PyoXlkr3pC/B4FX3QMW8bC7wNo2FXZO2OceyoyOY6w==
X-Received: by 2002:a17:90a:3ace:: with SMTP id b72mr17782881pjc.48.1589127422024;
        Sun, 10 May 2020 09:17:02 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id b16sm7097539pfp.89.2020.05.10.09.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:17:00 -0700 (PDT)
Message-ID: <5eb828fc.1c69fb81.45904.9413@mx.google.com>
Date:   Mon, 11 May 2020 00:16:49 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 280f79a824b9
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wlK8JnACTe3N"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--wlK8JnACTe3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. I mainly pulled in the well-reviewed patches in the
list, most of them are various bug fixes, and the two new tests are supposed to
be a PASS with latest v5.7-rc4 kernel.

My apologies for not updating fstests for so long, I've been busy with other
work and family errands. There're still plenty patches that need reivew,
hopefully I could clear the 'to-review' queue.

Thanks,
Eryu

The new head of the master branch is commit:

280f79a824b9 src/fssum: Fix duplicate CLI arguments

New commits:

Amir Goldstein (2):
      [f3bdafb91bb2] overlay/029: fix test failure with nfs_export feature enabled
      [98a6203999a0] overlay: another test for dropping nlink below zero

Anthony Iliopoulos (1):
      [4590ee0ad3f9] xfs/126: make blocktrash work reliably on attrleaf blocks

Arvind Raghavan (1):
      [280f79a824b9] src/fssum: Fix duplicate CLI arguments

Darrick J. Wong (4):
      [0f58b106e2a5] generic/590: fix the xfs feature detection logic
      [dff50e608494] generic/570: don't run this test on systems supporting userspace hibernate
      [6388518be930] xfs/30[78]: fix regressions due to strengthened AGF checks
      [35200671b31e] xfs/122: fix for linux 5.7 stuff

Filipe Manana (5):
      [15898a13d6d2] fsx: allow zero range operations to cross eof
      [c8b5a737509b] fsx: fix infinite/too long loops when generating ranges for clone operations
      [e5faa1ef15e4] fsx: fix infinite/too long loops when generating ranges for copy_file_range
      [f8ef0a099b03] fsx: move range generation logic into a common helper
      [10aa5e2904d2] btrfs: add a test for fsync of file with prealloc extents crossing eof

Yang Xu (1):
      [d9f75cdc8ffc] generic/456: document the other kernel commit

mafeng 00292095 (1):
      [0a1791f259d3] ext4/308: Fix misspelling in comment


Code Diffstat:

 ltp/fsx.c             |  87 ++++++++++++++++++++++-----------------
 src/fssum.c           |  49 +++++++++++-----------
 tests/btrfs/211       | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/211.out   |  10 +++++
 tests/btrfs/group     |   1 +
 tests/ext4/308        |   2 +-
 tests/generic/456     |   4 ++
 tests/generic/570     |   1 +
 tests/generic/590     |  31 +++++++++++---
 tests/overlay/029     |   6 +++
 tests/overlay/072     |  85 ++++++++++++++++++++++++++++++++++++++
 tests/overlay/072.out |   3 ++
 tests/overlay/group   |   1 +
 tests/xfs/122         |   2 +
 tests/xfs/122.out     |   1 +
 tests/xfs/126         |   2 +-
 tests/xfs/307         |   2 +-
 tests/xfs/308         |   2 +-
 18 files changed, 330 insertions(+), 71 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--wlK8JnACTe3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl64KI4ACgkQJlKqKVyP
52MLHxAAvlgXE6ScHn63FRala3UYXlcSkahmAMUIixT9kkun3lxrFOh0GbQXVku1
xPSaY/lX3/wXSP1PThpFgKQzgFM7Ac5ZqxCAr8enwODUVwqUzIFM5QIRbwJpKpEx
HQarJ+LDQBzoenOvf9lC5ET7LIfG5q6i1R5qRIjwJ+pvgjzIR+PaCFJHsuIT9fgS
FbYJLb6q94gk2RIas+D9p0T5o8foT71hDvWppmN+1iIJLpv3WCVD6yOxSKb/qLTh
nDd8sq1/b0EmjLwru2hU5jmgDY8v2jZoBH8YaXMvkCRbxwKuDrnUSkxvhER0Vuqe
zyEqsPxg2noxgfTI5mb04xIIXFtOP6VP+mE3t7UwyEvoigGIaKkcyfmVu22tZgdk
oN1QYpvispNVhWKlSwR0BnepRHrVFsj/y9IFwTi0vp2HUcwoyqOHk7M9IHbXMIrO
OlZGKrhkGeRHPd8KgdIKuTP/1SKeJGQwWn9JhrkckGlTUg1w9jO8QkWFtcjWMrgP
l6WfN74blpjaMnOUXWhBcO8mf/oA6OgQjE/d5snN0NSTuIpmVC543CmrXCXNFHRM
jtgsEjGA+2mncEVh3PREIX7OjPUai4A6fTEehGIPL3hw3K4WLej31LlzGsY1TcOL
BW+uCFZQnGQ1VqzlCXJq7Cz0moObEEJ6hZu2WXxASaeDNsDCx5k=
=0nnw
-----END PGP SIGNATURE-----

--wlK8JnACTe3N--
