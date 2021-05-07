Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54394C433B4
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D326145D
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhEGPCP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhEGPCP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:02:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C488461400;
        Fri,  7 May 2021 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620399675;
        bh=Ru4zRTXTaitvs/CC8jKQ+C/ZiKN+jVuyw541he08RYE=;
        h=From:To:Cc:Subject:Date:From;
        b=mNHNL246OtA/HwUsNAGpKRWEOzsekaAqiginlhHwI6jlcM95WWRnGPVCsnkdPMHZk
         b2g8doI8v1So4s5zhpUYb/tI65H5h3zecDwi88YQSKeKK39Johaq0uh6LU++MTF807
         ClKZT35cxX6MaDOHpoJWL7Af1Ea/fpR0IBgUX5Lbo8ixAJ/BI2wBHKXfYobwuglIcO
         Fj7ok4NaCH3RaSVEZAXkb4C274U+74uhxN7OLLJLqfyQM1T9Td8V/XwHoIR7YI7yLl
         1hDawK/6WyXzIHYaQA2Y2IoTi8UawA9ebURsxG6bNXoJEEmP+qaEqo3icWTwFzSYJo
         DkN10hXFmWf4A==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/7] idmapped mounts: extend testsuite and fixes
Date:   Fri,  7 May 2021 17:00:53 +0200
Message-Id: <20210507150100.968659-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

This introduces two new idmapped mount tests.
The first test extends the v3 fscaps tests for idmapped mounts.
The second test verified that idmapped mounts behave correctly when
nested user namespaces are used. In essence it creates a fairly complex
nested user namespace hierarchy and then tests whether file ownership
changes are correctly reflected in all idmapped mounts as seen from all
those user namespaces.
In addition this fixes a couple of minor things and shares more code
between the mount-idmapped and idmapped-mounts binaries.

Thanks!
Christian

Christian Brauner (7):
  idmapped-mounts: remove unused set_cloexec() helper
  idmapped-mounts: add missing newline to print_r()
  idmapped-mounts: split out run_test() function
  generic/637: add fscaps regression test
  idmapped-mounts: refactor helpers
  idmapped-mounts: add nested userns creation helpers
  generic/638: add nested user namespace tests

 .gitignore                            |   2 +
 src/idmapped-mounts/Makefile          |  16 +-
 src/idmapped-mounts/idmapped-mounts.c | 931 ++++++++++++++++++++++++--
 src/idmapped-mounts/mount-idmapped.c  | 228 +------
 src/idmapped-mounts/utils.c           | 359 ++++++++--
 src/idmapped-mounts/utils.h           | 102 ++-
 tests/generic/637                     |  42 ++
 tests/generic/637.out                 |   2 +
 tests/generic/638                     |  42 ++
 tests/generic/638.out                 |   2 +
 tests/generic/group                   |   2 +
 11 files changed, 1397 insertions(+), 331 deletions(-)
 create mode 100755 tests/generic/637
 create mode 100644 tests/generic/637.out
 create mode 100755 tests/generic/638
 create mode 100644 tests/generic/638.out


base-commit: 40818883aecd19581a71cc096d07eb9106c11b10
-- 
2.27.0

