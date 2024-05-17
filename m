Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876E12FF78
	for <fstests@vger.kernel.org>; Fri, 17 May 2024 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961486; cv=none; b=kITjYM48XrRb8na4HoM/lxQQA2SwidBcFwG1oQr5KbN6r/+QjrFLNf3/2f4WlDD/hlmfgR00GhbDi1MRPmpK/F5U8Mz+2IoUIEXXZyopEj5l+rkPBXWRpLPBXUWoR2nitDPK5qVSPudr0EnZPglrXtjyaGFc44hgTSlxBs67xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961486; c=relaxed/simple;
	bh=LSbv4pLkYVbjILFzetV8u6IwRSX825k/NLPCAFgKcMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq/6+iMwTDAXhw/QrcqUGuf/qoSO4/0T3RFeIyRrSfAaAsHDgqk7wIXaMyl1g4VXtKNKpyT6FSn276f8g5IslzVTpL894Mez2JK2rhyE0KenxvjxwFvb2eEXup7BIUNLRGmQ7Efl5Al7iF1aVESbj1TqF+/s1a/v8TLjKAFzQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTnrIzbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTnrIzbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E195C32781;
	Fri, 17 May 2024 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715961485;
	bh=LSbv4pLkYVbjILFzetV8u6IwRSX825k/NLPCAFgKcMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTnrIzbB+vpYnqWcrsXaNQ7UUbn738r0+nFJl03JZAAF8g9XRTwFFOgdCD6EaIwKB
	 N2K39ykYn+u4oKXSGk58wd3TPkOQyOkORo9fljBE0BKdzt6YxTRaq2IHgrGf3MX3hr
	 PCQRYudDs8I8hbMEJREZ6+jGqnTei0WFTbIf+IbJP5bAfciDQ8qNxUfHGNDsOl4jCM
	 CJmXAL6VtbtRLzXC5a87GxBCyYIFsja/XsX+4qc4ZqUJwnchrsX8f/rjoS6xP8I63H
	 6IorsMTmIcBJsUYPWWoHyjLJomcPW5AiwbntFYuagWSkZMy/Ue5ePpXRnoYewNpZyo
	 P6cIJFgiAZ6BA==
Date: Fri, 17 May 2024 08:58:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/tracing: use /sys/kernel/tracing at first
Message-ID: <20240517155804.GM360908@frogsfrogsfrogs>
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

Yeah, it showed up in kernel v4.1, but systemd only added a .mount file
for it a few years ago.

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
> 
