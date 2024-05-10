Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6913E881
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308307; cv=none; b=PW8LYykR2RlFSdc/etSoP1nq6dzHgOJVlS14uIxvDb2n/VXRQgAzNqsM/Tbo3iBo/gehzUQkxfoCogPtkrWxGLFPr8Rcm53BjVqAdlMxQKXybEBlcOozpcnwrAP28qajrCqDJ20nfrsy6tHuoCYvto3YvAWj6JV6O4O0wje/ooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308307; c=relaxed/simple;
	bh=fZ5UOKfkhYvB5XKwqPdG9CKerS/l8vNUL3a8IG6eXOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U32Iuc1cyaABdI/uR38yoL57AR3kmWRFNbq2RHy/idzTTj6mdog/WGJewVl62n60DjvnvW01s5c+a6LGase+EqvLXF/EJyiqB3EQyHxBGQY3hZsf2tORhWFgT+vcwlVxjtgUnwL/J+uhxw8fqJj4nbXxrr4YYlklTXrdXOfSA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl4ljHGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl4ljHGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEAAC116B1;
	Fri, 10 May 2024 02:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715308306;
	bh=fZ5UOKfkhYvB5XKwqPdG9CKerS/l8vNUL3a8IG6eXOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl4ljHGGEo16fnaf4qGdwQu1T1reh+CKG1AVGxOe4I+EbARxvjB/EMmpfZfNTIQ+z
	 8Ok8ygIC4EgNNP/f8hM7ZQX216RGqHwWbzEhqihIjiYX9ZxKncVAqRKdSxcrz9H7Vi
	 N0iUhFFJPx72OziYkXWQCiOsww2FwVNi8Ak/9v2hKhBd9SRaGAXC3fiPj73lcEu+FF
	 rq9Z8EPZrcXV/FfsOdiXvytqWRMKqNvemHexu30CpKj1SJ/LPpLYLd8DvE9bNT5BA+
	 /CWYEVr/ktIRu0VxTyfdOEmfP7GchsB4lzVNG+6Txr7G0l5E9g+gY69UJAK05zK4L7
	 UHzcpE0QuKuVA==
Date: Thu, 9 May 2024 19:31:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix _require_debugfs and call it properly
Message-ID: <20240510023146.GI2049409@frogsfrogsfrogs>
References: <20240429060906.465135-1-zlang@kernel.org>
 <20240429160356.GC360908@frogsfrogsfrogs>
 <20240429185857.n32qxnmfzghd5nuf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240510013726.fp72gsarkggnnys6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510013726.fp72gsarkggnnys6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, May 10, 2024 at 09:37:26AM +0800, Zorro Lang wrote:
> On Tue, Apr 30, 2024 at 02:58:57AM +0800, Zorro Lang wrote:
> > On Mon, Apr 29, 2024 at 09:03:56AM -0700, Darrick J. Wong wrote:
> > > On Mon, Apr 29, 2024 at 02:09:06PM +0800, Zorro Lang wrote:
> > > > The old _require_debugfs helper doesn't work now, fix it to check
> > > > a system supports debugfs. And then call this helper in cases which
> > > > need $DEBUGFS_MNT.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > > ---
> > > >  common/rc       | 10 ++++++++--
> > > >  tests/btrfs/150 |  1 +
> > > >  tests/ceph/001  |  2 +-
> > > >  tests/xfs/499   |  1 +
> > > >  4 files changed, 11 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/common/rc b/common/rc
> > > > index 56f1afb6..6f0bdf60 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -2978,8 +2978,14 @@ _require_sparse_files()
> > > >  
> > > >  _require_debugfs()
> > > >  {
> > > > -    #boot_params always present in debugfs
> > > > -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> > > > +	local type
> > > > +
> > > > +	if [ -d "$DEBUGFS_MNT" ];then
> > > > +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> > > > +		[ "$type" = "debugfs" ] && return 0
> > > > +	fi
> > > > +
> > > > +	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
> > > >  }
> > > >  
> > > >  #
> > > > diff --git a/tests/btrfs/150 b/tests/btrfs/150
> > > > index a02bdafc..fd386d92 100755
> > > > --- a/tests/btrfs/150
> > > > +++ b/tests/btrfs/150
> > > > @@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
> > > >  . ./common/fail_make_request
> > > >  
> > > >  _supported_fs btrfs
> > > > +_require_debugfs
> > > >  _require_scratch
> > > >  _require_fail_make_request
> > > >  _require_scratch_dev_pool 2
> > > > diff --git a/tests/ceph/001 b/tests/ceph/001
> > > > index 060c4c45..79a5f58a 100755
> > > > --- a/tests/ceph/001
> > > > +++ b/tests/ceph/001
> > > > @@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
> > > >  
> > > >  # real QA test starts here
> > > >  _supported_fs ceph
> > > > -
> > > > +_require_debugfs
> > > >  _require_xfs_io_command "copy_range"
> > > >  _exclude_test_mount_option "test_dummy_encryption"
> > > >  _require_attrs
> > > > diff --git a/tests/xfs/499 b/tests/xfs/499
> > > > index 9672f95d..6421cc4b 100755
> > > > --- a/tests/xfs/499
> > > > +++ b/tests/xfs/499
> > > > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> > > >  # real QA test starts here
> > > >  _supported_fs xfs
> > > >  _require_command "$CC_PROG" "cc"
> > > > +_require_debugfs
> > > 
> > > This test doesn't mess around with debugfs per se; it actually wants
> > > tracefs.  Perhaps this should be _require_ftrace instead?
> 
> Oh, I just found you've created a _require_ftrace helper in common/tracing:
> 
>   FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances/"
> 
>   _require_ftrace() {
>           test -d "$FTRACE_INSTANCES_DIR" || \
>                   _notrun "kernel does not support ftrace"
>   }
> 
> Newer kernel has /sys/kernel/tracing/, to avoid the dependence of debugfs.

Ah, I didn't realize that!  I wonder how long that's been in place...

> But there's still /sys/kernel/debug/tracing/, so I'm wondering
> if we should try to use /sys/kernel/debug/tracing at first?
> 
> For example:
> 
> _require_ftrace() {
> 	if [ -d /sys/kernel/tracing/instances/ ];then
> 		FTRACE_DIR="/sys/kernel/tracing"
> 		FTRACE_INSTANCES_DIR="/sys/kernel/tracing/instances"
> 	elif [ -d /sys/kernel/debug/tracing/instances/ ];then
> 		FTRACE_DIR="/sys/kernel/debug/tracing"
> 		FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances"
> 	else
> 		_notrun "The ftrace is not supported, or tracefs is not mounted"
> 	fi
> }

Yes.

--D

> Thanks,
> Zorro
> 
> > 
> > Sure, but if it depends tracefs only, should we use /sys/kernel/debug/tracing or
> > /sys/kernel/tracing ? If we use /sys/kernel/debug/tracing, is the debugfs needed
> > at first?
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > >  cprog=$tmp.ftrace.c
> > > >  oprog=$tmp.ftrace
> > > > -- 
> > > > 2.44.0
> > > > 
> > > > 
> > > 
> 
