Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99C9C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 10:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiE2KzW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiE2KzS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 06:55:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F5262CD0
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 03:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1627DB808BC
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D20C3411C
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653821714;
        bh=Mx0P0qH3WA3hMpnVdncZtbzIDGfcYLD3Kvd2uajX5Fg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZBwx4+UJwgEjEtCKf0ceWLtaPAuKbYLybQkCL0aQfBDgdFbrFGV6Go7Me2vLkF8xr
         liWsS+x9B+bcxjQESZsQqws6Fu00X21dYcmuxRlFtsQs712YOHHo261SIaY1ep8618
         66NhA14fuCYXCw9gHl0fl9f0iIjy1MPAVGTfUbddIZqtCTB866IIhrsNHi82fPgBXs
         Lh5uLikT03XFN1IodMCSobiKTto1XazfujdN6r6ILSn5jhacAP48U0HUzNZHimbH8g
         /jxiqKdcX0I+4qlAbZhs0b00BWJ8J81nBgQPA+LeZPPNHgM9lVhsqrM46i1JcpNv71
         fm84Z8VEbi6Sw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 5/5] generic/623: add overlay into the blacklist
Date:   Sun, 29 May 2022 18:55:05 +0800
Message-Id: <20220529105505.667891-6-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220529105505.667891-1-zlang@kernel.org>
References: <20220529105505.667891-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The _require_scratch_shutdown can't help this test case, except use
_scratch_shutdown or _scratch_shutdown_handle with it. But this test
case does 'shutdown' on $SCRATCH_MNT/file directly. It's not suitable
for overlay.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 tests/generic/623 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/623 b/tests/generic/623
index ea016d91..1083e796 100755
--- a/tests/generic/623
+++ b/tests/generic/623
@@ -11,7 +11,7 @@ _begin_fstest auto quick shutdown
 
 . ./common/filter
 
-_supported_fs generic
+_supported_fs ^overlay
 _fixed_by_kernel_commit e4826691cc7e \
 	"xfs: restore shutdown check in mapped write fault path"
 
-- 
2.31.1

