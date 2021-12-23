Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA0C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Dec 2021 23:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbhLWXsz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Dec 2021 18:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245079AbhLWXsy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Dec 2021 18:48:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB49C061401
        for <fstests@vger.kernel.org>; Thu, 23 Dec 2021 15:48:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A4461FAE
        for <fstests@vger.kernel.org>; Thu, 23 Dec 2021 23:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D60C36AE5;
        Thu, 23 Dec 2021 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640303332;
        bh=RREHQ+APOcdBN1OK1ZMIbazv86HlW3MS7ekxQo839LA=;
        h=From:To:Cc:Subject:Date:From;
        b=hcXPBzQRdN9w4IlAaf/3xaQBSHWVbQS4Z8e4MnsTlPaa5kiB9EU3NY6yT5rFwpXGF
         adwaNeVtTZSahqubxS8JGFrUkBCM5ggQ6RA8kmQ92+r01/ZnGC8VCQu6L3kLXQdWOH
         +wVCodu1Juh5+Zaqi9dMM7L1lGoSZ+0mnWZLjnfZ1Zxlgt1SQwDE5+9V0edjnoA+6I
         0tPyk/zbTucsJtnbBzeRbTn1VwlhTyCzVOTWcmK3jTAeupikrgTVc8ZJRjWRkktgnR
         0HHb5uFRGZxaHRGrfbAeKU+GXs+Wpc3iEDKtwPiFYmVBehkBE/ITX0IJauJOPONF6y
         Hjlb5uEVpIQ6g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH] setup-buildchroot: make sure chroot dir is given mode 0755
Date:   Thu, 23 Dec 2021 17:47:59 -0600
Message-Id: <20211223234759.173181-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make setup-buildchroot work when the umask is set to 0077.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 setup-buildchroot | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-buildchroot b/setup-buildchroot
index cdeb7fd..6c87d4d 100755
--- a/setup-buildchroot
+++ b/setup-buildchroot
@@ -569,7 +569,7 @@ run_in_chroot()
 
 create_chroot()
 {
-    mkdir -p "$CHROOT_DIR"
+    mkdir -p -m0755 "$CHROOT_DIR"
 
     test -z "${PROXY}" || export http_proxy=${PROXY}
     if ! run_cmd debootstrap --arch "$DEBIAN_ARCH" ${QEMU:+--foreign} \
-- 
2.34.1

