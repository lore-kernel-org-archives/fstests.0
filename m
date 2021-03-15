Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B44C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 11:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5392F64E99
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 11:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhCOLU1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229704AbhCOLUD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Mar 2021 07:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615807202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HRKBuXKFN76Zoc96hpFCwct6Yly+2MT4dfP/gKbydUI=;
        b=QUSBnpsp/xS3rOw/fNiaUj7jc4dLCfh+iyIZ4Hh+o71CiziYowOI4qXzqCgqAd4AfbkTXQ
        Y8D7xyXVKpDO7ftyR/o7pHVq1HCyVgXQYwfoXWboSlHFZ7acN3IKkpdZz6oTvqayGwj8D3
        8+oVPFhOPS0Kr7xV4pHFzr6g2gZjJH4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-zmj50nzdNrSR9w45oJ5pdg-1; Mon, 15 Mar 2021 07:20:01 -0400
X-MC-Unique: zmj50nzdNrSR9w45oJ5pdg-1
Received: by mail-pg1-f198.google.com with SMTP id e34so14713810pge.2
        for <fstests@vger.kernel.org>; Mon, 15 Mar 2021 04:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRKBuXKFN76Zoc96hpFCwct6Yly+2MT4dfP/gKbydUI=;
        b=uCvINB6ibNBquwntEE/X/HdI8DvYTx8orjaDRgAOiHR8HJQA8PDyGSJZ8Lak5JhnY0
         KnyGES27+kBe5PA5nibVti4AZLQXj+K/2lnVMK8Y5y7DkVuy1M1/xxMZIAyLyVxjmm6j
         kuMQxY3AteWanS3z7yalFV8Enl3OI/yAoleRvHKElmCGc4PztEXn9PgmllkjXCHjecHd
         oiRkiQc5uF10AYgNmvSQax7oV+7CbT6gGpolH2Dln/qyx590wWvh1BOnPwYE6Y1IzazS
         wHCGy2grUSV+e1Bf2LfWeCSL1s9VoLNy+7i/sqAoOAOadwwnVJ6vdNz1sVV1+GsvDSaj
         vWJA==
X-Gm-Message-State: AOAM531coexBjZcJtASVxBXlPDp3MS25n13y3mLmPkDZB0O0FXH0BN/3
        M4JsgtQptqz1JCNfMft1KbDH6CMwOfYQ0ZS23Oz8aGL+110wbH0EE/Nlk7j2vF7UlnNUCdLzHOP
        tLPPJjx3j7wuk424Yxw==
X-Received: by 2002:a62:7d14:0:b029:1f6:18a1:6b98 with SMTP id y20-20020a627d140000b02901f618a16b98mr9933832pfc.15.1615807199990;
        Mon, 15 Mar 2021 04:19:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJT7knaAeoW4gfZT7OeOw6acMAkh8kZnjJYd8L8xyqAG/9mfx46gsu+ys2AG1A86SSVXgEaw==
X-Received: by 2002:a62:7d14:0:b029:1f6:18a1:6b98 with SMTP id y20-20020a627d140000b02901f618a16b98mr9933809pfc.15.1615807199701;
        Mon, 15 Mar 2021 04:19:59 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r23sm11058448pje.38.2021.03.15.04.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 04:19:59 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Gao Xiang <hsiangkao@redhat.com>
Subject: [RFC PATCH v3 0/3] xfs: testcases for shrinking free space in the last AG
Date:   Mon, 15 Mar 2021 19:19:23 +0800
Message-Id: <20210315111926.837170-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

This version matches
kernel v8: https://lore.kernel.org/r/20210305025703.3069469-1-hsiangkao@redhat.com
xfsprogs RFC: https://lore.kernel.org/r/20201028114010.545331-1-hsiangkao@redhat.com

and mainly addresses comments for the previous version.

Thanks,
Gao Xinag

changes since RFC v2:
 - [1/3] add _require_scratch to _require_xfs_shrink() (Zorro);
 - [1/3] drop unneeded _scratch_unmount (Zorro);
 - [2/3] add _repair_scratch_fs for each test (Zorro);
 - [2/3] check new size after shrinking (Zorro);
 - [2/3] drop unneeded _scratch_unmount (Zorro);
 - [3/3] update group as "auto growfs ioctl prealloc stress" to follow xfs/104 (Zorro);
 - [3/3] use generic falloc instead of resvsp (Darrick).

Gao Xiang:
  common/xfs: add a _require_xfs_shrink helper
  xfs: basic functionality test for shrinking free space in the last AG
  xfs: stress test for shrinking free space in the last AG

 common/xfs        |  11 +++++
 tests/xfs/990     |  70 ++++++++++++++++++++++++++
 tests/xfs/990.out |  12 +++++
 tests/xfs/991     | 122 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/991.out |   8 +++
 tests/xfs/group   |   2 +
 6 files changed, 225 insertions(+)
 create mode 100755 tests/xfs/990
 create mode 100644 tests/xfs/990.out
 create mode 100755 tests/xfs/991
 create mode 100644 tests/xfs/991.out

-- 
2.27.0

