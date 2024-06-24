Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6419DF61
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246275; cv=none; b=dUYp93M/NMBuGZZpNv2oX01l+oCk5z+AeXviSEf293hYZevX3a2m6imE4xFaFt7CAmHWNSJg6H3vgJXRyambhXXFn6bccN3rwenainABWmrM07Vnh0LOt3Yw9G5SUi2fVq2Jqhlk21e9tY++4slYzri3789rpURxUhVMZG64SU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246275; c=relaxed/simple;
	bh=FoNqkRsZ/O+96MQLzWzIR5fc8+8CrPpQvflRPCURPhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJGmkicjmDwd/ZugG3Z3989PYjTu4PAe+ilL+m5ZE6tfdwKuaG5nDCBy0GWXokn5CcyH0pRrsMfGRjY9usLBz0ja0qHBxypwOxY1mpVlhtw6bMPWn6A8ghW+hU1oz6Avy2f2LRei8GxeSRLUwD6eWnRynZCbInq7/MkJdboZY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psX5NZrl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psX5NZrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D903FC2BBFC;
	Mon, 24 Jun 2024 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246274;
	bh=FoNqkRsZ/O+96MQLzWzIR5fc8+8CrPpQvflRPCURPhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psX5NZrlueW49MqGUTUpdMVQoAVmn/Zpxk/1Esg8wgk2O5j82M63tOOr2V6ippdbG
	 SKVHXNlIyXNhFeatjpeE+4HSQ3PbBM2UYkd8wwiL81y6C3wwMzoiJCERFHoxM+OEYe
	 Yxa6CybfAlaLC7RL+ZmQQ4N3SP3S0uzSYjDcQUejQOwwhfRbdtFrICGh+cSsJT5WuX
	 LJH2j4fOsvFz4jcoWVUjWqsQA+Tg2ZHt5q38EnsCY1VEswQ/zVfLh9UEa7O6bbfzIV
	 dtSyDpYsecB+VxmlFgnczOPNwb2+3UcoRgsWasYvWJ5XIereXdV0+Itmt9+I8Mpxwc
	 jVo+ahmHxNaQg==
Date: Mon, 24 Jun 2024 09:24:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 5/5] common/rc: print scratch and test mount options
Message-ID: <20240624162434.GH103020@frogsfrogsfrogs>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580@eucas1p2.samsung.com>
 <20240614061722.1080-6-da.gomez@samsung.com>
 <20240614155555.GE6110@frogsfrogsfrogs>
 <xxx2zqe7wyw7negkjjhgrhnykdw247jguaaykjdm2j2rpfwkcv@26mxj7pbpkae>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xxx2zqe7wyw7negkjjhgrhnykdw247jguaaykjdm2j2rpfwkcv@26mxj7pbpkae>

On Mon, Jun 24, 2024 at 02:02:33PM +0000, Daniel Gomez wrote:
> On Fri, Jun 14, 2024 at 08:55:55AM GMT, Darrick J. Wong wrote:
> > On Fri, Jun 14, 2024 at 06:17:26AM +0000, Daniel Gomez wrote:
> > > Mount options for a SCRATCH device might not be the same in the TEST
> > > device if RECREATE_TEST_DEV is not enabled. So, print mount options for
> > > each device to clarify this.
> > > 
> > > Add mount and mkfs info for TEST devices so we get the same information
> > > being printed for both devices.
> > > 
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  check     |  4 ++++
> > >  common/rc | 20 ++++++++++++++++++--
> > >  2 files changed, 22 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/check b/check
> > > index 723a52e30..e02d28b39 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -807,7 +807,11 @@ function run_section()
> > >  	# print out our test configuration
> > >  	echo "FSTYP         -- `_full_fstyp_details`"
> > >  	echo "PLATFORM      -- `_full_platform_details`"
> > > +	echo "TEST device:"
> > > +	echo "MKFS_OPTIONS  -- `_test_mkfs_options`"
> > > +	echo "MOUNT_OPTIONS -- `_test_mount_options`"
> > >  	if [ ! -z "$SCRATCH_DEV" ]; then
> > > +	  echo "SCRATCH device:"
> > >  	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
> > >  	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
> > 
> > Now there are two lines that start with "MKFS_OPTIONS"; will this break
> > anyone's parsing scripts?  Or should these be prefixed:
> > 
> > echo "TEST_MKFS_OPTIONS -- `_test_mkfs_options`"
> > ...
> > echo "SCRATCH_MKFS_OPTIONS -- `_scratch_mkfs_options`"
> > 
> > ?
> 
> This looks like my initial version, but I prefer the 'sub-menu style' because
> we did not have these variables before. However, I think it makes sense to
> introduce them so we can differentiate between them. 

The trouble is, if your parsing script were doing something like
splitting on "-- " then the "TEST device:" string would not split
properly and you'd have to add context retention of some sort to know
which "MKFS_OPTIONS" this was for.  Better just to namespace the new
lines from the start.  I guess for compatibility's sake then we'd have
to have:

TEST_MKFS_OPTIONS -- -o foo=bar
MKFS_OPTIONS      -- -o foo=baz

in the output, along with a comment somewhere in the source that the
non-prefixed scratch mkfs options is that way for hyst[eo]rical output
parsing reasons.

--D

> I guess introducing this change would break anyone's parsing scripts regardless?
> However, I do think is necessary to specify the mount differences.
> > 
> > Also should these four variables be captured explicitly by the reports
> > that are generated by common/report ?
> 
> I guess the report only includes the scratch mount options. I will update it to
> include the new specific test and scratch mount/mkfs options.
> 
> > 
> > --D
> > 
> > >  	fi
> > > diff --git a/common/rc b/common/rc
> > > index a42792c37..b351a82eb 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -235,6 +235,17 @@ _scratch_mount_options()
> > >  					$SCRATCH_DEV $SCRATCH_MNT
> > >  }
> > >  
> > > +_test_mount_options()
> > > +{
> > > +	_test_options mount
> > > +
> > > +	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
> > > +		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > > +	else
> > > +		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > > +	fi
> > > +}
> > > +
> > >  _supports_filetype()
> > >  {
> > >  	local dir=$1
> > > @@ -456,8 +467,7 @@ _test_mount()
> > >          return $?
> > >      fi
> > >  
> > > -    _test_options mount
> > > -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > > +    _mount -t $FSTYP$FUSE_SUBTYP `_test_mount_options $*`
> > >      mount_ret=$?
> > >      [ $mount_ret -ne 0 ] && return $mount_ret
> > >      _idmapped_mount $TEST_DEV $TEST_DIR
> > > @@ -571,6 +581,12 @@ _metadump_dev() {
> > >  	esac
> > >  }
> > >  
> > > +_test_mkfs_options()
> > > +{
> > > +	_test_options mkfs
> > > +	echo $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
> > > +}
> > > +
> > >  _test_mkfs()
> > >  {
> > >      case $FSTYP in
> > > -- 
> > > 2.43.0
> > > 
