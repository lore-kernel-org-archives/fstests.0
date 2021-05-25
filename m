Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668DEC47085
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 04:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E6C613D5
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 04:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhEYEsW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 00:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230385AbhEYEsW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 00:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621918012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eBhzLIsTN75zcg6uhoERL+6C873uPZ6LV6NYDbM+3A0=;
        b=WvhKk1nKTkRPEW3FzCYIPUVbLaqJPn2JIer1VUcEmPYOzp4WX55cfqoZrE5FH7JH+UKeb8
        HHRf06TWUlInUZXf7Pl+Xa3MWKGrWNg5qNE+Xg8HSKBHzNdblgBLCh+chHwCsxhYG6AORZ
        v0AdDdhCykHOx7cjOS9rnf54zPdWOfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-DolAUbnFMmeYY8vJefeW4A-1; Tue, 25 May 2021 00:46:50 -0400
X-MC-Unique: DolAUbnFMmeYY8vJefeW4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18CD7100945F
        for <fstests@vger.kernel.org>; Tue, 25 May 2021 04:46:50 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27FD659443
        for <fstests@vger.kernel.org>; Tue, 25 May 2021 04:46:48 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/2] common/config: remove default 4k blocksize from XFS_MKFS_OPTIONS
Date:   Tue, 25 May 2021 12:46:41 +0800
Message-Id: <20210525044642.552682-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfstests set "-bsize=4k" to XFS_MKFS_OPTIONS by default, then give
it to MKFS_OPTIOPNS. So MKFS_OPTIOPNS always contains "-bsize=4k"
except we set XFS_MKFS_OPTIONS manually.

It's useless to set XFS_MKFS_OPTIONS to "-bsize=4096" by default,
especially that will cause all cases with _scratch_mkfs_blocksized()
always fail as "-b size option respecified", when test on XFS. For
exmaple: generic/222

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/config b/common/config
index a47e462c..ecd59fae 100644
--- a/common/config
+++ b/common/config
@@ -60,7 +60,6 @@ export EMAIL=root@localhost    # where auto-qa will send its status messages
 export HOST_OPTIONS=${HOST_OPTIONS:=local.config}
 export CHECK_OPTIONS=${CHECK_OPTIONS:="-g auto"}
 export BENCH_PASSES=${BENCH_PASSES:=5}
-export XFS_MKFS_OPTIONS=${XFS_MKFS_OPTIONS:=-bsize=4096}
 export TIME_FACTOR=${TIME_FACTOR:=1}
 export LOAD_FACTOR=${LOAD_FACTOR:=1}
 export DEBUGFS_MNT=${DEBUGFS_MNT:="/sys/kernel/debug"}
-- 
2.31.1

