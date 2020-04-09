Return-Path: <SRS0=x5Yn=5Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC22C2BA19
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 19:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307742087E
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 19:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZn10YmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgDITzY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:55:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33177 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725970AbgDITzX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Apr 2020 15:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586462123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oujoFpLF58e1ZJRU7fAw2sETb1qcQ/UqTGw7xVX4kbs=;
        b=ZZn10YmQZvVRJbXTUXsk1jMdB8ltlcZ2z3fyyP/9y7Z/HM+7dCXHEJB2B8hKNvDGe1/w0A
        Sa7RcvrINae8R6cpySwpaOaZMyvkZ2WIeqpTu122VW4mI5dKw0fOixVK5Rd4+wFbyyWzJ1
        A/zEUwjvc4TgDBAmCf7dYsxnZQ95dUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-Q8FTkMgwPFiDWTAwHtdn0Q-1; Thu, 09 Apr 2020 15:55:16 -0400
X-MC-Unique: Q8FTkMgwPFiDWTAwHtdn0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C07008017F3;
        Thu,  9 Apr 2020 19:55:15 +0000 (UTC)
Received: from [127.0.0.1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8472460BF3;
        Thu,  9 Apr 2020 19:55:15 +0000 (UTC)
To:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] fstests: exclude exfat from tests which require metadata
 journaling
Message-ID: <070404f2-9554-152b-5bbd-0fa87f4dfb65@redhat.com>
Date:   Thu, 9 Apr 2020 14:55:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/rc b/common/rc
index 476d3d07..ec17c99a 100644
--- a/common/rc
+++ b/common/rc
@@ -3211,7 +3211,7 @@ _has_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
-	ext2|vfat|msdos|udf)
+	ext2|vfat|msdos|udf|exfat)
 		echo "$FSTYP does not support metadata journaling"
 		return 1
 		;;

