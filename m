Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B13DDB02
	for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285261; cv=none; b=HJCGcwhrcfpI4t/oyQL7SmKkm8CKlzV9TEi1CgTi2tqi8nGv9Vc8/sDyw9r8oggjK0xA0K99kRrKMO903nJEpPIbYw00pMS4HJsiNIZjp6CBgXNTzf7ECRXCnO6FxfaCA1RSmCjoCIJSca4yKFcIGUywTd0R+pg67sUPDL0oTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285261; c=relaxed/simple;
	bh=jeH2zw4BGNRXHlLehDIqu3eWxux0A2kBrwIhX6tMTfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovTf3oTrQieEAY4IsH9FJdnpvXzdgi+2MzIm3tJGUN3Y8F95uzgOrYPsLWDklreWoPsFPVgJgGRTIdurgdPEXfnp4/uyRcFi4iFPmC3DyEziyiwXIQ7AoGX48lVFJYl1Ph869zPN5x7Oo0pqW2e06VkssYDKYTugOBnmDuBINWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgsT2q8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgsT2q8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C3F1F000E9;
	Fri, 17 Jul 2026 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285258;
	bh=eGkSRp4teI72/jI7XMKfV3fBWLaaZ8qcn87O2VoAlz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bgsT2q8B7l8GSJIcINJTO6jRK3jIi+NiWEpy+hp2BX9RD/9UjbzBQ4RurxHf31sBq
	 gCkwXYyrLIbeZGkSPXI2iKnya1r1cp9vFlzGL9JZ4CgZCjzWgG4HIF4qsx5gpdhHWR
	 xWrMr9DUedhNhRcymJ1HQW3kVFvubPi1LFC16NIAgRo0MvBn5S7aIgOhRNaXttxCH1
	 nXgp7ty0I85LQFMPrh4fVrC9IOw0eeSC0r0gKATZFhKnwlPnL1kgNIJDkfaGvE/xKj
	 Pkda7tpl/To2Hbd/IaDQif5ScMyQqBS/qRBwONV3Gsv/1qgH2hZ8yWt1m0Lmej1jEh
	 +oSuTo9O9DU+A==
Date: Fri, 17 Jul 2026 18:47:30 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Anand Suveer Jain <asj@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
Message-ID: <aloCfjjqesxpzL9z@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, 
	Anand Suveer Jain <asj@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>

On Wed, Jul 08, 2026 at 11:25:37AM +0800, Chao Yu wrote:
> On 7/7/26 18:13, Anand Suveer Jain wrote:
> > On 6/7/26 14:43, Chao Yu wrote:
> >> f2fs has supported to report fserror, this patch adds support for f2fs
> >> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> >>
> >> Cc: Darrick J. Wong <djwong@kernel.org>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>  common/rc | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/common/rc b/common/rc
> >> index 494725547..f51ad59f3 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
> >>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
> >>  		test -n "$x" && return 0
> >>  		;;
> > 
> > 
> >> +	f2fs)
> >> +		x="$(cat /sys/fs/f2fs/features/fserror)"
> >> +		test -n "$x" && return 0
> > 
> > Don't we need to check if /sys/fs/f2fs/features/fserror
> > is present in the running kernel (there are helpers)
> 
> Hi Anand,
> 
> You mean _has_fs_sysfs_attr()? however, it forces to check first parameter $dev
> w/ block device type:
> 
> 	if [ ! -b "$dev" -o -z "$attr" ];then
> 		_fail "Usage: _has_fs_sysfs_attr <mounted_device> <attr>"
> 	fi

Hi Chao and Anand,

The *_fs_sysfs related helpers were brought in by me in:
  commit 2a7b77abcd1dde735186b363da24540706c43b73
  Author: Zorro Lang <zlang@redhat.com>
  Date:   Tue Jul 5 17:30:24 2016 +0800

    xfs: configurable behavior on errors at unmount time

At that time, I didn't think about the "features/" directory.

Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
family of functions shouldn't be restricted to the $dev directory,
we should remove this restriction.

Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
helpers which call *_fs_sysfs(). Also change the test cases who call these
functions.

Finally, we can introduce the *_fs_sysfs_features functions (or simply use
*_fs_sysfs directly).

Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
them is somewhat confusing and easy to mix up.

I need to write a series of patches to clean up these logic. For this current
patch, we can start with a small-scale change first. What do you think?

Thanks,
Zorro

>
> 
> > before reading it?
> 
> How about this?
> 
> f2fs)
>     local feat_file="/sys/fs/f2fs/features/fserror"
>     if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
>         return 0
>     fi
>     ;;
> 
> > 
> > 
> > 
> >>  	esac
> >>  
> >>  	_notrun "$FSTYP does not support fanotify ioerrors"
> > 
> 
