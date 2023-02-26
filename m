Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3DC64ED6
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Feb 2023 15:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjBZP0c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Feb 2023 10:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjBZP0P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Feb 2023 10:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9C233FF
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677424676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=s1/fUaEg65oKizGF2exT5LmxdQZ1BqDWdzC0vRQQxHc=;
        b=PBAcLEoR3kNJsqkzcedOZb/cyyInhVhZEdh24eWQLlECL7jdOBF7rDJllHlhqeo4WBRRQr
        06CN7/vydbG9vutICT/dtadxVgUEw0aqEhG38b1u9maWpJg/Wqdp249mxiSFuzOyLgxRh8
        KAK6YZxPl/uUnRZ+RbcrekjADpNJSAY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-v2erfkcFO1qt6BUYMVI5fQ-1; Sun, 26 Feb 2023 10:17:54 -0500
X-MC-Unique: v2erfkcFO1qt6BUYMVI5fQ-1
Received: by mail-pg1-f200.google.com with SMTP id d18-20020a63f252000000b00502f11fb2fcso837991pgk.6
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 07:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1/fUaEg65oKizGF2exT5LmxdQZ1BqDWdzC0vRQQxHc=;
        b=4gboZpbolZSgiPDy0C4z6FoEvPCD/222n1zuetQZ9V7WAktRq9C7i9hRe9+OlmCncG
         bMHeOVJSqwNU7QCiom9tvPZdPjgnxClzVR9CB86yZXQL2dqwjmt8UHlkYl8Z9dZo2nD/
         UtQH/FdyXXVR8m0u3RHf4MAXMaTT7gqF+Irg3J/gX+BCf5nQ2ANH7HabS83IsPfnUog7
         rCFF11c3vRnRW7/BknNZ1N0umxtyNjj0Wy03B0Roa/uNOQ3pkMATlglSEBxSInZEcZ6c
         sXPU5Fcqpkd/xlY2YX+OP0ycMjs+5fd9DSdv5ukWBRXpUFTyDtMgJ1wijgDubZ5w2cij
         dQBw==
X-Gm-Message-State: AO0yUKWEyPT9W5hAmJm77DMMKGDDRKyeTRSqWnkA2EjSP8DYJYUO31WR
        +G1pymhmgz9xeKp503HeFWf4is+j3V7z+iCdqP2ZFBhYHrbMXMYJqHjkfFSDAt5oOzslcaqxLgS
        sOmGD3CDYGoHMsWb6cv2QPaNX9EBKO8gFedS8ZAaWECyGlvTAFpuvMiWW5tbuOJeH1NNwyuLYjQ
        ==
X-Received: by 2002:a17:903:27c3:b0:19c:a3be:d9f5 with SMTP id km3-20020a17090327c300b0019ca3bed9f5mr13150554plb.48.1677424673446;
        Sun, 26 Feb 2023 07:17:53 -0800 (PST)
X-Google-Smtp-Source: AK7set+CONGL/soJ752w9TIARYRYmJdtvhuXySMAseoaSBSMOiKGasfRD/OBvi43H1Gj6z21Na3rBw==
X-Received: by 2002:a17:903:27c3:b0:19c:a3be:d9f5 with SMTP id km3-20020a17090327c300b0019ca3bed9f5mr13150536plb.48.1677424672951;
        Sun, 26 Feb 2023 07:17:52 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh20-20020a170903329400b0019ccded6a46sm2772223plb.228.2023.02.26.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 07:17:52 -0800 (PST)
Date:   Sun, 26 Feb 2023 23:17:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.02.19 onto master branch
Message-ID: <20230226151748.7v5vxoouvi7y72os@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.02.19 version.

Thanks,
Zorro

The new head of the master branch is commit:

9ba85b9a6f0f populate: fix some weirdness in __populate_check_xfs_agbtree_height

New commits:

An Long (1):
      [4eb6985b70ab] btrfs/011: use $_btrfs_profile_configs to limit the tests

Anand Jain (2):
      [085ee672b3d8] fstests: btrfs/185, 198 and 219 add _fixed_by_kernel_commit
      [63c4983ca5c5] fstests: btrfs/249: add _wants_kernel_commit and _fixed_by_git_commit

Boris Burkov (1):
      [150efa34087d] btrfs: test block group size class loading logic

Darrick J. Wong (16):
      [89224e31d44a] fuzzy: use FORCE_REBUILD over injecting force_repair
      [2690ec99261d] xfs: test rebuilding the entire filesystem with online fsck
      [76070f8f0e2c] xfs: stress test ag repair functions
      [4ec8fcc61022] xfs: race fsstress with online repair for inode record metadata
      [b3fc8bc8f7c0] xfs: test rebuilding xattrs when the data fork is btree format
      [ee1df86f65be] xfs: race fsstress with online repair for inode and fork metadata
      [4d1f5cae8771] xfs: ensure that online file data fork repairs don't hit EDQUOT
      [74a089e8bcb4] xfs: race fsstress with online repair for special file metadata
      [82d24c3cdac7] xfs: race fsstress with online scrub and repair for quota metadata
      [3a4d641020e8] xfs: race fsstress with online scrub and repair for quotacheck
      [c2c1a3f8c423] xfs: race fsstress with inode link count check and repair
      [a02d2818e9d1] xfs: test fs summary counter online repair
      [74065e2f1821] xfs: race fsstress with online repair for summary counters
      [a6cbb0cc0d5e] xfs/422: don't freeze while racing rmap repair and fsstress
      [215075d03ddf] populate: take a snapshot of the filesystem if creation fails
      [9ba85b9a6f0f] populate: fix some weirdness in __populate_check_xfs_agbtree_height

Filipe Manana (1):
      [2cbd24f84a63] generic/604: fix test to actually create dirty inodes


Code Diffstat:

 README              |  3 ++
 common/btrfs        |  3 ++
 common/fuzzy        | 71 +++++++++++++++++++++++++++++++++++---------
 common/populate     | 70 ++++++++++++++++++++++++++++---------------
 common/rc           |  2 +-
 common/xfs          | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/011     | 30 +++++++++++--------
 tests/btrfs/185     |  2 ++
 tests/btrfs/198     |  6 ++--
 tests/btrfs/219     |  9 +++---
 tests/btrfs/249     |  7 +++--
 tests/btrfs/285     | 50 +++++++++++++++++++++++++++++++
 tests/btrfs/285.out |  2 ++
 tests/generic/604   |  2 +-
 tests/xfs/422       |  4 +--
 tests/xfs/708       | 37 +++++++++++++++++++++++
 tests/xfs/708.out   |  2 ++
 tests/xfs/709       | 37 +++++++++++++++++++++++
 tests/xfs/709.out   |  2 ++
 tests/xfs/710       | 38 ++++++++++++++++++++++++
 tests/xfs/710.out   |  2 ++
 tests/xfs/711       | 37 +++++++++++++++++++++++
 tests/xfs/711.out   |  2 ++
 tests/xfs/712       | 37 +++++++++++++++++++++++
 tests/xfs/712.out   |  2 ++
 tests/xfs/713       | 37 +++++++++++++++++++++++
 tests/xfs/713.out   |  2 ++
 tests/xfs/714       | 37 +++++++++++++++++++++++
 tests/xfs/714.out   |  2 ++
 tests/xfs/715       | 38 ++++++++++++++++++++++++
 tests/xfs/715.out   |  2 ++
 tests/xfs/716       | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/716.out   |  2 ++
 tests/xfs/717       | 37 +++++++++++++++++++++++
 tests/xfs/717.out   |  2 ++
 tests/xfs/718       | 39 ++++++++++++++++++++++++
 tests/xfs/718.out   |  2 ++
 tests/xfs/719       | 39 ++++++++++++++++++++++++
 tests/xfs/719.out   |  2 ++
 tests/xfs/720       | 72 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/720.out   |  3 ++
 tests/xfs/721       | 38 ++++++++++++++++++++++++
 tests/xfs/721.out   |  2 ++
 tests/xfs/722       | 39 ++++++++++++++++++++++++
 tests/xfs/722.out   |  2 ++
 tests/xfs/723       | 40 +++++++++++++++++++++++++
 tests/xfs/723.out   |  2 ++
 tests/xfs/724       | 40 +++++++++++++++++++++++++
 tests/xfs/724.out   |  2 ++
 tests/xfs/725       | 40 +++++++++++++++++++++++++
 tests/xfs/725.out   |  2 ++
 tests/xfs/726       | 40 +++++++++++++++++++++++++
 tests/xfs/726.out   |  2 ++
 tests/xfs/727       | 40 +++++++++++++++++++++++++
 tests/xfs/727.out   |  2 ++
 tests/xfs/728       | 38 ++++++++++++++++++++++++
 tests/xfs/728.out   |  2 ++
 tests/xfs/729       | 37 +++++++++++++++++++++++
 tests/xfs/729.out   |  2 ++
 tests/xfs/730       | 36 +++++++++++++++++++++++
 tests/xfs/730.out   |  4 +++
 tests/xfs/731       | 41 ++++++++++++++++++++++++++
 tests/xfs/731.out   |  2 ++
 tests/xfs/732       | 46 +++++++++++++++++++++++++++++
 tests/xfs/732.out   |  2 ++
 65 files changed, 1369 insertions(+), 67 deletions(-)
--
Zorro Lang
zlang@kernel.org

