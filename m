Return-Path: <SRS0=UVRB=6W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46250C35280
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 03:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064122075E
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 03:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiMVmXsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEHDZ4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 May 2020 23:25:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57470 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726683AbgEHDZ4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 May 2020 23:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588908355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmZrAJvQ6wyKbNzPxYf3yPr1PSAcBQ35taDsANBRcDc=;
        b=RiMVmXsucYMLwsctEBEC/gsghJX1bDTU9sn+0UIerUUHQMOuNA0hM0Ww29aur2swqz6ROp
        BpJG1fUpvyYdvFo+vmADDjnuJuj+RDH28wWBgnaFAkFfZMeCOCOGDOWUZ4/mXh/cKI1shd
        VS38+vCAkXE8wODJ4PAPO7Cd8k06dTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-dhDFYq-1PS2rbOG1VMDyWQ-1; Thu, 07 May 2020 23:25:53 -0400
X-MC-Unique: dhDFYq-1PS2rbOG1VMDyWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750A5835B41
        for <fstests@vger.kernel.org>; Fri,  8 May 2020 03:25:52 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC132E052
        for <fstests@vger.kernel.org>; Fri,  8 May 2020 03:25:52 +0000 (UTC)
To:     fstests <fstests@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] generic/506: fix _require test, use xfs_io vs chattr
Message-ID: <e29cb8b1-5c4f-0cc4-017f-a2303d31a1f6@redhat.com>
Date:   Thu, 7 May 2020 22:25:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_require_prjquota doesn't work on xfs unless the scratch device has
been mounted with project quota, so do that prior to the test.

older chattr/lsattr don't understand project quotas, so use xfs_io
instead for compatibility on older systems.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/506 b/tests/generic/506
index e8d0ca24..2eb82a03 100755
--- a/tests/generic/506
+++ b/tests/generic/506
@@ -43,15 +43,13 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 
-_require_command "$LSATTR_PROG" lsattr
-_require_command "$CHATTR_PROG" chattr
-
 _require_scratch
 _require_scratch_shutdown
 
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
-_scratch_mount
+_qmount_option "prjquota"
+_qmount
 _require_prjquota $SCRATCH_DEV
 _scratch_unmount
 
@@ -67,16 +65,16 @@ do_check()
 		sync
 	fi
 
-	$CHATTR_PROG -p 100 $testfile
+	$XFS_IO_PROG -x -c "chproj 100" $testfile
 
-	before=`$LSATTR_PROG -p $testfile`
+	before=`$XFS_IO_PROG -x -c "lsproj" $testfile`
 
 	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
 
 	_scratch_shutdown | tee -a $seqres.full
 	_scratch_cycle_mount
 
-	after=`$LSATTR_PROG -p $testfile`
+	after=`$XFS_IO_PROG -x -c "lsproj" $testfile`
 
 	# check inode's project quota id
 	if [ "$before" != "$after" ]; then

