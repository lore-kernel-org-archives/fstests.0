Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C546CCA480
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiFTTaD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiFTTaC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 15:30:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2271C121
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 12:30:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E452E1F9DE
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655753399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5b+oP1cC+XIgT34cKI1K6B4NQiAU0vxv4AAKjKmjNmo=;
        b=mEf1DqCXUcbIegm4ZAi1B0o1Gn92exvZDpm/3WYB+gjvJ05HWjFO9MYxx8/0u3VhR4nBNj
        N/iklx5Le5f3gsRBcTlIAF+Huz2SC3BRXUwtGKOQ8YXGBhpn5ZK486io7pWrlHVNxZp3ZN
        JU9t/z3TEKIbnXXR3g5uox18aNbgd1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655753399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5b+oP1cC+XIgT34cKI1K6B4NQiAU0vxv4AAKjKmjNmo=;
        b=CcInWHIMLAkqr/sozNq1n1w344DLXuERbcYQiU8bPOqTywK+Y/G+ujI4kNmChyP6yYqFmj
        aJjgE3xhX1+k4QDg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9FE62C141;
        Mon, 20 Jun 2022 19:29:59 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/6] check: avoid FSTYP=<fstyp parameter> repetition
Date:   Mon, 20 Jun 2022 21:29:29 +0200
Message-Id: <20220620192934.21694-2-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620192934.21694-1-ddiss@suse.de>
References: <20220620192934.21694-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/check b/check
index de11b37e..42925e09 100755
--- a/check
+++ b/check
@@ -277,15 +277,13 @@ while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
 
-	-nfs)		FSTYP=nfs ;;
-	-glusterfs)	FSTYP=glusterfs ;;
-	-cifs)		FSTYP=cifs ;;
-	-9p)		FSTYP=9p ;;
-	-virtiofs)	FSTYP=virtiofs ;;
-	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
-	-pvfs2)		FSTYP=pvfs2 ;;
-	-tmpfs)		FSTYP=tmpfs ;;
-	-ubifs)		FSTYP=ubifs ;;
+	-nfs|-glusterfs|-cifs|-9p|-virtiofs|-pvfs2|-tmpfs|-ubifs)
+		FSTYP="${1:1}"
+		;;
+	-overlay)
+		FSTYP=overlay
+		export OVERLAY=true
+		;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST ${group//,/ }"
-- 
2.35.3

