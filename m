Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E77C43462
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD64F613B0
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhDOJth (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhDOJtf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 05:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618480152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyDkbOJF+LAXZhVyXOvOwWICcwEeTsYdSwwQvMcPKv0=;
        b=IB1gPkFPDAQvFhLL4no2DRvhThL1gQPf/poGr6DcOnQYhOBopvzioPHtwT9qIho0wOPBE8
        eONBN/X459apco45aQT0S5lmNgLOq7zL/sEoV+VW7PSjP/UFRay4ncp3k9nL90khzAb1K7
        lnB4igMALzA2FWZGV+aBWHulfhtKf0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-zjKKZ4giPUiivq1xKHLXqg-1; Thu, 15 Apr 2021 05:49:11 -0400
X-MC-Unique: zjKKZ4giPUiivq1xKHLXqg-1
Received: by mail-wr1-f69.google.com with SMTP id 33-20020adf80240000b02900f9e2646f9aso2483988wrk.0
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 02:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyDkbOJF+LAXZhVyXOvOwWICcwEeTsYdSwwQvMcPKv0=;
        b=tHmMmUNmG6zKv3eZ9gdf8G5slMQTOf783qDRKBYVSb1KEgNFx7yLhtPvo5835MNKcM
         Kszpf/cCEHO7dn4//xsZD0BIk9kOkQG/QCdU+QRB5kdD25A+VRkOWM5VpRoeQu+UpfNl
         TNmm8v6zH4GTGnh6U+sEKDA3ncEH1QqH2dXNzVjw9oFaqAmPJQ1JCOvAidfyPXueVbW3
         qWVjCR591HLWWYc+7XMuR4dIZBgAryqHOAH98oMabE+32kB6rHybK4HfYve3YdcOWe+L
         bOhvg/7ZoOIuKyFRUrdhSHkh/3JdT4dwEobGdRYQCHnxd6DjYwKHxUEcktCc7StGb5PQ
         /pmA==
X-Gm-Message-State: AOAM532UMXknAl+uftjTb/7tJlnHF16BmCct51znskK4zHjB+P8nwQKx
        gGW3j3A5Z4//7gcbNhqwtVWkuAGxRAYGpCIBhL1LSimj7kmBvEiWPxXGmww6Mc7Q7Jj6TCs44Lt
        H18uOs29xKwl683dKnzUdLP2f4WnUxsAWoCzpf0hFi2u4DPSxdiFusE7eUyo+sfZj1quA
X-Received: by 2002:a1c:94:: with SMTP id 142mr2344748wma.31.1618480149595;
        Thu, 15 Apr 2021 02:49:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhDChxWY49dUVS2tU0A0bxWSlMCmf44Nsrc+xImHUmwjnFlW4Ud2Z6rJTyyDJFRFiH2Dk4gg==
X-Received: by 2002:a1c:94:: with SMTP id 142mr2344722wma.31.1618480149285;
        Thu, 15 Apr 2021 02:49:09 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id v4sm2427278wrf.36.2021.04.15.02.49.08
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:49:08 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 4/4] generic/003: Amend the test for exfat
Date:   Thu, 15 Apr 2021 11:49:05 +0200
Message-Id: <20210415094905.61853-5-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210415094905.61853-1-preichl@redhat.com>
References: <20210415094905.61853-1-preichl@redhat.com>
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
index ec4fdfc1..b2a3db39 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -37,6 +37,13 @@ _require_relatime
 
 rm -f $seqres.full
 
+if [ "$FSTYP" = "exfat" ]; then
+	# exfat's timestamp for access_time has double seconds granularity
+	access_delay=2.1
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

