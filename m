Return-Path: <SRS0=7tTV=ZC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E8C43331
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Nov 2019 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C16206BB
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Nov 2019 16:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ5DHYVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKJQvy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Nov 2019 11:51:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45989 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfKJQvy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Nov 2019 11:51:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so7617045pga.12
        for <fstests@vger.kernel.org>; Sun, 10 Nov 2019 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=1RoOs8XQFgdHOnEtT79h0OYDv6e2ANC7/kx67v9q5QA=;
        b=VJ5DHYVb8yIPFc8XSeQubjhVRfqz9StjEGr3svTxkXLPmdgA/uMn2nCPLwTnSrjoi2
         +GRM6ticq20Lw20kf5Eq94kdEXqsKstbiEOMPu+aLQ5h8iS++0fRrL6NOR1mzntsK5Qm
         gY3mUsZwCOEUawMx5JgHtEcFzLKvQiapbKvr5BvR0TR3YxBwOAiuQfJIO1nIDK5nRh4A
         eiLrWmxkIJyOUW6R9anieMx+zCgXf2PKf+ro2LKMc0BqbKW7cvkM81SFpkltggKFYQ8W
         I5D3quppl5XR3EDHSgbKngpmWoydV1pmUlzYC3iNs7iIlZ0pU6u/S/6EC3tPEfU38Vyl
         vVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=1RoOs8XQFgdHOnEtT79h0OYDv6e2ANC7/kx67v9q5QA=;
        b=UxZzFyMtA9Hri8d00j4RDxoKn/SL5DKuMfryOcBWNw5FgbJbwieWWfLIerHEE8+SQM
         5sPCm8EiZWaeqeNOpQw7w2UqtsO8tEAfybSNmk4ej36MmFYIUA436ckvqxApjSkBFeJF
         1wMJ3VxzT72TPYB2Ra3YbJ1hCTXYc7seE9L67kEiwdziINjKUkGX2Ftk+VYWfnnDiWaN
         lVNvZoJuEiO5utqiRBuF18yM+KnOWFxX1OGfeph1w8GM1jt8o+Be69xDOWBEkl/YKPA8
         tNVRyxOTrNWk1/2GW0WQMOpsc9fSFqBlhXHPzwIliVt9aINfEuVK0oM/QnQG4dyGHady
         ulyw==
X-Gm-Message-State: APjAAAUY4qZpU9ymYoAQiqszozg9TWh8XktWC8mWYbu8q0oQTJDpp3DQ
        h6Nvz2FNDhSniXJCAACKqwjfNlxP
X-Google-Smtp-Source: APXvYqwaZXTiy8Dp61bJFaV6TYVHsBec6qVku6Sda6l1cXt3LIgTM5aysq76KI28cwoFr8ylGMlV1A==
X-Received: by 2002:aa7:8d93:: with SMTP id i19mr23844459pfr.26.1573404713178;
        Sun, 10 Nov 2019 08:51:53 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id c184sm15227524pfc.159.2019.11.10.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 08:51:52 -0800 (PST)
Message-ID: <5dc84028.1c69fb81.65ad3.94b5@mx.google.com>
Date:   Mon, 11 Nov 2019 00:51:46 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to e07c7b16a4f9
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lh9AU4QTzgON"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--lh9AU4QTzgON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're new tests added for xfs and btrfs, and some
quota tests are fixed to work well with ext2 and ext4 (nojournal mode).

The new failures introduced are btrfs/200 and xfs/148, they both fail with
v5.4-rc6 kernel currently.

Thanks,
Eryu

The new head of the master branch is commit:

e07c7b16a4f9 generic/235: Fix false failure on ext2

New commits:

Chengguang Xu (1):
      [8947e7cacf2e] overlay/066: adjust test file size && add more test patterns

Darrick J. Wong (1):
      [fcfa7d242f3d] xfs: make sure the kernel and repair tools catch bad names

Eric Sandeen (1):
      [edeef98d4f42] xfs/207: explicitly test for xflag character

Filipe Manana (3):
      [e1670cce6af9] common: open files in ro mode for extent and hole count helpers
      [6fb111ab6089] common: add helper to count number of exclusive extents in a file
      [cb836732356c] btrfs: test that send can issue clone operations within the same file

Jan Kara (4):
      [6ad9168b0ad6] common/quota: Fix _qmount_options
      [2814810ed1a0] generic/050: Fix test failure for filesystems without journal
      [777e98ec577c] generic/382: Make test independent of fs allocation
      [e07c7b16a4f9] generic/235: Fix false failure on ext2

kaixuxia (1):
      [8d8b993f7925] fsstress: show the real file id and parid in rmdir() and unlink()


Code Diffstat:

 .gitignore                                 |   1 +
 common/quota                               |   4 +-
 common/rc                                  |  47 ++++++++--
 ltp/fsstress.c                             |  18 +++-
 tests/btrfs/200                            | 122 +++++++++++++++++++++++++
 tests/btrfs/200.out                        |  17 ++++
 tests/btrfs/group                          |   1 +
 tests/generic/050                          |   8 ++
 tests/generic/050.cfg                      |   1 +
 tests/generic/{050.out => 050.out.default} |   0
 tests/generic/050.out.nojournal            |  22 +++++
 tests/generic/235                          |   5 +-
 tests/generic/235.out                      |   4 +-
 tests/generic/382                          |   5 --
 tests/generic/382.out                      |  12 ---
 tests/overlay/066                          | 120 +++++++++++++++++--------
 tests/xfs/148                              | 137 +++++++++++++++++++++++++++++
 tests/xfs/148.out                          |  50 +++++++++++
 tests/xfs/207                              |  13 ++-
 tests/xfs/207.out                          |   4 +-
 tests/xfs/group                            |   1 +
 21 files changed, 515 insertions(+), 77 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--lh9AU4QTzgON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl3IP80ACgkQJlKqKVyP
52PMqhAAlzR5/PzB9cvquw2TQ+4bH60O755TbGzdq29Ncu+EWDwmjuiiPM5hNdNh
uqCrHyVpILJuWS2oCKPZDapRz7BWJqJYKaILb6xV1/r1e5vauRyIyf2UqAoCtuMl
jDCaL3Ik0UplTfW3JOmkEa560OvFJCiBJYDkotB8VMI76C9LcTh8r0chGomWcHVc
27oA9M0ZCsHtnEB3j7tpg0CsUwOqc6F9Wi68DwrS3ZMBJfFNGcm9l6r2yMUXjCAQ
d5JIAgpx23U7LJYWtDR1rZ5Zl6FYCLWIwl9VuOtDE7o7YrmnHteW7yS1NPZR/hs9
6lX5kIqO0kesdEwy5VquCvGmxi+tq+AhkM8YR1Rp3znizOQqjvu2FL+EYP5wTdIp
BIqblNG6ClvdeqnNtdC06ul195lzY/gYqck+f7l9N34QFeSQgqiXUE1oxEUPNoqa
BaUE+/ly53TyrjO2dsQcoED7CCqV/vbxtrrFn5404YAr+YHbpHw0eg1/2BEJUoot
KEGSlThC9BCIisxl2NnEHYrtCiQOYYbcHmg1PN+AT9+yRTH9rmiwcSmdwREhfcuV
XMa3Yp8llkZXzGws/b+YEr3zLD/5RTmCGSLYGc2UeQehDyoRm7g711Rms74y1ty7
b+/ut1uMAnwGfF7xHCznhi1isHAlILYEjlxliROd7x2LSVysWiU=
=0+SE
-----END PGP SIGNATURE-----

--lh9AU4QTzgON--
