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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7034C433C1
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Mar 2021 15:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720F96193A
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Mar 2021 15:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCUPFL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Mar 2021 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCUPEk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Mar 2021 11:04:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC76EC061574
        for <fstests@vger.kernel.org>; Sun, 21 Mar 2021 08:04:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k8so14033245wrc.3
        for <fstests@vger.kernel.org>; Sun, 21 Mar 2021 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=fpKQ/XMp7q0bTBrakjH2LIhYfURY3OMMrGx/bZWNvts=;
        b=CBRGuXd1fqrlkFmnkpt6tyLSlSE7mJXyEw1CEdo4NYxh86jNQtDm3LYgAOWiumu0bg
         RZnYCM3yjlKp3IqYy7zj7v/UA+8/9r098XsWI0HfWDrUqtQnueX4vo5e1qiKxoCnu0mI
         VgQ94xCNovoSAadD2n3UJZy5+EAK8hDebq9N1ulE6HXvC26pVMfy3yrg79AR+6ePqF3w
         FiKmQpQ9NecpehUHNKt0LYRWv2OawTAikNtfxOmDPaPDzU84CDoF6WWdDWlqo9th9YTZ
         lpwCB+dgT94eNwxdwQiUZ2ZHt/9ru0MOHPszNmpuaJ9/Yq8SBVDzuwnduFukln40BGt8
         +NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=fpKQ/XMp7q0bTBrakjH2LIhYfURY3OMMrGx/bZWNvts=;
        b=RTEeNizMIVxpe/YQhsADlQift020xW4wmDrIrtJ/5HSE1d1nJlw32elolbm/IcYzWy
         KkEFaKiKpF0uWHT3Sg5Oc7f8Iz03KGixSeyCicIPmUp+DplMwRvBN6gK5dcH2u33GXEt
         43/zyd91a39Xw+zfgTnauYuckg4nPPVk39Gqgm8y+23/2sU84fPCEVBmkoQPIp2xBhEK
         EpfWEI9n5OI1MY23mfvGTZfcyT+Cw4xl5uN+5QZ4rjtCBbGW/0Hbw9TSwQSO+e9IIoXw
         nKnYdo6V/HiJ4/k1tMVh0eEoYzA2+5CtZ+xIt8dtvo2N1+/x/ywJ3An5DTJFky7E+8fB
         wUCQ==
X-Gm-Message-State: AOAM530hRKbIfsu9UdUfRAj+SoGu9ZqlJZ3GTCKd5kapd0bW0/9LQvrM
        uJwjEHOKDcOpEPN3nJGgZE1FFZzMShV4Iw==
X-Google-Smtp-Source: ABdhPJwKkLb0xn02u2ZY4DRXM0vWWjyk/92qG7WKOzBHWH6IrhJuovgxuuq5/SlATLAPYIVnb/xrkA==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr7435203wrp.231.1616339078087;
        Sun, 21 Mar 2021 08:04:38 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id y205sm16511508wmc.18.2021.03.21.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 08:04:37 -0700 (PDT)
Message-ID: <60576085.1c69fb81.01e8.eedc@mx.google.com>
Date:   Sun, 21 Mar 2021 23:04:32 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to c68a8f59924e
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Ni1Ck6VXocGJ"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--Ni1Ck6VXocGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in xfs inode fork extent count
overflow detection test from Chandan Babu R, also the metadump improvements
from Darrick J. Wong. Many thanks to Allison Henderson for helping review the
patches!

There're also two new tests for btrfs, and btrfs/233 currently fails with
latest Linus tree.

Thanks,
Eryu

The new head of the master branch is commit:

c68a8f59924e xfs: Stress test with bmap_alloc_minlen_extent error tag enabled

New commits:

Chandan Babu R (13):
      [1066be0dd6f2] _check_xfs_filesystem: sync fs before running scrub
      [b0b379e77db7] common/xfs: Add a helper to get an inode fork's extent count
      [c25df583e373] common/xfs: Add helper to obtain fsxattr field value
      [9f8584434b58] xfs: Check for extent overflow when trivally adding a new extent
      [d9d2de11ef48] xfs: Check for extent overflow when growing realtime bitmap/summary inodes
      [9ffcdd4c7810] xfs: Check for extent overflow when punching a hole
      [224a6745873e] xfs: Check for extent overflow when adding/removing xattrs
      [b721a2174344] xfs: Check for extent overflow when adding/removing dir entries
      [490a8d56fba9] xfs: Check for extent overflow when writing to unwritten extent
      [7425ee44da99] xfs: Check for extent overflow when moving extent from cow to data fork
      [3ab311f592f6] xfs: Check for extent overflow when remapping an extent
      [200ee9e93b84] xfs: Check for extent overflow when swapping extents
      [c68a8f59924e] xfs: Stress test with bmap_alloc_minlen_extent error tag enabled

Darrick J. Wong (4):
      [d4811ae1ff90] common: capture metadump output if xfs filesystem check fails
      [45b9734b9816] common: move _scratch_metadump to common/xfs
      [b7860b30cee7] populate: support compressing metadumps
      [9fb30a9500c1] common: capture qcow2 dumps of corrupt ext* filesystems

Filipe Manana (3):
      [40f8dc416af3] btrfs: test delayed subvolume deletion on mount and remount
      [4a2683ce3e6d] btrfs: add test for cases when a dio write has to fallback to a buffered write
      [7c476f1890c5] btrfs/232: fix umount failure due to fsstress still running

Max Reitz (1):
      [8275832d6782] common/rc: virtiofs does not support atime options

Yang Xu (1):
      [3d15d3fe85f9] src/chprojid_fail.c: Fix undefined compile error on old kernel


Code Diffstat:

 README              |   7 ++
 common/config       |   1 +
 common/populate     |  25 ++++++--
 common/rc           |  35 ++++++----
 common/xfs          | 103 +++++++++++++++++++++++++++--
 src/chprojid_fail.c |   1 +
 tests/btrfs/232     |   4 ++
 tests/btrfs/233     | 152 +++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/233.out |   5 ++
 tests/btrfs/234     |  64 ++++++++++++++++++
 tests/btrfs/234.out |  21 ++++++
 tests/btrfs/group   |   2 +
 tests/xfs/129       |   2 +-
 tests/xfs/234       |   2 +-
 tests/xfs/253       |   2 +-
 tests/xfs/284       |   4 +-
 tests/xfs/291       |   2 +-
 tests/xfs/336       |   2 +-
 tests/xfs/432       |   2 +-
 tests/xfs/503       |   8 +--
 tests/xfs/529       | 171 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/529.out   |  20 ++++++
 tests/xfs/530       | 124 +++++++++++++++++++++++++++++++++++
 tests/xfs/530.out   |  11 ++++
 tests/xfs/531       |  83 ++++++++++++++++++++++++
 tests/xfs/531.out   |  19 ++++++
 tests/xfs/532       | 139 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/532.out   |  18 ++++++
 tests/xfs/533       | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/533.out   |  17 +++++
 tests/xfs/534       |  84 ++++++++++++++++++++++++
 tests/xfs/534.out   |  11 ++++
 tests/xfs/535       | 104 ++++++++++++++++++++++++++++++
 tests/xfs/535.out   |  12 ++++
 tests/xfs/536       |  81 +++++++++++++++++++++++
 tests/xfs/536.out   |   8 +++
 tests/xfs/537       | 105 ++++++++++++++++++++++++++++++
 tests/xfs/537.out   |  13 ++++
 tests/xfs/538       |  84 ++++++++++++++++++++++++
 tests/xfs/538.out   |   7 ++
 tests/xfs/group     |  10 +++
 41 files changed, 1712 insertions(+), 35 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Ni1Ck6VXocGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmBXX+UACgkQJlKqKVyP
52MhKw/+PbIB3IhN9YXKPLT+rOjLEDxqHG5SjJDRBzJ0lqgjTHb4p7jJdZfhZeVo
yYEFfui6A2uZUg/uBC2R4/lZB9BXiTm9A/dLCndn57Lz7CgFLAujumax/7ToBiK9
ekYXW98YHD+lR+IXy5WrwSs6Xb4LtRztJ4Ih2kDTaRAFv09XhdWmFbqm4EBijj8w
XjVCAiPtQKYbKDmOrCsA3yJgiq48RG5p4XhtqlK33Oyhujd7zlYHeY9/C3SrPskS
GvQfIPvRfIzhtXZkvT9J/fhm1PIQ+yshE+IAIE4AJVZDONB34FVpJ9xEEjXFmhPl
cuOT4B37QjL4reNDINoblJRZ4KbQG1ssbzWEw0phlpSc4eZ4mRcW03NkU6+9ygXx
EMuRsn7TPNZwR2MqLwp3LPfhbngckXRcAm9YGn0fE8bQN1faKoUUbUHWvbuv4EsJ
tgWyYriY4HOGdbu3KKfJEfpCD8kGFM7YXjAR52CsCcG5goyY7PYBLFoNkrDk4uQV
a5/UZ4Uh36X6q/xKxY+LKxlGZ4OQ8J971oUTkG1JualLPZmxngVBz23M+eFCIbKU
MggLtpvizY15XSqwKz8R+/IOx2lKcWbknFAp6OQZ6GuL3oP8YSCvYPSzrc0EFBwz
zc1y9V5DlNF+hZxoGPJWQ82v+tdwtnmQ6y6haLtUXhMdRGNdVtw=
=Q+s0
-----END PGP SIGNATURE-----

--Ni1Ck6VXocGJ--
