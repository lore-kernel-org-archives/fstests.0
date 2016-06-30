Received: from mx1.redhat.com ([209.132.183.28]:38708 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932090AbcF3Nwl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 09:52:41 -0400
Date: Thu, 30 Jun 2016 21:52:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] geceric/362: check truncate can update file size
 correctly when truncate fails
Message-ID: <20160630135237.GG23649@eguan.usersys.redhat.com>
References: <20160623082718.GF3226@eguan.usersys.redhat.com>
 <20160630082549.27201-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160630082549.27201-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 04:25:49PM +0800, Wang Xiaoguang wrote:
> In btrfs, when truncate operation fails for enospc reason, file may still
> have some disk blocks, but it will fail to update filesize accordingly.
> 
> Kernel commit c0d2f61 has fixed this bug for btrfs:
>     btrfs: fix disk_i_size update bug when ftruncate() fails
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
> v2: move this test to generic test and add comments why testcase
> use reflink.

Thanks for the updated version. Did it fail for you when testing on
unpatched kernel? I ran the test more than 10 times on 4.6 kernel (which
doesn't have the fix) and all passed, as well as RHEL7 kernel.

Can you please confirm?

Thanks,
Eryu
