Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98850C77B61
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjDXOL4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjDXOLx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 10:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626309038
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682345466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYbc5AtNLEZfnSaGtcFFZyBlvVMJOdnhjqqfGs0avcE=;
        b=MHBWJeMhLIO8pbztCw4dFRdXZjkZj5Z4KVV9ImLVZwY/EPtutIYJHVsUO9h7LKLWnrjE82
        zO8m66zoNtZTE0R3yZMIFNtPYT0noEaDjNcdWYpWBzpGyZ5kAaen354rESATmKnBXEv7ZE
        jNCtV8xNGj+8UV90pxxBWKrV0vVTcKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-7BTwzkR_MDis9g6Gd3LT0g-1; Mon, 24 Apr 2023 10:11:02 -0400
X-MC-Unique: 7BTwzkR_MDis9g6Gd3LT0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7454E85A5A3;
        Mon, 24 Apr 2023 14:11:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 423854C83A;
        Mon, 24 Apr 2023 14:11:01 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 5/6] generic/531: Check for O_TMPFILE
Date:   Mon, 24 Apr 2023 15:10:41 +0100
Message-Id: <20230424141042.450535-6-dhowells@redhat.com>
In-Reply-To: <20230424141042.450535-1-dhowells@redhat.com>
References: <20230424141042.450535-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make generic/531 check that the filesystem under test supports O_TMPFILE
before attempting to test it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---
 tests/generic/531 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/531 b/tests/generic/531
index 5e84ca97..e5f3dddd 100755
--- a/tests/generic/531
+++ b/tests/generic/531
@@ -20,6 +20,7 @@ testfile=$TEST_DIR/$seq.txt
 # real QA test starts here
 _supported_fs generic
 _require_scratch
+_require_xfs_io_command "-T"
 _require_test_program "t_open_tmpfiles"
 
 _scratch_mkfs >> $seqres.full 2>&1

