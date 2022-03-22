Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F4C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 18:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiCVSbF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbiCVSbD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 14:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC2A69CC5
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647973773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QiLY6z7nIT5DOLRxDSYNxwhrkrYRK4WhBtF1brXz4co=;
        b=d+4wjStvwEhbe6QtgJID6hS3ixWhdtXqO0miB1HtRdSXVMRROVOpT1ADghH0dMWV04gT23
        6QmIgihgpHptoH2qjE51PORF2hWXiiol4cDVf/3WebarWeOqVI5ochJajTlRxHikcE4rZQ
        jA0fA886ob47yNoD23xyklHMm5xwSPw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-NxdrTSZ0OHGD6LtQNbJcQg-1; Tue, 22 Mar 2022 14:29:32 -0400
X-MC-Unique: NxdrTSZ0OHGD6LtQNbJcQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 124CE811E78;
        Tue, 22 Mar 2022 18:29:32 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-13-229.pek2.redhat.com [10.72.13.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 022532166B2D;
        Tue, 22 Mar 2022 18:29:29 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v2 0/2] xfstests: hexdump and CVE-2022-0847
Date:   Wed, 23 Mar 2022 02:29:24 +0800
Message-Id: <20220322182926.1829846-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks review points from Dave and Darrick. This patchset contains 2 patches:
[PATCH v2 1/2] xfstests: replace hexdump with od command
[PATCH v2 2/2] fstests: test dirty pipe vulnerability issue of CVE-2022-0847

[v2 1/2] did below changes:
1) Change g/404, remove od/hexdump command, generate md5 directly
2) Change g/042, remove -v option of od/hexdump
3) As Dave has given this V1 patch a "reviewed-by", so add it

[v2 2/2] did below changes:
1) remove _cleanup(), turn to use default _cleanup function
2) add "rm -f $localfile" before testing start

Thanks,
Zorro


== Messages from original V1 patch ==
I've sent the V2 [2/2] last week[1], but due to the [2/2] hasn't been merged
and the [1/2] will affect [2/2]. So I send these two patches in one patchset
this time. Just please note, the [2/2] is the last version.

[1]
https://lore.kernel.org/fstests/20220320123932.1000005-1-zlang@redhat.com/

