Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CDAC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiFURhl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiFURhi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 13:37:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77D2C673
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c21so19954679wrb.1
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ2IC4zVsrLXI6SfkGeF94WnniQ41DcKpT4ccA5f3kA=;
        b=frCSob2bDfMV4gFYOElq9h1+89Pzmrtn1kui/rudE0x33VC+kVNHBZWo5U8BKiK5SH
         ueHHI6+NnQZHxfdz+Acw76KiLNIpiF2PmdoX+Sh63V7gew5hztaOgHIF4zWN9nLUSM3Z
         lsyjWyqtVsRr+yrgaatQgd/nwdiEZ3hRkNPWpaok8D0fjJBjM45vGOTyMaklzZQuD/p1
         cRdZljKbjBi8sKpzoUvObgl4lvhvlqJXVybrIhrXutulRtT31N9H7ZO2MOkPebdZt8PV
         prBrfL+5bG8FEBwvxdsYJUAkNU/NuHTYI0+j/O3nx78F2BYt8cl8I2dEg0eI/ZuRYMQv
         gJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ2IC4zVsrLXI6SfkGeF94WnniQ41DcKpT4ccA5f3kA=;
        b=dB6cghXYCGga6dP03efo+JelQI2P59Wksb0MkM52NkV3FJxhO0JyV9ONsb/kqPjwFK
         OWT7Wv2acKeXRPVvs5saae0GO1trGkyCGxbDXj+5uO4iqAm4EhcolmRdl1EqBjU4UVkA
         NX1mt5lgXSYuU+oRqHJVVhwKjadfNs8R6E17P3Zc9htQxOvYQHVi+YUV4vXIwEHUcQDT
         7IOQx414kNKK89UzMVk5FqKU1GJbcDvm76LtFbpiv+EpR6ixb75+rRIce1Ihc8mxjMH4
         74dbQwKeZDR/U86JJBfrDgS3i/4dAnjIXP6HpWJlXqpOuEiEQ3m7+JkzbzW1SBA/otaw
         SuNQ==
X-Gm-Message-State: AJIora+1UN4weOftMpl4G2Uk2BBJ31jf2dxe3HHcsjqkT/97YiWZY33F
        t6J+UoIuveGCddj5z4+XaZ0=
X-Google-Smtp-Source: AGRyM1tlXN1qNtCfN8nkJnT/hWSswUQM+nlkliSA0oXQYLMLnJP+hIvl7xsWZ0TuZt/n/wLgpZmwhg==
X-Received: by 2002:a5d:5a81:0:b0:21b:6f28:f65f with SMTP id bp1-20020a5d5a81000000b0021b6f28f65fmr22401012wrb.87.1655833054878;
        Tue, 21 Jun 2022 10:37:34 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6e91000000b0021a39f5ba3bsm16105120wrz.7.2022.06.21.10.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:37:34 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH v2 0/3] aborted fstests may leave frozen fs behind
Date:   Tue, 21 Jun 2022 20:37:26 +0300
Message-Id: <20220621173729.2135249-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro,

As discussed on v1, this series fixes cleanup routines of
freeze tests without adding auto-cleanup in check.

I also took a closer look at some test cleanups and handled the
kill of background processes after unfreeze.

I tested that all the tests in the 'freeze' group that I modified
run to completion with no regressions.

I did not try to interrupt all the rest of the tests, because
interrupting a test at exact time that it is frozen is quite hard.

I did test that interrupting xfs/517 several times did not leave the fs
frozen.  Before the changes, it was rather easy to get it to leave a
frozen fs behind, because the freeze_loop() keeps the fs frozen around
half of the time that the test is running.

Thanks,
Amir.

Changes since v1:
- Remove auto-cleanup in check
- Add more kill+wait in cleanups where needed
- Change the cleanup routines of the freeze_loops

Amir Goldstein (3):
  fstests: add missing _require_freeze() to tests
  fstests: unfreeze fs on cleanup routines
  xfs/{422,517}: kill background jobs on test termination

 tests/generic/068 | 14 ++++++++++----
 tests/generic/085 |  3 +++
 tests/generic/280 | 13 ++++++++++++-
 tests/generic/390 |  8 +++++++-
 tests/generic/459 |  2 ++
 tests/generic/491 |  9 +++++++++
 tests/xfs/011     |  3 ++-
 tests/xfs/119     | 10 ++++++++++
 tests/xfs/297     | 11 +++++++++++
 tests/xfs/318     |  6 ++++--
 tests/xfs/325     |  6 ++++--
 tests/xfs/422     | 35 ++++++++++++++++++++++++++++++++---
 tests/xfs/438     |  4 +++-
 tests/xfs/517     | 27 ++++++++++++++++++++++++---
 14 files changed, 133 insertions(+), 18 deletions(-)

-- 
2.25.1

