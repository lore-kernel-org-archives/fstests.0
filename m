Received: from mx1.redhat.com ([209.132.183.28]:50964 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcFCDcB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Jun 2016 23:32:01 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B90A7F6A6
	for <fstests@vger.kernel.org>; Fri,  3 Jun 2016 03:32:00 +0000 (UTC)
Date: Fri, 3 Jun 2016 11:31:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfstests: xfs discontiguous multi-block buffer
 logging test
Message-ID: <20160603033158.GD5140@eguan.usersys.redhat.com>
References: <1464873001-17508-1-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464873001-17508-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 02, 2016 at 09:10:01AM -0400, Brian Foster wrote:
> XFS had a bug in the multi-block buffer logging code that caused a NULL
> lv panic at log push time due to invalid regions being set in the buffer
> log format bitmap. This was demonstrated by modifying a multi-block
> directory buffer in a manner that only logs regions beyond the first
> FSB-sized mapping of the buffer.
> 
> To recreate these conditions, this test fragments free space and
> populates several directories with enough entries to require
> discontiguous multi-block buffers. To recreate the problem, we remove
> entries from the tail end of the directory and fsync to flush the log.
> 
> Note that this test causes a panic on kernels affected by the bug. As
> such, it is included in the 'dangerous' group. The bug is resolved by
> kernel commit a3916e528b91 ("xfs: fix broken multi-fsb buffer logging").
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks good to me. Also tested on patched kernel with different block
size XFS, test passed within 20s for me.

Reviewed-by: Eryu Guan <eguan@redhat.com>
