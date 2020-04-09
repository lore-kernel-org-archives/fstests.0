Return-Path: <SRS0=x5Yn=5Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85522C2BA19
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 20:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510AC20730
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 20:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5C5NTr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDIUGd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:06:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30934 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbgDIUGd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Apr 2020 16:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586462792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ROXXNC5x81buN/p+5lABAjtnpw9W16Q39DPUg4bsMxw=;
        b=M5C5NTr3NHjiYR6y512Rgu76r9DnI2BcJztQxtB2WvGChCHxJAsyo7PGThhwAWQu/rJ+CJ
        bJ6A4aZ8leFnRLcCB8Drtb3ErJSKIhkAD0gzdi4jQ1XG/YGvzIynbBLPgxHOIyO1Ll/R6H
        ++ZM/T+SC09kE5Q8TKEdD6KWYCkerJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-y2zGkPfrNaSwDvhlq4RD1w-1; Thu, 09 Apr 2020 16:06:30 -0400
X-MC-Unique: y2zGkPfrNaSwDvhlq4RD1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC533800D53;
        Thu,  9 Apr 2020 20:06:29 +0000 (UTC)
Received: from [127.0.0.1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 362DE96B68;
        Thu,  9 Apr 2020 20:06:29 +0000 (UTC)
To:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] fstests: test for fallocate capability in more tests
Message-ID: <8202d5fd-041f-455c-e306-4244216d305d@redhat.com>
Date:   Thu, 9 Apr 2020 15:06:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These 3 tests explicitly call xfs_io's fallocate command, test whether
it works before running the test.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/286 b/tests/generic/286
index 00cb87b7..8be4fbc9 100755
--- a/tests/generic/286
+++ b/tests/generic/286
@@ -23,6 +23,7 @@ _supported_fs generic
 _supported_os Linux
 
 _require_test
+_require_xfs_io_command "falloc"
 _require_seek_data_hole
 
 src=$TEST_DIR/seek_copy_testfile
diff --git a/tests/generic/404 b/tests/generic/404
index 14decdb7..69d7e71e 100755
--- a/tests/generic/404
+++ b/tests/generic/404
@@ -76,6 +76,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
 
 blksize=`_get_block_size $TEST_DIR`
diff --git a/tests/generic/569 b/tests/generic/569
index 4573be5a..385fa59f 100755
--- a/tests/generic/569
+++ b/tests/generic/569
@@ -29,6 +29,7 @@ _cleanup()
 # real QA test starts here
 _supported_os Linux
 _supported_fs generic
+_require_xfs_io_command "falloc"
 _require_test_program swapon
 _require_scratch_swapfile
 

