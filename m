Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FCAC433E2
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350BA619AB
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhC3WAe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232883AbhC3WAP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Mar 2021 18:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617141614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkJ6qWHxSfuxNqvg132bNGuMpPuVn9GLJ8yG6ihh9YQ=;
        b=BDVcHwjKE8YZWD4kTQtCmsJ5YiB46afGoH9yTDfLieaMGCNDTkNKBjITqjFwJZlmDyF9CL
        Q8bQqvAye4c44sm8vZLNRfYWjBlMcmABv6yHmxxwaA135BMlhxd8xk3rKwzczTmMvjLlJm
        6l5ohG6YUoATHtYwBS3y2As5hKp5E2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-cESApNTHPdKLH65NczLo7Q-1; Tue, 30 Mar 2021 18:00:12 -0400
X-MC-Unique: cESApNTHPdKLH65NczLo7Q-1
Received: by mail-wr1-f69.google.com with SMTP id b6so10913456wrq.22
        for <fstests@vger.kernel.org>; Tue, 30 Mar 2021 15:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkJ6qWHxSfuxNqvg132bNGuMpPuVn9GLJ8yG6ihh9YQ=;
        b=H04UpGytwtMW/s4jFHJ4IQaWNkXupWcUGj4Lu7IsFfBRua489Ij/yVwAXd0lW3jM72
         9zdIhwE6DMmytc0vatUktRlrX0Iw0spCDGxczbYqGzxE4iY/JkS0ZPyQjwxXLJpayQgA
         92zTGNE8NvnCb6OFxcN6J4UBAvIapbBzcH5dJ9MHUoFm0s54/MejYXlGoZSeqN8JzUO3
         2SxbYoVBI+QfHVBE6h8gch56Kv6FiwbX3VqN+twQiVsZCNF1PzavOY9R2DZSn5E+qT25
         m9BJKy1pFteoXxAwhwwmrKX/t2NWSj2EPZl9jA8SXtBHipfLLRtUnxgdXMS82f75L7LR
         Z3oQ==
X-Gm-Message-State: AOAM531+IGhhTlNHhLuBzlC/GBN5pJ1325CDivFtJBAS2GXz9iCisg5w
        Vd+B7OQUIRW4HVSfVLWDPY255UYS07yepMQA8SWy3rmgqijoRoqmesI5nMGwytyJFoIEA6Azuzm
        DwlFxYUq1eTcCJQFJYfmblTGnOXoTAPnoyrtauYtXo2AoNUsnsrawol75+c3IcGJnrGkU
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr135830wrj.248.1617141611454;
        Tue, 30 Mar 2021 15:00:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8Li+6AtOE/660aNu6IWRryi7KZQbsh7hZyHtnJ2jCz5sQlsZHgSEqXaW4FCTM1PXWlBFMAA==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr135806wrj.248.1617141611181;
        Tue, 30 Mar 2021 15:00:11 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id z2sm522894wrm.0.2021.03.30.15.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:00:10 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
Subject: [PATCH v2 4/4] generic/003: Amend the test for exfat
Date:   Wed, 31 Mar 2021 00:00:05 +0200
Message-Id: <20210330220005.56019-5-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330220005.56019-1-preichl@redhat.com>
References: <20210330220005.56019-1-preichl@redhat.com>
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

