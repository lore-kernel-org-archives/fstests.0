Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF9C77B61
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjDXOMC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXOMB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 10:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143229ECF
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682345472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8VTud3w63WCYqJ57XpfS96mqXqPXVZrjfaAdeZ100w=;
        b=djzcSV+Y7UrgUPKwJ+iK3lFrTZs1RRJFJqZ0gMbjlADq3rmRszmXcKXoRh7dd7Pt8mbqVK
        F7u5QuKKFJZlS5RuhttcVx97vZOcCZz/P+ZH/isa54TWEXtwnHktrN98Bc+QdD4vkhY9bl
        NqpQZ9FnZqILvCKaSmzRCVsLhftAaO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-8m0qqJItPPOILzLywCbtsA-1; Mon, 24 Apr 2023 10:11:06 -0400
X-MC-Unique: 8m0qqJItPPOILzLywCbtsA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14E1985A5A3;
        Mon, 24 Apr 2023 14:11:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80D6B492C13;
        Mon, 24 Apr 2023 14:11:03 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 6/6] generic/696: AFS doesn't support the "noacl" command line option
Date:   Mon, 24 Apr 2023 15:10:42 +0100
Message-Id: <20230424141042.450535-7-dhowells@redhat.com>
In-Reply-To: <20230424141042.450535-1-dhowells@redhat.com>
References: <20230424141042.450535-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

AFS doesn't support the "noacl" command line option.  ACLs are mandatory
and interpreted by the server.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---
 tests/generic/696 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/696 b/tests/generic/696
index 178d78e1..55a2fd5a 100755
--- a/tests/generic/696
+++ b/tests/generic/696
@@ -31,7 +31,10 @@ _scratch_mkfs >$seqres.full 2>&1
 $here/src/vfs/vfstest --test-setgid-create-umask \
         --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
 
-export MOUNT_OPTIONS="-o noacl $MOUNT_OPTIONS"
+if [ "$FSTYP" != afs ]
+then
+    export MOUNT_OPTIONS="-o noacl $MOUNT_OPTIONS"
+fi
 
 # Also test S_ISGID stripping whether works correctly on underflying filesystem
 # that supports noacl feature.

