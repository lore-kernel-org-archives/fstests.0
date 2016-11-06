Received: from mx1.redhat.com ([209.132.183.28]:37058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbcKFE6o (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 6 Nov 2016 00:58:44 -0400
Date: Sun, 6 Nov 2016 12:58:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v5 1/2] common/populate: use _require_xfs_io_command() in
 right place
Message-ID: <20161106045841.GE27776@eguan.usersys.redhat.com>
References: <20161102040727.5765-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102040727.5765-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 02, 2016 at 12:07:26PM +0800, Wang Xiaoguang wrote:
> In original common/populate codes, we put _require_xfs_io_command "falloc" and
> _require_xfs_io_command "fpunch" in the begin of common/populate, but it's
> not appropriate, for fs, which does not support falloc and punch, will not
> be able to use other helper functions in common/populate, so here I choose
> to put _require_xfs_io_command "falloc" or "punch" in helper function which
> really use falloc and fpunch.
> 
> And xfs/120 uses fpunch, add _require_xfs_io_command "fpunch".
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>

Thanks for the patch! But I noticed that the new patchset posted by
Darrick recently removed "_require"s from common/populate too ([PATCH
2/9] populate: add _require_populate_commands to check for tools), and
his subsequent patches depend on this update. So I think it's better to
take Darrick's patch, rather than taking this one and forcing Darrick to
rebase his whole patchset again.

And patch 2 requires the movement of the "_require"s in common/populate,
so I'm going to merge it after reviewing & applying Darrick's patchset
(otherwise generic/256 won't run on filesystems that don't support
fallocate(2), e.g. ext2/3). That means patch 2 won't be in the pull
request this week either. Hopefully we can see it in next pr.

Thanks,
Eryu
