Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F658C77B7A
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jun 2023 05:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjFGFYg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jun 2023 01:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFGFYf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2023 01:24:35 -0400
X-Greylist: delayed 318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 22:24:34 PDT
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E9C198A
        for <fstests@vger.kernel.org>; Tue,  6 Jun 2023 22:24:34 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-getLHz0BMEG5bMFoXbIojw-1; Wed, 07 Jun 2023 01:17:13 -0400
X-MC-Unique: getLHz0BMEG5bMFoXbIojw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32E7C1C08DA1
        for <fstests@vger.kernel.org>; Wed,  7 Jun 2023 05:17:13 +0000 (UTC)
Received: from cav-thunderx1s-cn88xx-03.khw4.lab.eng.bos.redhat.com (cav-thunderx1s-cn88xx-03.khw4.lab.eng.bos.redhat.com [10.19.240.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03DE19E8B;
        Wed,  7 Jun 2023 05:17:12 +0000 (UTC)
From:   Zhenyu Zhang <zhenyzha12@gmail.com>
To:     fstests@vger.kernel.org
Cc:     zhenyzha@redhat.com, hshuai@redhat.com, gshan@redhat.com,
        shahuang@redhat.com, lijin@redhat.com
Subject: Confirm xfstest + nfs generic/568 failure issue
Date:   Wed,  7 Jun 2023 01:17:09 -0400
Message-Id: <20230607062851.256699-1-zhenyzha12@gmail.com>
MIME-Version: 1.0\nContent-Type: text/plain; charset=UTF-8\nContent-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello all,

Sorry to bother you.
When I run generic/568 on 64k kernel, I hit the following error:
 Sending command: ./check -virtiofs generic/568
 2023-06-05 05:33:10,297 avocado.test INFO | FSTYP         -- virtiofs
 PLATFORM      -- Linux/aarch64 localhost 5.14.0-319.el9.aarch64+64k #1 SMP PREEMPT_DYNAMIC Thu May 25 18:43:04 EDT 2023
 MKFS_OPTIONS  -- myfs2
 MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 myfs2 /mnt/myfs2
 
 generic/568       - output mismatch (see /home/xfstests-dev/results//generic/568.out.bad)
     --- tests/generic/568.out 2023-06-05 17:31:17.248857480 +0800
     +++ /home/xfstests-dev/results//generic/568.out.bad 2023-06-05 17:33:10.348857480 +0800
     @@ -1,4 +1,4 @@
      QA output created by 568
      wrote 2/2 bytes at offset block_size - 1
      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     -OK: File did not grow.
     +ERROR: File grew from 8192 B to 69632 B when writing to the fallocated range.
     ...
     (Run 'diff -u /home/xfstests-dev/tests/generic/568.out /home/xfstests-dev/results//generic/568.out.bad'  to see the entire diff)
 Ran: generic/568
 Failures: generic/568
 Failed 1 of 1 tests

My host and guest pagesize is 64k:
# getconf PAGESIZE
65536

I'm not sure if this is a product cache issue or a script issue.
I use --cache=never|always|none|auto both hit this issue

Best regards 
Zhenyu Zhang

