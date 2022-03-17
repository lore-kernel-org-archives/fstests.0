Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47435C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 10:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiCQKKR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiCQKKM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 06:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EA371CCAF9
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647511728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VLQ3Am8xum7XVQlbGbf6phBwln/756rdUIZTpvyTRcI=;
        b=HW8UUKYWrSmzXYhMOXuCDMkflyBClA7c3Wl60RnkgPJWgOgd5/Z47wZl30FMlOqirDRhXN
        WJr782QN0EPUzIg6WpHX7Qk9QDehXSAAgzLH38iaLN3N/Qhu/bw+5pAcXl0b4aNzlXbk8X
        ec5Lfz9I92a/MnrsmgJdA3ww0QsEmH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-JiRRCas7OsGeOB1OTz_Liw-1; Thu, 17 Mar 2022 06:08:46 -0400
X-MC-Unique: JiRRCas7OsGeOB1OTz_Liw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 963D580419E
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3874087D88;
        Thu, 17 Mar 2022 10:08:45 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     Boyang Xue <bxue@redhat.com>
Subject: [PATCH v1 0/2] check for dedupe and security namespace support
Date:   Thu, 17 Mar 2022 18:08:40 +0800
Message-Id: <20220317100842.1237893-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

Hi,

Some filesystems don't support dedupe and security namespace, we should
check for the support before running the test. I found this problem by
running these tests on our downstream NFS.

Please help review this fix.

Thanks,
Boyang

Boyang Xue (2):
  generic/674: check for dedupe support on scratch fs
  generic/513,675: check for security namespace support

 tests/generic/513 | 2 ++
 tests/generic/674 | 1 +
 tests/generic/675 | 2 ++
 3 files changed, 5 insertions(+)

-- 
2.27.0

