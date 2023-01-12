Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B5C61DB3
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 22:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjALWZw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjALWZY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 17:25:24 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7451C102
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 14:23:16 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d16so4749266qtw.8
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KyBoqOq2P0BwT+Vo/t9AnqnKpbro5FdGqo3uRiPoiM=;
        b=JTlQyGLUnV+9u48+Wawd3/hZHsh4ufepw1LDQsh6o0OVQXn9QPAMNd/m13J5ZpIM0w
         1zmhhE1gkoKCwWRuaxwEqIxusjWMoVchgCGSccNTbAI5qIOJoqH61RS9zaAPRpeUQ2lT
         rkk+dUk2c/Al8lU5xIWWfX84SXE97ZXjud8noldNGCgeBe1SK6kEX2ELPIkXwN0GnRiC
         oe8huKO39tVPg/r45j5sGVNh3PwHIVNwsLtCL+4MGUxZRowhOImUDrqXKIuUHiTujx71
         sa6r8XYO7Iv4R0OHq+OZVpyH4pKN840sZsCPjz7kdKn15YTIIPjXxlCuFTp8l6mNf4Fr
         Kfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KyBoqOq2P0BwT+Vo/t9AnqnKpbro5FdGqo3uRiPoiM=;
        b=FVACiKUsjnxcBMlT4skoDMhwBLNeEC7CyqFrXALPPRRLhSCLWCm1o6eeH05Ez08z7W
         Q/VH14EbF+h5VmszMOd1MnBxCN9XjYtwN4kCKrezlZ9608ms3jY/+7Ev2u8jGrVLaz3b
         IRN482v0PdJ0Ex2153Xdd3TlxGpf9+T1mJkXClzocOiRpP7WOSvZrQww6RchiXOF4qBQ
         RV0zTcsvwc+ISvHBfaLszHTBZHbIc+jZ1uqOMlRXVvsDNmLMRnVn7xvBJY/yv4Ro/l5B
         o2rPvzeoPfpa7epsrDTtpCRV3LEVGSiWVRCHyKFpmqdes/I7IWCCZ6X2W6aPP1/NeDHM
         7DkA==
X-Gm-Message-State: AFqh2kr3rD24z5TxddEtTHcQIiugqQegtw6TanrohPQ/pz+vt0iLGoL+
        /3BPR+PrY6qiafnn0tpiXNc4fHZ61xY=
X-Google-Smtp-Source: AMrXdXt9Nk8lNUPyqbQ4gQXX/xVng48LYO5+fi1HQNPMvpJlukdn6AcSfFPHsi1O/i4jAqpDeBNCJg==
X-Received: by 2002:ac8:6e87:0:b0:3a8:11f3:b81c with SMTP id c7-20020ac86e87000000b003a811f3b81cmr105851988qtv.53.1673562195278;
        Thu, 12 Jan 2023 14:23:15 -0800 (PST)
Received: from shiina-laptop.redhat.com ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id r8-20020a05620a298800b006bb29d932e1sm11701320qkp.105.2023.01.12.14.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:23:14 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH v2 0/2] xfs: test xfsrestore on multi-level dumpfiles with wrong root
Date:   Thu, 12 Jan 2023 17:22:40 -0500
Message-Id: <20230112222242.153502-1-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For 'xfsrestore -x', a few more tests are necessary because we hit an
issue at the cumulative mode while developing this feature:
  https://lore.kernel.org/linux-xfs/e61ae295-a331-d36a-cae1-646022dc2a6e@gmail.com/
This fix adds a few tests to run 'xfsrestore -x' to the multi-level
dumps with various file operations referencing existing tests.

Before adding the tests, a helper function to create a fake root is
added.

changes since v1:
  - Introduce the new helper to xfs/557
  - Elaborate the background of this fix
  - Add one more test for multi-level dumps based on xfs/065

Hironori Shiina (2):
  xfs: add helper to create fake root inode
  xfs: test xfsrestore on multi-level dumpfiles with wrong root

 common/xfs        |   38 ++
 tests/xfs/545     |   31 +-
 tests/xfs/554     |   35 +-
 tests/xfs/557     |   31 +-
 tests/xfs/560     |  125 ++++
 tests/xfs/560.out | 1517 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/561     |  213 +++++++
 tests/xfs/561.out |  849 +++++++++++++++++++++++++
 8 files changed, 2756 insertions(+), 83 deletions(-)
 create mode 100644 tests/xfs/560
 create mode 100644 tests/xfs/560.out
 create mode 100644 tests/xfs/561
 create mode 100644 tests/xfs/561.out

-- 
2.39.0

