Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F81E502
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354275; cv=none; b=B0ZwizdLzT6Thshg8wPxt8ziGMj3KMnOJ/BoFw1e6Jbtu7I353XXVLxne5goWpha7B+PbzAPfJtKFo0dznkXNzsCSro3uzD6ebVrRnjzXmaNP1nTxwcGzzWZV28LBfaKTc6cwyBYKr+icrfNVHdoN6UslxgXbd0WwsKB6F1dC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354275; c=relaxed/simple;
	bh=6I6bF1HS/yjj87OFsCu7H5iNtOb30p/qjq4FdWQFTNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOsx2TIportiy5yjMTIhyQ43dsvhZi/QRbdplZoGhi1H4HtsGlI+wS8Jhf7ih2pSICP/iJpotQedmJoyS4eJzKJMUn9Yc2eRmh3ziMcb+ALmxYvIlRWw80b+cD+Fc8HPg2NgerR6EdlZP4xINrfp27Asav1cvN29t4T826jboZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvlPmBAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvlPmBAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9FCC113CC;
	Fri, 10 May 2024 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715354275;
	bh=6I6bF1HS/yjj87OFsCu7H5iNtOb30p/qjq4FdWQFTNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvlPmBAvvJtNWn0cxMOYAJXf6xzqhi/Xn0QmqlK+6dEmw8dp/qjs6GLqEAW70s5UD
	 E58MC4Z2bW7STH+jRiYz0WT2iZewI9+t5Gs1aaxgIYd8QVBsOwMpTaZ1e/MvXn+RE6
	 wGK1oJcIjl9JHtKl/FI5fabP6Ye1qXQnAy73idyUli0ZBup3z76tGCAvPxwlo82ajB
	 Py3VHuuKea/0M6uH5IqmrTruSO9flOMQduDK/yOKxXqxPam3KXomnhBcTVnhevqUmj
	 VZ+58U/KsY2WTntn9aEUS0tjhtlshU7OE6+Rb31Wouid68Ao6vRNahBNjkKwxFwqGG
	 58T1JD3ye2nug==
Date: Fri, 10 May 2024 08:17:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common/tracing: use /sys/kernel/tracing at first
Message-ID: <20240510151754.GH360908@frogsfrogsfrogs>
References: <20240510043339.1238462-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510043339.1238462-1-zlang@kernel.org>

On Fri, May 10, 2024 at 12:33:39PM +0800, Zorro Lang wrote:
> To avoid the dependence of debugfs, tracefs is mounted on another
> place -- /sys/kernel/tracing now. But for the compatibility, the
> /sys/kernel/debug/tracing is still there. So change _require_ftrace
> helper, try to use the new /sys/kernel/tracing path at first, or
> fallback to the old one if it's not supported.
> 
> xfs/499 uses ftrace, so call _require_ftrace in it.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  common/tracing | 13 +++++++++----
>  tests/xfs/499  |  6 +++---
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/common/tracing b/common/tracing
> index b3051c27..8613d044 100644
> --- a/common/tracing
> +++ b/common/tracing
> @@ -4,11 +4,16 @@
>  #
>  # Routines for dealing with ftrace (or any other tracing).
>  
> -FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances/"
> -
>  _require_ftrace() {
> -	test -d "$FTRACE_INSTANCES_DIR" || \
> -		_notrun "kernel does not support ftrace"
> +	if [ -d /sys/kernel/tracing/instances/ ];then
> +		FTRACE_ROOT="/sys/kernel/tracing"
> +		FTRACE_INSTANCES_DIR="/sys/kernel/tracing/instances"

To answer my own question, this new path has been in Debian since at
least 2021.

> +	elif [ -d /sys/kernel/debug/tracing/instances/ ];then
> +		FTRACE_ROOT="/sys/kernel/debug/tracing"
> +		FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances"
> +	else
> +		_notrun "The ftrace is not supported, or tracefs is not mounted"
> +	fi
>  }
>  
>  _ftrace_cleanup() {
> diff --git a/tests/xfs/499 b/tests/xfs/499
> index 9672f95d..883415dc 100755
> --- a/tests/xfs/499
> +++ b/tests/xfs/499
> @@ -14,18 +14,18 @@ _begin_fstest auto quick
>  _register_cleanup "_cleanup" BUS
>  
>  # Import common functions.
> +. ./common/tracing

You could probably get rid of the "Import common functions" comment.

This looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  # real QA test starts here
>  _supported_fs xfs
> +_require_ftrace
>  _require_command "$CC_PROG" "cc"
>  
>  cprog=$tmp.ftrace.c
>  oprog=$tmp.ftrace
>  sedprog=$tmp.ftrace.sed
>  
> -ftrace_dir=$DEBUGFS_MNT/tracing/events/xfs
> -
> -test -d $ftrace_dir || _notrun "ftrace not enabled"
> +ftrace_dir=$FTRACE_ROOT/events/xfs
>  
>  # The second argument to __print_symbolic is stringified in the tracepoint's
>  # fmt file, so we look for "{ NUM, STRING }" and try to separate each of them
> -- 
> 2.44.0
> 
> 
