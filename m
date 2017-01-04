Received: from mx1.redhat.com ([209.132.183.28]:36890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758701AbdADJHc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Jan 2017 04:07:32 -0500
Date: Wed, 4 Jan 2017 16:55:16 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: Fix inconsistent xfs_io error report caused
 false alert
Message-ID: <20170104085516.GQ1859@eguan.usersys.redhat.com>
References: <20170104083708.5268-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104083708.5268-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 04, 2017 at 04:37:08PM +0800, Qu Wenruo wrote:
> Test case like generic/304 and generic/158 can cause false alert due to
> the error output change of xfs_io.
> 
> For error case, xfs_io mostly reports error like "dedupe: ERROR STRING"
> while under certain case, it reports error like "XFS_IOC_FILE_EXTENT_SAME:
> ERROR STRING".
> 
> Fix it by adding a new filter, _filter_dedupe_ioctl(), to filter out all
> "XFS_IOC_FILE_EXTENT_SAME:" to "dedupe:"
> 
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>

Thanks for the patch! I've sent a similiar patch to address this issue :)

http://www.spinics.net/lists/fstests/msg04822.html

And Darrick suggested to do a "reverse" filter today.

http://www.spinics.net/lists/fstests/msg04837.html

Thanks,
Eryu
