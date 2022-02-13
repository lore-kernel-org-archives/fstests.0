Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE2C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Feb 2022 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiBMRuu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Feb 2022 12:50:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiBMRuu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Feb 2022 12:50:50 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4075A0AE
        for <fstests@vger.kernel.org>; Sun, 13 Feb 2022 09:50:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v129so8378425wme.2
        for <fstests@vger.kernel.org>; Sun, 13 Feb 2022 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=z6jwv/Zo5Tz+dkqUrzQLPYhkLu/AVfHAqx/6Is7LrOY=;
        b=OwGb0BZhRchZqP+M8HGHgEPP0cD34AuBFV4R/IFS2rlC0MPy8VsqYzadw3tU/oPYPN
         hPfgHxxfZ/4z0HEE/VnIyZU1Qsz5W9Qre04skWkhu7Q8Da94kh4i5rB+EzmKDJx8aF2l
         q7r9vKhbk49skEHBpm60gBG0WRs9kRiHJaJoBeS/FvMz5KYzd+vPLJ+5gOBpN9kVuqH3
         54BYKPGKfN8hgznSnfjItbX716qMvnqTBrxBjNQZbJTFO8OS7X/io1nGUol1eRXyJCC3
         culzS/2PoKyxr7lG99cLS1h3tLpcWTYpQ4mo5gl/54CbyiT9CaTOjQ5rJMP/Mzy1/aiA
         WNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=z6jwv/Zo5Tz+dkqUrzQLPYhkLu/AVfHAqx/6Is7LrOY=;
        b=0OMBsEUuAyjPAmKw8SmsFCzgGR0WB1GetRLWBNDdZurRcZXRrV/nPMMPqfbs26BD1h
         QhhiMa+NEEeTNfCGiynn0pkIaO2S37qoV9jf0fRb9Tnw9AZDhRe0r4S1EaO7ppqME/OT
         ozEXo6h3uGONUubJ831RPPuJpbVqJsz8UeEirz2cusOBkprnDut7PSzV8VtZ0I53VmWJ
         xLCJkABr0he9AVO+ZOvdDRTfSwXjc9F6BtrWP1BMZTT0R2Di+nk5Dv5XJ9ZNJqRSZ3Ha
         pLUVWG6D3VlX2/02HYpRCT3Owqrsv/8v2jmCO2uXJ04wbNWgT5vrJ7CdYkgnBsOMDWfz
         SUyw==
X-Gm-Message-State: AOAM530RlDi5To7gISXeY1RCHwQUtYU9GzNpOaU8dakVT2PyO3+JS2ts
        qBrSL8CXmxrPPNxe6jK5p6Bh1EgKH5I=
X-Google-Smtp-Source: ABdhPJzDiL/Q6cLiadLbbnh0w9OwcXCYTPMxyE+o4ijUJdy1U9euArEgaSGTJLYVSfn9a3/yXsaSmg==
X-Received: by 2002:a1c:7712:: with SMTP id t18mr8067306wmi.145.1644774642109;
        Sun, 13 Feb 2022 09:50:42 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id i6sm29907370wry.33.2022.02.13.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:50:41 -0800 (PST)
Message-ID: <620944f1.1c69fb81.bad98.c790@mx.google.com>
Date:   Mon, 14 Feb 2022 01:50:37 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to b91862aa4c95
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t510VFY6gWB8"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--t510VFY6gWB8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're 7 new tests added in this update, including 4
btrfs tests and and 3 generic tests. The rest commits are normal bug fixes.

And currently three of the new tests fail with btrfs with latest v5.17-rc3
kernel, generic/673 may expose a new bug in btrfs, and the fixes for
btrfs/25[79] are proposed & pending.

Due to the Lunar New Year holidy, I've accumulated a pile of review backlogs. I
think I've picked up all patches from January and a small part of patches from
February that have been reviewed.

So please resend if I missed any patche from Jan., and be patient if you sent
patches in this month :)

Thanks,
Eryu

The new head of the master branch is commit:

b91862aa4c95 btrfs: verify "btrfs filesystem defragment -c" behavior

New commits:

Anthony Iliopoulos (2):
      [6bd65c707208] common/rc: fix group detection regex to strictly match required name
      [9017f3b63b50] common/dump: add explicit requirement for specific users and groups

Darrick J. Wong (3):
      [67f35c96a2d1] generic/273: use _get_file_block_size
      [705d9aff1d28] generic: test suid/sgid behavior with reflink and dedupe
      [290e6c83e8d8] fstests: skip tests that require XFS_IOC_ALLOCSP

Dave Chinner (1):
      [a245d8b81584] fstests: add more tests to the metadump group

Lukas Czerner (1):
      [394c20991779] common/rc: set maximum label length for ext4

Qu Wenruo (4):
      [d8639e1632ab] btrfs: defrag with regular and preallocated extents
      [8925b0290ffe] btrfs: autodefrag with regular and hole extents
      [bf49b2cde6d6] btrfs: defrag with compressed extents
      [b91862aa4c95] btrfs: verify "btrfs filesystem defragment -c" behavior

Theodore Ts'o (1):
      [ccbbd09981c7] common: handle old versions of modprobe which don't support --help

Zorro Lang (1):
      [cd99a4999bfb] fsx: disable allocsp_calls if -F is specified


Code Diffstat:

 common/btrfs          |  16 +++++
 common/config         |   2 +-
 common/dump           |   5 ++
 common/rc             |  27 ++++++++-
 ltp/fsstress.c        |   4 ++
 ltp/fsx.c             |   1 +
 tests/btrfs/257       |  76 ++++++++++++++++++++++++
 tests/btrfs/257.out   |   2 +
 tests/btrfs/258       |  80 +++++++++++++++++++++++++
 tests/btrfs/258.out   |   2 +
 tests/btrfs/259       |  57 ++++++++++++++++++
 tests/btrfs/259.out   |   2 +
 tests/btrfs/260       | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/260.out   |   2 +
 tests/generic/273     |   4 +-
 tests/generic/673     | 107 ++++++++++++++++++++++++++++++++++
 tests/generic/673.out |  49 ++++++++++++++++
 tests/generic/674     | 117 +++++++++++++++++++++++++++++++++++++
 tests/generic/674.out |  49 ++++++++++++++++
 tests/generic/675     |  70 ++++++++++++++++++++++
 tests/generic/675.out |  13 +++++
 tests/xfs/107         |   1 +
 tests/xfs/129         |   2 +-
 tests/xfs/234         |   2 +-
 tests/xfs/253         |   2 +-
 tests/xfs/284         |   2 +-
 tests/xfs/291         |   2 +-
 tests/xfs/336         |   2 +-
 tests/xfs/432         |   2 +-
 29 files changed, 845 insertions(+), 13 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--t510VFY6gWB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmIJRMAACgkQJlKqKVyP
52Mh4RAAwaAcpDuEFOEKmexyfEWLDgjKkvCHvlwe31r5beLkjpTXQreVoUzvBUVh
pOtbYc72lRkInU8vbDXbYk9V79+t4zxeRTDw8Ka/KT/mzMcKXtcCce2eUuvEq1vk
UGvIiSrnZ0fVXTR69MoFLC59RUTzhyXFQLaVUP2htIqqXckJNh6KVCp0zCW7FPsd
5Lb8BTpFssUmQiWYfjePHWK0rKaxTpaQtS5Xgm6O/Yp0Pqcdnv0GwXUekZqCGoCp
+2Vfvg7udCt39nJGDlF4+7sFUMyHDhDf4w+IWl9URFQlqrN1BHTKM59bI9pjsQ2G
LIGsX2FayF2knbzR6NUdTGxsIFDIGx0sLHivD4bn+AyMW11HyGOOA/3/gFNiRYyL
mI4SBlxPQE4KnsIS6vOUEtDn/vCkAV2doG9VfKaHhGWfYyU67t6UAJhSvudVdkEm
2zemEqsX+JIZ4EbI7TreErmTCILMEgZTFR6VwQYZDU8EFhRZUDdena67Fj7L5jv1
ZtxRqGtzFBaZYd1M+GAXa8SCbkg8ffN2/4vd9irybj/G1AgYxbau6z5yC5P+9lE+
GWUcmw4MwYhj3ErbpUOjhVFuY+dSUz7phTl0LId79QzY4Az2C0YdfjxkFnvFTIN9
4GB1ohRSofaAnUrfsTpv+dVqmvEgnRpjvCDuFTn0bn+dyeGLY4g=
=xP70
-----END PGP SIGNATURE-----

--t510VFY6gWB8--
