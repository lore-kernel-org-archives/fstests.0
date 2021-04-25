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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7AC433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24D46113D
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 09:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDYJC3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhDYJC2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 05:02:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECDC061574
        for <fstests@vger.kernel.org>; Sun, 25 Apr 2021 02:01:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l2so347361wrm.9
        for <fstests@vger.kernel.org>; Sun, 25 Apr 2021 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=WrjWFBDgkF3MR77V/YJd4uzZyD+EcC/8Fip5BTDS50M=;
        b=WNod8+RqqkKTc6pnKLbi39wmJG0mpBq3CFBPqsp+Csnt+izPmRN+lY8m9XAjM5mDLC
         XLK5UxxHFwqedKS8hOSMPjVOxZdJeLkgjth/wJYFHWGSs8P7+qbLeabVf9SMss4ADEZ+
         Z332veOfFgEu9CdFh0JqTUthd2xF9gb+7Ki33Bdahnk8P54C6XY4+fHVLN67l7I4pXzv
         AXO4mrGP/mSheBNgcBjdJoNDjd5+5+f1HLhhiVqLisNBfAB85bDE8sk6cWehwLjmBjFb
         tpVEai7d/5B17lxTpcBaHEGuZOj3dUH1G4xUGDoj6oTPKBLPrpIuu1cb7wwz1NEx0ilI
         34Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=WrjWFBDgkF3MR77V/YJd4uzZyD+EcC/8Fip5BTDS50M=;
        b=KYADcW2/TsIZHUV8KfRyztOz3LAddvckd8bKQVAc+Y0xxbbzKNs7W7xsOjkbMHgQRh
         7/uglucNQyk5rFduii6e6+L7MfEmqmndly4u2ixQMhStKybkLKLUpeOUMXYJmenY8w1S
         6d/dWHFiMpnDNrOkDYyq6Fmfqc45ES9NBGk2fvEPvd+VBeMuLhA1iD30xz2/68u587OH
         e+RRQybkyQ4MzmX6H8P9AIvZfsNUlVl+dIWVmrMRCq73kDvgVefkjBLzyqSqpxSoPO9v
         uq6msfhPduEHMtWrc2GAL/cZqMGrvT5Yh4zl4q32lQH+8dMoOb1sJG/Xlau9ief3SRbr
         /TTg==
X-Gm-Message-State: AOAM533GDTspefQbBuaYpg/aBZCn+sSc1LfGd8cec9XL62stlR/GwH8w
        RrPS7/WD9viq8U1TK+0Fxt2xBdVrrbphfA==
X-Google-Smtp-Source: ABdhPJw1mFBAiWoJZ9/mkVmhDTEBXF6N4ozQdFQ7qAUdY+LrAuZ6ADxbq2pSMOm888QKK1jf2HnpIg==
X-Received: by 2002:a5d:524e:: with SMTP id k14mr15452072wrc.282.1619341306019;
        Sun, 25 Apr 2021 02:01:46 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id g3sm5026267wrx.78.2021.04.25.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 02:01:44 -0700 (PDT)
Message-ID: <60852ff8.1c69fb81.8c49d.5dbe@mx.google.com>
Date:   Sun, 25 Apr 2021 17:01:40 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 40818883aecd
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JJGYIFZInLYO"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--JJGYIFZInLYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Several xfs new tests from Darrick J. Wong are merged
in this update, and they all should pass with v5.12-rc7 kernel. There're also
some random fixes as usual.

Many thanks to Brian Foster and Allison Henderson for helping review most of
the patches!

Thanks,
Eryu

The new head of the master branch is commit:

40818883aecd xfs/144: Use _qsetup instead of qsetup

New commits:

Darrick J. Wong (8):
      [982941cf89f5] generic/223: make sure all files get created on the data device
      [bec48842284e] common/dmthin: make this work with external log devices
      [af7ac9448fd6] xfs: test that the needsrepair feature works as advertised
      [8fb042e54ea0] xfs: functional testing of V5-relevant options
      [7d20ed3e1fb9] xfs: test inobtcount upgrade
      [472f957a8cf7] generic: check userspace handling of extreme timestamps
      [f806708c2c48] xfs/122: add legacy timestamps to ondisk checker
      [63b6a5644e71] xfs: detect time limits from filesystem

Naohiro Aota (1):
      [74e99aebdc01] fstests: add missing checks of fallocate feature

Pavel Reichl (2):
      [ace9db40f929] common/rc: Add _require_{chown,chmod}()
      [bd5aba84ffdb] generic/495: split the test

Sun Ke (1):
      [bb2f356f14d7] generic/619: a better way to get tot_avail_size

Yang Xu (2):
      [a8c09c9e020b] xfs/145: Remove useless -f option for xfs_quota command
      [40818883aecd] xfs/144: Use _qsetup instead of qsetup


Code Diffstat:

 common/dmthin         |   9 +++-
 common/rc             |  36 ++++++++++++++-
 common/xfs            |  71 ++++++++++++++++++++++++++++
 tests/btrfs/013       |   1 +
 tests/btrfs/016       |   1 +
 tests/btrfs/025       |   1 +
 tests/btrfs/034       |   1 +
 tests/btrfs/037       |   1 +
 tests/btrfs/046       |   1 +
 tests/btrfs/107       |   1 +
 tests/ext4/001        |   1 +
 tests/f2fs/001        |   1 +
 tests/generic/087     |   1 +
 tests/generic/088     |   1 +
 tests/generic/125     |   1 +
 tests/generic/126     |   1 +
 tests/generic/128     |   1 +
 tests/generic/193     |   1 +
 tests/generic/223     |   5 ++
 tests/generic/314     |   1 +
 tests/generic/317     |   1 +
 tests/generic/347     |   2 +-
 tests/generic/355     |   1 +
 tests/generic/456     |   1 +
 tests/generic/495     |  14 +-----
 tests/generic/495.out |   3 --
 tests/generic/500     |   2 +-
 tests/generic/597     |   1 +
 tests/generic/598     |   1 +
 tests/generic/619     |   2 +-
 tests/generic/634     | 123 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/634.out |   2 +
 tests/generic/635     | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/635.out |   1 +
 tests/generic/636     |  49 ++++++++++++++++++++
 tests/generic/636.out |   2 +
 tests/generic/group   |   7 ++-
 tests/xfs/042         |   1 +
 tests/xfs/114         |   1 +
 tests/xfs/118         |   1 +
 tests/xfs/122         |   1 +
 tests/xfs/122.out     |   1 +
 tests/xfs/144         |  21 +--------
 tests/xfs/145         |   4 +-
 tests/xfs/154         |  80 ++++++++++++++++++++++++++++++++
 tests/xfs/154.out     |   4 ++
 tests/xfs/155         |  91 ++++++++++++++++++++++++++++++++++++
 tests/xfs/155.out     |   2 +
 tests/xfs/156         |  93 +++++++++++++++++++++++++++++++++++++
 tests/xfs/156.out     |  17 +++++++
 tests/xfs/157         | 114 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/157.out     |  19 ++++++++
 tests/xfs/158         |  98 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/158.out     |  23 ++++++++++
 tests/xfs/159         |  44 ++++++++++++++++++
 tests/xfs/159.out     |  15 ++++++
 tests/xfs/331         |   1 +
 tests/xfs/341         |   1 +
 tests/xfs/342         |   1 +
 tests/xfs/423         |   1 +
 tests/xfs/group       |   6 +++
 61 files changed, 1070 insertions(+), 44 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--JJGYIFZInLYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmCFL1gACgkQJlKqKVyP
52MCBg/+J57cXQo9wfXtJTs90Jk3u6ujWcG7UI9ScY/Ps+6PZilhuCl5bQZSOKUy
OkiWblo86LBuKDFv160weQ+EHQeIDhrePLh5H5EI4VXISKM9X+sgeiWxpaWnVua+
4csDm04g2fLNSKSFx3IfTfpqILWPbSztIp/YPfi4noMK09X18w7J290rlqFQLTis
+b3yLpbn9ha3fLUyCgZVm2VzLV25KL4FtoguXeBQhwX9JZYW345kLkkbK2xt18JL
mQa7BBUQAZJIGbbnu8YBqX0Z8S14U1/jSCfE+4bfy1aigsvMvjgDXoNkbAQ9i9nH
5AuVKPsSsvQfckknyCxVPjNcn5mFZ+Zz4/r6DtYF+h8Ywb0bL525pja/ne+vfSNx
vvdsGjG1lPdN8LROOs8y3mo3krjyeOhr1EKpNyUmR5mADhXXznp6NA8NR/h4AVXC
Bzi3RDXOhJGWhjy0VnBnnWlAniF3oVhYVgj4mjcIYoHtQ0f6OSkiQxiDNvfPh+Ee
qB+j9KpiRt87DVHQ/JKMsI58ox/GG7UPPgWV9fsOuYQJelDqMgCTStWUxvub4z2o
CudVAQKz8qFQFpBRUVik96kT0pkXH6iZsdrfKCcb5ZBDnv9FmJWNoFm55uWdMcC2
W/MFLMLZMhdPK8CPmvbkhefS8f7J80qPT7bvNdSAMxdLs3HZ3SQ=
=rSQB
-----END PGP SIGNATURE-----

--JJGYIFZInLYO--
