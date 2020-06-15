Return-Path: <SRS0=OS5J=74=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEF7C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Jun 2020 10:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BB32068E
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Jun 2020 10:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFr2KbAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgFOKwm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:52:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35793 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728815AbgFOKwm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Jun 2020 06:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592218361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dlmEEYEzz3MjXrf/l1MCtF+IfVk5Lcg9CdnRTKN11pU=;
        b=UFr2KbAOIkfWm8NNoGiWtsZ1zZPlxnBHKQeUd4oTCCAOhb6smXDsCbfyZ+ac1zfYN2YLd0
        EPVf9k9Xw83hQFQouQocQW36DVV28/ibGo0efdIzPJHjaoZPr5UDn+kaRQQUkeoKrPZ30q
        8IT/IgTaM0Y8T5L9lYF3r6NeXPCVyI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Gpe259Z3N6a0EzHeACB8Vg-1; Mon, 15 Jun 2020 06:52:39 -0400
X-MC-Unique: Gpe259Z3N6a0EzHeACB8Vg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0658015CE
        for <fstests@vger.kernel.org>; Mon, 15 Jun 2020 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A210768AE
        for <fstests@vger.kernel.org>; Mon, 15 Jun 2020 10:52:38 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] 270: wait for fsstress processes to be killed
Date:   Mon, 15 Jun 2020 12:52:36 +0200
Message-Id: <20200615105236.32198-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently wait will do nothing, because $pid is empty due to the fact
that the command was ran on the background in a separate shell so we
never got the $! set.

This is causing unexpected test failures especially under low memory
due to the fact that the fsstress is still running when we are
checking and comparing quota usage.

Fix it by using -w argument for killall that will wait for all processes
to actually die before it exits.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 tests/generic/270 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/generic/270 b/tests/generic/270
index 5092ffa4..55779f5e 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -38,7 +38,6 @@ _workout()
 	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
 
 	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
-	pid=$!
 
 	echo "Run dd writers in parallel"
 	for ((i=0; i < num_iterations; i++))
@@ -50,8 +49,7 @@ _workout()
 		sleep $enospc_time
 	done
 
-	$KILLALL_PROG $tmp.fsstress.bin
-	wait $pid
+	$KILLALL_PROG -w $tmp.fsstress.bin
 }
 
 # real QA test starts here
-- 
2.21.3

