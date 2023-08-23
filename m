Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B105EE49A0
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Aug 2023 10:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjHWKef (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjHWKdc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 06:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C1E5D
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 03:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7AED65F99
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A5FC433C8;
        Wed, 23 Aug 2023 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692786804;
        bh=COkzoY3eDxGaWCq+HizizMegdgXje7DhsTzfrpqfAME=;
        h=From:Date:Subject:To:Cc:From;
        b=K5631yb+gvTD8inLoJjsZ0w1Z0TEgZAc31VSsRq61dFBZ2MJ46cxbUEI1WJtJ999o
         Amw+it6bT+I6RAfRfHVnHb9u/vRuRprird72+pw5TWPSo0nWCCNGFObDel6CvctC73
         2Z2IsH0zpDHhg9yKpQhGSc14xqy8eyR+1j64vfPe9sPtLQkAdEVEOrKnY0TuN5iONl
         Hw82WYlMbC13KZ4HeVxMGFh3xXttN407MmixBkjYOTYGxLPb6+fs6KAGH2w+LrwOby
         gK7WlPvZswlRYKZ6UmJ265n57iGWRu0FhUpAec6xYF4+KsdRxQAdACaIo7n7Cjb5BP
         VZNjyOjjBv89Q==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 23 Aug 2023 06:33:20 -0400
Subject: [PATCH] common/attr: fix the _require_acl test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-require_acl-v1-1-cf24b72123dd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAG/g5WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyNj3aLUwtLMotT4xOQc3TSL5CSjJHNzcwsjIyWgjoKi1LTMCrBp0bG
 1tQCwKfKyXQAAAA==
To:     fstests@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=COkzoY3eDxGaWCq+HizizMegdgXje7DhsTzfrpqfAME=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk5eB0grBIlaoPI7fGFCPx+BocG6sWVx8SCU9/L
 H0seoPzwsWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOXgdAAKCRAADmhBGVaC
 Fa4OEACSKsGemW5yOYZMtD0fomWJF7W0kxd18V3cAPKAsLHCTNGPtwbGeQlYwCm8L4p/150ULit
 ujb99EmqeERc3u49RMoU/lqyQV6SV7c/X0Kd6oZhXvWbl5HntMsnQ3DSER4OsxKECEuTRMKSXTJ
 jq7JWUWdRCaigpoGl3GixCSls+LSb9gzjzObsgTr2n3CPVxGlJiR1uu7Fq5ix9fnZHoeNmg+Vc5
 XwQjyq3DUBLWPLAckBb2F1XsOZll6ngN7d/+4U0dx7anUN50EPsor7yAIK4lTfNO9W47Ks9hqcv
 T+Iy/sPPgvupk1Ca/iccJBIPJQ0XGVRtZCYS9W2+toct8spwgwh3HwQ9bt/BBfrdHjGNB0O0pdO
 xxmOC4xLgWMYNO4uRmiTc05vi8NNpx3pwmBSHfQbi20ZrMG4xHLGTSAjypSogyeAOBzMlgOOrLP
 jq0z2XABoHNeA/oXXDGfJFsmVANx6pA+rg4DU1tLARWqeOxbz7b0jnVx+X535lz8Lr5sGbIrM7g
 /ARF1MZkAgASJ0GD9AUR4DicQtm/Ij3+gFJAwWV0HsRYfhVhohBvLEmX7UxCCPkZRAdNDXaEOvy
 OSNTdwbVAOyATkXbiU0W6vG8A/rSOmQV2103qJSYAdfvLIedVKKfVdH9pSbWcYtJzh3i+gUKa6H
 oFktfUuusH7jBJA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_require_acl tests whether you're able to fetch the ACL from a file
using chacl. Unfortunately, filesystems like NFSv4 that don't support
POSIX ACLs return -ENODATA when someone calls getxattr for
system.posix_acl_access. chacl treats that as if there is no ACL
attached to the file and so doesn't return an error even though the
filesystem doesn't support ACLs.

Fix the test to have chacl set an ACL on the file instead, which should
reliably fail on filesystems that don't support them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/attr | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/common/attr b/common/attr
index cce4d1b201b2..3ebba682c894 100644
--- a/common/attr
+++ b/common/attr
@@ -163,13 +163,12 @@ _require_acls()
     [ -n "$CHACL_PROG" ] || _notrun "chacl command not found"
 
     #
-    # Test if chacl is able to list ACLs on the target filesystems.  On really
-    # old kernels the system calls might not be implemented at all, but the
-    # more common case is that the tested filesystem simply doesn't support
-    # ACLs.
+    # Test if chacl is able to set an ACL on a file.  On really old kernels
+    # the system calls might not be implemented at all, but the more common
+    # case is that the tested filesystem simply doesn't support ACLs.
     #
     touch $TEST_DIR/syscalltest
-    chacl -l $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
+    chacl 'u::rw-,g::---,o::---' $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
     cat $TEST_DIR/syscalltest.out >> $seqres.full
 
     if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then

---
base-commit: 8de535c53887bb49adae74a1b2e83e77d7e8457d
change-id: 20230823-require_acl-f8cb2b777822

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

