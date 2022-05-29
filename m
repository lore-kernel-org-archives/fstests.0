Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2EDC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 10:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiE2KzN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiE2KzN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 06:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4C62CD0
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 03:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F30360C59
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80787C385A9
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653821711;
        bh=VAnwX6Rd0WvrnzTauSOl40v+/9yxK3eHMS1ktOE+TcY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OfrGex+guvfiigVR2sGP6hIeMNDvqEbgsK/+dpcJC/v9XDbqDfDG614ryM4a5HdiW
         aYAB4crN7icjl2o+utyLerGljJIf4K7A6cl8HTACudfh2qfg7ESQPVUiby1gbXbFcH
         jb4q9R0QmZaBwjqCESNDiwo4JqVQcCm+ch5svrmAdNP5eqMKraI8WjzAT1CHI05wjV
         FWa7O9+8GVqBH7+9V7JjprEK46VomSzjqbIhVWlpKDDVsvbDkW4D8/Csq4t5eiRHK9
         4jC44qW3nCKH3/7u+BEiitvLkjcVY2bz7Px6vXmZYum/b+os8MuPq9FcBIzpNgqR7F
         6GDu1T4CzSRxw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/5] generic/506: call _require_quota before _qmount
Date:   Sun, 29 May 2022 18:55:02 +0800
Message-Id: <20220529105505.667891-3-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220529105505.667891-1-zlang@kernel.org>
References: <20220529105505.667891-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The g/506 fails on some filesystems (e.g. overlay) which doesn't
support prjquota:

  MOUNT_OPTIONS =  -o prjquota
  qmount failed

To avoid this failure, call _require_quota before doing real quota
mount.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 tests/generic/506 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/506 b/tests/generic/506
index 25a5b0f8..ec91af78 100755
--- a/tests/generic/506
+++ b/tests/generic/506
@@ -27,6 +27,7 @@ _begin_fstest shutdown auto quick metadata quota
 _supported_fs generic
 
 _require_scratch
+_require_quota
 _require_scratch_shutdown
 
 _scratch_mkfs >/dev/null 2>&1
-- 
2.31.1

