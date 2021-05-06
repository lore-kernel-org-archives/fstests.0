Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DFCC433ED
	for <linux-fstests@archiver.kernel.org>; Thu,  6 May 2021 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D03C613B5
	for <linux-fstests@archiver.kernel.org>; Thu,  6 May 2021 14:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhEFO2E (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 May 2021 10:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234002AbhEFO2E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 May 2021 10:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620311225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x3AOZuJBE2nH0EU6wAcRHTGc+AikyM2yp8+U3sVbjOc=;
        b=He5MN/CHuwW4qlEDrg/Jt2UpqTFy5Fd3Yr87qUVied25/stJQ1l8IVaUWwQq+MoQGcZ7kj
        BrVKoiJLPHVvFzslvRN7LsCj3puiT+MGsVhQTfgoIMKb1h7LmRr86GBlNmoOFDDIOmV+Z4
        UjmOJfuAOn3zdylqBVGdZVKVxEvi+0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-TIgsaXVYMhy1mcM_fdrbPw-1; Thu, 06 May 2021 10:27:02 -0400
X-MC-Unique: TIgsaXVYMhy1mcM_fdrbPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 280B118BA280;
        Thu,  6 May 2021 14:27:01 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0771C19D61;
        Thu,  6 May 2021 14:26:59 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH v2] gfs2: Fix mmap + page fault deadlock
Date:   Thu,  6 May 2021 16:26:58 +0200
Message-Id: <20210506142658.1077906-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Commit 20f829999c38 has moved the inode glock taking from gfs2_readpage and
gfs2_readahead into gfs2_file_read_iter and gfs2_fault.  In gfs2_fault, we
didn't take into account that page faults can occur while holding the inode
glock, for example,

  gfs2_file_read_iter [grabs inode glock] ->
    generic_file_read_iter ->
      filemap_read ->
        copy_page_to_iter ... ->
          gfs2_fault [tries to grab inode glock again]

  gfs2_file_write_iter ->
    iomap_file_buffered_write ->
      iomap_apply ->
        iomap_ops->iomap_begin [grabs inode glock] ->
        iomap_write_actor ->
          iov_iter_fault_in_readable ... ->
            gfs2_fault [tries to grab inode glock again]

Fix that by checking if we're holding the inode glock already.

Reported-by: Jan Kara <jack@suse.cz>
Fixes: 20f829999c38 ("gfs2: Rework read and page fault locking")
Cc: stable@vger.kernel.org # v5.8+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index a0b542d84cd9..95b59763b748 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -538,18 +538,22 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
+	bool recursive = gfs2_glock_is_locked_by_me(ip->i_gl);
 	struct gfs2_holder gh;
 	vm_fault_t ret;
 	int err;
 
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	err = gfs2_glock_nq(&gh);
-	if (err) {
-		ret = block_page_mkwrite_return(err);
-		goto out_uninit;
+	if (likely(!recursive)) {
+		err = gfs2_glock_nq(&gh);
+		if (err) {
+			ret = block_page_mkwrite_return(err);
+			goto out_uninit;
+		}
 	}
 	ret = filemap_fault(vmf);
-	gfs2_glock_dq(&gh);
+	if (likely(!recursive))
+		gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	return ret;
-- 
2.26.3

