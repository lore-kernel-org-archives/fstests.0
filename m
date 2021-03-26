Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDBC433E5
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098F161A32
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhCZPlx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230253AbhCZPlr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Mar 2021 11:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616773306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkJ6qWHxSfuxNqvg132bNGuMpPuVn9GLJ8yG6ihh9YQ=;
        b=bogh1sd2JpSv2ToNLH7hXLITSqB/gXHrfCf03qXCJiC78mDED2BwhKzNgLlZLuFQCOy3QO
        gs6M+0V42B0wDo1AZv6tu1cfSqrycf7g5uktUjoUyyhrHhrjqT2mHUUNKZ4tI2p8BRM8a7
        fUaAcT/2O7aS1lB5vSvpHdI2XcnvLv4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-LIagPlV0Mb-30ZBCKAAcUQ-1; Fri, 26 Mar 2021 11:41:43 -0400
X-MC-Unique: LIagPlV0Mb-30ZBCKAAcUQ-1
Received: by mail-ed1-f72.google.com with SMTP id h2so4609772edw.10
        for <fstests@vger.kernel.org>; Fri, 26 Mar 2021 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkJ6qWHxSfuxNqvg132bNGuMpPuVn9GLJ8yG6ihh9YQ=;
        b=JdWqmgacH4BXn9nPXxM//3MVuuwQRPE5qSYqbgRcOKNpxVDC241tEiNUp5wS4XA2CL
         2UL9xO5qwMNmsGdwKSeP1jPELlxjfwPtM751PfhtZA2tM6/WrkByriTOz54n+dJHB20N
         AXBNVMmW4o5TRhS2nxuqVRf6uyDYBn6qYlyqMe2E/I7i41RInF8qbrZbZmEy6P6kiodx
         R/8OMGyYLvFbXI6Y1p3AZ5+SfMuOjt1bgO0jmApbIFMz81wO+WvWE2vL52BN4rDW8WUm
         YguBSDNJPr5gBV9gprXbqOaSuhnL3bQjXBtSgi9cyaQv5/bsIUm1O1kXOI6uPnonYozx
         HIqw==
X-Gm-Message-State: AOAM5326VZ6GLd+yGFKOuaq/IGpUzajIt4JVkvxvMkP4iV2T3iUnuoGc
        BTD8HXDD4yvjegVn7t9XNuIPb02un2ITYMRTJXUDIF9oDUvMD0xkNuSp2saz6JlEAJbLt4S9HVK
        7D7j9hhelh53XUTNpWb7BUpxjx8QZMQv3Kt1qzNsyoKvlFT44025EgKWz0Ygpq33K7iop
X-Received: by 2002:a05:6402:1051:: with SMTP id e17mr15931672edu.42.1616773301745;
        Fri, 26 Mar 2021 08:41:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx7vWLjFsd1WEpsh7V5plJI4CqA2p5Czt0YjSI9gzfkGq8XfpnV5kqRzBg95RHHh0bgaRKQA==
X-Received: by 2002:a05:6402:1051:: with SMTP id e17mr15931660edu.42.1616773301597;
        Fri, 26 Mar 2021 08:41:41 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id p9sm4389791eds.66.2021.03.26.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:41:41 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, xzhou@redhat.com
Subject: [PATCH 5/5] generic/003: Amend the test for exfat
Date:   Fri, 26 Mar 2021 16:41:34 +0100
Message-Id: <20210326154134.309159-6-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326154134.309159-1-preichl@redhat.com>
References: <20210326154134.309159-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Update the test so it can be run even for exfat which has 2 seconds
granularity for access_time and does not have a timestamp for
metadata change.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/003 | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/tests/generic/003 b/tests/generic/003
index ec4fdfc1..39596665 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -37,6 +37,13 @@ _require_relatime
 
 rm -f $seqres.full
 
+if [ "$FSTYP" = "exfat" ]; then
+	# exfat's timestamp for access_time has double seconds granularity
+	access_delay=2
+else
+	access_delay=1
+fi
+
 _stat() {
 	stat -c "%x;%y;%z" $1
 }
@@ -79,14 +86,14 @@ echo "aaa" > $TPATH/dir1/file1
 file1_stat_before_first_access=`_stat $TPATH/dir1/file1`
 
 # Accessing file1 the first time
-sleep 1
+sleep $access_delay
 cat $TPATH/dir1/file1 > /dev/null
 file1_stat_after_first_access=`_stat $TPATH/dir1/file1`
 _compare_stat_times YNN "$file1_stat_before_first_access" \
 	"$file1_stat_after_first_access" "after accessing file1 first time"
 
 # Accessing file1 a second time
-sleep 1
+sleep $access_delay
 cat $TPATH/dir1/file1 > /dev/null
 file1_stat_after_second_access=`_stat $TPATH/dir1/file1`
 _compare_stat_times NNN "$file1_stat_after_first_access" \
@@ -109,7 +116,7 @@ _compare_stat_times NYY "$dir2_stat_before_file_creation" \
 
 # Accessing file2
 file2_stat_before_first_access=`_stat $TPATH/dir2/file2`
-sleep 1
+sleep $access_delay
 cat $TPATH/dir2/file2 > /dev/null
 file2_stat_after_first_access=`_stat $TPATH/dir2/file2`
 _compare_stat_times YNN "$file2_stat_before_first_access" \
@@ -135,11 +142,15 @@ echo "xyz" > $TPATH/dir1/file1
 file1_stat_after_modify=`_stat $TPATH/dir1/file1`
 _compare_stat_times NYY "$file1_stat_before_modify" \
 	"$file1_stat_after_modify" "after modifying file1"
-sleep 1
-mv $TPATH/dir1/file1 $TPATH/dir1/file1_renamed
-file1_stat_after_change=`_stat $TPATH/dir1/file1_renamed`
-_compare_stat_times NNY "$file1_stat_after_modify" \
-	"$file1_stat_after_change" "after changing file1"
+
+# exfat does not support last metadata change timestamp
+if [ "$FSTYP" != "exfat" ]; then
+	sleep 1
+	mv $TPATH/dir1/file1 $TPATH/dir1/file1_renamed
+	file1_stat_after_change=`_stat $TPATH/dir1/file1_renamed`
+	_compare_stat_times NNY "$file1_stat_after_modify" \
+		"$file1_stat_after_change" "after changing file1"
+fi
 
 # Mounting with strictatime option and
 # accessing a previously created file twice
@@ -148,7 +159,7 @@ cat $TPATH/dir2/file3 > /dev/null
 file3_stat_after_second_access=`_stat $TPATH/dir2/file3`
 _compare_stat_times YNN "$file3_stat_after_first_access" \
 	"$file3_stat_after_second_access" "after accessing file3 second time"
-sleep 1
+sleep $access_delay
 cat $TPATH/dir2/file3 > /dev/null
 file3_stat_after_third_access=`_stat $TPATH/dir2/file3`
 _compare_stat_times YNN "$file3_stat_after_second_access" \
-- 
2.30.2

