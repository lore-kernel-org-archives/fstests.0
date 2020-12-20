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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C17C4361B
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Dec 2020 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A08923A5E
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Dec 2020 16:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgLTQ5D (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Dec 2020 11:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgLTQ5D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Dec 2020 11:57:03 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51AC061285
        for <fstests@vger.kernel.org>; Sun, 20 Dec 2020 08:56:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id i7so4881368pgc.8
        for <fstests@vger.kernel.org>; Sun, 20 Dec 2020 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=J8xLr1bkfiiFouN0ne3Yj7tO9JOnV4bmC8uNgc58r90=;
        b=lLlypGibfBEqvUhunxKeuJ4Zay3ZpqRHrSSqjTPWLD0Ad4FCWq5vyQ6OG2jF8IN6ng
         xir9OeVfderquMVhGoKYMQQWUkM0wjD7F+MDuzOj9UBhj2VF0qrPkfCSfNMmqb0Y3VDQ
         D1bkrUBqbgvOwfuC38gYcXv+2ljbKemY4voYPnuT4wQcvf9lgSQXZJtlrTX1WTB1/FUz
         Qy3y3Dl1ErrQ0QVLHAJHBHM2SQVAFVrinCiEHlDpJJp3yGTFCkVSg2/d79tl/BUvv0xc
         5jI6tTvnIpeDnlvY54OZgoTZtN7bRUcilndAlkfHsU3J+qmGUATp9f57KK1kutF7diG0
         +jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=J8xLr1bkfiiFouN0ne3Yj7tO9JOnV4bmC8uNgc58r90=;
        b=UQBGKjgNAti7ujCiXhrmPYLAVmN77VxX4OC4hiD9lKf0SsG3TbeIwcnecm0zGGGanB
         qSm4M424cOg+hBmKFfT3GzXl8fftCaGSDjaTGPeDX8CMZbnumqc6uIXp6hb8PoOl9X/B
         WutRFU5X3/3jQI0izGJ81naai6Nh+M8p0Gl4nB+f+1rb1rC50gUeqHVD0n3Q2m4ODoMJ
         YSqx+LxLr6ZmEK+AjTogF0b4NC5E2588shkqjbl7mcA0zmNeW8YzPl3Ay6vSTC1XcalY
         nXnwKq5Z9+QyO6hrGEFxN7Erdoc439/Ft3ucjrJNsBXVUX33GDjS3f5+bj3fpUn8cWlu
         tW6g==
X-Gm-Message-State: AOAM530OMNndXll6YdAFezxXR0+L+zRqjiL8p5CwgpxpDQpqRo1e3xwd
        xTHKhfWf5vUEGlb6xJCK/Z8tuWo/whE=
X-Google-Smtp-Source: ABdhPJxA/XDHawtjD2uZTMl11/wQPtkzw6E+Idrisq6BnLWiGSWdHDDsC4GwpL9whU/yJouVELPkGg==
X-Received: by 2002:a63:804a:: with SMTP id j71mr11959838pgd.307.1608483362670;
        Sun, 20 Dec 2020 08:56:02 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id z28sm14449664pfr.140.2020.12.20.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 08:56:01 -0800 (PST)
Message-ID: <5fdf8221.1c69fb81.8c656.9b9d@mx.google.com>
Date:   Mon, 21 Dec 2020 00:55:57 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 0ad1c034838d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Ov3GuAHhHW1A"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--Ov3GuAHhHW1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. As usual, this update contains some new tests and
various bug fixes and improvements.

New btrfs tests btrfs/154 and btrfs/227 all currently fail with latest kernel.
And xfs/513 has been updated to catch a xfs bug, but it should pass with latest
kenrel.

Also, unionmount tests has been improved to run with custom overlay mount
options by assigning $OVERLAY_MOUNT_OPTIONS to UNIONMOUNT_MNTOPTIONS. You need
to update your local unionmount tests to latest to contain commit 95be14e
("Allow user provided options with or without -o")

Thanks,
Eryu

The new head of the master branch is commit:

0ad1c034838d overlay: run unionmount tests with custom overlay mount options

New commits:

Amir Goldstein (1):
      [0ad1c034838d] overlay: run unionmount tests with custom overlay mount options

Brian Foster (1):
      [62cf7ce77f4f] generic/563: use a loop device to avoid partition incompatibility

Eric Biggers (1):
      [a225507009a3] generic: test for creating duplicate filenames in encrypted dir

Feiyu Zhu (1):
      [0c5013c565b7] src/t_enospc.c: Fix an error for the loop initialization declaration

Filipe Manana (1):
      [eabfcdfe9084] btrfs: test incremental send after removing a directory and all its files

Kaixu Xia (1):
      [c2dd12732f31] xfs/513: fix the regression caused by mount option uqnoenforce

Nikolay Borisov (1):
      [2a7406efecc2] btrfs: Update btrfs/215

Ritesh Harjani (1):
      [72dc169b442e] generic: Add test to check for mounting a huge sparse dm device

Su Yue (1):
      [a633d252e3c4] shared/032: add options for jffs2

Xiao Yang (1):
      [90d76997831e] src/multi_open_unlink: Stop using attr_set

ethanwu (1):
      [9f0744b16961] btrfs: test if rename handles dir item collision correctly


Code Diffstat:

 common/overlay                  |   8 ++
 common/rc                       |  31 ++++++++
 src/Makefile                    |   2 +-
 src/btrfs_crc32c_forged_name.py |  91 ++++++++++++++++++++++
 src/multi_open_unlink.c         |   8 +-
 src/t_enospc.c                  |   8 +-
 tests/btrfs/154                 |  64 ++++++++++++++++
 tests/btrfs/154.out             |   2 +
 tests/btrfs/215                 |  14 ++--
 tests/btrfs/227                 | 122 +++++++++++++++++++++++++++++
 tests/btrfs/227.out             |   6 ++
 tests/btrfs/group               |   2 +
 tests/generic/563               |  23 ++++--
 tests/generic/620               |  62 +++++++++++++++
 tests/generic/620.out           |   3 +
 tests/generic/621               | 166 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/621.out           |  21 +++++
 tests/generic/group             |   2 +
 tests/shared/032                |   5 ++
 tests/xfs/513                   |   4 +-
 tests/xfs/513.out               |   4 +-
 21 files changed, 621 insertions(+), 27 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Ov3GuAHhHW1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl/fgdoACgkQJlKqKVyP
52N/Hg//X7519XmAJuDRAp7dgRvoF2u/dpI9XoYoA9BXjxDPNc1o5002vFtjFNe1
xM7ZeMPvADzc6mK7ZaC7jZ3q+RD0+gDDJCRUB/Co8EofM797SjGFnK5Uz+XL1uWw
6nixUaLPzrj39+KnIECyQAGl0lxJS+rzOxIpUIVJUYgqCI4NVvFS8yP/bE6rTup1
9OdmFIg1Ueam3oXwwErgjEkXVFNMWn8152Umk5XINFUDK7OBmCpimIacmOuifca+
NAJgyXCHASNMAEw1meqiUXSwne2hSZ7FNISpXeehCgdHYPB3CZhXQ0X4njsSPLH+
JGRCAytIr3kIhVw3mRDFCzYqBhd+9998A7+RxDJjjWxM5LMxEmm3Ri3TfYBYbzfg
BsteJak8YhbqZzVW0FrFQTVVKJISbOayU47vPDq/gvU1gfcbVuylJWrOY1DhnoaI
NoxFX7hHvaeokWCi6f2ciCfIToWIc0i0zx2FUoa1bfEgvvhG7zzsU8GqRAE4wyRK
g6XAgAap/AM40vqJ8BzTIRe2++SsXR0Zyu65k6BQ+ojiQuNVDy9MxEWUwAAoSvzh
ZOM4ZelJocP10Gkn3CceRnQ7jzv5u8sWsJBeoWqQm0rm2gD6HyyQUo80Ebcgkm6E
4nEL+62JsmtWJiivIdvYd9lLNNB1S1aeFDeMg2mxa0oiMoPNNpI=
=metW
-----END PGP SIGNATURE-----

--Ov3GuAHhHW1A--
