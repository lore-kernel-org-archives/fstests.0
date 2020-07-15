Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B749CC433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A56B206E9
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUmvVUhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgGOLm1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:42:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24324 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbgGOLm1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 07:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594813346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ciCpbOQZjsNuvrCUAWVTshzzqdOfY5nRyZ/17OGwPOA=;
        b=iUmvVUhJ1IeFlFLfznp+8/k53wxMPcw6dvi+XUxqiksOTBK5PiwMYmPMiZxUwMTAxfD+kn
        DBu0ZSiJkvfh7G/rI5D35B3948LFHMRean69BrD8fw98Oj0r39lDUY6oxnSxlD6qmx1yfC
        D8M/eBfZdjg0QpZg1VQI42JidymVKBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-neY-IkhMMmuXQyd_cEMocQ-1; Wed, 15 Jul 2020 07:42:24 -0400
X-MC-Unique: neY-IkhMMmuXQyd_cEMocQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE2D800C64
        for <fstests@vger.kernel.org>; Wed, 15 Jul 2020 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E8EF5D9C5
        for <fstests@vger.kernel.org>; Wed, 15 Jul 2020 11:42:22 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] check: clear WARN_ONCE state before each test
Date:   Wed, 15 Jul 2020 13:42:19 +0200
Message-Id: <20200715114219.18353-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

clear WARN_ONCE state before each test to allow a potential problem
to be reported for each test

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 check | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/check b/check
index 2e148e57..6ba64d5d 100755
--- a/check
+++ b/check
@@ -756,6 +756,11 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			touch ${RESULT_DIR}/check_dmesg
 		fi
 		_try_wipe_scratch_devs > /dev/null 2>&1
+
+		# clear the WARN_ONCE state to allow a potential problem
+		# to be reported for each test
+		(echo 1 > /sys/kernel/debug/clear_warn_once) > /dev/null 2>&1
+
 		if [ "$DUMP_OUTPUT" = true ]; then
 			_run_seq 2>&1 | tee $tmp.out
 			# Because $? would get tee's return code
-- 
2.21.3

