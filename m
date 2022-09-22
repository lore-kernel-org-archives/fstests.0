Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD9C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 13:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiIVNtG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiIVNsl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 09:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38369DF3BC
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663854514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZPdxeVRitzgNEnEGr25UFIDaOdKThFzt7KR/fGRikA=;
        b=PShpCLMybUXM/vdSO9pisjwY3YFH32kKxn+JxzawavhK7WGoZSIX3Le7B/YJ3UZyv5eqLS
        XbtIvI5W42SCSLXw3a7f6942XIUpe9QUuBRayV9XFt/h2Ht/2dUFFT7SlT5RuVoBbVs/ix
        YlRkEuoWgQhrDX9Q5XplxSQDvgS6zAk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-gTr_TuVMOZuaMhQ3OpoM4w-1; Thu, 22 Sep 2022 09:48:33 -0400
X-MC-Unique: gTr_TuVMOZuaMhQ3OpoM4w-1
Received: by mail-ej1-f69.google.com with SMTP id ga33-20020a1709070c2100b00781bd47a18eso4234754ejc.12
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NZPdxeVRitzgNEnEGr25UFIDaOdKThFzt7KR/fGRikA=;
        b=N2hkmWwdRTBzPbEDpxE4zORBcqUi1Mw/pb3dLOLNC0EptthlxF1F+Vl51cn5PzEvhI
         aXtrIqq4nmVn/sUBENuYJ08oYE/HeT3H8nx4aOnqHMEhcDcHrwTTuh9m0OSk0BIQ/baG
         o+Os/TC9rScG5PZbwY8Vf6MzwJV4uw2fLCHddIm5Ib10RXciu0ptsz/ONDfeBSK3VNAd
         BBma8Mhjzsy15QukVppGEFiqrie88s/OEiLV06Vh2+MeMkZjIOfOQwV4gKHFxHdVwjaB
         qA0NGiOaRtce0OJMwl5Jgnh2EV84sXDm/UHQj/OV4rBqsAjFNZG6btQqSN5rfvQFiFVs
         za5w==
X-Gm-Message-State: ACrzQf1bEyAzOPCqmOtoh8YnwSzHxNSW4C7M2ND/ttUm8JtvL7t03VG3
        1B1foNW3b+hWeL8dLNQJ9sQa5chJl2d9XO4qQyKZzxVbr5Qs5G7Ig05frRm5bwS6nM7emsC2GLo
        lUAOlcedDzC+3LRP+UJkOvmugJLf1h1jzcPL3e0WuAECyeFam9OPmXEsMx38qnJvKQBva
X-Received: by 2002:a17:907:3fa1:b0:782:e53:7ab7 with SMTP id hr33-20020a1709073fa100b007820e537ab7mr2985565ejc.144.1663854511289;
        Thu, 22 Sep 2022 06:48:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6uZunoDZcSQ/zmxL8kY6t+1nggMN1xGD7ApEVX40YhOjnfzsmxktQTuVPlSVkvvogUhh33aw==
X-Received: by 2002:a17:907:3fa1:b0:782:e53:7ab7 with SMTP id hr33-20020a1709073fa100b007820e537ab7mr2985546ejc.144.1663854511011;
        Thu, 22 Sep 2022 06:48:31 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id e4-20020aa7d7c4000000b0044ec76521a1sm3760861eds.55.2022.09.22.06.48.29
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:48:29 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 4/4] g/394: clean up test files
Date:   Thu, 22 Sep 2022 15:48:22 +0200
Message-Id: <20220922134822.1020119-4-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922134822.1020119-1-preichl@redhat.com>
References: <20220922134822.1020119-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Clean up test files taking space.

-rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899
-rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899-1
-rwxr-xr-x. 1 root root    0 sep 22 14:58 394.1183899+1

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/394 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/394 b/tests/generic/394
index fc03e2f3..cbc2ce13 100755
--- a/tests/generic/394
+++ b/tests/generic/394
@@ -14,7 +14,7 @@ _cleanup()
 {
 	cd /
 	ulimit -f unlimited
-	rm -f $tmp.*
+	rm -f $tmp.* $TEST_DIR/$seq.*
 }
 
 # Import common functions.
-- 
2.37.3

