Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D7BC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Feb 2022 17:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbiBTRbe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:31:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiBTRbd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Feb 2022 12:31:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46F2409F
        for <fstests@vger.kernel.org>; Sun, 20 Feb 2022 09:31:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so7566872wrf.1
        for <fstests@vger.kernel.org>; Sun, 20 Feb 2022 09:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=tX30vhtN2WiNbOXTKzhvdzl+PVFATSFVgFXPLeRxhVQ=;
        b=cAKcxr8EJYg+ynZWJC5pTxV8TCq3a5oKkDkwAZUiXf8SjX8FAQkIpHxjFicrquP/IT
         SkZX2fofj0ImBB7tHZWPF0wPFtl4xTSxpuc76L++1lb6HODiHLjbINoh37/J3F9Pbkw4
         JLhhYWJX9OBEUZ5NhL/gecWjHNcpZU6Qfg7UlrANeII0ShZ9/JdcnX6rD9DwMjvZ4h/F
         k7rfM5SzmIgQAoH9zYJlR4XS5o7OKwrvVXgVIdNFl5Gg6jYOLTYgIKXgtswbv4AIZZCX
         fyB7Rs41Vj2JOL2wOH6Qs6zyJ4+ZMjCQiUpQJ1KDiC8bRWOCA+q+bi/+LGr0ZJ/77CRX
         gqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=tX30vhtN2WiNbOXTKzhvdzl+PVFATSFVgFXPLeRxhVQ=;
        b=6bqGRdGoW5CTlsCyQQJ/I6aLxEhpgDCKaMfriF0BJfw59/Ed8YEcCSvv0oHIKhkDoF
         nZlfCFBYw4qWaWeeyR7Sn/Pe1YwOt+nLBuQBxlaIsFSytWzH470CGEp08sm8YWrvzKfL
         89d9t6dw+OVBSnDCKEZXo7jDmAcTexcU8oLG3Mt6dshiZ37jkIk9hDvdTcALw2KUWPbR
         cr27zUgl9U0nw2v0pYomj7IgRdCx1urqTUGg43cUDDrrjPkNz9EzaO4rbpaeVblu4jOl
         vXuwwwTebixYz7Qm0W2cZYcnzHuPb2EuKoQ77V8Afv5K1/mbqvxeOdLp88KSuz4P5foZ
         /avQ==
X-Gm-Message-State: AOAM533qDe2+XXBooHg/qbhSY8RtnQ60oQwO9otgmFySPUzdk96tCxms
        db/W4qofFYAsDa1LT5/CorGvpCc7Wag=
X-Google-Smtp-Source: ABdhPJzygym9R37MsJxqDU1nn0ZMGcITymhoCyq9OHo7rX+TPNe6CiEJFp1OeRgCNpyk+5TOZhp4AQ==
X-Received: by 2002:a05:6000:154a:b0:1e9:3cb3:5022 with SMTP id 10-20020a056000154a00b001e93cb35022mr8942131wry.312.1645378269517;
        Sun, 20 Feb 2022 09:31:09 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id h10sm40661827wrt.57.2022.02.20.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:31:08 -0800 (PST)
Message-ID: <62127adc.1c69fb81.ffe6a.09b1@mx.google.com>
Date:   Mon, 21 Feb 2022 01:31:05 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 2ea74ba4e70b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dz1ZTljXfScG"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--dz1ZTljXfScG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is mainly an update for bug fixes, along with one
new btrfs test. One notable improvement is that btrfs supports capturing device
metadumps of currupted filesystems.

And the new btrfs/261 test currently fails with latest v5.17-rc4 kernel.

There're still some review backlogs, primarily 3 patchsets:

- ext4 fast_commit tests from Ritesh Harjani
- improvements for NFS from Anna Schumaker
- btrfs fsverity tests from Boris Burkov

Thanks,
Eryu

The new head of the master branch is commit:

2ea74ba4e70b btrfs: add support for capturing metadumps of corrupted fses

New commits:

Anthony Iliopoulos (1):
      [2ea74ba4e70b] btrfs: add support for capturing metadumps of corrupted fses

Filipe Manana (1):
      [41e691e469f7] btrfs: log replay after fsync of file with prealloc extents beyond eof

Luis Chamberlain (4):
      [d01e8f25f31d] common/config: fix use of MODPROBE_RM_PATIENT_TIMEOUT_ARGS
      [115096a405bc] btrfs/237: adjust uuid heuristics
      [9470dc5dddea] common/btrfs: use $AWK_PROG
      [67f9580c212d] tests/btrfs: use $AWK_PROG instead of awk

Qu Wenruo (1):
      [11342071e105] src/fssum: use newer EVP_* interface to replace deprecated MD5_* interace

Shin'ichiro Kawasaki (5):
      [3c47d5f0d091] generic/204: remove unnecessary _scratch_mkfs call
      [85a48b27b0e0] generic/{171,172,173,174}: check _scratch_mkfs_sized return code
      [ba2dedfb6ad7] ext4/021: check _scratch_mkfs_sized return code
      [1a7e6b57172d] xfs/015: check _scratch_mkfs_sized return code
      [96b95682588f] common: factor out xfs unique part from _filter_mkfs

Sun Ke (1):
      [eb564a218799] common/attr: adbjust acl_max of f2fs


Code Diffstat:

 README              |  4 +--
 common/attr         | 19 +++++++++++--
 common/btrfs        | 21 ++++++++++++--
 common/config       |  3 +-
 common/filter       | 40 +--------------------------
 common/rc           |  3 ++
 common/xfs          | 41 +++++++++++++++++++++++++++
 src/fssum.c         | 23 ++++++++++++++++
 src/md5.h           |  2 +-
 tests/btrfs/001     |  2 +-
 tests/btrfs/003     |  2 +-
 tests/btrfs/006     |  6 ++--
 tests/btrfs/011     |  2 +-
 tests/btrfs/022     | 12 ++++----
 tests/btrfs/027     |  4 +--
 tests/btrfs/035     |  4 +--
 tests/btrfs/085     |  2 +-
 tests/btrfs/090     |  2 +-
 tests/btrfs/124     |  4 +--
 tests/btrfs/125     |  6 ++--
 tests/btrfs/149     |  8 +++---
 tests/btrfs/161     |  4 +--
 tests/btrfs/162     |  6 ++--
 tests/btrfs/163     |  6 ++--
 tests/btrfs/164     |  4 +--
 tests/btrfs/175     |  2 +-
 tests/btrfs/176     |  6 ++--
 tests/btrfs/181     |  2 +-
 tests/btrfs/184     |  2 +-
 tests/btrfs/185     |  8 +++---
 tests/btrfs/194     |  4 +--
 tests/btrfs/197     |  4 +--
 tests/btrfs/198     |  4 +--
 tests/btrfs/215     |  4 +--
 tests/btrfs/216     |  4 +--
 tests/btrfs/218     |  4 +--
 tests/btrfs/237     |  9 +++++-
 tests/btrfs/254     |  4 +--
 tests/btrfs/261     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out | 10 +++++++
 tests/ext4/021      |  2 +-
 tests/generic/171   |  2 +-
 tests/generic/172   |  2 +-
 tests/generic/173   |  2 +-
 tests/generic/174   |  2 +-
 tests/generic/204   |  6 +---
 tests/xfs/015       |  2 +-
 47 files changed, 272 insertions(+), 122 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--dz1ZTljXfScG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmISeqAACgkQJlKqKVyP
52NBtxAAxn2mDC6PmEVKTQibsH2BaZaCpcCiLfgdqiNMq0Z2/ZymQ28b7ywlHx1d
gjWowABNlX7m4ADofAbRU8vDikqj83Lg5LgAviYOi8pepoS5QB9Ss+o8vqPEgtoU
y2hxczaVHWlaaglqq33Vdy/aDwREHYolYuXwivJd3HxhwwmsiyYl91zvbMQJcQFl
T1Y9qi6c/NeTTS9Wl2E8KqqwoGkWPl/4xMVJc/545+gbYasJz8DjZ+ppzR54abCx
zNFdeDoJmpASqDOZLzg2IrDW2Xb/FAzNzpQjdDl2+M68dMtb7VkMcc+5x/G0fH94
cm9hVjqvh21R1Ge3TW+e6mj541JlmdgugRvmbl7CYQVp9E1pnaqdHIsND/u9bdOY
wzB/TzzrgnRYtubYlOZt52dZ3f5YhuHT4nKu7tIbXC4JnF60izAaGoBiVA5HFfZf
mSszZQiTuF3BRBRi/OqlkUOLVU7+4HQXByCQfu5igTGlQYG6NZMl+ABbOon0dADj
T0MVQvxdSrt9Nxd80/uTUlTZ5087nLKWSZcm2PN44Cabu0/MuRHdm2/x6Zze6Amt
sUGZUqqnGPj9Dc2sKEkKOLvl5M0HWfA3LxRHlhXB+YC/eFkmTFikXpA7pnbNN2hx
iRZHyN7YZXvt7ppz1jHrk1RXuRfRyNwStSkFTkY3gYPujKEMwrM=
=EJyT
-----END PGP SIGNATURE-----

--dz1ZTljXfScG--
