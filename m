Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9354C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Oct 2022 09:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJQJxX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJQJxV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2022 05:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADEB12749
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 02:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0726660FF4
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 09:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC22C433D6;
        Mon, 17 Oct 2022 09:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666000399;
        bh=svfY6u+u5JK0GEk9XKhsgsGFl/CtbzmM13wlczJDboI=;
        h=From:To:Cc:Subject:Date:From;
        b=e96F8RPrZDiABW6EnlWZzSSOOV1dD57EA5WT9A2UT+5zmJ70zDA1BgOAzgXeX6LDR
         mph/2qK+c7mKquOqNJXKCMNkaVeEw9Zb+if8fAjU/t15g0Is8y/P5nps4T5P1k/ldG
         tLeXPiJlXHhEp/iLp19vOZngdTgW5KIQ0zO++8A1JPDbD+JiOrEkYfGnm/UW083/dj
         mJ9OYXFmRzPlyXpho2ECjJjYd9pprTdlZHaZ8G5O5DOOmrp7AJGf948f20TXv7gNE4
         ymOHeXOs6Q0ZvFwB5hNOhQJnJbwSpwcf0SXDbzuuC6QdsnDITOwa35LmOTFjv0w04Z
         8Qy6xfYKS6UhQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>
Subject: [PATCH] generic/193: add to perms group
Date:   Mon, 17 Oct 2022 11:53:11 +0200
Message-Id: <20221017095311.68280-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=brauner@kernel.org; h=from:subject; bh=svfY6u+u5JK0GEk9XKhsgsGFl/CtbzmM13wlczJDboI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7qrHIm5puDfaL+nQ2+Xz24daZU5muhhvuyWRsbao0d5KS em/ZUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHXbQz/zKyzpu9w6MzZLnZVebfl9A M5/O9u7pM6HKzpJB4d6yzuyMjwdx/vtuywldPlpSXUeBexKqbvjN5+pSI/gVe35dT8/yvYAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test changes permissions and specifically tests for setuid and
setgid bits to be dropped or kept. It really needs to be run when -g
perms is specified.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 tests/generic/193 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/193 b/tests/generic/193
index ddaff69b..e2710b07 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -7,7 +7,7 @@
 # Test permission checks in ->setattr
 #
 . ./common/preamble
-_begin_fstest metadata auto quick
+_begin_fstest metadata auto quick perms
 
 _register_cleanup "_cleanup_files"
 tag="added by qa $seq"

base-commit: a75c5f50584e03ca7862ad51f48efd2d524d1dc5
-- 
2.34.1

