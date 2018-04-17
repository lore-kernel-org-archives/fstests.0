Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751187AbeDQOlC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Apr 2018 10:41:02 -0400
Date: Tue, 17 Apr 2018 22:40:59 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: ioctl FIBMAP for dax gone in v4.17-rc1
Message-ID: <20180417144059.nwbbynhgq3k3i63q@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org, fstests@vger.kernel.org, sandeen@sandeen.net
List-ID: <fstests@vger.kernel.org>


Hi,

FIBMAP ioctl call to file in pmem dax mountpoint, both xfs
and ext4, starts to fail on v4.17-rc1 Linus tree.

+fibmap: Invalid argument

Pass on v4.16.
Pass on non-dax mountpoint.

We got these in v4.17-rc1:
6e2608d xfs, dax: introduce xfs_dax_aops
fb094c9 ext2, dax: introduce ext2_dax_aops
5f0663b ext4, dax: introduce ext4_dax_aops

And we don't have ->bmap call in these aops, which may lead
to the ioctl call failure.

Do we have any plan of adding/supporting it ?

xfstests generic/223 covers this issue. If we are not going
to support this call for dax, we need to fix the testcase.

Thanks,
Xiong
