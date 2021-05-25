Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D9DC47084
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A78A6108D
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhEYNgn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233351AbhEYNgm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5U4wXSqt9HoVCrwqD6ndhQExL2M6maq//3kuXNLtxA=;
        b=My2fF36dwZng17gQ+tWq6gyCo1S8PZgYGB4+H9MLuEmiL/N5LsKe8jD5vDHWvYkLwzuTvC
        OgE+UCttuQfUai4HdNK+JlENdk2N7kASBXSAhPWD+hPL6hdSIOcofhpFYdUZQWZlVTPJKu
        bp+HP3aeC+sWzJC3QVzBhMISkj2Y7Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-IsE4Ym32M_GpEguFDss-uA-1; Tue, 25 May 2021 09:35:10 -0400
X-MC-Unique: IsE4Ym32M_GpEguFDss-uA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EA8F102731F;
        Tue, 25 May 2021 13:34:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C66B25D9CD;
        Tue, 25 May 2021 13:34:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/9] afs: Indicate the minimum DIO alignment is 1
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:36 +0100
Message-ID: <162194967599.4011860.12553916320978856647.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make the _min_dio_alignment() query return 1 if the filesystem to be
operated upon is AFS.  It has no alignment or size granularity requirements
for doing read and write RPCs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 common/rc |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index c0659215..cb60c35b 100644
--- a/common/rc
+++ b/common/rc
@@ -3827,6 +3827,8 @@ _min_dio_alignment()
 
     if [ -b "$dev" ]; then
         blockdev --getss $dev
+    elif [ "$FSTYP" = afs ]; then
+	echo 1
     else
         $here/src/feature -s
     fi


