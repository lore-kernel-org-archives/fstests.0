Received: from sandeen.net ([63.231.237.45]:44010 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeBWW6b (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Feb 2018 17:58:31 -0500
Subject: Re: [PATCH] xfs/444: test log replay after XFS_IOC_SWAPEXT
References: <9227d8db-faf6-5c19-239b-074c7f5cfc00@sandeen.net>
 <20180223215420.GE14582@magnolia>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <4b4550ca-4c2a-2e5f-d49e-2b084d3c90f6@sandeen.net>
Date: Fri, 23 Feb 2018 16:58:30 -0600
MIME-Version: 1.0
In-Reply-To: <20180223215420.GE14582@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 2/23/18 3:54 PM, Darrick J. Wong wrote:
> On Fri, Feb 23, 2018 at 12:33:41PM -0600, Eric Sandeen wrote:
>> This is a mashup of xfs/042 and some of the log replay tests;
>> it checks whether the log can be replayed if we crash immediately
>> after an xfs_fsr / XFS_IOC_SWAPEXT.
>>
>> Hint: it can't.  It fails because the temporary donor inode has
>> been deleted and has invalid mode 0 when we try to replay its
>> swapext operation.  Kernel patches to fix it will follow soon.
> 
> Hmm, does this filesystem have rmap enabled or not?

Not when I tested it.  I can try with it.

> Different swapext strategy in play depending on the answer to that
> question.

Hm, ok.


> Maybe I should wait for patches to show up. :P

Something like this, with a better comment, and also skipping
XFS_ILOG_[DA]OWNER on replay if mode == 0 to catch it on an
upgrade if needed.

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 26f2413..72a0223 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -436,6 +436,12 @@ xfs_inode_item_format(
 			~(XFS_ILOG_ADATA | XFS_ILOG_ABROOT | XFS_ILOG_AEXT);
 	}
 
+	/* If this inode has been deleted do not try to recover swapext */
+	if (VFS_I(ip)->i_mode == 0) {
+		ilf->ilf_fields &= ~(XFS_ILOG_DOWNER | XFS_ILOG_AOWNER);
+		iip->ili_fields &= ~(XFS_ILOG_DOWNER | XFS_ILOG_AOWNER);
+	}
+
 	/* update the format with the exact fields we actually logged */
 	ilf->ilf_fields |= (iip->ili_fields & ~XFS_ILOG_TIMESTAMP);
 }
