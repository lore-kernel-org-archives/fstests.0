Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FF55E45
	for <fstests@vger.kernel.org>; Sat, 11 May 2024 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715439200; cv=none; b=bgXR7tj4Cfk2m/aPIPEyt6a0U04VuV1XJZoycfV8JmUXtYFrita0kK5L2RJEtsnJFt4vMVTBEGXDuRZ55qZt+rwAr2k7jKKXKHwIh8a3cbB66gceh5dEm8WydWQc/UY3EkRduD1fldYGooYdvWXiHXxVt/xd5uufTfpDBRskEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715439200; c=relaxed/simple;
	bh=KqEvgueAw8Mwnn0k2iMVPM+2wtgPmU6Duw/R5DHRWrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faBILS/XqfA5FhgiTZEZs14GYKd0FRu+rQB2Bxt5LTGXN3UYxXspmbOIXv2K7dGLCHxBxKvNfaITj/KcFoImAYiPzMDQfRw7LOYHOoMRkrX02rHvvB/HuBLoO9KabTZP/mbeKRB87qxiM/iedGeQ78QdM+8Dlj/J+t3PR++5dK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SllC0PNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SllC0PNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEBEC2BBFC;
	Sat, 11 May 2024 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715439199;
	bh=KqEvgueAw8Mwnn0k2iMVPM+2wtgPmU6Duw/R5DHRWrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SllC0PNHKHhuN+gLkjSVfhVV5NF76DfzKh2KcwriiWHWuQrELLp7J2y8yJSm5rXka
	 mGp7rnRXQgO/NuHGpzMnunKPN9f0+xe/yBzt1cnnLjRRlS4aAZwKp/JQx+zAL9rrQh
	 9tiFPDvofp0YoiKo/0bsrMwe0ZgIEzjcM2uMEqakdUObPOAbUm+6HJ2fnLSzKuSfBF
	 2OtIeHN8fLtU3dT6nLiDOa3eeNnDfyovLFEF2Y2VPMRvggbFOPgV3Cv+uXq4hiVRQf
	 dt44r0GXSa28a+e15RBUsNhl2WH/ml8DZA3Hourim7Dt3fjPLkZqE1DZStRObuwXI+
	 rY0fdclKD5RFw==
Date: Sat, 11 May 2024 07:53:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/tracing: use /sys/kernel/tracing at first
Message-ID: <20240511145318.GM2049409@frogsfrogsfrogs>
References: <20240510043339.1238462-1-zlang@kernel.org>
 <20240510151754.GH360908@frogsfrogsfrogs>
 <20240511044641.fgdvav54bxcw2wvj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511044641.fgdvav54bxcw2wvj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, May 11, 2024 at 12:46:41PM +0800, Zorro Lang wrote:
> On Fri, May 10, 2024 at 08:17:54AM -0700, Darrick J. Wong wrote:
> > On Fri, May 10, 2024 at 12:33:39PM +0800, Zorro Lang wrote:
> > > To avoid the dependence of debugfs, tracefs is mounted on another
> > > place -- /sys/kernel/tracing now. But for the compatibility, the
> > > /sys/kernel/debug/tracing is still there. So change _require_ftrace
> > > helper, try to use the new /sys/kernel/tracing path at first, or
> > > fallback to the old one if it's not supported.
> > > 
> > > xfs/499 uses ftrace, so call _require_ftrace in it.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > >  common/tracing | 13 +++++++++----
> > >  tests/xfs/499  |  6 +++---
> > >  2 files changed, 12 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/common/tracing b/common/tracing
> > > index b3051c27..8613d044 100644
> > > --- a/common/tracing
> > > +++ b/common/tracing
> > > @@ -4,11 +4,16 @@
> > >  #
> > >  # Routines for dealing with ftrace (or any other tracing).
> > >  
> > > -FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances/"
> > > -
> > >  _require_ftrace() {
> > > -	test -d "$FTRACE_INSTANCES_DIR" || \
> > > -		_notrun "kernel does not support ftrace"
> > > +	if [ -d /sys/kernel/tracing/instances/ ];then
> > > +		FTRACE_ROOT="/sys/kernel/tracing"
> > > +		FTRACE_INSTANCES_DIR="/sys/kernel/tracing/instances"
> > 
> > To answer my own question, this new path has been in Debian since at
> > least 2021.
> 
> Oh, I thought the /sys/kernel/tracing was created in linux v4.1 :
>   cc31004a4aa7 ("tracefs: Add directory /sys/kernel/tracing")
> 
> But might be used in different distro widely later.

That creates an empty /sys/kernel/tracing directory, but userspace still
has to mount something to it, hence
/lib/systemd/system/sys-kernel-tracing.mount.

--D

> > 
> > > +	elif [ -d /sys/kernel/debug/tracing/instances/ ];then
> > > +		FTRACE_ROOT="/sys/kernel/debug/tracing"
> > > +		FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances"
> > > +	else
> > > +		_notrun "The ftrace is not supported, or tracefs is not mounted"
> > > +	fi
> > >  }
> > >  
> > >  _ftrace_cleanup() {
> > > diff --git a/tests/xfs/499 b/tests/xfs/499
> > > index 9672f95d..883415dc 100755
> > > --- a/tests/xfs/499
> > > +++ b/tests/xfs/499
> > > @@ -14,18 +14,18 @@ _begin_fstest auto quick
> > >  _register_cleanup "_cleanup" BUS
> > >  
> > >  # Import common functions.
> > > +. ./common/tracing
> > 
> > You could probably get rid of the "Import common functions" comment.
> 
> Sure, will change that when I merge it.
> 
> > 
> > This looks good!
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Thanks,
> Zorro
> 
> > 
> > --D
> > 
> > >  
> > >  # real QA test starts here
> > >  _supported_fs xfs
> > > +_require_ftrace
> > >  _require_command "$CC_PROG" "cc"
> > >  
> > >  cprog=$tmp.ftrace.c
> > >  oprog=$tmp.ftrace
> > >  sedprog=$tmp.ftrace.sed
> > >  
> > > -ftrace_dir=$DEBUGFS_MNT/tracing/events/xfs
> > > -
> > > -test -d $ftrace_dir || _notrun "ftrace not enabled"
> > > +ftrace_dir=$FTRACE_ROOT/events/xfs
> > >  
> > >  # The second argument to __print_symbolic is stringified in the tracepoint's
> > >  # fmt file, so we look for "{ NUM, STRING }" and try to separate each of them
> > > -- 
> > > 2.44.0
> > > 
> > > 
> > 
> 
