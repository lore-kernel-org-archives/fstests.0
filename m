Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D4C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 09:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiEZJ5O (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 May 2022 05:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiEZJ5L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 May 2022 05:57:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED10C9EC2
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 02:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56450B81ED7
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 09:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71533C385A9
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653559028;
        bh=yDQWXozBVyWjawbIZFK14dDVIjQCbTaMak/9+I5Fo6o=;
        h=From:To:Subject:Date:From;
        b=q4IMF2Dy5mM+mf8zII9eNxYUI9xpFUxA4rbcVgMHNtGQTTOMode8iEAt9cjlAc3x0
         8W2WMKWksq81nChjd23keMyz8vdUC1S31KtxEdQxuZu85v5wiKQjA3hsfLZrp6bjrU
         rtNIM9o+j+/eCX6FmUbh158mJr8YbpxspRHCPeKB3zryR9E4SNxej3Tny0737Q/uju
         8BLBpfvJgt8Kza3QEP5ys3L5cAomtIQXilV+a+vQKumT8oDuNVTavJb4Y/9k05L0ze
         DFXZ9Y6LgeGQ7M89hzppsxNO7rplTgnGATkd1g7g7V5FTHMmIDgvlK0Qr9vCof0Rtb
         e8EmSwO929AdQ==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: filter out extra mount error
Date:   Thu, 26 May 2022 17:57:04 +0800
Message-Id: <20220526095704.3772355-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The lastest mount command (from util-linux) merged below commit:
  79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
which brought in a new error output when mount fails.

That cause some cases (e.g. xfs/005) fail as:
  mount: Structure needs cleaning
         dmesg(1) may have more information after failed mount system call

More failed cases like generic/050, ext4/002, xfs/154, etc ...

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Due to _try_scratch_mount is call in many places, so I'm not sure if it's good
to filter this message in _try_scratch_mount. Maybe better to filter it in each
failed cases? Or write another function (e.g. _try_scratch_mount_fail) ?
Welcome review points.

Thanks,
Zorro

 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 70a15f9c..67342760 100644
--- a/common/rc
+++ b/common/rc
@@ -335,7 +335,8 @@ _try_scratch_mount()
 		_overlay_scratch_mount $*
 		return $?
 	fi
-	_mount -t $FSTYP `_scratch_mount_options $*`
+	_mount -t $FSTYP `_scratch_mount_options $*`  2> \
+		>(grep -v "dmesg(1) may have more information after failed mount" >&2)
 	mount_ret=$?
 	[ $mount_ret -ne 0 ] && return $mount_ret
 	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
-- 
2.31.1

