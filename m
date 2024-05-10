Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289013B7AE
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311840; cv=none; b=GtPtT04E8lMEiZOCmLGi9KzJd6asuDdKGcfWvcuQ4luCDRdLwLT+CaQBQvVESdzrVCt+3XIuImFIYBv6+NCE+qpMlR+0ZphC3psu7F8Ohnd5TQtZs8SkHcLmqd0p+A1Itjr94TpsOXsBhpdPZ9tkXGoHylhX7RJV9pEvzJ+48tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311840; c=relaxed/simple;
	bh=2Y/daBnTzKHJKUtOoE8msaa8kA7NdcDJCLjjTpOQGdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uz6nphQqt3RB5mZ4Ltldbn8SxXRn3bkRy3tu29Yy+H4aKkyzgOayWW5RuA2NnVrXKOEjUDDuZRZLvuyTkxfAQTeDy6cWKFqbqIHVcoq4cbm77cg57Xr2kDq0ecxGcmhd5hlv2AcQyht2fYZdqLPqvoXv+BaShdz1jn6b9lIws4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0O59jom; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0O59jom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FCEC116B1;
	Fri, 10 May 2024 03:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715311839;
	bh=2Y/daBnTzKHJKUtOoE8msaa8kA7NdcDJCLjjTpOQGdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0O59jomG0nA0kasN2R8ceGWaDu3jmFsZ/gNWd3UGFUYuez78YQm8DkdhFkFwxNZf
	 AMOs6CcjZNyTdF7GECeZ9Mh2cR/Vhk0IAC+7+5p/eOcsiaVNTcYvCLTVdk7QOg/b33
	 QYX/5JQ4Jwd8OGZIyuGa96WbQasOOd3RlTd+67Va6TpdpOCOvhpgHIuG+W1JPVIyzk
	 6XYFT3mxOkPD3wE28j/4fWoq4RgomxbdAgOO6Lb/CyX7Su498Rz6Kqvi5eMu4Pp8ip
	 AwnV8p1fuTPSJp1ZdYR767bXfqydnDQdev7/oS5coSunrFHukKA59/ttKbBX+mjE/I
	 7bSWTqiguZApQ==
Date: Fri, 10 May 2024 11:30:35 +0800
From: Zorro Lang <zlang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix _require_debugfs and call it properly
Message-ID: <20240510033035.akqao4dc3z3jrovr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240429060906.465135-1-zlang@kernel.org>
 <20240429160356.GC360908@frogsfrogsfrogs>
 <20240429185857.n32qxnmfzghd5nuf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240510013726.fp72gsarkggnnys6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240510023146.GI2049409@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510023146.GI2049409@frogsfrogsfrogs>

On Thu, May 09, 2024 at 07:31:46PM -0700, Darrick J. Wong wrote:
> On Fri, May 10, 2024 at 09:37:26AM +0800, Zorro Lang wrote:
> > On Tue, Apr 30, 2024 at 02:58:57AM +0800, Zorro Lang wrote:
> > > On Mon, Apr 29, 2024 at 09:03:56AM -0700, Darrick J. Wong wrote:
> > > > On Mon, Apr 29, 2024 at 02:09:06PM +0800, Zorro Lang wrote:
> > > > > The old _require_debugfs helper doesn't work now, fix it to check
> > > > > a system supports debugfs. And then call this helper in cases which
> > > > > need $DEBUGFS_MNT.
> > > > > 
> > > > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > > > ---
> > > > >  common/rc       | 10 ++++++++--
> > > > >  tests/btrfs/150 |  1 +
> > > > >  tests/ceph/001  |  2 +-
> > > > >  tests/xfs/499   |  1 +
> > > > >  4 files changed, 11 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/common/rc b/common/rc
> > > > > index 56f1afb6..6f0bdf60 100644
> > > > > --- a/common/rc
> > > > > +++ b/common/rc
> > > > > @@ -2978,8 +2978,14 @@ _require_sparse_files()
> > > > >  
> > > > >  _require_debugfs()
> > > > >  {
> > > > > -    #boot_params always present in debugfs
> > > > > -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> > > > > +	local type
> > > > > +
> > > > > +	if [ -d "$DEBUGFS_MNT" ];then
> > > > > +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> > > > > +		[ "$type" = "debugfs" ] && return 0
> > > > > +	fi
> > > > > +
> > > > > +	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
> > > > >  }
> > > > >  
> > > > >  #
> > > > > diff --git a/tests/btrfs/150 b/tests/btrfs/150
> > > > > index a02bdafc..fd386d92 100755
> > > > > --- a/tests/btrfs/150
> > > > > +++ b/tests/btrfs/150
> > > > > @@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
> > > > >  . ./common/fail_make_request
> > > > >  
> > > > >  _supported_fs btrfs
> > > > > +_require_debugfs
> > > > >  _require_scratch
> > > > >  _require_fail_make_request
> > > > >  _require_scratch_dev_pool 2
> > > > > diff --git a/tests/ceph/001 b/tests/ceph/001
> > > > > index 060c4c45..79a5f58a 100755
> > > > > --- a/tests/ceph/001
> > > > > +++ b/tests/ceph/001
> > > > > @@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
> > > > >  
> > > > >  # real QA test starts here
> > > > >  _supported_fs ceph
> > > > > -
> > > > > +_require_debugfs
> > > > >  _require_xfs_io_command "copy_range"
> > > > >  _exclude_test_mount_option "test_dummy_encryption"
> > > > >  _require_attrs
> > > > > diff --git a/tests/xfs/499 b/tests/xfs/499
> > > > > index 9672f95d..6421cc4b 100755
> > > > > --- a/tests/xfs/499
> > > > > +++ b/tests/xfs/499
> > > > > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> > > > >  # real QA test starts here
> > > > >  _supported_fs xfs
> > > > >  _require_command "$CC_PROG" "cc"
> > > > > +_require_debugfs
> > > > 
> > > > This test doesn't mess around with debugfs per se; it actually wants
> > > > tracefs.  Perhaps this should be _require_ftrace instead?
> > 
> > Oh, I just found you've created a _require_ftrace helper in common/tracing:
> > 
> >   FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances/"
> > 
> >   _require_ftrace() {
> >           test -d "$FTRACE_INSTANCES_DIR" || \
> >                   _notrun "kernel does not support ftrace"
> >   }
> > 
> > Newer kernel has /sys/kernel/tracing/, to avoid the dependence of debugfs.
> 
> Ah, I didn't realize that!  I wonder how long that's been in place...

Looks like it happened in 2015, by cc31004a4aa7 ("tracefs: Add directory
/sys/kernel/tracing"):

https://lwn.net/Articles/630526/

> 
> > But there's still /sys/kernel/debug/tracing/, so I'm wondering
> > if we should try to use /sys/kernel/debug/tracing at first?
> > 
> > For example:
> > 
> > _require_ftrace() {
> > 	if [ -d /sys/kernel/tracing/instances/ ];then
> > 		FTRACE_DIR="/sys/kernel/tracing"
> > 		FTRACE_INSTANCES_DIR="/sys/kernel/tracing/instances"
> > 	elif [ -d /sys/kernel/debug/tracing/instances/ ];then
> > 		FTRACE_DIR="/sys/kernel/debug/tracing"
> > 		FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances"
> > 	else
> > 		_notrun "The ftrace is not supported, or tracefs is not mounted"
> > 	fi
> > }
> 
> Yes.

Oh, I found you set FTRACE_DIR="$FTRACE_INSTANCES_DIR/fstests.$seq". If we
don't need the root path of tracefs, I can just set FTRACE_INSTANCES_DIR.

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Sure, but if it depends tracefs only, should we use /sys/kernel/debug/tracing or
> > > /sys/kernel/tracing ? If we use /sys/kernel/debug/tracing, is the debugfs needed
> > > at first?
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > > 
> > > > --D
> > > > 
> > > > >  cprog=$tmp.ftrace.c
> > > > >  oprog=$tmp.ftrace
> > > > > -- 
> > > > > 2.44.0
> > > > > 
> > > > > 
> > > > 
> > 
> 
