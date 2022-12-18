Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C40C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Dec 2022 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLROw3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Dec 2022 09:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLROw2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Dec 2022 09:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7446319
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2022 06:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671375102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=zZtrr+yTvsCcxDWafMuD6Bv5twrao+npT5jibS/OVjU=;
        b=LUPqt7T4kYyQP8qqr808xvunrNTd5lT+T8fq7VQpYPeJ4Znddb3Uinn6c8OLvQSNOke+lJ
        Fp5PeC5bJZmMi95dhWP2IS8GssnO0XDrH1N+2kLWpalOSb+dKD+NOqKqKc5FpY5BmiQg70
        YoWah4jsP1MYoWENZkG9mrCTTlYpUaM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-208-lb9cPnw_Pnad2vpZeb0dVA-1; Sun, 18 Dec 2022 09:51:41 -0500
X-MC-Unique: lb9cPnw_Pnad2vpZeb0dVA-1
Received: by mail-pg1-f199.google.com with SMTP id o8-20020a6548c8000000b0047927da1501so4065490pgs.18
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2022 06:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZtrr+yTvsCcxDWafMuD6Bv5twrao+npT5jibS/OVjU=;
        b=A30CnAx17B+asMckqz2Kb221XyyW9dmFrnWoVQCbqGDpGjbGfYz1gFJzS/HYLC2CKy
         qMnaz3HnsRH388mcVz4Knz6xCsJEKsKXoLDmLZsWlGNdkanVZpl1YQfasGZ/FencZwW3
         dOe/uxI96cr/rMSWtZrxAY2LejbTSk6R2ZN/pPkTpap5o0X5Zf+5xrB0mLcPx05XJ90j
         l6usLW+1IcL+6RuAvT7XID8xxRQ8Tfb9sQSxFdIVz/0h0A6nWX+cd56XN+UIOvKaExuU
         lmDYVvY1aiM+UjoS5yL/Sy8YMJZtW65x5n55WpHqjgSjoEjeqRe62iPqYI21IVk6OWY3
         0iIw==
X-Gm-Message-State: AFqh2kr1yJF68mhhIKB3TGT7805iMdPGioy/5Syw0XCIrAkYAXNWKPmX
        wvR5q6EzbL9s4EFWESMvKh9Sb3zAuSVAfs5T0k4q77lHmz5cWFeKwMN6OBpNfx9++pX7e8IKElt
        eCriO1T8LFEQqgDK/ro/u07q1qLVKSn9WxLh6uBBHgr7rEP0PCsEk2zGpZridTMh95Q==
X-Received: by 2002:a17:902:ea02:b0:187:2f28:bfd6 with SMTP id s2-20020a170902ea0200b001872f28bfd6mr7055524plg.21.1671375100041;
        Sun, 18 Dec 2022 06:51:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtAdPKHMB7O0tK6EIT3ZyEA0fuGWe9WLhyjqoPKG41KbO+1jA7hq72zqpDChvkURTHiuySDww==
X-Received: by 2002:a17:902:ea02:b0:187:2f28:bfd6 with SMTP id s2-20020a170902ea0200b001872f28bfd6mr7055499plg.21.1671375099637;
        Sun, 18 Dec 2022 06:51:39 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b0017f64ab80e5sm5167162plg.179.2022.12.18.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 06:51:38 -0800 (PST)
Date:   Sun, 18 Dec 2022 22:51:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to e26310404671
Message-ID: <20221218145134.mdvz7rbt7s23qwff@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.12.18 release.

Release note:
1) No new case this week.
2) Some improvement on common/populate and related part.
3) Fix some issue of check script

More details refer to below, thanks for all your contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

e26310404671 fuzzy: don't fail on compressed metadumps

New commits ([U]pdate):

Darrick J. Wong (5):
[U]      [a8a3cd342f90] xfs/018: fix attr value setting in this test
[U]      [538abf799424] common/populate: create helpers to handle restoring metadumps
[U]      [830b45aa636f] common/xfs: create a helper for restoring metadumps to the scratch devs
[U]      [b8c6b5045afb] common/populate: move decompression code to _{xfs,ext4}_mdrestore
[U]      [e26310404671] fuzzy: don't fail on compressed metadumps

David Disseldorp (1):
[U]      [210af953f709] check: ensure sect_stop is initialized if interrupted

Leah Rumancik (1):
[U]      [99b970640652] check: wipe tmp.arglist

Qu Wenruo (1):
[U]      [8a1c35e615fd] check: call _check_dmesg even if the test case failed

Xiao Yang (1):
[U]      [e4b8751d735e] xfs/243: add _require_scratch_delalloc()

Yang Xu (1):
[U]      [9c69817e88ef] src/vfs/utils: Reset errno to zero when detect O_TMPFILE

Ziyang Zhang (2):
[U]      [be957968f6fa] common/xfs: Add a helper to export inode core size
[U]      [8fc059413cc1] common/populate: Ensure that S_IFDIR.FMT_BTREE is in btree format


Code Diffstat:

 check             |  6 +++++-
 common/ext4       | 20 ++++++++++++++++++++
 common/fuzzy      |  5 ++---
 common/populate   | 49 +++++++++++++++++++++++++++++++++++--------------
 common/xfs        | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/utils.c   |  6 ++++--
 tests/xfs/018     | 17 +++++++++++++++--
 tests/xfs/018.out | 42 +++++++++++++++++++++++++++++++-----------
 tests/xfs/129     |  2 +-
 tests/xfs/234     |  2 +-
 tests/xfs/243     |  1 +
 tests/xfs/253     |  2 +-
 tests/xfs/284     |  2 +-
 tests/xfs/291     |  2 +-
 tests/xfs/335     |  3 ++-
 tests/xfs/336     |  5 +++--
 tests/xfs/337     |  3 ++-
 tests/xfs/341     |  3 ++-
 tests/xfs/342     |  3 ++-
 tests/xfs/432     |  2 +-
 tests/xfs/503     |  8 ++++----
 21 files changed, 186 insertions(+), 49 deletions(-)
--
Zorro Lang
zlang@kernel.org

