Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA986C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 08:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiGHIvv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 04:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiGHIvt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 04:51:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EF823B9
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 01:51:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 998941FEF9;
        Fri,  8 Jul 2022 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657270307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edUJPb2YHWx7/4NM+Iy+t/w1rUsBJkqir0JpYw7neVI=;
        b=mKGpLpqBV6YBcV+Ld4kbDqC9pXhW3LBKIzYV+RTcIxuA4ft+Uu9Tl6fAYZysiQIkO1Yheg
        rcZXGMKTzjOm1bH9a0GLK349hwtBgD9OKZ2895QK5vUxeHvm/poq9MwwuBPX2Pnh1njJmR
        QaugyXKXcaTPO3pa+uTc2/DiP1RZNXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657270307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edUJPb2YHWx7/4NM+Iy+t/w1rUsBJkqir0JpYw7neVI=;
        b=JzDxmB+7PX2cdJfERh8aaOUxHITVj5wFn3ba/F2zJPr0nkVi34HKKNdjizbib3XW/F25/f
        oNpb1J8k4VzA6oAw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DA6A2C141;
        Fri,  8 Jul 2022 08:51:47 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     djwong@kernel.org, zlang@redhat.com,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 1/5] report: use array for REPORT_ENV_LIST
Date:   Fri,  8 Jul 2022 10:51:38 +0200
Message-Id: <20220708085142.20991-2-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708085142.20991-1-ddiss@suse.de>
References: <20220708085142.20991-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There's no need for multiple assignments.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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

