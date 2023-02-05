Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF81C636CD
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Feb 2023 14:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBEONz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEONy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Feb 2023 09:13:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1837EF0
        for <fstests@vger.kernel.org>; Sun,  5 Feb 2023 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675606397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=QLpMju6WG0L2iqKFcuNMKobHrHCSz2CSxY0cua0Z1ow=;
        b=LYLT6BnNTRiVe7K2ZqvSotKGL5zXlhaBejfBFAJwM9UbqQq94VnIlQHzS+OS6oaEaAcSF3
        O8cPZeh+gl2ybFm4Fo2OTIrzv/PLQbGGm2mNAKi8vXKPoxXPtSEIHYPi5/qXxWeSfcmv1a
        HJtq1nRSxt2tPDaLI1PYE8MDs58B420=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-4bf10YTKMeyKTOBGv_0NCA-1; Sun, 05 Feb 2023 09:13:15 -0500
X-MC-Unique: 4bf10YTKMeyKTOBGv_0NCA-1
Received: by mail-pl1-f200.google.com with SMTP id y9-20020a1709027c8900b00195e237dc8bso4936157pll.13
        for <fstests@vger.kernel.org>; Sun, 05 Feb 2023 06:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLpMju6WG0L2iqKFcuNMKobHrHCSz2CSxY0cua0Z1ow=;
        b=wZ4at+x/P9X3z6SDuXa8JriNTn+NmCBUOsuKFPEhmYX9Bzr4RG5+fjYO0yja0sbqSL
         mONDWU3fuyJLuezPpa+PFNF4eC9K63LMUKZWPgAMYNGDUGdVZ8a+tDmzI4wV1oswCp9B
         mFjJx/qq65RzZwwURK09WPzqJSIePrx5zfYpzUVVmpp9MJtNjGjSWvfI1mElpspzkVJJ
         9FIe4q9MFyQpuZ+Utwb+G2AxOY7xevC4EasHGxSYbnD7pqTW/bGg1bLB125h+otRS95s
         WMf9oLmlE8OFvaAp8Mp5Aa1JM1SkRmKVU2TPs7lo3LZ8BjCnmEg/NSP4vi4lMTrjrlnS
         hNTg==
X-Gm-Message-State: AO0yUKXa2iFceI3Cvs6oyp/zgfO2Yytb25dr79WNIPBZq+Ahb7VRq9op
        0IpiL6I7FaVH9B2mF7mU/i7DnobnrgqNE+KumFWQK3CZXoBmMTc6sgOP6IHXgHiyIdHb9ybjgRy
        6h/4RIDszM5FRG0vLJA7oC0F8a/AKbYCyNz7Pwu1R5LG1OwgkHpIdwWKuCzGvlVLLkQ==
X-Received: by 2002:a05:6a20:12cf:b0:be:ce7a:8728 with SMTP id v15-20020a056a2012cf00b000bece7a8728mr21930601pzg.53.1675606394528;
        Sun, 05 Feb 2023 06:13:14 -0800 (PST)
X-Google-Smtp-Source: AK7set+ALk8gJGGcRG4Unf/9sbhzAFxM5bbB1MmfNH7XlgeB3b3dFjWOnpQpUGqQp7SZPuv9i4slYQ==
X-Received: by 2002:a05:6a20:12cf:b0:be:ce7a:8728 with SMTP id v15-20020a056a2012cf00b000bece7a8728mr21930577pzg.53.1675606394133;
        Sun, 05 Feb 2023 06:13:14 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n18-20020a639712000000b004a281fb63c3sm4527837pge.87.2023.02.05.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:13:13 -0800 (PST)
Date:   Sun, 5 Feb 2023 22:13:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.01.22 onto master branch
Message-ID: <20230205141309.wnujyhzsfgsii7pw@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.01.22 version.

Thanks,
Zorro

The new head of the master branch is commit:

3aa3a26e075c xfstests: add fuse support

New commits:

Christian Brauner (1):
      [81e6f6284499] generic: update setgid tests

Darrick J. Wong (8):
      [bbfa08730c1e] xfs: fix dax inode flag test failures
      [8f8ba51412a0] xfs: fix reflink test failures when dax is enabled
      [11afd20ba354] xfs/182: fix spurious direct write failure
      [28aadc29ed2f] xfs: skip fragmentation tests when alwayscow mode is enabled
      [1cb825fdefd7] xfs/{080,329,434,436}: add missing check for fallocate support
      [49da0ed40794] various: test is not appropriate for always_cow mode
      [3ea9a3274403] populate: remove file creation loops that take forever
      [39bb1e3d3b2c] populate: improve attr creation runtime

Dave Chinner (1):
      [116804dc92d2] populate: ensure btree directories are created reliably

Miklos Szeredi (1):
      [3aa3a26e075c] xfstests: add fuse support

Ojaswin Mujoo (1):
      [c08fcc7fb71c] generic/692: generalize the test for non-4K Merkle tree block sizes


Code Diffstat:

 README.fuse           | 26 ++++++++++++++++
 check                 |  3 +-
 common/config         |  9 ++++--
 common/populate       | 86 +++++++++++++++++++++++++++------------------------
 common/rc             | 24 ++++++++++----
 common/xfs            |  9 ++++++
 src/Makefile          |  2 +-
 src/popattr.py        | 62 +++++++++++++++++++++++++++++++++++++
 src/popdir.pl         | 72 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/020     |  4 +--
 tests/generic/392     | 10 ++++++
 tests/generic/673     | 16 ++--------
 tests/generic/673.out | 16 ++--------
 tests/generic/683     | 16 ++--------
 tests/generic/683.out | 12 ++-----
 tests/generic/684     | 16 ++--------
 tests/generic/684.out | 12 ++-----
 tests/generic/685     | 16 ++--------
 tests/generic/685.out | 12 ++-----
 tests/generic/686     | 16 ++--------
 tests/generic/686.out | 12 ++-----
 tests/generic/687     | 16 ++--------
 tests/generic/687.out | 12 ++-----
 tests/generic/692     | 37 +++++++++++++++-------
 tests/xfs/080         |  1 +
 tests/xfs/128         |  2 +-
 tests/xfs/182         |  5 +--
 tests/xfs/182.out     |  1 -
 tests/xfs/184         |  1 +
 tests/xfs/192         |  2 ++
 tests/xfs/198         |  1 +
 tests/xfs/200         |  1 +
 tests/xfs/204         |  2 ++
 tests/xfs/211         |  1 +
 tests/xfs/232         |  1 +
 tests/xfs/326         | 12 +++++++
 tests/xfs/329         |  1 +
 tests/xfs/434         |  1 +
 tests/xfs/436         |  1 +
 tests/xfs/440         |  1 +
 tests/xfs/558         |  6 ++++
 41 files changed, 340 insertions(+), 216 deletions(-)
--
Zorro Lang
zlang@kernel.org

