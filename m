Received: from aserp1050.oracle.com ([141.146.126.70]:17139 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbcJJQdv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Oct 2016 12:33:51 -0400
Date: Mon, 10 Oct 2016 09:31:58 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/175: disable inline data feature for btrfs
Message-ID: <20161010163158.GB5616@birch.djwong.org>
References: <20161010050647.30262-1-wangxg.fnst@cn.fujitsu.com>
 <b0db2215-ee06-0dc6-51de-2dc096943b03@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0db2215-ee06-0dc6-51de-2dc096943b03@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 10, 2016 at 05:03:49PM +0800, Anand Jain wrote:
> 
> 
> On 10/10/16 13:06, Wang Xiaoguang wrote:
> >For btrfs, if compression is enabled, it may generate inline data for a
> >blocksize data range, this inline data is stored in fs tree, will not have
> >a individual extent, try to reflink this data range at a not-zero offset
> >will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
> 
>  Hm. I didn't get the point of why its not a btrfs bug ?

/me was wondering about that too -- if you try to reflink an inlinedata
file, the reflink just fails?  I guess that's not totally unreasonable
for the normal usecase (reflink copy) since the copy will probably end
up being inlinedata too.  OTOH it's a little surprising that reflinking
a portion of a file at a non-zero offset (i.e. non-copy reflink) like
we're doing here doesn't convert the file to non-inline and fails
instead.

--D

> 
> Thanks, Anand
> 
> 
> >Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> >---
> > tests/generic/175 | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> >diff --git a/tests/generic/175 b/tests/generic/175
> >index 964580c..b3f90dc 100755
> >--- a/tests/generic/175
> >+++ b/tests/generic/175
> >@@ -50,6 +50,13 @@ rm -f "$seqres.full"
> >
> > echo "Format and mount"
> > _scratch_mkfs > "$seqres.full" 2>&1
> >+# For btrfs, if compression is enabled, it may generate inline data for a
> >+# blocksize data range, this inline data is stored in fs tree, will not have
> >+# a individual extent, try to reflink this data range at a not-zero offset
> >+# will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
> >+if [ "$FSTYP" = "btrfs" ]; then
> >+	export MOUNT_OPTIONS="-o max_inline=0 $MOUNT_OPTIONS"
> >+fi
> > _scratch_mount >> "$seqres.full" 2>&1
> >
> > testdir="$SCRATCH_MNT/test-$seq"
> >
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
