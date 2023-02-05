Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7055FC636CD
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Feb 2023 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBEOQi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEOQh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Feb 2023 09:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CBF7EF0
        for <fstests@vger.kernel.org>; Sun,  5 Feb 2023 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675606549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=kIn/NEtfZX3r/UlfMuEd8UYiMaguSVpwwUOnBdvmfYQ=;
        b=GQSPUba3qHlXCKBnxNPdKrH89deJII4EUruddYGpq8uoEN8drTPHy6tIhjTSwiZWcne0gM
        4cXncaaTYpikuCSPZoTJhFRmp6eSeD3CTcOVfjnjUM5iOYHAAnzSeSR6Rs5oiFIxArG2hp
        eEGkInhQ0o7YnQcFEdP5CjZVtKTfPVE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-480-eldkBYXyNzG-9Ly75iavJA-1; Sun, 05 Feb 2023 09:15:48 -0500
X-MC-Unique: eldkBYXyNzG-9Ly75iavJA-1
Received: by mail-pj1-f70.google.com with SMTP id k15-20020a17090a590f00b002300fe6b09dso7307870pji.0
        for <fstests@vger.kernel.org>; Sun, 05 Feb 2023 06:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIn/NEtfZX3r/UlfMuEd8UYiMaguSVpwwUOnBdvmfYQ=;
        b=PRn9L25MSjxHqplUUfQ/SoXDMHm5SYx7Mc5OZO1in0tVwExr/SxpLwp+kkyOMhvoeD
         RM07FeBJ0W9msidZNEmYKEflvsl18TFM5leEWo2iLpKG0FATuOITD4Dz8wkEyeQVYy2r
         lf3a+UK33Q2oqmj2UHiOSxx1XljlG2zlIYteQiJEZnjbeFogvzt5qRi0bArBxGeh0TQO
         ky4iKUyw5KcUDlmcrSE1Jhf528QlHgzAm/bNlZQNeuL9HN6KRltuWG64AJL+UsIo4UVW
         r0fw9Bwemnsgm8x04s2A1ptbuhzt9wDjctwTTNvD+tNzbeY/BiJVVXSrVZw/sD5r891s
         8aBg==
X-Gm-Message-State: AO0yUKVyKNUc1W46Ml2YZr2hZ+dm0whttfmthFvTfPkw+OkT0vC9Q5ue
        cRX5dAyS9D//0gDtGSt/CLC1r+wX1WEgDJnm7135HLvEdf7xSi+1wZhF1aRX9lVeeDhG0rnujSg
        sM4WjQSZqyDkPtUsiG3g9h+TKmcvQBbx5IiCpxzdIVhCYI9CTuN8QlKe3YGTi8HbASA==
X-Received: by 2002:aa7:9911:0:b0:592:5dd5:7655 with SMTP id z17-20020aa79911000000b005925dd57655mr14858539pff.28.1675606547027;
        Sun, 05 Feb 2023 06:15:47 -0800 (PST)
X-Google-Smtp-Source: AK7set/OS3Iiwsk3AL6LZf2dHuT5oJydgxdfalhis+aglN0L0U392BnJTExPve/wDrTVFVK/eHsdbw==
X-Received: by 2002:aa7:9911:0:b0:592:5dd5:7655 with SMTP id z17-20020aa79911000000b005925dd57655mr14858520pff.28.1675606546601;
        Sun, 05 Feb 2023 06:15:46 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b005907716bf8bsm5208643pfo.60.2023.02.05.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:15:46 -0800 (PST)
Date:   Sun, 5 Feb 2023 22:15:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.02.05
Message-ID: <20230205141542.rsc235bvyppog66q@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.02.05 release.

Release Notes:
1) There're 3 new cases in this release -- btrfs/283, xfs/567, xfs/568 and
   generic/707. Generally these 3 cases won't break (crash/hang) old kernel
   testing.
2) More update fix some test failures (case issue) or build warning.

Thanks for all these contribution! More details as below.

Thanks,
Zorro

The new head of the for-next branch is commit:

f6ab376b553d xfs/191: fix xattr leaf block emptying on 64k blocksized fses

New commits ([N]ew, [U]pdate):

Anand Jain (4):
[U]      [7fa8a9a25bd1] fstests: doio.c, fix missing initialization of -C arg
[U]      [8d8d05a8e222] fstests: fstest.c, fix compile warnings replace sprintf with snprintf
[U]      [c569ebf56180] fstests: t_getcwd.c, fix a warning related to buffer overflow
[U]      [1f12612b7c29] fstests: aiodio_sparse2.c, fix compiler warning buffer overflow

Anthony Iliopoulos (1):
[U]      [f6ab376b553d] xfs/191: fix xattr leaf block emptying on 64k blocksized fses

Darrick J. Wong (2):
[U]      [82961ee6b44f] generic/038: set a maximum runtime on this test
[U]      [c7c1063809ef] generic/500: skip this test if formatting fails

Filipe Manana (2):
[U]      [d3db87166a6d] btrfs/299: update kernel commit hash and subject
[N]      [276e00a966b3] btrfs: test send optimal cloning behaviour

Hironori Shiina (2):
[U]      [e100e9dfd87b] xfs: add helper to create fake root inode
[N]      [6a19144c851c] xfs: test xfsrestore on multi-level dumpfiles with wrong root

Jan Kara (1):
[N]      [da69ce70dfcd] generic/707: Test moving directory while being grown


Code Diffstat:

 common/dmthin                        |    7 +-
 common/rc                            |   22 +-
 common/xfs                           |   40 +
 ltp/doio.c                           |    1 +
 src/aio-dio-regress/aiodio_sparse2.c |    1 +
 src/fstest.c                         |   17 +-
 src/t_getcwd.c                       |    4 +-
 tests/btrfs/283                      |   88 ++
 tests/btrfs/283.out                  |   26 +
 tests/btrfs/299                      |    3 +-
 tests/generic/038                    |    6 +
 tests/generic/500                    |    3 +-
 tests/generic/707                    |   70 ++
 tests/generic/707.out                |    2 +
 tests/xfs/191                        |   12 +-
 tests/xfs/545                        |   31 +-
 tests/xfs/554                        |   35 +-
 tests/xfs/557                        |   31 +-
 tests/xfs/567                        |  125 +++
 tests/xfs/567.out                    | 1517 ++++++++++++++++++++++++++++++++++
 tests/xfs/568                        |  213 +++++
 tests/xfs/568.out                    |  849 +++++++++++++++++++
 22 files changed, 2999 insertions(+), 104 deletions(-)
--
Zorro Lang
zlang@kernel.org

