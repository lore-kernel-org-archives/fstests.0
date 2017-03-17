Received: from mx1.redhat.com ([209.132.183.28]:36726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdCQHlt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Mar 2017 03:41:49 -0400
Date: Fri, 17 Mar 2017 15:41:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] fstests: add GlusterFS support
Message-ID: <20170317074147.GD14226@eguan.usersys.redhat.com>
References: <1489642099-9019-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489642099-9019-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, gluster-devel@gluster.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 16, 2017 at 01:28:19PM +0800, Zorro Lang wrote:
> Add basic GlusterFS support. Neither new GlusterFS specific tests
> nor related patches are included. Only support FSTYP=glusterfs or
> check -glusterfs XXX.
> 
> To test on glusterfs, two gluster volumes and two mountpoint
> directories are needed.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi glusterfs developers,
> 
> Recently some people cares about testing kernel FUSE by running
> xfstests. We can't test FUSE independently, we must depend upon
> someone real FS base on FUSE, e.g. GlusterFS.
> 
> This patch only want to run xfstests on glusterfs, but I haven't
> made sure if there's no case bugs for glusterfs. I think that's
> another problem which I will fix in later patches.
> 
> At first I prepare two gluster volumes and two directories, then
> set into xfstests/local.config.
> 
> [root@ibm-x3650m4-10 xfstests-dev]# cat local.config
> TEST_DIR=/mnt/gluster/test
> TEST_DEV=ibm-xxxx-xx.redhat.com:testvol
> SCRATCH_MNT=/mnt/gluster/scratch
> SCRATCH_DEV=ibm-xxxx-xx.redhat.com:scratchvol
> 
> (feel free to set MOUNT_OPTIONS, or GLUSTERFS_MOUNT_OPTIONS)
> 
> Then I ran some generic cases, e.g. g/001 and g/117, one test on
> TEST_DEV, and the other run on SCRATCH_DEV:
> 
> [root@ibm-x3650m4-10 xfstests-dev]# ./check -glusterfs generic/001
> FSTYP         -- glusterfs
> PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 3.10.0-581.el7.x86_64
> MKFS_OPTIONS  -- ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol
> MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol /mnt/gluster/scratch
> 
> generic/001 9s ... 8s
> Ran: generic/001
> Passed all 1 tests
> 
> [root@ibm-x3650m4-10 xfstests-dev]# ./check -glusterfs generic/117
> FSTYP         -- glusterfs
> PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 3.10.0-581.el7.x86_64
> MKFS_OPTIONS  -- ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol
> MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol /mnt/gluster/scratch
> 
> generic/117 24s ... 24s
> Ran: generic/117
> Passed all 1 tests
> 
> The results look good. But there're some cases fails on glusterfs,
> I think that's case problem or glusterfs problems. I'll look into
> them in the future.

Looks fine to me. I tested with quick group and noticed some failures
too, but I agreed we can fix them later if they're fstests bugs.

I tend to merge this patch in this week's update, unless there're more
comments from glusterfs community.

> 
> I only know how to use "mount -t glusterfs XXXX:vol /mnt", if you
> have any other requirements or suggestions, please tell me.
> Welcome send more patches to fstests@ mail list:)
> 
> Thanks,
> Zorro
> 
>  README.config-sections |  7 +++++++
>  check                  |  2 ++
>  common/config          |  6 ++++++
>  common/rc              | 34 ++++++++++++++++++++++++++++++++--
>  4 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/README.config-sections b/README.config-sections
> index df7c929..9133997 100644
> --- a/README.config-sections
> +++ b/README.config-sections
> @@ -121,3 +121,10 @@ TEST_DIR=/mnt/test
>  TEST_DEV=192.168.14.1:6789:/
>  TEST_FS_MOUNT_OPTS="-o name=admin,secret=AQDuEBtYKEYRINGSECRETriSC8YJGDZsQHcr7g=="
>  FSTYP="ceph"
> +
> +[glusterfs]
> +FSTYP=glusterfs
> +TEST_DIR=/mnt/gluster/test
> +TEST_DEV=192.168.1.1:testvol
> +SCRATCH_DIR=/mnt/gluster/scratch

s/SCRATCH_DIR/SCRATCH_MNT/ , I can fix it at commit time.

Thanks,
Eryu
