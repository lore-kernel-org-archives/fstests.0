Received: from mx2.suse.de ([195.135.220.15]:43705 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750808AbeFFIzg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Jun 2018 04:55:36 -0400
Date: Wed, 6 Jun 2018 10:55:35 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fstests: get rid of set_prog_path
Message-ID: <20180606085535.zcc76ec5sv3xnm4w@quack2.suse.cz>
References: <20180529165119.31961-1-jack@suse.cz>
 <20180603142117.GM6581@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603142117.GM6581@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Sun 03-06-18 22:21:17, Eryu Guan wrote:
> On Tue, May 29, 2018 at 06:51:18PM +0200, Jan Kara wrote:
> > -        export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
> > -        export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
> > -        export MKFS_UDF_PROG="`set_prog_path mkudffs`"
> > -        export MKFS_BTRFS_PROG="`set_mkfs_prog_path_with_opts btrfs`"
> > -        export MKFS_F2FS_PROG="`set_mkfs_prog_path_with_opts f2fs`"
> 
> We should keep above two setups, set_mkfs_prog_path_with_opts does extra
> work than set_prog_path.
>
> > diff --git a/tests/xfs/446 b/tests/xfs/446
> > index 752c6a7de827..ac74723f471f 100755
> > --- a/tests/xfs/446
> > +++ b/tests/xfs/446
> > @@ -37,7 +37,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
> >  # real QA test starts here
> >  _supported_fs xfs
> >  _supported_os Linux
> > -export CHECKBASHISMS_PROG="`set_prog_path checkbashisms`"
> 
> This is removed but not added in common/config file.
> 
> I fixed both issues on commit.

Good spottings. Thanks for fixing them up!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
