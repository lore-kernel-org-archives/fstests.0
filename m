Return-Path: <david@fromorbit.com>
Date: Tue, 23 Dec 2014 08:35:13 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfstests: f2fs support
Message-ID: <20141222213513.GR15665@dastard>
References: <1401717572-21731-1-git-send-email-jaegeuk@kernel.org>
 <549866D8.1030507@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549866D8.1030507@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: jaegeuk@kernel.org, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforget.net
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 22, 2014 at 12:45:44PM -0600, Eric Sandeen wrote:
> (redirecting to the new fstests list)
> 
> Dave, this got a review from Lukas, and seems fine.
> Can you pull it in?

Can it be reposted so I can pull it in directly? quoted patches
aren't recognised by any tool...

Cheers,

Dave.
> 
> Thanks,
> -Eric
> 
> On 6/2/14 8:59 AM, jaegeuk@kernel.org wrote:
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > 
> > This patch adds to support f2fs file system.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  common/config | 7 +++++++
> >  common/rc     | 6 ++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/common/config b/common/config
> > index 0dbf0b9..0607294 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -210,6 +210,7 @@ case "$HOSTOS" in
> >          export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
> >          export MKFS_UDF_PROG="`set_prog_path mkudffs`"
> >          export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
> > +        export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
> >          export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
> >          export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
> >          export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
> > @@ -241,6 +242,9 @@ _mount_opts()
> >  		# acls & xattrs aren't turned on by default on ext$FOO
> >  		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> >  		;;
> > +	f2fs)
> > +		export MOUNT_OPTIONS="-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
> > +		;;
> >  	reiserfs)
> >  		# acls & xattrs aren't turned on by default on reiserfs
> >  		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
> > @@ -295,6 +299,9 @@ _fsck_opts()
> >  	reiserfs)
> >  		export FSCK_OPTIONS="--yes"
> >  		;;
> > +	f2fs)
> > +		export FSCK_OPTIONS=""
> > +		;;
> >  	*)
> >  		export FSCK_OPTIONS="-n"
> >  		;;
> > diff --git a/common/rc b/common/rc
> > index f27ee53..fcdabfe 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -105,6 +105,9 @@ case "$FSTYP" in
> >      btrfs)
> >  	 [ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
> >  	 ;;
> > +    f2fs)
> > +	 [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
> > +	 ;;
> >      nfs)
> >  	 ;;
> >  esac
> > @@ -511,6 +514,9 @@ _scratch_mkfs()
> >      tmpfs)
> >  	# do nothing for tmpfs
> >  	;;
> > +    f2fs)
> > +        $MKFS_F2FS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
> > +	;;
> >      *)
> >  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $SCRATCH_DEV
> >  	;;
> > 
> 
> 

-- 
Dave Chinner
david@fromorbit.com
