Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D023C432BE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 06:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18536101A
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 06:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbhIAGRd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Sep 2021 02:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242085AbhIAGRc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Sep 2021 02:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630476995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ngm/MteNQr9tqz4iOtioD3Z8/F+T69Bdwxh+/yEimNM=;
        b=fiYvXHc8EOjI+aCWVwfOjqvhNVC3kRMgR6I4CW3u4DLDPCKqB4v7tfOgF+/3Zea3HDTktx
        L5bD8ATqx9BalPbfv1wYxa1c9gbYRYl4IDkRbYSKq2zqPX2uBD/5ftavJ6z28az0fmrIm9
        5DvbX1xtMjg3bmnyWu6INoFgke9iHj0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-QyTFRcY4PiGmePNZQT-q2g-1; Wed, 01 Sep 2021 02:16:33 -0400
X-MC-Unique: QyTFRcY4PiGmePNZQT-q2g-1
Received: by mail-pf1-f199.google.com with SMTP id v65-20020a627a44000000b003f286b054cbso877750pfc.11
        for <fstests@vger.kernel.org>; Tue, 31 Aug 2021 23:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ngm/MteNQr9tqz4iOtioD3Z8/F+T69Bdwxh+/yEimNM=;
        b=eultrf2xEqjDWOhIJ998msS3ZMjGUOm5B4DMikdVpFFKT+3YgVLN5Al9uBUda3yEu9
         VTcWVLCSGqzvXIvz/4X+CzG9nAhvAy1K8wGuiqpe+q6TNH93IW3dAVtkZXGs6lT7mUpS
         gJI0OpURxVsWxtnV+U323k0E4asJgjJEf6U4qxwaccgrNOS+dYFy5oQCSOAI9kqlXlvH
         TTb+A53ws2+I44kniIaBHBQg4hX3d3egKOmUsa34+XVL4ZJdybEj3E92tpg8i9wJxmhv
         VCV0VLq2iF2nXvkU31fRAD4pWMnu2lLfWtneF3ohtsBbJQchVOXljQRzCLOI1nDVvBI/
         0h+Q==
X-Gm-Message-State: AOAM530xldXukY3imq/h072yGZI7pV2qn3fWc+H2A7jblB9OJtv3mMq+
        swFr9pTWC5kgJBNruwZ7V9j6xQPUatNsYPu8GvqCN5LF1nJp26VP9xixO1KVuQd1lfkthZT0nLO
        8mocTeeQqhVYQ1ShoxQ==
X-Received: by 2002:a63:1266:: with SMTP id 38mr30463585pgs.219.1630476992823;
        Tue, 31 Aug 2021 23:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjYWkt8j1TLJa5C4wUfuUg2bb7jFRPLyphjF/42soPUq5FhgSonEH9HDOEHSqeU6vZT5Iy6Q==
X-Received: by 2002:a63:1266:: with SMTP id 38mr30463567pgs.219.1630476992495;
        Tue, 31 Aug 2021 23:16:32 -0700 (PDT)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g4sm22697570pgs.42.2021.08.31.23.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 23:16:31 -0700 (PDT)
Date:   Wed, 1 Sep 2021 14:16:20 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Pavel Reichl <preichl@redhat.com>, Murphy Zhou <xzhou@redhat.com>,
        fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] common/rc: fix MKSWAP_PROG quoting
Message-ID: <20210901054822.phzkg5xqoocx3duq@xzhoux.usersys.redhat.com>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
 <20210831052632.p4kaygjeujipo4w5@fedora>
 <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
 <20210831134207.aa4e26xuyji4npia@fedora>
 <YS5hRsSXNHYQdUv9@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS5hRsSXNHYQdUv9@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After commit
  0e4dd8b9 common/rc: fix ignoring of errors on
we are getting this error message when running swapfiles tests:
  +./common/rc: line 2553: MKSWAP_PROG: command not found

Rewrite the line and add a filter for mkswap.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---

Thanks all for the suggestions!

v2:
  rewrite the line and add a filter
  source filters for generic/643

 common/filter     | 6 ++++++
 common/rc         | 2 +-
 tests/generic/643 | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index 2efbbd99..0883a3fd 100644
--- a/common/filter
+++ b/common/filter
@@ -661,5 +661,11 @@ _filter_quota_report()
 		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
 }
 
+# Filter mkswap warning about the permissions
+_filter_mkswap_stderr()
+{
+	grep -v "insecure permission"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/common/rc b/common/rc
index 46b6b220..0a3933a5 100644
--- a/common/rc
+++ b/common/rc
@@ -2550,7 +2550,7 @@ _format_swapfile() {
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
 	# Ignore permission complaints on filesystems that don't support perms
-	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
+	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | _filter_mkswap_stderr
 }
 
 _swapon_file() {
diff --git a/tests/generic/643 b/tests/generic/643
index 2bb9d220..9b067ea2 100755
--- a/tests/generic/643
+++ b/tests/generic/643
@@ -21,6 +21,7 @@ _cleanup()
 	rm -f $tmp.*
 	test -n "$swapfile" && swapoff $swapfile &> /dev/null
 }
+. ./common/filter
 
 # real QA test starts here
 _supported_fs generic
-- 
2.20.1

