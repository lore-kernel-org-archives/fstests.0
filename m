Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69290C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 16:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348668AbiDKQji (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348663AbiDKQjg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 12:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB0E831DD1
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2022 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649695041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZ0ODfu73rbmIIrVLfXIxokoNGCZmyKrOxhtoOLLgHU=;
        b=fm401hK3HQbui60fyLJiyvZ3qDEhUBmgtzdiWU7P5vsDOtopVHCuGUrKqy7aUhAL0EmFXg
        FrZHDlc2joegtrglDy6LYMx52usJnM6aX0+4qXz+tR8cHXBYQYipSkWkUjBQ/x/PM+PK/c
        538SF5ttgm7yRqD/zJ7joAiMDR6U0cw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-qZAeIRM8M9KONZ5y-50eIg-1; Mon, 11 Apr 2022 12:37:18 -0400
X-MC-Unique: qZAeIRM8M9KONZ5y-50eIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B0BB3822205;
        Mon, 11 Apr 2022 16:37:18 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-187.pek2.redhat.com [10.72.12.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5A147B7C;
        Mon, 11 Apr 2022 16:37:16 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me
Subject: [PATCH v3 0/2] xfstests: hexdump and CVE-2022-0847
Date:   Tue, 12 Apr 2022 00:37:08 +0800
Message-Id: <20220411163710.2157888-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks review points from Dave and Darrick. This patchset contains 2 patches:
[PATCH v3 1/2] xfstests: replace hexdump with od command
[PATCH v3 2/2] fstests: test dirty pipe vulnerability issue of CVE-2022-0847

[v3 1/2] Fix generic/404 failures on un-4k block size. Refer to:
https://lore.kernel.org/fstests/20220410171926.aanoxq2ybool5we5@zlang-mailbox/T/#u

[v3 2/2] Nothing changed

Thanks,
Zorro

== Messages from original V2 patch ==

[v2 1/2] did below changes:
1) Change g/404, remove od/hexdump command, generate md5 directly
2) Change g/042, remove -v option of od/hexdump
3) As Dave has given this V1 patch a "reviewed-by", so add it

[v2 2/2] did below changes:
1) remove _cleanup(), turn to use default _cleanup function
2) add "rm -f $localfile" before testing start

== Messages from original V1 patch ==
I've sent the V2 [2/2] last week[1], but due to the [2/2] hasn't been merged
and the [1/2] will affect [2/2]. So I send these two patches in one patchset
this time. Just please note, the [2/2] is the last version.

[1]
https://lore.kernel.org/fstests/20220320123932.1000005-1-zlang@redhat.com/

