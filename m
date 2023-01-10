Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC12C678D6
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 22:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjAJWCB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjAJWBt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 17:01:49 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9D4859A
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:01:47 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id c82so5953021ybf.6
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPL4YCj2HQuiFMiL52YqTW1GTg66rhdvhpK2PJ8LIRs=;
        b=eMcVAnPg0N6bpAH0YJ6WHF406gfB8Que6lTt7gW9wLoEOYhsI0w3A/7iI/aMS/ZHzk
         33XgDPaX8RY5DQIbaPpwZesoRc/YNkTsS3TNWlehq2PFpu1XozDQwAbnm+6GAF+CPZOf
         id+Y9z1UnM+Aq1MogYxxRdOLdyLqj+6aDyklxw5Kr97qzmfj7kC3jbWQVt+yvIb1G/Ek
         c6BwcznPtaH5tvf6PcdsxdYwsZ/vjwXwEvJtqIpTwCrtLLNjFvS2QGcp6PucFanq+ecO
         hsbMJYajxi1Qneb4QzB+U93J82CQ5e9gJLak95uYWLI1k7TMTPSlCDr3zd8hb0Ga0wAL
         xLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPL4YCj2HQuiFMiL52YqTW1GTg66rhdvhpK2PJ8LIRs=;
        b=gmDONYUIgPvA232EUH2ecNcHSh/CajrmABkXBMDLhcp90Mjsp+noatgkm/OKMFSQiz
         /EewLk4CDtlRg1t4Q/vIlfooLIL153sHJcyqzaEL+t9vFVBSxHG0HkRBJHOjWTTMuG32
         Rv0ydOLb6wJnhkFsYhQc0lWHBEqxeRjiIfBf6bStKz95iMyfkRY07iktUA4ypOs9xcFG
         fgwDrzsv6polnL/wZZYSbV6SwgUpktQGpPgmu/v+5P+utMNEs1zdvX7hGrA9ua60hm7C
         1ew9a46/m+69MBMDodVS+X4lFaLZ+mZ1/ufv/oV4Y7nduu99EqqG8DX9F40s4GpwHTTa
         6Rtw==
X-Gm-Message-State: AFqh2kp9bvcbVN5aDoiQrn/mVhsSyhkol4OR3gQsj829bLxUx8e3n7v3
        4EkMY7LhiXc+6aGheiJF/mDrnQ7eHlg=
X-Google-Smtp-Source: AMrXdXutgvksa6DW3NsC0sVP+tf+iud28KoekNF4/o8p4WoZ2/xVZPaLLxsn22Uoc6uTVfa3OZGjqQ==
X-Received: by 2002:a25:b8c8:0:b0:706:c69c:29be with SMTP id g8-20020a25b8c8000000b00706c69c29bemr60302246ybm.42.1673388106927;
        Tue, 10 Jan 2023 14:01:46 -0800 (PST)
Received: from shiina-laptop.hsd1.ma.comcast.net ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a454800b006fc7302cf89sm7936709qkp.28.2023.01.10.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:01:46 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH 0/2] xfs: test xfsrestore on multi-level dumpfiles with wrong root
Date:   Tue, 10 Jan 2023 17:00:56 -0500
Message-Id: <20230110220058.139131-1-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

To ensure 'xfsrestore -x' works well, this fix adds a test for
'xfsrestore -x' with multi-level dump files. The '-x' flag corrects a
wrong root inode which can be created by problematic xfsdump (v3.1.7 -
v3.1.9) because of bulkstat misuse.

Before adding the test, a helper function to create a fake root is
added.

Hironori Shiina (2):
  xfs: add helper to create fake root inode
  xfs: test xfsrestore on multi-level dumpfiles with wrong root

 common/xfs        |   38 ++
 tests/xfs/545     |   31 +-
 tests/xfs/554     |   35 +-
 tests/xfs/560     |  125 ++++
 tests/xfs/560.out | 1517 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1690 insertions(+), 56 deletions(-)
 create mode 100644 tests/xfs/560
 create mode 100644 tests/xfs/560.out

-- 
2.39.0

