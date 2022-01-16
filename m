Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697BCC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Jan 2022 15:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiAPPik (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 Jan 2022 10:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiAPPih (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Jan 2022 10:38:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4EC061574
        for <fstests@vger.kernel.org>; Sun, 16 Jan 2022 07:38:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v123so15452313wme.2
        for <fstests@vger.kernel.org>; Sun, 16 Jan 2022 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=WNuOR2FXz0viX5mTWsjxnYi14dRhXlnyZgndOnSAmuc=;
        b=eLjstgevTuU4wMdKEmD/PJWYeSubyJeo3tdQx2lEEnT8hVjMSAv+SUIy0gk0QA+iPh
         zJ0PsWmD6ehG6PoVWx5L+xV4+WXDE8Vgy/Ach+48HDgJi3um61tJEH0jojaV6jjuiOxO
         Hnh5FrMmZ+xrjBgtIbUgrnQ1j0UgGJNbufYxaOMWt88CHtVwxma527z6Yk/BiyyYlpuI
         t0Sz8kcjXRgRPPIOHpfJ439n9gYdFXySlMg/4vMJYgcZGHRkvsPKJMFhVsn2sUdNBlkz
         y1iCZeGJOsB6FStCx64dNL7o5TiuzkJy9zj5COSJzMKCgIrwZVWXVMe10b2MFony7cn9
         LvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=WNuOR2FXz0viX5mTWsjxnYi14dRhXlnyZgndOnSAmuc=;
        b=zYCuWgKNRNkFTn/gmusC7Vu0u6IhiYcgi+HolY5/l9yjv2u2vQE/kQjAGbNNfZGkXA
         fIe7hBKaoN7RdL13oxYd7v53CoYKTr90YJq0PVYxqjpD6LoC0ijNdsoWNmTSESyEhK4F
         VrD77G++Xe+CdbYBCsPUZ3T6pYpE256dWIcfGWaPDTMMTGGZbnUhkEJUbOa6/WqfJpd0
         4/ImysQUZy/0cUdq3HMJjck77mmYSZlym4j7RU3LprRm6mY807s39Htv40vmvXQMM7cH
         kFf7Pp2gqfVCJqbqg2w9c66LaNu2YJnB6islZ1MSqTEmjsZp80jsXcF9+mUKN2eMUs+D
         7E2g==
X-Gm-Message-State: AOAM53226B3xAXufQsHmQaprdBi7P45ylfwCjFRgZz9kPct1OVNu6O9O
        CQHyP+ibwbqK9ZoEkkPh2Pl7rHF9syA=
X-Google-Smtp-Source: ABdhPJzIAW0UNWole4tjB3uHCBKwzxgmxSjAkOpP40f4NgfNvzbjAUs8foesyO7W6rCNLnwIwvoBvg==
X-Received: by 2002:a1c:a9c2:: with SMTP id s185mr23355886wme.164.1642347515821;
        Sun, 16 Jan 2022 07:38:35 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id l31sm11639232wms.1.2022.01.16.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 07:38:34 -0800 (PST)
Message-ID: <61e43bfa.1c69fb81.b7718.97e2@mx.google.com>
Date:   Sun, 16 Jan 2022 23:38:31 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to bec9f2cc9d7a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GFI3Rhnk2pDW"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--GFI3Rhnk2pDW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains some bugfixes and improvements,
mainly for xfs and idmapped mount tests. There's also one new xfs case, which
should pass with latest v5.16 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

bec9f2cc9d7a unwritten_sync: convert XFS_IOC_FREESP64 to ftruncate

New commits:

Christian Brauner (3):
      [b3c31bd3ab60] idmapped-mounts: remove redundant fchownat() call in setgid tests
      [7edd45acf142] idmapped-mounts: add more explanations to setgid tests
      [9100066c2034] idmapped-mounts: add missing ownership comparisons to setgid tests

Darrick J. Wong (7):
      [3f79f632b073] common/rc: fix unicode checker detection in xfs_scrub
      [3925a4ec9d47] xfs/220: fix quotarm syscall test
      [9ecf4cbf3c37] xfs: test fixes for new 5.17 behaviors
      [c2a8e177817e] xfs: regression test for allocsp handing out stale disk contents
      [a32fb1bb5661] fsx: add support for XFS_IOC_ALLOCSP
      [479b5b5786db] alloc: upgrade to fallocate
      [bec9f2cc9d7a] unwritten_sync: convert XFS_IOC_FREESP64 to ftruncate

Qu Wenruo (1):
      [94232f08cb9c] btrfs/011: continue the test if we failed to cancel the replace

Shiyang Ruan (1):
      [26d2df0ee39a] generic/670: allow _mread_range() races with reflink_range()

Theodore Ts'o (1):
      [db4dfa826d7a] common/rc: fix _check_xfs_scrub_does_unicode on newer versions of libc-bin


Code Diffstat:

 .gitignore                            |   1 +
 common/rc                             |  19 ++++--
 common/xfs                            |  12 ++++
 ltp/fsx.c                             | 110 +++++++++++++++++++++++++++++++-
 src/Makefile                          |   2 +-
 src/alloc.c                           |  66 +++++++++++++++----
 src/allocstale.c                      | 117 ++++++++++++++++++++++++++++++++++
 src/idmapped-mounts/idmapped-mounts.c |  62 ++++++++++++++++--
 src/unwritten_sync.c                  |   9 +--
 tests/btrfs/011                       |  16 ++++-
 tests/generic/670                     |   5 +-
 tests/xfs/107                         |  57 +++++++++++++++++
 tests/xfs/107.out                     |   2 +
 tests/xfs/130                         |   6 +-
 tests/xfs/130.out                     |   1 +
 tests/xfs/220                         |  30 +++++++--
 tests/xfs/308                         |   5 +-
 tests/xfs/308.out                     |   2 -
 18 files changed, 475 insertions(+), 47 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--GFI3Rhnk2pDW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmHkO9IACgkQJlKqKVyP
52PjQw/+MHMJh6hafMRnpq/mKsZMulAtILVchCFvngiRmQ6gLLCAlI2VM2r0Wfd5
4yZCkeWJG/bJWfb+iw4fWPsBfsxUPxCRkrAKwR/IOzmjOdbwpA6/++pcPi2fMDwf
l86OqbbLTcOQZ9tUTUUx2/vDOGO2+X8sXYemy6/Jl3clZwVUUY4kNSG7oIc1a1bf
17ZSEMjQN57kvi1z4pFsBf1SUIumwNPVnbFvb6FqzdOmXir+InNspE0GICPjnYn3
1pHvvACuWzB32VJHHqHW6woNE5jNL8+STWAnFFblLyykp59H5Jx8Kj54kypaqiZI
ZLAIvR4UHmsuzqzYebcVsvkGVwX4rTOydwuVoFFJQttMhutntq6dY5/GI+dA5K+1
ssxUA2nLALhsVgwV0AiMMG3M512MlKIZOhHN1yRtFW54veEKpjTBBY/GR94FdNlr
stnH088fZGUf7lp+DjdPizI90GzxoSogSdFaN+P7vOXiWEOIqiMituyba1lEoAnj
oMxgLo7Ix/c7ZFCLEEQ8l2Xg6k9fbSR2pEfkCnPRETsxdf4f+Y4FjD377QBvr4xY
PfDWFdalKLH21G1XOPt0q3wro0HSvIjdX1j3kEL+ABzybsZmJt0kc/FfAwjO9n6V
O6dSR4jpqtIJdzpFl8Q+yi0CC1gnA5+KMf4O1YK9eU/HUC/VTa4=
=3E6b
-----END PGP SIGNATURE-----

--GFI3Rhnk2pDW--
