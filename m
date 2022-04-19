Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C4C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350534AbiDSM72 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350475AbiDSM7Z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 08:59:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70543206D
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 05:56:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g18so22285449wrb.10
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAcQVZLKpaxPlSx2/CMIgoJtyVV7xKofhfaFWnwMmnU=;
        b=o1Q2F2u73sSjntDrgkhLA4oLVofmeQQw9Y1dh5mG0Xt9URTsCQo8BEZVvbLycRttAu
         FMU6pf9FTUq0cw+OOzO70uRE8qo/mxgNEg/zSYcU2jA8XuFIhpeCs0xP7A7EpV/oxoPO
         r29DwFrYugdP4bS++h/d/QhJ76nbH65/6gizcGVybUf9de3M6Lc93ficFb8q+Yr43UuG
         QH5X9XLR75haAGITZPExou9jBMIZT7mUypDMSFqFHhUz1NDDpdEqV0ZUp42tnglvFtT4
         6SqS4zTPLL+X2rUhFGwv0YOUSvV7sSTopsYqh5W5gDxP30Luult0ZJopYY7nc2Huwd+8
         s5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAcQVZLKpaxPlSx2/CMIgoJtyVV7xKofhfaFWnwMmnU=;
        b=1kC7bHMz6eTBBR1zwFkUD5sTBdGGzS7gcUs/J+DkKyYkUVZid410RHoLzSYxi0Wd+Y
         flHRV5Fo60lFqDGjVYjcbi7FU+GQ7Skb7AfL73FaiR1A8sRPpFzHEKCI8IlsB/0wXOK6
         ahdJAM8Y2zjFSnIE/cjp0GTh8htQvDAQDh6BmerJkPMUlFFgSfvZ7NkhQIoTwmyVpq6q
         0wO1zo1W+WRTHLGhqlIyOWQOUPjfwwii1EsZhuNIE0vayNC3AfX7k0QjTDyeDSzesL2s
         wQCwJBuRZNLXoP7gxWyvruSPi1LKJF6x/5ojBBYM8A+/9QoVVY4wywHIUF5PdUufjjLc
         aoGQ==
X-Gm-Message-State: AOAM530M979oYSlIu8dITm/jO2S+ZJ2K+fYbKu3pZbUvhQ30SUoIrrCB
        Pwxyaf0FAe7MdhHGnGMhdU1Zp9YybCw=
X-Google-Smtp-Source: ABdhPJx5+SFfffNUinSRA3gOSuRRyfXXMSMjL4+Krr6PBD/P33Up0dYMwROzbdB+qt8B5fBymX/DyQ==
X-Received: by 2002:a5d:5849:0:b0:205:85cb:baaf with SMTP id i9-20020a5d5849000000b0020585cbbaafmr11692049wrf.442.1650373001094;
        Tue, 19 Apr 2022 05:56:41 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b00207aac5d595sm12499142wrx.38.2022.04.19.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:56:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: [PATCH v2 0/2] Annonate fstests with possible reasons for failure
Date:   Tue, 19 Apr 2022 15:56:35 +0300
Message-Id: <20220419125637.2502181-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro,

This series adresses your review comments on v1.
Specifically, I dropped the controversial patch #3 and the
SKIP_KNOWN_ISSUES run option.

To clarify, multiple annotations could be used in each test,
for example:
 _fixed_by_kernel_commit 09889695864 xfs: foo
 _fixed_by_kernel_commit 46464565465 ext4: bar
 _fixed_by_git_commit e2fsprogs 62464626 e2fs: baz
 _fixed_in_version xfsprogs v5.15

On test failure, all the hints will be printed to output as *possible*
reason for failure.

These annotation and printed hints are inspired by a similar LTP feature.

These annotation could be used by testers to auto-generate expunge list
for testing stable kernels from the information in _fixed_by_kernel_commit
and _fixed_in_kernel_version. This trivial task is left is an excercise.

Thanks,
Amir.

Changes since v1:
- Rename s/_known_issue_before_kernel/_fixed_in_kernel_version (zlang)
- Add generic helpers for non-kernel fixes (zlang)
- Drop _known_issue_on_fs (zlang)
- Clarify multiple hints are allowed (tytso)

Amir Goldstein (2):
  common: support black listing fs in _supported_fs()
  common: print hints for reasons of test failures

 check             | 10 ++++++++-
 common/preamble   |  2 +-
 common/rc         | 57 +++++++++++++++++++++++++++++++++++++++--------
 tests/generic/500 |  3 +--
 tests/generic/631 |  3 +--
 tests/generic/679 |  3 +--
 tests/overlay/009 |  3 +++
 tests/overlay/010 |  3 +++
 tests/overlay/014 |  2 ++
 tests/overlay/016 |  4 +++-
 tests/overlay/017 |  4 +++-
 tests/overlay/018 |  4 +++-
 tests/overlay/020 |  3 +++
 tests/overlay/022 |  2 ++
 tests/overlay/029 |  2 ++
 tests/overlay/038 |  2 ++
 tests/overlay/041 |  2 ++
 tests/overlay/042 |  3 +++
 tests/overlay/043 |  4 +++-
 tests/overlay/044 |  4 +++-
 tests/overlay/054 |  3 +++
 tests/overlay/055 |  3 +++
 tests/overlay/063 |  3 +++
 tests/overlay/065 |  4 ++++
 tests/overlay/067 |  3 +++
 tests/overlay/070 |  4 +++-
 tests/overlay/071 |  4 +++-
 tests/overlay/072 |  2 ++
 tests/overlay/074 |  5 +++++
 tests/overlay/077 |  5 +++++
 tests/overlay/078 |  1 +
 31 files changed, 133 insertions(+), 24 deletions(-)

-- 
2.25.1

