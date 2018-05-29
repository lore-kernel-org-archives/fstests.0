Received: from mx2.suse.de ([195.135.220.15]:35094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933565AbeE2MjD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 08:39:03 -0400
Date: Tue, 29 May 2018 14:39:02 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Test for s_inodes_count overflow during fs resize
Message-ID: <20180529123902.gua35zqb6d3f32b4@quack2.suse.cz>
References: <20180524183140.16125-1-jack@suse.cz>
 <20180528163541.GD6581@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528163541.GD6581@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue 29-05-18 00:35:41, Eryu Guan wrote:
> On Thu, May 24, 2018 at 08:31:40PM +0200, Jan Kara wrote:
> > Test for overflow of s_inodes_count during filesystem resizing.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  common/config      |   1 +
> >  common/rc          |   7 ++++
> >  tests/ext4/033     | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/033.out |   6 +++
> >  tests/ext4/group   |   1 +
> >  5 files changed, 133 insertions(+)
> >  create mode 100755 tests/ext4/033
> >  create mode 100644 tests/ext4/033.out
> > 
> > diff --git a/common/config b/common/config
> > index fa07a6799824..659ebeed3ffc 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -170,6 +170,7 @@ export INDENT_PROG="`set_prog_path indent`"
> >  export XFS_COPY_PROG="`set_prog_path xfs_copy`"
> >  export FSTRIM_PROG="`set_prog_path fstrim`"
> >  export DUMPE2FS_PROG="`set_prog_path dumpe2fs`"
> > +export RESIZE2FS_PROG="`set_prog_path resize2fs`"
> >  export FIO_PROG="`set_prog_path fio`"
> >  export FILEFRAG_PROG="`set_prog_path filefrag`"
> >  export E4DEFRAG_PROG="`set_prog_path e4defrag`"
> > diff --git a/common/rc b/common/rc
> > index 7368e2e12988..b8aad429e153 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3176,6 +3176,13 @@ _require_dumpe2fs()
> >  	fi
> >  }
> >  
> > +_require_resize2fs()
> > +{
> > +	if [ -z "$RESIZE2FS_PROG" ]; then
> > +		_notrun "This test requires resize2fs utility."
> > +	fi
> > +}
> > +
> 
> I think this could simply be done by
> 
> _require_command "$RESIZE2FS_PROG" resize2fs
> 
> in the test.

Yes, will do.

> And this could be added to other existing resize2fs tests too, e.g.
> ext4/010, ext4/032 and ext4/306, and convert 'resize2fs' to
> '$RESIZE2FS_PROG', in a follow-up patch.

Yeah, I've noticed as well. Will create a patch for that.

> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	_dmhugedisk_cleanup
> > +	# Recreate scratch so that _check_filesystems() does not complain
> > +	_scratch_mkfs >/dev/null 2>&1
> 
> This could be done by calling _require_scratch_nocheck, instead of
> _require_scratch.

Thanks, I'll fixup xfs/310 as well (that's where I've copied this from ;).

> But I'm not sure why it's expected to leave a corrupted fs behind after?

Because SCRATCH_DEV is used as a DM backing store, it is not a valid
filesystem...

> > +testdir=$SCRATCH_MNT/test-$seq
> > +blksz="$(_get_block_size $SCRATCH_MNT)"
> > +
> > +umount $SCRATCH_MNT
> 
> _scratch_unmount

Will fix in xfs/310 as well.

> > +
> > +INODES_PER_GROUP=$((blksz*8))
> > +GROUP_BLOCKS=$((blksz*8))
> > +
> > +# Number of groups to overflow s_inodes_count
> > +LIMIT_GROUPS=$(((1<<32)/INODES_PER_GROUP))
> 
> Use lower case for local variables?

OK.

> > +
> > +# Create device huge enough so that overflowing inode count is possible
> > +echo "Format huge device"
> > +_dmhugedisk_init $(((LIMIT_GROUPS + 16)*GROUP_BLOCKS*(blksz/512)))
> 
> I think we need to require a minimum size on SCRATCH_DEV too, otherwise
> I got mkfs failure when testing with 1k block size on a 10G SCRATCH_DEV,
> the backing device didn't have enough space to store the metadata.
> 
> After assigning a 25G device to SCRATCH_DEV, mkfs with 1k block size
> passed, but test still failed in the end, I'm not sure what's going
> wrong this time..
> 
> --- tests/ext4/033.out  2018-05-28 22:12:56.234867728 +0800
> +++ /root/workspace/xfstests/results//ext4_1k/ext4/033.out.bad
> 2018-05-29 00:20:56.907283189 +0800
> @@ -3,4 +3,4 @@
>  Format huge device
>  Resizing to inode limit + 1...
>  Resizing to max group count...
> -Resizing device size...
> +Resizing failed!
> 
> And dmesg showed:
> 
> [166934.718495] run fstests ext4/033 at 2018-05-29 00:07:04
> [166937.651454] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
> [167629.640111] EXT4-fs (dm-11): mounted filesystem with ordered data mode. Opts: (null)
> [167632.068897] EXT4-fs (dm-11): resizing filesystem from 4294836224 to 4294967296 blocks
> [167632.069900] EXT4-fs warning (device dm-11): ext4_resize_fs:1937: resize would cause inodes_count overflow
> [167765.672787] EXT4-fs (dm-11): resizing filesystem from 4294836224 to 4294959104 blocks
> [167765.673573] EXT4-fs error (device dm-11): ext4_resize_fs:1950: comm resize2fs: resize_inode and meta_bg enabled simultaneously
> [167766.005282] EXT4-fs warning (device dm-11): ext4_resize_begin:45: There are errors in the filesystem, so online resizing is not allowed
> 
> Tests with 2k/4k block sizes all passed.

Weird, I don't see why 1k should be any different. Let me check. Thanks for
review and testing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
