Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:38291 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750907AbcFVDFp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 23:05:45 -0400
Date: Wed, 22 Jun 2016 13:04:22 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fail_at_unmount
 error handling
Message-ID: <20160622030422.GI27480@dastard>
References: <1466429073-10124-1-git-send-email-zlang@redhat.com>
 <1466429073-10124-2-git-send-email-zlang@redhat.com>
 <20160621070818.GT5140@eguan.usersys.redhat.com>
 <20160622000040.GF27480@dastard>
 <241381551.489652.1466559773511.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241381551.489652.1466559773511.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zirong Lang <zlang@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, sandeen@redhat.com, cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 21, 2016 at 09:42:53PM -0400, Zirong Lang wrote:
> The umount doesn't hang because in _dmerror_load_error_table(), it use
> "--nolockfs" option for dmsetup suspend operation. If drop this option,
> umount will hang.
> 
> As I test, mount/pull device/unmount can cause a hang, because unmount will
> try to writeback something to root inode? But yes, do more fsstress load
> can help to trigger the hang easier:)
> 
> I haven't known why "--nolockfs" will cause this situation. "--nolockfs" will
> make suspend don't attempt to synchronize filesystem when suspending a device.
> Maybe some uncompleted I/Os cause xfs shutdown, after resume error table?

when dm loads the new table, it first suspends the device. This
freezes the filesystem, which means it completely clean. Hence after
this there is nothing to write back on unmount and it doesn't hang.

Using --nolockfs means dm does not suspend the device and hence the
filesystem is not frozen before loading the new table. That means
unmount occurs with dirty metadata still in memory, and so umount
will try to write it and behaviour is then determined by the sysfs
attribute.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
