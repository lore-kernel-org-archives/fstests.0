Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD2EC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Apr 2022 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiDQRnG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Apr 2022 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiDQRnF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Apr 2022 13:43:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D765A2ED6F
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so16265926wrr.9
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1micQICcO+8J/NuzCiw/BJXQmRmH489XmrXaxQYAGo=;
        b=jNaZ/hefVQaJRPB5a4srfhZf/FIzjuqGTbBJeb2p+OSI6hqClqAvkELU0nM5I5r5PM
         MHcozvW+jp3+obacAu4ed9rbvcEWAges9ClNguzYZIAVbwlXj8ftaUMyt0Z7CQUVeMx8
         Nf8Lz5nRO//bFgpafuV3fqC8Q3sWQ2hUl2GPV27mZJIkt1hVxS1c4JRaKGC/NH8ldK6+
         /VdGfuJ+8y5DsTsscX3To2V2FGWHUAVqLzuNwp33EyMe1QPkkWtsdl6Zwmtnu/M9F91q
         QRKlyZl9/H10Jibp9qBqpxNYmVtoRepgNvpaeGH42aFy5htktqi1LoIRhZorAYlRqa7L
         ZGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1micQICcO+8J/NuzCiw/BJXQmRmH489XmrXaxQYAGo=;
        b=gZStKPLnoBBla1piN/DvxSIOnugxQGP0JWVBSe25l0j6qEie/XMW+BiJbk6XIwYAC5
         N+qxiYFmypwXeMqjs+OuGlh1YYkgXFvmDRPosF9POrnJTSPNAFspJaIanQkyWjz9tVM0
         KkxC7RJtaQ79nKvGPwpi5ccX8DL5ckcLwVVps4cm8+yf6llO6XmAa7PVg/9Y14JUMCqT
         6tyiU8e8Uce6WqZo+B7ArzWrYRsxOPwDxi4Qp8mKWWv8T3/Tv6fYF89b6WCnp4qr0JYV
         PBEcj+zmIXd0o2YGNqeo3z6TzCN4GcwVwjDdv8+ezPwERnYl7u2iW1KjK6me47sw2p+s
         c5oA==
X-Gm-Message-State: AOAM531fRRnsfK+lrRTn6tOfk4P/XoPL2BH0K/An4U+QOQDRteVb5R53
        k+jL884nrd2IzKB4fqs8apU=
X-Google-Smtp-Source: ABdhPJyoZ1o/n6WcjwGDvyuzTj4FwGeqVx9WtPYzq1GFtec/RtWRhS+QBqGMEl6kl8Dx+b6uNxLr0w==
X-Received: by 2002:a05:6000:230:b0:209:87ac:4cf5 with SMTP id l16-20020a056000023000b0020987ac4cf5mr5820761wrz.80.1650217227335;
        Sun, 17 Apr 2022 10:40:27 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm9108564wrg.70.2022.04.17.10.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:40:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH 0/3] Annonate fstests with possible reasons for failure
Date:   Sun, 17 Apr 2022 20:40:20 +0300
Message-Id: <20220417174023.3244263-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In a perfect worlds, tests are expected to pass, but we do not live in a
perfect world.

In reality, fstests are often merged before a fix is merged to Linus'
tree or before a fix to all fs is available [1][2].

We all know that day when we pull fstests upstream branch and get a
bunch of new test failures.

This series [3] adds several new ways to annotate tests to provide some
hints for testers about which tests are expected to pass on which fs
and or which kernel versions:

 _fixed_by_kernel_commit
 _known_issue_before_kernel
 _known_issue_on_fs

And a new run option SKIP_KNOWN_ISSUES=yes.

These annotation and run option are inspired by a similar feature in LTP.

These annotation could be used by testers to auto-generate expunge list
for testing stable kernels from the information in _fixed_by_kernel_commit
and _known_issue_before_kernel. This trivial task is left is an excercise.

Thanks,
Amir.

[1] https://lore.kernel.org/fstests/20220412172853.GG16799@magnolia/
[2] https://lore.kernel.org/fstests/20220414155007.GC17014@magnolia/
[3] https://github.com/amir73il/xfstests/commits/hints

Amir Goldstein (3):
  common: support black listing fs in _supported_fs()
  common: print hints for reasons of test failures
  common: add run option to skip tests for known issues

 README            |  2 ++
 check             | 10 ++++++++-
 common/preamble   |  2 +-
 common/rc         | 54 ++++++++++++++++++++++++++++++++++++++++-------
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
 tests/overlay/061 |  2 ++
 tests/overlay/063 |  3 +++
 tests/overlay/065 |  4 ++++
 tests/overlay/067 |  3 +++
 tests/overlay/070 |  4 +++-
 tests/overlay/071 |  4 +++-
 tests/overlay/072 |  2 ++
 tests/overlay/074 |  5 +++++
 tests/overlay/077 |  5 +++++
 tests/overlay/078 |  1 +
 33 files changed, 135 insertions(+), 23 deletions(-)

-- 
2.35.1

