Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B274AC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Jan 2022 15:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiAWPM1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Jan 2022 10:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiAWPM0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jan 2022 10:12:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99362C06173B
        for <fstests@vger.kernel.org>; Sun, 23 Jan 2022 07:12:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so1427524wms.3
        for <fstests@vger.kernel.org>; Sun, 23 Jan 2022 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=2YdoUx8eABio4WmzX+TOuPlTXfJjSrNNmfzNFy91goU=;
        b=VagTXrEcGRDAYHYZtcWlg/3e4RIPHhtPHRAwr5Zrbms4BEJz2NUn5gujFoiHeynSED
         FYgouVeLqpvXF7m2sdpHJUS95a3K8ArngOnqIXLFWcOKZo7ZHDcAsWqgs6xkfft3Ylzk
         liaXKTLWYDOfhDy1wluEwl3PRLWQAmA0yq1QAhCabHQGNcefgbxpcoZcxJ/EMJXjtYbb
         0vw/62Sb/+1ySrFf0QAspB8f5qgLUc/JPVyu+R2jJyOp2YPLnKYHe+N0/gnQFUP+Exyo
         0oW2gea/S9H0nRZpVzRXvac+xUfdmZaDmWoyvDxuSUeJM9avrrRB95kylehf9PagpSJR
         USaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=2YdoUx8eABio4WmzX+TOuPlTXfJjSrNNmfzNFy91goU=;
        b=k4ejioKZiO3w98/xnmpubdAQlYh5Co6/AqW5euSvoj1dG1n3CTMKmIh5GGdNAYXeY/
         OlwiMboF2pdgyu/VD3sx7uEOjKp7STfrY4jcarO8LYu9v6KHoNKVGqj9yZXxuuHGRuTh
         nlPOna8jFC0zdX+EmFsAjZsAoGZysnbdA5aIIK56/PcATNztI6XOAtRcvgkAewKdxSZS
         /NnPJpiTpsaETK5h2+2lSh0XLzgP2NMqMDwHEnmRSROcRbt/CAgykGdBdtFy08ynk9Wz
         ogGncZV5zZZTNbBQZVOuHTJlmJdHoJFHm4Z+bgpVbdiJJOwgA+bZl1CoDjO8nmJDYoZi
         d/qA==
X-Gm-Message-State: AOAM533lSSUqCjuvjwI8T5dKMju672tNSLjHQZfLLnfChHO6LPorVr5p
        2WX5Vg1Sp6H7IZH9eWveQzNhvGquis2PRg==
X-Google-Smtp-Source: ABdhPJznO8pqMVSgoCaufrq/+l21OuIQvxWcD0mS06sA6JdiDjJzwwLHky8Tu5imDTIb5UaunX/aKw==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr8322807wmk.95.1642950744816;
        Sun, 23 Jan 2022 07:12:24 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id v5sm16244578wmh.19.2022.01.23.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 07:12:24 -0800 (PST)
Message-ID: <61ed7058.1c69fb81.972e3.9a94@mx.google.com>
Date:   Sun, 23 Jan 2022 23:12:20 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to d8dee1222ecd
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DEa5KXWZ3KQG"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--DEa5KXWZ3KQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're two new btrfs tests that have been added in
this update, and they both would hang with v5.16 kernel. So you may want to
skip btrfs/25[56] for now. Other commits are normal random fixes and
improvements.

Thanks,
Eryu

The new head of the master branch is commit:

d8dee1222ecd idmapped-mounts: always run generic vfs tests

New commits:

Christian Brauner (2):
      [bd4746b14ae6] idmapped-mounts: add fs_allow_idmap() helper
      [d8dee1222ecd] idmapped-mounts: always run generic vfs tests

Darrick J. Wong (2):
      [11804b17759b] iogen: upgrade to fallocate
      [be9fdf6287a0] xfs/107: fix formatting failures

Filipe Manana (1):
      [5c0235c9565c] btrfs: test that defrag on small files does not hang or crashes

Lukas Czerner (1):
      [b454412847f3] ext4/053: Test remount without changing mount options

Shin'ichiro Kawasaki (1):
      [cf686862d840] btrfs: add test for quota disable in parallel with balance

Yang Xu (1):
      [a3183c6422b5] src/ext4_resize.c: set errno to 0 before the strtoull call


Code Diffstat:

 ltp/iogen.c                           |  34 +++--
 src/ext4_resize.c                     |   1 +
 src/idmapped-mounts/idmapped-mounts.c | 237 ++++++++++++++++++----------------
 tests/btrfs/255                       |  53 ++++++++
 tests/btrfs/255.out                   |   2 +
 tests/btrfs/256                       |  68 ++++++++++
 tests/btrfs/256.out                   |   3 +
 tests/ext4/053                        |  57 +++++++-
 tests/generic/633                     |   1 -
 tests/xfs/107                         |  10 +-
 10 files changed, 339 insertions(+), 127 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--DEa5KXWZ3KQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmHtcBMACgkQJlKqKVyP
52OOoRAAxN/52s8Upg5KtG9r45EHhEH86A8CB2XHeVZstEXikaxArmnz8EqEeLsZ
labIMO/NT4ev9yjtcbqSt1zgJRDhihB8nEkt8XrKdL2I2EX/EG3YK8iSh4S11l0z
NlVUqEDHFKALwxgI4kv84EbziptMthxQ3MZtd4LlJqMkwwhZNZju72bBkFQ3wb07
RfXCQNmRCDhol/xo2QT9uc0o00IfQMTLBIJzwkbT21kcH2G3txvWm48M9C7QXUCE
FOJ4T5uDh/elJCokGKzC+pJMS/NCqWy0+4+3C0DVfCtqbElUsFyFb/KxqH9AYdSp
z9Bsfz3m5D3yDKMvnHnRJwcMk+r8hnVnL/iqhvNUi2FuloKYp+mevR58OjWI7a5j
8KgLCT24X1bYtnOCcFbg53ZBhY2Ia1IlplRy5MYb5tiDV62QVCONUEYNtfIYWo8h
8Bs3IZHtCsZBceEtvPpgtmDUasTm7jvjYeUQcN8HSiUb+/NzYLpVY/AxX6dittFf
0RUXGgmhxp1zoCTk3J2zuJvXedK7BDn8oGdI+jqEq+Dof/1oaJhkAwUceAjI5KLd
8RHnp/y9YlO8z/ny1UoX8vK03Mb/g+hC1I/4YkkqUF85LPC1h7HcD0KV2eGQ0Xlj
iCp4nMUwgyTJqi8HfcQ7e5D+Q1WBXBaWYp4/xgwJr5ZknRFT5No=
=yAYB
-----END PGP SIGNATURE-----

--DEa5KXWZ3KQG--
