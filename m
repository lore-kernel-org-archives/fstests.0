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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E5C48BDF
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D22610A0
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 16:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhFMQOK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Jun 2021 12:14:10 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53992 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhFMQOK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Jun 2021 12:14:10 -0400
Received: by mail-wm1-f48.google.com with SMTP id b205so5984161wmb.3
        for <fstests@vger.kernel.org>; Sun, 13 Jun 2021 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=yTrOsP7nexCJkLWQTZKf1pUNcye7Bd9F2EIIYf9yM98=;
        b=Zx/bpfRga9R9OH68IWkEUBKADukUCHxeLoophzWANVmDQd1gctCaK20aDNOLjGhBaI
         YctIkPRE4Maov9JWpCeGuksIB7PgAzXZ0D+LLlleZL+xfQz19gbebsUum+Hd3ScNANrP
         ChQJHKzqskXdJnMGYECAvgxEZfs5NgJFqRVWeLtgFwn8kSrLbPzKob4VVz32zrDvZSL6
         uaKEKb2VASB1TG5+qMiCYCdg5ZwOneayg5V/wHzjUkbwYb/79QHi6AgZrDHP3lh+OYD5
         YbUiObrCRwJKaSEPEFO5Vv5QMoK/VIJ4I9M3yF7Za4F0r7BT96eKTUvwQOFfZ5E31lnc
         V5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=yTrOsP7nexCJkLWQTZKf1pUNcye7Bd9F2EIIYf9yM98=;
        b=lxg0FAmfB83/aUwMe/gjYhiKULiyYnU+by+ecrJsg5TuMbiJ1QaOU7lngxbk272k7u
         hOUVzq9ed4WZ8FXwfPG9/c43eco+g38lS7DQrtEYjdt3MoGn/23Z3UUsBSJi1uqjSIz4
         QgG+jn48lRgcPdSHNRAmD7XhbFDj7ESBKMjoX30YXtN/h2v37PVdqN4lxBV5Rom5qpGr
         YGhq2KfSQadGTbOYW+mvD5BlSYybDIRewDYQnUbALus2i+e7vWUB0W9jiG/7+oy7iYN2
         ZPwJZVPY9d8tKgU+2pY7GiBjvRa2P+TuaVwjrYy8qlqybNQeAPLyjdUNxq/Jjup1I21R
         DcFg==
X-Gm-Message-State: AOAM533NUkd/fYEkbzWy3xjSu3Mhii/3A2SbvyzPijbCBcTM8I8WzV5T
        GwfN5rxQ3bCuMKltaSGaPMvdWj7f2J0=
X-Google-Smtp-Source: ABdhPJxM5P2R9H7RYhPtqjUNg0nb2BEYgPYfv6TekhulQ1ANRZ2CwQEb1j98huHe3GWHcuYPMfeZnw==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr12406868wml.88.1623600656329;
        Sun, 13 Jun 2021 09:10:56 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id l31sm10955557wms.31.2021.06.13.09.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 09:10:55 -0700 (PDT)
Message-ID: <60c62e0f.1c69fb81.8713f.29bf@mx.google.com>
Date:   Mon, 14 Jun 2021 00:10:51 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 1c8b154ab966
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="q9JZYnTrvAuJ"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--q9JZYnTrvAuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. _scratch_mkfs_blocksized() supports btrfs now, and only
the sector sizes listed in /sys/fs/btrfs/features/supported_sectorsizes. Also
there're two new tests, and btrfs/241 currently fails with latest v5.13-rc5
kernel.

Thanks,
Eryu

The new head of the master branch is commit:

1c8b154ab966 btrfs: test incremental send swapping location of a directory with a file

New commits:

Amir Goldstein (2):
      [a31c9b8d6a30] generic/507: support more filesystems
      [2ac31add10af] overlay/075: add test coverage for clearing immutable/append-only flags

Anand Jain (2):
      [559ac446066b] btrfs: support other sectorsizes in _scratch_mkfs_blocksized
      [811fa6247811] common/rc: fix _scratch_mkfs_blocksized indentation

Filipe Manana (1):
      [1c8b154ab966] btrfs: test incremental send swapping location of a directory with a file

Leah Rumancik (2):
      [9ff5f0ccac24] ext4/048: add check for od endian flag
      [66734233e510] ext4: test journal checkpoint ioctl


Code Diffstat:

 .gitignore               |   1 +
 common/rc                |  67 +++++++++++++--------
 src/Makefile             |   2 +-
 src/checkpoint_journal.c |  97 +++++++++++++++++++++++++++++++
 tests/btrfs/241          | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/241.out      |   6 ++
 tests/btrfs/group        |   1 +
 tests/ext4/048           |  13 ++++-
 tests/ext4/050           | 115 ++++++++++++++++++++++++++++++++++++
 tests/ext4/050.out       |   2 +
 tests/ext4/group         |   1 +
 tests/generic/507        |  13 +++--
 tests/overlay/075        |  11 ++++
 13 files changed, 444 insertions(+), 33 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--q9JZYnTrvAuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmDGLdkACgkQJlKqKVyP
52O4BA//UuOw7jzCGGmCNw/fJPmfQzUv37vB1rBqn0G5iRRgz+bS6+61O9CeKiJj
EBbL8j/PmXcxUjwF4eL1NXlQbbTA9b49zJDTkczH/CBr+WV4SZXLqjK+oIuGXk6O
fQpVzNTDqZ1HwLi2JY9TETD2S42Z6g1S+nt0hs3ZdMHXJ1zycTui57PmbyeAfxZj
niJJO9+VQlFUJnJcOjtNkO9Txj8VZMtvM7fmr+Gzn9QyHb2rvO+eaBPck3ajMsw0
2Vj1PPhFQStvu+FbFzoWI+zumGOtPfg781AU12WVJan2O8s+BF+zfZdfjrINVPnF
RT8ablVUDUf2RpwY2DYSRqGmwaXNRET16qe8SgJ6m8nRCQvuoMc885pvlRhFVqDf
qg0tfvKb+hK49wD6s455tr99ESTaVHbnegw6a5QJ8I3WGZIMcBRNVZY+kTtiUxun
8hXTTAyqNqHRdum8S8EVK3Y8NsaK7N49Yubl1sy7+0Ev62YtOiLTeWR4pvLvZJ5O
Dvk6uI2kFart8zPxNLI4oiRPwjL9kqmUJVqdIz6xZkExNMqwmvbJfDfnVZTqXPCv
zDd4BnwuHRvzF6EnTa7HcDd7rT/PRpj6l5tfDznlP+PKVMwh2kP/2vlqjkqTb8wt
qTLpMtD93JDS7peKJfMqjpuEOcJTeH1YCmOjtOkxW3ge44q0LXM=
=CI62
-----END PGP SIGNATURE-----

--q9JZYnTrvAuJ--
