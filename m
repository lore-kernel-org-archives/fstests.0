Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C379AC4338F
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Aug 2021 12:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1AF61214
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Aug 2021 12:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhHVMsY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Aug 2021 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVMsY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Aug 2021 08:48:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD0C061575
        for <fstests@vger.kernel.org>; Sun, 22 Aug 2021 05:47:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q11so21798990wrr.9
        for <fstests@vger.kernel.org>; Sun, 22 Aug 2021 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=6crty3RNJb3Y178xZb4yHBRc9g5rtaoeBNawd4qyjjo=;
        b=B2TZej+3E2mlM+JUvdoWUVM1wMkKGc+q3TkQi7xDNROI6XVZ/cq7P95jrp8Q39sqg1
         ElPr7np+9G2cpuuexrgWEM5Fv9DjYEDRmijd46yjQARhvZ1ShGdtMl1yRhWZlzlxpYf8
         0YWYY0RNjpAFjtTwBh2otVf2paHcAPH0zZtDwi/vBoluQCGpSE60sk9elIj8yRJRZDP/
         cO7fmTrRTijRAbJhEK3mX25XWhCzUzHJ983vzN2mVp4C1Y0RWm0Q+8qRubKytrqKkG8p
         ljBDzW9QvebTCnTng7+S16mJQciqDO18m6dWFcrMJGxdq4ZKjzmY/YwFCqwOQNHGh4xu
         W+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=6crty3RNJb3Y178xZb4yHBRc9g5rtaoeBNawd4qyjjo=;
        b=R0BLP8w6nVRA9RmIcHSvOSpi9X0qtjSj9IsX2mzSFKpa3Y0dOOcRo9+2uwYOm7nTkP
         vQwHHle7wc7aR1B71z+jNY54PYB7Vo2eXmBlJazoAOHiWNtAoEeWUd3LaNPtJ2nyixkU
         TimqHNDizkxglMQrOLCnObWpDojyApDcPgbT+FUbPOVWNt+QnwuWpGzzmEQ82R0g+Vn4
         62WWqxd8Odr5QnFShgd7wz9+00Bjuw/iEL/pt943HtGwbsHCsLCh1WPDMlGPKhlkjcTg
         CpSKOWUxrQKeinzVogerpPrRof8VzRX1mpakZgSmt2lgW0K6yI+0rbaxZ+IY8lFiON9f
         FhZQ==
X-Gm-Message-State: AOAM531wxAKlWaSNyF1ldOk3mcwKY4Nf9BWQlbUGc9Uc4NX1sPL3ANtj
        rM3AHQn0UJctN1rRQWbwGCMM3FgwhmE=
X-Google-Smtp-Source: ABdhPJy8OokuqMO94WeHxhbmuMqZpz5fwBqYu3nskfGdBiRgFpCdpayrLRScx/otqSdflY1UhsqRYg==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr8358995wrq.377.1629636461598;
        Sun, 22 Aug 2021 05:47:41 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id z5sm10033720wmi.36.2021.08.22.05.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 05:47:40 -0700 (PDT)
Message-ID: <6122476c.1c69fb81.92473.5a2c@mx.google.com>
Date:   Sun, 22 Aug 2021 20:47:37 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 5f8179ce8b00
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n6xSEo9VYKDZ"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--n6xSEo9VYKDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains several improvements and new
tests. The last piece of btrfs zoned block device fixes from Naohiro Aota have
been merged. And Luis Chamberlain introduced _patient_rmmod() helper to solve
the long standing rmmod scsi_debug race. Christian Branuner extended the
idmapped mount tests, also introduced btrfs specific idmapped mounts test.

The new generic/643 test currently fails with ext4, xfs and btrfs, the proposed
fix is not upstreamed yet.

xfs/187 has been removed, since xfs is removing the ability to downgrade
deprecated V4 filesystems from attr2 to attr1.

Thanks,
Eryu

The new head of the master branch is commit:

5f8179ce8b00 btrfs: introduce btrfs specific idmapped mounts tests

New commits:

Boyang Xue (1):
      [39d6777fb39f] ext4: regression test for "tune2fs -l" after ext4 shutdown

Christian Brauner (8):
      [3507237efef9] idmapped-mounts: use die() helper
      [935ea18dc68e] idmapped-mounts: switch to getopt_long_only()
      [a36a8d3f9c0c] idmapped-mounts: introduce an explicit command line switch for testsuite
      [a1067602eff3] generic: add fscaps regression test
      [dfbbbe0de60d] idmapped-mounts: refactor helpers
      [4cbbb9577af4] idmapped-mounts: add nested userns creation helpers
      [065ca65561b1] generic: add nested user namespace tests
      [5f8179ce8b00] btrfs: introduce btrfs specific idmapped mounts tests

Darrick J. Wong (2):
      [88ed9a8131c3] generic: add swapfile maxpages regression test
      [75858d5e8baa] xfs/176: fix the group name

Dave Chinner (1):
      [25d4b1fe41b8] xfs/187: remove the test

Kai-Wen Hu (1):
      [2e58996bdbcf] generic/457: post-check fs on thin-vol device instead of scratch device

Luis Chamberlain (2):
      [d405c21d40aa] common/module: add patient module rmmod support
      [935ed7d3846a] common/scsi_debug: use the patient module remover

Naohiro Aota (3):
      [952310a57d93] common: add zoned block device checks
      [900288fb6d0b] btrfs: add checks for zoned block device
      [1538aef8361f] generic: add checks for zoned block device


Code Diffstat:

 README                                |    4 +
 common/btrfs                          |   26 +
 common/config                         |   31 +
 common/module                         |  108 +
 common/rc                             |   13 +
 common/scsi_debug                     |   37 +-
 configure.ac                          |   10 +-
 src/idmapped-mounts/idmapped-mounts.c | 4917 ++++++++++++++++++++++++++++++++-
 src/idmapped-mounts/mount-idmapped.c  |  229 +-
 src/idmapped-mounts/utils.c           |  359 ++-
 src/idmapped-mounts/utils.h           |  102 +-
 tests/btrfs/003                       |   16 +-
 tests/btrfs/011                       |   21 +-
 tests/btrfs/012                       |    2 +
 tests/btrfs/023                       |    2 +
 tests/btrfs/049                       |    2 +
 tests/btrfs/116                       |    2 +
 tests/btrfs/124                       |    4 +
 tests/btrfs/131                       |    2 +
 tests/btrfs/136                       |    2 +
 tests/btrfs/140                       |    2 +
 tests/btrfs/194                       |    2 +-
 tests/btrfs/195                       |    2 +
 tests/btrfs/197                       |    2 +
 tests/btrfs/198                       |    2 +
 tests/btrfs/215                       |    2 +
 tests/btrfs/236                       |   33 +-
 tests/btrfs/245                       |   34 +
 tests/btrfs/245.out                   |    2 +
 tests/ext4/051                        |   29 +
 tests/ext4/051.out                    |    2 +
 tests/generic/108                     |    2 +
 tests/generic/457                     |    3 +
 tests/generic/471                     |    2 +
 tests/generic/570                     |    2 +
 tests/generic/633                     |    3 +-
 tests/generic/643                     |   62 +
 tests/generic/643.out                 |    2 +
 tests/generic/644                     |   28 +
 tests/generic/644.out                 |    2 +
 tests/generic/645                     |   28 +
 tests/generic/645.out                 |    2 +
 tests/xfs/176                         |    2 +-
 tests/xfs/187                         |  117 -
 tests/xfs/187.out                     |   39 -
 45 files changed, 5699 insertions(+), 596 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--n6xSEo9VYKDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmEiRssACgkQJlKqKVyP
52MIihAAqa5GjzWfWl4f8CXUyJ/YBhtPHGiQR7rhaRwod9Uk3BDd5105HjjrQsve
QRMTmWeXOjxq/gWtAdVMPYiLFhfpbF3Heouy3bPDLVi77+czkriGVXYyaEaizQUg
QwIGtLXFw1OgW4oftvWMor8pj1GoQ4Xw2M5H+1JOn7Gv6hlj8fNHmqprVhGsy8C2
OuNwGvqKPtS/1kKomD6BRKjUaG23sQ0LA4rAGgQr6aUIjLmUUMutYKINXPXfFF2g
gJX/MEUQdualNPrQshUVSJ4KtF0wdYomecs68w3/dkPAMfqk/hJ3IP4Uwnmq065z
w5Vk98o67W1jUR/2Ww+mCHR2iebfpZvr+ZnF6YC5oG2vX++Gz+LrFeNFTuCPtFhv
vPautrqX2AntyNp3vx0Vrn+jaR0aVENQgoGNbUiMfo5KUFqNNdvMLWTBBYiVJMxb
orZbi2bWfNFu44ZxTQC3Qa2PNX6CjuoS/BTYGShInp8KkD/tf4ItIOCGdgEz9SAe
k+DL7d4j+88rVzxZl/i4BHYjj2M6VKJEWCDnDk7xUNVGdAN6YlyzK3OrdiWAhJ0y
3u3mmWvZQ4He1lLPqc5RseD0WQJsJvNMpVXk1NbBDbuP63iq/vfp4B6x8PHiuL3b
YC9+7PTi4Aots6+XapDKhN0cM/sF/Y3pwbhIus7QRjMBAlbZIdg=
=3h3H
-----END PGP SIGNATURE-----

--n6xSEo9VYKDZ--
