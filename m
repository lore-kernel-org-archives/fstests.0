Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28887C54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 08:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiITIjf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiITIiq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 04:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F3A33E11
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663663099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+dZpGadBGZMrEUOsC3uXfz+Uog6h2eFowDYVEsDXzCs=;
        b=F9w3x55sG/PgiHIrc1RP4zQ/stStsw3cROBbWzQywreHGtz4TN97eRFsRnmou1I8NkQViU
        4OHuDmT7M9mfNUgdwJerq3C6uxa6J8UEaSc8h2pDeVkgYHIMR6SLXiaUNi5UZEfamemwP7
        AQhkpwQPQ1Eq2zdLV5nbah5yTObAg6M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-iXQDlPxZMR2Tm3GtmVXzLA-1; Tue, 20 Sep 2022 04:38:14 -0400
X-MC-Unique: iXQDlPxZMR2Tm3GtmVXzLA-1
Received: by mail-ej1-f69.google.com with SMTP id gt19-20020a1709072d9300b00780ec98af88so975002ejc.13
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 01:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=+dZpGadBGZMrEUOsC3uXfz+Uog6h2eFowDYVEsDXzCs=;
        b=1U4mYjvBaWNZgpjNjPGrJ0hKelpjTFCiBJ+ICwrkWVPAk2z1Ag6iUHb01/FmWxYS2k
         yrQdmjBdXxiCOzOGk8UJ2nrJihWoOae/VtXvw9wjZGwTyawBTwZNztVbONf/sR4Bpfza
         fHSHJfg8PvUIJEDANcdMFFeNodBGYHIfc5T7r9tnIovcmnsyNWbNr4NYKjfMdCJwDlaa
         yc+58h4qGEPP69Z7sAzf+FTGd4kD+gq1zJbDxHRZFZ9yB9IuDsBb+sEFpmoWpK3mg3or
         Opm+uFLnKjD71J8XvN9otilxQxLw1ytp27e7RbLIDY06R6w7XLg6UhT18XS24MFBWpOJ
         5dhA==
X-Gm-Message-State: ACrzQf1mgd/igGTrtzFyEFcdWLGS0AUM/lJxafG5GEFBRzismaMGrtY7
        nwD0uLI1iabSfCqmDZb5AVcM2o3byVJn1hH11sV30B1OOHiwnlQHgaacViwZD/bryKVAUdnrOMv
        olYU93YHyh3jrCFlexMYlr86+6mfWcGjqHQayVhbrk92irk4dKsxPkxUNQjI2Uec5K8gp
X-Received: by 2002:a17:906:4ac1:b0:780:3448:ff06 with SMTP id u1-20020a1709064ac100b007803448ff06mr16166268ejt.403.1663663092594;
        Tue, 20 Sep 2022 01:38:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5WG5GaZjKdrZkeYmSASU0QTh5SmB249OddgQBnjZIZuCZWviIoKPIAOrBr56iXBCgZLfSAGQ==
X-Received: by 2002:a17:906:4ac1:b0:780:3448:ff06 with SMTP id u1-20020a1709064ac100b007803448ff06mr16166252ejt.403.1663663092313;
        Tue, 20 Sep 2022 01:38:12 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906328500b007414152ec4asm449294ejw.163.2022.09.20.01.38.11
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:38:11 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] ext4/044: Add missing check for return value
Date:   Tue, 20 Sep 2022 10:38:10 +0200
Message-Id: <20220920083810.288984-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When calling _within_tolerance either return value or text output
should be checked. Otherwise the function is useless for a test.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/ext4/044     | 8 +++-----
 tests/ext4/044.out | 4 +++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/ext4/044 b/tests/ext4/044
index 158e2ac5..50de5a40 100755
--- a/tests/ext4/044
+++ b/tests/ext4/044
@@ -18,8 +18,6 @@ _require_scratch
 _require_test_program "t_get_file_time"
 _require_metadata_journaling
 
-echo "Silence is golden"
-
 echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
 _scratch_mkfs -t ext3 -I 256 >> $seqres.full 2>&1
 _scratch_mount
@@ -49,9 +47,9 @@ nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime, cur_time[ns]: $nsec)"
 fi
 
 # Check difference between file time and current time
-_within_tolerance "sec_atime" $sec_atime $sec 1
-_within_tolerance "sec_mtime" $sec_mtime $sec 1
-_within_tolerance "sec_ctime" $sec_ctime $sec 1
+_within_tolerance "sec_atime" $sec_atime $sec 1 -v
+_within_tolerance "sec_mtime" $sec_mtime $sec 1 -v
+_within_tolerance "sec_ctime" $sec_ctime $sec 1 -v
 
 _scratch_unmount >> $seqres.full 2>&1
 
diff --git a/tests/ext4/044.out b/tests/ext4/044.out
index 12a61dc4..8a3a8072 100644
--- a/tests/ext4/044.out
+++ b/tests/ext4/044.out
@@ -1,2 +1,4 @@
 QA output created by 044
-Silence is golden
+sec_atime is in range
+sec_mtime is in range
+sec_ctime is in range
-- 
2.37.3

