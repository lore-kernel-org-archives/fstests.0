Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B5CCA47E
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jun 2022 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiFSNr0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiFSNrI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jun 2022 09:47:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0290C6378
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so359461wmb.5
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeM4C3LJEJ2YOy8YiYjY8tslsHGZfBwi4HmTLMK9ZlI=;
        b=O6EOMRM0m4hD8DR+N46u2nwA1g2zlFzMRb9KxxNTeAYYhntttlajxFfj6XN1OpibkO
         U9VrNuVZIoqRcg2P4w9r69Uf95gmjBHAkeOtRpFB8yWGDg9ZnQ7tHADdykUWql4SLy65
         Bg3AcBeAJL+hiBIGzcx/c+lWeQFAC83BiVEON80qsD3cZ7FFFVkDPpokZ69az5VUknb8
         SXhTy+P0kft/Tjj0DCpuDjkkZ9F2XgJIxyffTBLdT0k+JunXV42YRNL4a2SFoOF8xphL
         c6Yb9RLrkSuB62gipuMEG6FOWDrnoyKJyPGig42esXuCdK0uJ69q8EgfII5xzgq/Q7c8
         G13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeM4C3LJEJ2YOy8YiYjY8tslsHGZfBwi4HmTLMK9ZlI=;
        b=F1gc4UgBScjZZvkAP6cwkbAWmPw62YUG+CHv8uq23W8qd/DQWp3O73MEdeOHm7TKXh
         kn+XrXd3omisIBrWbL760B/VWx3Eeu45uEMSxbbwc42ZXIpdBomiFbQ0COl0IBKKW+y+
         LHm3HBrYFXB5YeNLnc4gEUvZMR4Ob4fzMEQUXJmDwNaMShWiioSvkxD/RIgu3PUjIaoG
         XukxjPDqhfo/ZGZxB7ZfyPCUXnAXG4qAnGXONeppgdd5T0KnZcXwgTkhzAIgsYwIoQPz
         HsWY5g5l7GSYgF/fEBU6fGCgEcH494auQ6SnQ2vQIEjRv64yoa5cHRKCWmN59IMF++va
         illw==
X-Gm-Message-State: AOAM530lwFBKtwOYxk20BnkGUAYo72r++kz0p9uKjXMsiinRHfK/Ohy8
        0VsrQ5lFnC2jteyaeCvpYVM=
X-Google-Smtp-Source: ABdhPJxK19tp5fnOgW96HI5UCQ7Ajhw2Qu5kGED7uoNzIv6y5yidNEuziZMQWJezODsSVCocgjtisg==
X-Received: by 2002:a05:600c:25cd:b0:39c:6bc0:a1fb with SMTP id 13-20020a05600c25cd00b0039c6bc0a1fbmr30569202wml.179.1655646425372;
        Sun, 19 Jun 2022 06:47:05 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b00219e77e489fsm5240927wrj.17.2022.06.19.06.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:47:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH 0/4] aborted fstests may leave frozen fs behind
Date:   Sun, 19 Jun 2022 16:46:53 +0300
Message-Id: <20220619134657.1846292-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro,

I was analyzing a flakey test failure of xfs/517 and
fell down a rabbit hole of frzon fs cleanups.

Patch 4 fixes the false positive I was running into occasionnaly
in cases where xfs/517 was completed successfully.

While testing, I found out that if I interrupt the run of xfs/517
this often leaves the fs frozen. So I did an audit of the tests that
freeze the fs and found that very few of them unfreeze fs on interrupt.

This is an attempt to provide a robust solution that minimizes the
risks of that happenning.

I tested that all the tests in the 'freeze' group that I modified
run to completion.

I did not try to interrupt all the rest of the tests, because
interrupting a test at exact time that it is frozen is quite hard.

I did test that interrupting xfs/517 several times did not leave the fs
frozen.  Before the changes, it was rather easy to get it to leave a
frozen fs behind, because the freeze_loop() keeps the fs frozon around
half of the time that the test is running.

As far as I can tell, this series is orthogonal to Dave's _cleanup()
work [1]. It adds missing cleanups to tests (e.g. xfs/422) that could
later make use of the common cleanup helpers (i.e. _fsstress_cleanup).
However, the common _fsstress_cleanup() helper will need to kill without
waiting. To my understand, Dave was also against waiting in the cleanup
helper.

Thanks,
Amir.

[1] https://lore.kernel.org/fstests/20220524073411.1943480-1-david@fromorbit.com/

Amir Goldstein (4):
  fstests: add missing _require_freeze() to tests
  fstests: make sure to unfreeze test and scratch mounts
  xfs/{422,517}: add missing killall to _cleanup()
  xfs/{422,517}: fix false positive failure

 check             | 14 ++++++++------
 common/rc         |  5 +++--
 tests/generic/390 |  2 --
 tests/xfs/011     |  2 --
 tests/xfs/119     |  1 +
 tests/xfs/318     |  3 ++-
 tests/xfs/325     |  3 ++-
 tests/xfs/422     | 16 ++++++++++++++--
 tests/xfs/438     |  2 +-
 tests/xfs/517     |  8 ++++++--
 10 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.25.1

