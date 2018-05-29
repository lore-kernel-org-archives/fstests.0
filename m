Received: from mail-pg0-f68.google.com ([74.125.83.68]:36094 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933444AbeE2M6g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 May 2018 08:58:36 -0400
Date: Tue, 29 May 2018 20:58:30 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] ext4: Test for s_inodes_count overflow during fs resize
Message-ID: <20180529125830.GE6581@desktop>
References: <20180524183140.16125-1-jack@suse.cz>
 <20180528163541.GD6581@desktop>
 <20180529123902.gua35zqb6d3f32b4@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529123902.gua35zqb6d3f32b4@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 29, 2018 at 02:39:02PM +0200, Jan Kara wrote:
> On Tue 29-05-18 00:35:41, Eryu Guan wrote:
> > On Thu, May 24, 2018 at 08:31:40PM +0200, Jan Kara wrote:
> > > Test for overflow of s_inodes_count during filesystem resizing.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  common/config      |   1 +
> > >  common/rc          |   7 ++++
> > >  tests/ext4/033     | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/033.out |   6 +++
> > >  tests/ext4/group   |   1 +
> > >  5 files changed, 133 insertions(+)
> > >  create mode 100755 tests/ext4/033
> > >  create mode 100644 tests/ext4/033.out
> > > 
> > > diff --git a/common/config b/common/config
> > > index fa07a6799824..659ebeed3ffc 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -170,6 +170,7 @@ export INDENT_PROG="`set_prog_path indent`"
> > >  export XFS_COPY_PROG="`set_prog_path xfs_copy`"
> > >  export FSTRIM_PROG="`set_prog_path fstrim`"
> > >  export DUMPE2FS_PROG="`set_prog_path dumpe2fs`"
> > > +export RESIZE2FS_PROG="`set_prog_path resize2fs`"
> > >  export FIO_PROG="`set_prog_path fio`"
> > >  export FILEFRAG_PROG="`set_prog_path filefrag`"
> > >  export E4DEFRAG_PROG="`set_prog_path e4defrag`"
> > > diff --git a/common/rc b/common/rc
> > > index 7368e2e12988..b8aad429e153 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3176,6 +3176,13 @@ _require_dumpe2fs()
> > >  	fi
> > >  }
> > >  
> > > +_require_resize2fs()
> > > +{
> > > +	if [ -z "$RESIZE2FS_PROG" ]; then
> > > +		_notrun "This test requires resize2fs utility."
> > > +	fi
> > > +}
> > > +
> > 
> > I think this could simply be done by
> > 
> > _require_command "$RESIZE2FS_PROG" resize2fs
> > 
> > in the test.
> 
> Yes, will do.
> 
> > And this could be added to other existing resize2fs tests too, e.g.
> > ext4/010, ext4/032 and ext4/306, and convert 'resize2fs' to
> > '$RESIZE2FS_PROG', in a follow-up patch.
> 
> Yeah, I've noticed as well. Will create a patch for that.
> 
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	_dmhugedisk_cleanup
> > > +	# Recreate scratch so that _check_filesystems() does not complain
> > > +	_scratch_mkfs >/dev/null 2>&1
> > 
> > This could be done by calling _require_scratch_nocheck, instead of
> > _require_scratch.
> 
> Thanks, I'll fixup xfs/310 as well (that's where I've copied this from ;).
> 
> > But I'm not sure why it's expected to leave a corrupted fs behind after?
> 
> Because SCRATCH_DEV is used as a DM backing store, it is not a valid
> filesystem...

Aha, it must be too late last night for me to review.. :)

Thanks,
Eryu
