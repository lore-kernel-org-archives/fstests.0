Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D901FC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 22:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiF0WX1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiF0WX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 18:23:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B058E1117A
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 15:23:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4CC8D1F86A;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656368598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWKHcjw6nj6jAjaRxgIXYzgmKDWqjR8xD2ha70O5DBI=;
        b=nl3wLz2VNMAP89/geIiXqb9YVlZHvdfgwVuFX4TmyoYXW4faAKv7m453BZL8jlL4+ibvWA
        9+CzdZsJHJpYOt8KgEjfeGGgf4uluKXoteyET8z3pqRY59Ny5KEaHK/BdFIIAykmtarNUo
        GzV5AkIiMSLgwa7RDQ2/STmi4jdlu3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656368598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWKHcjw6nj6jAjaRxgIXYzgmKDWqjR8xD2ha70O5DBI=;
        b=NLZYGPlR5ZO0vv4JgnzzbIKC6timSaCm1SoKr+xKf86MAs94qtFCDYj6sBC6Eauqgx2KqA
        vXt5SGQ2v1TQ8XCg==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2A8762C141;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH v2 1/6] report: use array for REPORT_ENV_LIST
Date:   Tue, 28 Jun 2022 00:22:51 +0200
Message-Id: <20220627222256.14175-2-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627222256.14175-1-ddiss@suse.de>
References: <20220627222256.14175-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There's no need for multiple assignments.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/report | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/common/report b/common/report
index 84d9e0a7..2b8285d8 100644
--- a/common/report
+++ b/common/report
@@ -4,26 +4,10 @@
 
 # List of xfstests's enviroment variables to include reports
 ## TODO automate list population inside common/conf
-REPORT_ENV_LIST="$REPORT_ENV_LIST SECTION"
-REPORT_ENV_LIST="$REPORT_ENV_LIST FSTYP"
-REPORT_ENV_LIST="$REPORT_ENV_LIST PLATFORM"
-REPORT_ENV_LIST="$REPORT_ENV_LIST MKFS_OPTIONS"
-REPORT_ENV_LIST="$REPORT_ENV_LIST MOUNT_OPTIONS"
-
-REPORT_ENV_LIST="$REPORT_ENV_LIST HOST_OPTIONS"
-REPORT_ENV_LIST="$REPORT_ENV_LIST CHECK_OPTIONS"
-REPORT_ENV_LIST="$REPORT_ENV_LIST XFS_MKFS_OPTIONS"
-REPORT_ENV_LIST="$REPORT_ENV_LIST TIME_FACTOR"
-REPORT_ENV_LIST="$REPORT_ENV_LIST LOAD_FACTOR"
-
-REPORT_ENV_LIST="$REPORT_ENV_LIST TEST_DIR"
-REPORT_ENV_LIST="$REPORT_ENV_LIST TEST_DEV"
-REPORT_ENV_LIST="$REPORT_ENV_LIST SCRATCH_DEV"
-REPORT_ENV_LIST="$REPORT_ENV_LIST SCRATCH_MNT"
-
-REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_UPPER"
-REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_LOWER"
-REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_WORK"
+REPORT_ENV_LIST=("SECTION" "FSTYP" "PLATFORM" "MKFS_OPTIONS" "MOUNT_OPTIONS" \
+		 "HOST_OPTIONS" "CHECK_OPTIONS" "XFS_MKFS_OPTIONS" \
+		 "TIME_FACTOR" "LOAD_FACTOR" "TEST_DIR" "TEST_DEV" \
+		 "SCRATCH_DEV" "SCRATCH_MNT" "OVL_UPPER" "OVL_LOWER" "OVL_WORK")
 
 encode_xml()
 {
@@ -70,7 +54,7 @@ _xunit_make_section_report()
 
 	# Properties
 	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
-	for p in $REPORT_ENV_LIST;do
+	for p in "${REPORT_ENV_LIST[@]}"; do
 		_xunit_add_property "$p"
 	done
 	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
-- 
2.35.3

