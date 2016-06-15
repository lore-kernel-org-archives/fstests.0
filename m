Received: from mx1.redhat.com ([209.132.183.28]:40714 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932709AbcFODfj (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 23:35:39 -0400
Date: Wed, 15 Jun 2016 11:35:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] shared: regression test for hang when processing
 corrupted orphaned inode list
Message-ID: <20160615033537.GV5140@eguan.usersys.redhat.com>
References: <20160613093350.GJ5140@eguan.usersys.redhat.com>
 <1465873139-8724-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20160614043942.GN5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160614043942.GN5140@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 12:39:42PM +0800, Eryu Guan wrote:
> On Tue, Jun 14, 2016 at 10:58:59AM +0800, Guangwen Feng wrote:
> > Commit c9eb13a fixed this bug:
> > 	ext4: fix hang when processing corrupted orphaned inode list
> > 
> > Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> 
> Looks good to me overall. Some minor issues inline below
> 
[snip]
> 
> > +	debugfs -w -R "ssv last_orphan $i" $SCRATCH_DEV >>$seqres.full 2>&1
> 
> You defined $DEBUGFS_PROG, use it here :)
> 
> > +	_scratch_mount
> > +	_scratch_unmount
> 
> There's a new helper to do this now, _scratch_cycle_mount

Sorry, the helper doesn't help here, it umount first then mount.  You're
doing mount then umount.

Thanks,
Eryu
