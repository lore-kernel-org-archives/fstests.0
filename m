Received: from mx1.redhat.com ([209.132.183.28]:50832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033727AbcKAHU5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Nov 2016 03:20:57 -0400
Date: Tue, 1 Nov 2016 15:20:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 4/4] xfstests: btrfs/134: add test for incremental
 send which renames a directory already being deleted
Message-ID: <20161101072055.GQ27776@eguan.usersys.redhat.com>
References: <1477619046-16375-1-git-send-email-robbieko@synology.com>
 <1477619046-16375-5-git-send-email-robbieko@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1477619046-16375-5-git-send-email-robbieko@synology.com>
Sender: fstests-owner@vger.kernel.org
To: robbieko <robbieko@synology.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 28, 2016 at 09:44:06AM +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
> 
> Test that an incremental send operation dosen't work because
> it tries to rename a directory which is already deleted.
> 
> This test exercises scenarios used to fail in btrfs and are fixed by
> the following patch for the linux kernel:
> 
> "Btrfs: incremental send, add generation check for inode is waiting for move."

I was testing with v4.9-rc1+ kernel and btrfs-progs v4.6. Seems above
patch is not merged in 4.9-rc1 kernel, but test passed for me, is that
expected?

Thanks,
Eryu
