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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62623C4338F
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Jul 2021 16:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4551560F37
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Jul 2021 16:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhGYQEz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Jul 2021 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYQEz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Jul 2021 12:04:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0763BC061757
        for <fstests@vger.kernel.org>; Sun, 25 Jul 2021 09:45:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b9so7235373wrx.12
        for <fstests@vger.kernel.org>; Sun, 25 Jul 2021 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=BWoYgEY5ckuMjB8Li9MAC2SH3EH+SKs8JoySOzxdC8o=;
        b=Hwx18K99BrXBaPz0060WrmRmcwlsbYhnNfIsbbHuNdN2lo0me0PT53NkIY0T2z0hqi
         vmQ1QEEMMtq0AljFB6SYAWgu0Ei0G8zYUAK8ep/CBnfRS6Y/9FQfrCf7kFuD9yXy1VnZ
         LSI1r1jtPJRyv3XQreXy9pkaMMTnuM8QY2BvJsn0h6mhCZwKaHdW6XG9sx0oErzaAMLL
         BHKsEm031CteQ6uYEh2xPZ4EsymdG43L0C1DOHJy7nN3CQRU2X946yD/IoVZce5PULV8
         BsfftnlHsjDtoSzKBEKl1hrlzfybNgaiqFK9dapOw5AJW3EdJ8ebfvBLi9Gz4B6vuvnN
         eVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=BWoYgEY5ckuMjB8Li9MAC2SH3EH+SKs8JoySOzxdC8o=;
        b=Ye6rtkKl2HCV+qMqwIXCJmZbGnCMZukdXzsAIjd/QfEJCD9cML0vcmY4Hbh2galjOo
         Y5Hty0Y6UTn2tItXo2WpgGNO/JemuBIJo+SW91+yW1j+FZEk+X0BaJQdbQBHf+dyWpqO
         qj0pRA5TluntdmTukNxvcj+D4k0tWiHhxHieMN8kE5xVjB1AbgmSIpXdZUHLvMM77Tpz
         sOsuCVE3ZzDAnldRYMq4gvgNUUPeiduCkk8FCSF1pEUonkDuonJrIPdUGS7/rmmQh1kj
         R1rbnHp80ktDYsMmVH2ZhB/6QJqzGtPP6VgLZpA1/xkdzcYaxqFjHpYLZCK7zrDaOkby
         /TeQ==
X-Gm-Message-State: AOAM532rhA2OKVg+Og00rHvkLrSXasyuAd6Xxe7u6LK0s29bxtnocr2A
        sQoV3gcKXyZ2Ouh29E6EbM+3uspZz0M=
X-Google-Smtp-Source: ABdhPJxCK1IqcfpH8n/++/jzsMN4tEC0ZwVGHt7yAODRKw+VEVlHoAbjYzhNhdcLyXXFsKGZIkDNVQ==
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr15256227wri.261.1627231523332;
        Sun, 25 Jul 2021 09:45:23 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id p11sm39847581wrw.53.2021.07.25.09.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 09:45:22 -0700 (PDT)
Message-ID: <60fd9522.1c69fb81.b6491.7d54@mx.google.com>
Date:   Mon, 26 Jul 2021 00:45:19 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to dad0c0a852d1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aEjIQVhVRxop"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--aEjIQVhVRxop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update only contains improvements and minor bug
fixes. The new tests from Darrick J. Wong and the 64k blocksize fixes from
Ritesh Harjani are in my to-review queue.

Thanks,
Eryu

The new head of the master branch is commit:

dad0c0a852d1 overlay/077: check for inconsistent d_ino/st_ino

New commits:

Amir Goldstein (1):
      [dad0c0a852d1] overlay/077: check for inconsistent d_ino/st_ino

Christoph Hellwig (7):
      [6963e2d46129] common/quota: allow removing quota options entirely in _qmount_option
      [eae404046837] xfs/007: unmount after disabling quota
      [4c5df3388944] xfs/106: don't test disabling quota accounting
      [6ba125c9cc98] xfs/220: avoid failure when disabling quota accounting is not supported
      [ea2b89d98a65] xfs/304: don't turn quota accounting off
      [80f5ba2f5485] xfs/305: don't turn quota accounting off
      [395a4d379980] xfs: use $XFS_QUOTA_PROG instead of hardcoding xfs_quota

Darrick J. Wong (3):
      [54319929a08a] new: allow users to specify a new test id
      [e0049e62e37b] generic/561: hide assertions when duperemove is killed
      [8cb89d25518f] xfs/152: avoid failure when quotaoff is not supported

Eric Biggers (4):
      [6ae3a3a5ac74] generic/423: test stx_size of symlink
      [c833b98c64cf] generic: update encryption tests to use term "no-key names"
      [040bee9e47c0] common/encrypt: add helper function for filtering no-key names
      [72167f61778e] common/encrypt: accept '-' character in no-key names

Marcos Paulo de Souza (1):
      [b0f8ace89c79] btrfs: source common/module when requiring module reload


Code Diffstat:

 common/encrypt        | 20 ++++++++++++++++++
 common/quota          |  4 +++-
 new                   | 16 +++++++++++---
 src/t_dir_offset2.c   | 18 ++++++++++------
 tests/btrfs/163       |  1 +
 tests/btrfs/219       |  1 +
 tests/btrfs/225       |  1 +
 tests/btrfs/242       |  1 +
 tests/generic/397     | 12 +++++------
 tests/generic/419     |  6 +++---
 tests/generic/419.out |  2 +-
 tests/generic/421     |  8 +++----
 tests/generic/423     |  4 +++-
 tests/generic/429     | 46 +++++++++++++++++++---------------------
 tests/generic/429.out | 22 +++++++++----------
 tests/generic/561     |  9 ++++++--
 tests/overlay/077     |  5 +++--
 tests/xfs/007         |  7 +++++--
 tests/xfs/052         |  4 ++--
 tests/xfs/106         | 42 ++++++++++++++++++++-----------------
 tests/xfs/106.out     | 58 +++++++++++++++++++++++++++++++++++++++++++--------
 tests/xfs/107         | 18 ++++++++--------
 tests/xfs/108         |  6 +++---
 tests/xfs/152         | 20 +++++++++++-------
 tests/xfs/152.out     |  4 ----
 tests/xfs/220         |  9 ++++++--
 tests/xfs/261         |  4 ++--
 tests/xfs/303         | 14 ++++++-------
 tests/xfs/304         |  6 +++---
 tests/xfs/305         |  2 +-
 30 files changed, 235 insertions(+), 135 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--aEjIQVhVRxop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmD9lOsACgkQJlKqKVyP
52NLXQ/9HSDoiQ3PIY8kHDDitry7oqXEhSsEbFDkXr1GGl0GPHqZLXV/zFkdQEHE
bZu4Y64yJrmof25FhbCU/SCChxp6bmfZll8ZuU6fM+eOo9cAbmN7wMuzaw7r+AHy
Pdx6TJYXP/4o0rzXaz3I1Kkv4CHHoD7Q70KJEeitS8lhUur6RB0a4n9eNP68LOKj
YugAryhjKIjG1xTFLDLYzwuUd4wbiXHNtOTxywdy/mZVg4OaOwzRA8cRExeAttWS
/7j8keyWKAkJGBleBhDyMJhaauKCT5eP49yqAe4A9mD0fuWPqun6ucpdTmUq5/pr
jmHfY+IDhfo3vRmtcBBMyPC6rbMYmjkoS6TtspciZS/RkID47TAY34E4jrkKwvFc
Mo6exNJvY/EhrttZV2fLIUstnYWf4NO+oY7zXzdczPe1Bo9RvB97v5pY/fzzrg3i
mDtI8juUKchoNsU0YVMR1qBXp3EVogFUEk0h1qs+kz7QxHg5AV+vJCPbF3oZ/OnE
pRBwNjcUVwsVlP+U7Gk86jzlozQGSXUT64F7D3j3Xim0hO99i2A2gUB4/9x/h93L
2vZop4dJQhdjzf0RCt7bIw+J7vl8154xTGRgqJ66YM1eWLYMs1kGZpBaRux0uD9r
UmIlSlLcwB2nHx+LA2qMDZdh6eeA42sGYgytD1AzSx7b+2exff4=
=JJAp
-----END PGP SIGNATURE-----

--aEjIQVhVRxop--
