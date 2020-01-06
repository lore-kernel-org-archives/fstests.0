Return-Path: <SRS0=Klg3=23=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B34C2D0D1
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 10:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFA6207FD
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 10:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvxMWqK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFKYx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:24:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35582 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFKYw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jan 2020 05:24:52 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so7621546pjc.0
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2020 02:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=JNaokyiNpzLUs4EiWBifI1bPhWCIKOPNu9ojUcWsQpE=;
        b=TvxMWqK8SC8vEfjWD4a0PPzOfSvUsOCTjf4WnMZZjic1Q/85+J88dpoB4ixA3/DL1R
         0YVolWyW54DpYZJcthb8AxL6mk8+ZOgQKg/Zj/j+QdT4vADhGOyYzb0tlMfnFrJEXY40
         udb6g5f4ZNSfmOLdozlhVgcm7hc1W0gbND8mwSL8jc+FUczlhsf4TyIRVZWqXRO1TWTk
         5DpSozc2eMPqc0vVWGkwOx85H1r6HwopWfD1jrb0RkgPThk0lxyyA2KmRqJ/VvLFCQip
         7E8eQ9hkagBo3hGN93EGxEINc+ICCImmLd67hb1VKLJCD/GjyC2E1iQZbnde4zBwoIJD
         g7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=JNaokyiNpzLUs4EiWBifI1bPhWCIKOPNu9ojUcWsQpE=;
        b=MDRttXTNjQHCSh7rjbUjmL5J2idkvysyzpOHkvBIAmnrXiO7UPwaPlUqbM8I5wJEbH
         MJce/eikAgsHHbCjacEKna2hVSSQmRyqO7DKX2ndpH1wnIHnSamlCEFA90uax2GVBdqc
         VOnq84jfjRxqYMaeF/jv6rpUWDeXUNUPjdobB3rFBcQrUOKDvwK1c0u04p2rTbCWcjsp
         qFMKoxBanlo8wxqG+yU6mQfEVYNVUSjgCPJMjwzatXPY/xrsK6oVjlzrXxfHsudFVxjr
         i1+0FK2XvgothDp388nUCsHkowsuFac/jwDSjEQzUuRHOSv9n1ke+GhXSzZZ1O6/cfkU
         0iIA==
X-Gm-Message-State: APjAAAUioqPf68a+nND02P/lmnnc2YmWTCj+k2FAucnNX/4oiJY9nGWO
        bIPrgwFvygWGvTCjZZcKmE2BLHIsEHE=
X-Google-Smtp-Source: APXvYqxguAqDMdtBeVr/tZkVnoaQ/Wf5qDmTr2HOZxKuyaAAQp2r/wv1bfXKR/wQQFNOjJ5xUKyt8Q==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr91183382plo.339.1578306291816;
        Mon, 06 Jan 2020 02:24:51 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id t9sm23463037pjq.11.2020.01.06.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 02:24:51 -0800 (PST)
Message-ID: <5e130af3.1c69fb81.85cfc.0d28@mx.google.com>
Date:   Mon, 06 Jan 2020 18:24:46 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 6458922bb5dc
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0ZzggZ6LV7K1"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--0ZzggZ6LV7K1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the fscrypt improvements
and new tests from Eric Biggers. There're also some new tests for btrfs & xfs,
and some random bug fixes.

The new btrfs test (btrfs/202) currently fails with v5.5-rc5 kernel, the fix is
not upstreamed yet.

There're still some review backlogs in my to-review list, my apology for the
delay!

Thanks,
Eryu

The new head of the master branch is commit:

6458922bb5dc btrfs: regression test for subvol deletion after rename

New commits:

Darrick J. Wong (2):
      [29e2be05501f] common/dmerror: always try to resume device
      [c4802d4a53a9] fsx: fix range overlap check

Eric Biggers (5):
      [80bc5f9d790b] fscrypt-crypt-util: create key_and_iv_params structure
      [faf3abfe3f16] fscrypt-crypt-util: add HKDF context constants
      [799d6b506df7] common/encrypt: create named variables for UAPI constants
      [a5d24c8bdf94] common/encrypt: support verifying ciphertext of IV_INO_LBLK_64 policies
      [0335928b8c93] generic: verify ciphertext of IV_INO_LBLK_64 encryption policies

Eric Sandeen (1):
      [7b3ddeec674e] fstests: verify that xfs_growfs can operate on mounted device node

J. Bruce Fields (1):
      [dda94e8088a7] generic/529: use an ACL that doesn't confuse NFS

Johannes Thumshirn (1):
      [6a31c46b1a44] btrfs/139: require 2GB scratch dev

Josef Bacik (1):
      [6458922bb5dc] btrfs: regression test for subvol deletion after rename

Qu Wenruo (1):
      [996e2632443d] btrfs/14[01]: Use proper helper to get both devid and physical for corruption

Yang Xu (2):
      [c09db96d31f2] generic/386: fill missing brackets in awk
      [64954c0ead68] generic/590: skip test if kernel doesn't support realtime


Code Diffstat:

 common/dmerror           |  21 +++++--
 common/encrypt           | 126 ++++++++++++++++++++++++++++++---------
 ltp/fsx.c                |  14 ++++-
 src/fscrypt-crypt-util.c | 151 ++++++++++++++++++++++++++++++++++-------------
 src/t_attr_corruption.c  |   2 +-
 tests/btrfs/139          |   3 +-
 tests/btrfs/140          |  34 ++++++++---
 tests/btrfs/140.out      |   2 -
 tests/btrfs/141          |  35 ++++++++---
 tests/btrfs/141.out      |   2 -
 tests/btrfs/202          |  57 ++++++++++++++++++
 tests/btrfs/202.out      |   4 ++
 tests/btrfs/group        |   1 +
 tests/generic/386        |   2 +-
 tests/generic/590        |   8 ++-
 tests/generic/592        |  43 ++++++++++++++
 tests/generic/592.out    |   6 ++
 tests/generic/group      |   1 +
 tests/xfs/149            | 101 +++++++++++++++++++++++++++++++
 tests/xfs/149.out        |  16 +++++
 tests/xfs/group          |   1 +
 21 files changed, 531 insertions(+), 99 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--0ZzggZ6LV7K1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl4TCnAACgkQJlKqKVyP
52Px1Q//ZhMHEh/9tmc013lMcVIAVBOrEojKd9ApEVaJqtEHEKwqnopnk0XTtBmV
4K3pr3sns9bF3bhtLjeFYXCLd2aZWBsoowfw1sVLxnBoqsip2OhQhrKiBzcbp8ey
OxBxD6VsSEhxH6i/E9DMkdLs905gXMCWS0itMyZvqw3CW8Nj4mJkEsRKpDix/WTP
ItQ+r64zae0UCgwpToyMVswVZLucwibNAe6xlPlGJFOqp7TRDte7MMt8EG5h9CLl
SDVzKo8kduiqDtsgT+Ia18/r+AX0vqyeN0sEUkd93JuTOcpWBq28TTHV3ivZIt7k
zEOwdwo+IHvI06j62ucTbFghlomeyMolGIOjB7xRvJK9LEhf3DTXXtjm5EnTqDGe
sBPmwLXfoLbhVEKLLO3GDbw5nMwpejs9qLUjLGGj936atH+eXquYJYVllbxmZeK8
fiMfMq8ZHWbte2/HjUYtSvFIKe3IjUFZSXxe+9xnpF+tWfc3d3I9N2d8OAhOo9UF
98ZOh2qEdjIYZYfGDoqPyxmRPW/mnzD0sfvHQvMXvjI/1Ot9eS0issCsSbBtl0uD
wrWFTRdb2ABG3y7eGFpqYFGyHNNvTsGoMOt6dJsFcJ5kfh1HZ+7m+lBo69J7BiNH
0LzvCh+4SMugQxJQjjsWuzZLoHM+rG7NSSB+wJ1HgCQxdicRM8Y=
=W9Sn
-----END PGP SIGNATURE-----

--0ZzggZ6LV7K1--
