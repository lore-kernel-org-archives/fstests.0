Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A2C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Dec 2022 14:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLROu5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Dec 2022 09:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLROu4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Dec 2022 09:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF54B1FD
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2022 06:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671375009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=tXqa58NKmtZtZ8i8uKoOOOpwOMwP4FFZFlW94FVS9XM=;
        b=Tc1ioqXM7Xh/d7YOzdCf/hLsCtkig2AtgkirGymJwxf/qc25l9vSZlkmP1QXvrGTYOJnL1
        FPKEsr5wHd1RKmD6iuYnggbjfEJjZjBo9MZWOPWbNG7OXb1GjFLABsvRlPAxi8mJKCku7T
        h9Mlk8CK8nxhOjcYj7nL2ZJVnxUE8EI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-PwrQPxWZPS2piFgPk-Ii2Q-1; Sun, 18 Dec 2022 09:50:07 -0500
X-MC-Unique: PwrQPxWZPS2piFgPk-Ii2Q-1
Received: by mail-pg1-f197.google.com with SMTP id e7-20020a636907000000b00486a75ac49dso2642566pgc.19
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2022 06:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXqa58NKmtZtZ8i8uKoOOOpwOMwP4FFZFlW94FVS9XM=;
        b=frYEiCaPcI1cGrder1u/5RFs9XP6mnJEgBt5aOe5Sb3Gc/D/A1YOhRbRMsxmjalHky
         Ql+h6ILqfRHPps4JhHeCSago85UiARNUbFfsP7BbQr4RhrvJaL6lGQruXAigCMZ3DO6N
         S7bJPAjEFezVNIEr/uTb9PdaZ5Er4wp8zyua2S8n/3936uVxigOT6/bCwuvC+c3UeTBv
         I4MXMmoAz0IeFQ63aUlnfFsrUVfMbWu6Sdw5w85mKO2c6sbma7PbvfYduzDEy2cqVEAz
         egVfYE4tgbKrrMagSNQyIz07jxcO9A3+6H38vytphnXSSUg/7iWndZsVjnLAWLQmFaCF
         lLYQ==
X-Gm-Message-State: AFqh2koHxKeWkJl1AUvj9QULvmi5bN1DkjYf2Er/S68fwhKEFLgKf8hc
        82z08dO7CaU1wacSxnuhE6vSMaL6ROYBPc4LGeZ1Xh3paEF+hDiTtqRRTdRArmR4UBUpcnz9WRj
        t4uYS8FQGxTABC0SY+uRo9bF5GPwQpg13Up+83fPYfU+vWMQuEuEuKnyMJp+WmoRRtg==
X-Received: by 2002:a05:6a20:d2c6:b0:af:7233:5bfc with SMTP id ir6-20020a056a20d2c600b000af72335bfcmr7288000pzb.8.1671375006628;
        Sun, 18 Dec 2022 06:50:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuvx7x8WKCYnQC9xxqhXsdy4It7usp2mU7i1JIaDEgVmvomnxk/M4BTP7to95fonS+TLeVbOQ==
X-Received: by 2002:a05:6a20:d2c6:b0:af:7233:5bfc with SMTP id ir6-20020a056a20d2c600b000af72335bfcmr7287976pzb.8.1671375006173;
        Sun, 18 Dec 2022 06:50:06 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s11-20020a65584b000000b004771bf66781sm4471788pgr.65.2022.12.18.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 06:50:05 -0800 (PST)
Date:   Sun, 18 Dec 2022 22:50:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.12.11 onto master branch
Message-ID: <20221218145001.gjnhkryq2b2el3ef@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.12.11 version. This tag is signed by me,
feel free to rebase on it.

Thanks,
Zorro

The new head of the master branch is commit:

87ab8bdf20db fstests: batch update of file mode and untracked files

New commits:

Filipe Manana (4):
      [676b0a09706d] btrfs: add a _require_btrfs_send_v2 helper
      [1f423c9e6e05] common: make _filter_fiemap_flags optionally print the encoded flag
      [6f6559a88eb2] btrfs/280: also verify that fiemap reports extents as encoded
      [8742da385e00] btrfs: test a case with compressed send stream and a shared extent

Jan Kara (2):
      [7823f7c160d7] ext4/044: Fix failure when mount options are incompatible with ext3
      [8ec6f05efca7] generic/273: Limit number of files by available inodes

Johannes Thumshirn (1):
      [6e470ab87ad6] fstests: skip btrfs/254 in case MIN_FSSIZE is more than 1G

Qu Wenruo (2):
      [3d7044904ac2] fstests: btrfs/080: fix the stray '\'
      [e2e7b549380a] fstests: btrfs/219: remove it from auto group

Shiyang Ruan (1):
      [87ab8bdf20db] fstests: batch update of file mode and untracked files


Code Diffstat:
Code Diffstat:

 .gitignore          |  2 ++
 common/btrfs        | 14 +++++++++
 common/punch        | 40 +++++++++++++++++++++---
 tests/btrfs/080     |  2 +-
 tests/btrfs/219     |  2 +-
 tests/btrfs/254     |  1 +
 tests/btrfs/280     |  4 +--
 tests/btrfs/280.out | 12 ++++----
 tests/btrfs/281     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/281.out | 17 ++++++++++
 tests/ext4/044      |  7 +++--
 tests/generic/273   | 16 ++++++++--
 tests/generic/692   |  0
 13 files changed, 187 insertions(+), 19 deletions(-)
--
Zorro Lang
zlang@kernel.org

