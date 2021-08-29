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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D150C432BE
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Aug 2021 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3456860F36
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Aug 2021 14:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhH2Owk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Aug 2021 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhH2Owk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Aug 2021 10:52:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CDFC061575
        for <fstests@vger.kernel.org>; Sun, 29 Aug 2021 07:51:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so10258727wrv.13
        for <fstests@vger.kernel.org>; Sun, 29 Aug 2021 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=neoFpnqH85icG1HETPtNf/46P6bmlUMjr+tb2G2hfrI=;
        b=nK/l4s6pnoDgBHtSHNH8avp3b5IrLNQWsMLW1hrpexenjhPpmxOJoxryAhiaE+vck/
         2oSsbx07r8lSk0E5JzticWFXChvSYKdcJT1XeG6jUlU47AITiF6yBy2WJ0M5U/jcBMyF
         kEU92gEUy/b2MhB2Uxs2Pxbodm0pKmrwGR5h4dtswEY0Vh9ggnbBIFVnUdSjpfBJ8pKl
         iUex2nH0H8ZXm+kaOcLtWBH00w5e3TL6OyfBJEujLJvIlbcPVWFejbC8e+7soT0ef63W
         H7Anjbyk4DNB41RiT84xknIUiD5Brkj/G75+ROxbS1kcyCtMMS1KsFQTYyU+TUzlLVrR
         PBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=neoFpnqH85icG1HETPtNf/46P6bmlUMjr+tb2G2hfrI=;
        b=kiLQL69VraByUg0uYhHxgZUutMlldXIZLeuKi2hcFF3GZ4LwuLp+PxtllRaVVF4y4n
         Re0WpVaqRspYcQSIjflf4HKFl5PhEeH32BvUsLFseIWfKR9q3L6LPGR0RDIM05sUZ5/y
         P7htrMJnf7V64r8JJtaMiDKtgejZCXoQ3ImQp0kcuOMRFdZvYHbmp4beCBpXU0KbkiU/
         dM9RZ3Ow1Rpcj3kPD82JY7IwFbWNm5nY9jR2xASBQ7ieprqR93Io125qlwLl6Pym77zW
         GpK9mEVb+x0l9nAa1Vbg8+AQ9AIR/Xk6tSE36DDfyhOcJHEdD4w5MUlsmWMWmpE7M1fc
         e/yw==
X-Gm-Message-State: AOAM530LjA9IvYVL8RSTUGPSs8s507qANLoUHAyIFfOOGdnTZt2uvz4n
        SQr9bxW3qf7K+9xxvvu54BZFfV0PkEc=
X-Google-Smtp-Source: ABdhPJx4l0EehM1rEZ47IXfuKiKM5WWGqegu27ORtLU5r4xWQ+c7AT/esVZlVSkdllD2/2LHIQ+TVQ==
X-Received: by 2002:adf:c381:: with SMTP id p1mr21107845wrf.64.1630248706392;
        Sun, 29 Aug 2021 07:51:46 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id p13sm12605816wro.8.2021.08.29.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 07:51:45 -0700 (PDT)
Message-ID: <612b9f01.1c69fb81.5b6b6.e230@mx.google.com>
Date:   Sun, 29 Aug 2021 22:51:41 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to ea1962cc9eaa
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9NSfXeeqQ56Q"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--9NSfXeeqQ56Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're 4 new tests and 2 bug fixes. Two of the four
new tests fail on btrfs with v5.15-rc7 kernel:

- btrfs/246: the fix has been merged but not in Linus tree yet
- generic/647: test hangs on btrfs, looks like a bug in btrfs, you may want to
  skip it for now in your automatic test runs

Thanks,
Eryu

The new head of the master branch is commit:

ea1962cc9eaa btrfs: make sure btrfs can create compressed inline extent

New commits:

Andreas Gruenbacher (1):
      [d3cbdabffc4c] generic: Test page faults during read and write

Darrick J. Wong (1):
      [90199d806150] idmap: override btrfs_ioctl_vol_args_v2 if system header doesn't have subvolid

Luis Chamberlain (1):
      [0e4dd8b9d2c8] common/rc: fix ignoring of errors on

Murphy Zhou (1):
      [bdaa90aae7fc] generic: check log recovery with readonly mount

Qu Wenruo (1):
      [ea1962cc9eaa] btrfs: make sure btrfs can create compressed inline extent

Theodore Ts'o (1):
      [f4660739fedd] ext4: add test to validate the large_dir feature


Code Diffstat:

 .gitignore                            |   1 +
 common/rc                             |   4 +-
 configure.ac                          |   2 +-
 src/Makefile                          |   2 +-
 src/dirstress.c                       |   7 +-
 src/idmapped-mounts/idmapped-mounts.c |   6 +-
 src/mmap-rw-fault.c                   | 186 ++++++++++++++++++++++++++++++++++
 tests/btrfs/246                       |  49 +++++++++
 tests/btrfs/246.out                   |   5 +
 tests/ext4/052                        |  71 +++++++++++++
 tests/ext4/052.out                    |   2 +
 tests/generic/646                     |  42 ++++++++
 tests/generic/646.out                 |   2 +
 tests/generic/647                     |  35 +++++++
 tests/generic/647.out                 |   2 +
 15 files changed, 410 insertions(+), 6 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--9NSfXeeqQ56Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmErnosACgkQJlKqKVyP
52M0BQ/8D9d44ZYMohBampjC18KjK0GhF0pZQvinJghbbC1tUfKfV7gEQu/xSX0c
dONsRlz2nRUlx5r1hhgEoE4+zUwqUUH/PF/4jrrejOTR+P//PpilPjaqNIU7B5E5
w87Zcm1e/viBX+JQIIJ+m3jNJU52YOOt/qcYAR3lckd1KB2gLwBBNLYFGaIbNYa5
JH3OmMjcRn7zeOJrcVcY+Nd72hxfSdEF/OoldA6nXHdGtmCz+yMD/7AX9rio6ZBt
HZxEcVXEv64jPSxf24E5CQPVEZQAI+ORyI9H8/eBWrWJTfcdGHcMAJI+4yZRcHCY
C6XOScDfebBnGbFeRC4Clkz27CR5gYNnTSiIPsg/lzmxsGya06B8roDO2ERRLjxK
QIgRno03vP7jqkVr1BOlOiKpBFOG9YMTc+NExmCmUBGPpKYmttj1gIuI2g7ZNBgH
LEPh62gFa+FLhTZEO/YWs7/lsvJjNxoG7/SPHFdQNwsM/oCtixcgQVF+5pnpX2Uc
PvEykXEBz3NuhH8zddFb2rSGT1h/EcTn3c/hUN8rkZKBKpfLZ6RE9mZSqBjyVXg/
MW6YmkwiREynob9yzcMugkq4xTCWR0LhPvPY85MRP+1JGZu7jpQ2PTYXh/LcFQIv
rov7xymxZ8rPPzBjI69CKXJTxwmBPpmQDMoVPsY1+zF+adCi6dQ=
=z34d
-----END PGP SIGNATURE-----

--9NSfXeeqQ56Q--
