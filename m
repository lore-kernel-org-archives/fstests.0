Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F7FC433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 29 Jan 2022 04:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352374AbiA2Eol (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 Jan 2022 23:44:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbiA2Eok (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jan 2022 23:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643431479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5vozK8XXO9snOKEiQFYvR9PmX6WbtKPcRMsxzvyuzGE=;
        b=JegLP/Z6Fm1INhP8/9zS/H34LhNFNbhXra9Ix3g9YPsNmYk4pR/sg5Plt0Sc2x52W7QW1n
        smHyTNX9F7po8Z3rUbW0elCQ9dST2cIXGLc6YA2McVUtXEPKhHIFkyXIRvBUfVo4rohZsW
        6hX2gm6MiWSnUz3Sb/I1X39fbgWPhE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-kY--aowIOT-_jT7SsECtUw-1; Fri, 28 Jan 2022 23:44:38 -0500
X-MC-Unique: kY--aowIOT-_jT7SsECtUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27EB2835B47;
        Sat, 29 Jan 2022 04:44:37 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE4BE4E2D7;
        Sat, 29 Jan 2022 04:44:35 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org
Subject: [PATCH] fsx: disable allocsp_calls if -F is specified
Date:   Sat, 29 Jan 2022 12:44:31 +0800
Message-Id: <20220129044431.1404283-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

As the fsx.c source code says:
  int     fallocate_calls = 1;            /* -F flag disables */
  int     allocsp_calls = 1;              /* -F flag disables */

The allocsp_calls and fallocate_calls should be disabled, if the -F
option is specified. But current fsx forgets to disable allocsp_calls
as is documented.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi Darrick,

Please help to take a look. I'm not sure if you'd like to disable
allocsp_calls by -F flag, or just copied that line then forgot to
change the F to another ?

Thanks,
Zorro

 ltp/fsx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 520e53a2..3ee37fe8 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2835,6 +2835,7 @@ main(int argc, char **argv)
 			break;
 		case 'F':
 			fallocate_calls = 0;
+			allocsp_calls = 0;
 			break;
 		case 'K':
 			keep_size_calls = 0;
-- 
2.31.1

