Received: from mail-pf1-f196.google.com ([209.85.210.196]:42437 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWRC5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Nov 2018 12:02:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so2879218pfr.9
        for <fstests@vger.kernel.org>; Thu, 22 Nov 2018 22:20:09 -0800 (PST)
Date: Fri, 23 Nov 2018 14:20:03 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] src/t_stripealign.c: Use block size reported by fstatfs()
Message-ID: <20181123062003.GK3889@desktop>
References: <20181121162646.18117-1-chandan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121162646.18117-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 21, 2018 at 09:56:46PM +0530, Chandan Rajendra wrote:
> On ppc64le, block size reported by fstat(2) is 64k (the page size)
> i.e. the "preferred I/O size". However src/t_stripealign.c requires the
> actual block size of the filesystem. Hence this commit now makes use of
> the block size reported by fstatfs(2) syscall.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

Looks like that only XFS returns the preferred iosize
(xfs_preferred_iosize()) on stat(2), other filesystems will return block
size (I checked the code of ext4, f2fs, ocfs2).

On the other hand, statfs(2) returns the actual block size on all
filesystems I've checked, including XFS. So this patch looks fine to me.

Thanks,
Eryu
