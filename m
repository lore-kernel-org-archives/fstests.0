Received: from mx2.suse.de ([195.135.220.15]:38483 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935486AbeE2Qnr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:43:47 -0400
Date: Tue, 29 May 2018 18:43:45 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Test for s_inodes_count overflow during fs resize
Message-ID: <20180529164345.3n2lzhopbzhexqdz@quack2.suse.cz>
References: <20180524183140.16125-1-jack@suse.cz>
 <20180528163541.GD6581@desktop>
 <20180529123902.gua35zqb6d3f32b4@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529123902.gua35zqb6d3f32b4@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue 29-05-18 14:39:02, Jan Kara wrote:
> On Tue 29-05-18 00:35:41, Eryu Guan wrote:
> > > +
> > > +# Create device huge enough so that overflowing inode count is possible
> > > +echo "Format huge device"
> > > +_dmhugedisk_init $(((LIMIT_GROUPS + 16)*GROUP_BLOCKS*(blksz/512)))
> > 
> > I think we need to require a minimum size on SCRATCH_DEV too, otherwise
> > I got mkfs failure when testing with 1k block size on a 10G SCRATCH_DEV,
> > the backing device didn't have enough space to store the metadata.
> > 
> > After assigning a 25G device to SCRATCH_DEV, mkfs with 1k block size
> > passed, but test still failed in the end, I'm not sure what's going
> > wrong this time..
> > 
> > --- tests/ext4/033.out  2018-05-28 22:12:56.234867728 +0800
> > +++ /root/workspace/xfstests/results//ext4_1k/ext4/033.out.bad
> > 2018-05-29 00:20:56.907283189 +0800
> > @@ -3,4 +3,4 @@
> >  Format huge device
> >  Resizing to inode limit + 1...
> >  Resizing to max group count...
> > -Resizing device size...
> > +Resizing failed!
> > 
> > And dmesg showed:
> > 
> > [166934.718495] run fstests ext4/033 at 2018-05-29 00:07:04
> > [166937.651454] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
> > [167629.640111] EXT4-fs (dm-11): mounted filesystem with ordered data mode. Opts: (null)
> > [167632.068897] EXT4-fs (dm-11): resizing filesystem from 4294836224 to 4294967296 blocks
> > [167632.069900] EXT4-fs warning (device dm-11): ext4_resize_fs:1937: resize would cause inodes_count overflow
> > [167765.672787] EXT4-fs (dm-11): resizing filesystem from 4294836224 to 4294959104 blocks
> > [167765.673573] EXT4-fs error (device dm-11): ext4_resize_fs:1950: comm resize2fs: resize_inode and meta_bg enabled simultaneously
> > [167766.005282] EXT4-fs warning (device dm-11): ext4_resize_begin:45: There are errors in the filesystem, so online resizing is not allowed
> > 
> > Tests with 2k/4k block sizes all passed.
> 
> Weird, I don't see why 1k should be any different. Let me check. Thanks for
> review and testing!

I've dug more into this. The excessive space usage for 1k blocksize is due
to the chunk size of dm snapshot being 512 sectors. I've modified the test
to use 16 sector chunk size. Then the test easily fits into 2GB. I've added
the size test just to be sure as well.

The test failure is due to a bug in e2fsprogs - they really end up creating
incorrect filesystem with these options. I'll fix that as well but it will
take a while so for now the test is going to fail. If you want to test
ext4/033 with 1k block size you can workaround the bug with:

export MKFS_OPTIONS="-b 1024 -O ^resize_inode"

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
