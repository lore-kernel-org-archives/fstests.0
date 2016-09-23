Received: from mx1.redhat.com ([209.132.183.28]:58184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbcIWE6G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Sep 2016 00:58:06 -0400
Date: Fri, 23 Sep 2016 12:58:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] generic: check whether we can truncate heavily
 reflinked file
Message-ID: <20160923045803.GX27776@eguan.usersys.redhat.com>
References: <57E38D6D.90007@cn.fujitsu.com>
 <20160923031207.30977-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160923031207.30977-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 23, 2016 at 11:12:07AM +0800, Wang Xiaoguang wrote:
> In btrfs, there is a bug about btrfs' truncate codes, it'll leak
> some fs space as the truncate operation proceeds. If this truncate
> operation is very large, later metadata request in this truncate
> operation may fail for enospc error. I also have sent a kernel
> patch fot btrfs to fix this issue.
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
> V3: Reduce test run time according to Eryu's suggestions.

This version looks good to me. Just one more thing to confirm with you,
did you verify that test passed with your btrfs patch applied?

Thanks,
Eryu
