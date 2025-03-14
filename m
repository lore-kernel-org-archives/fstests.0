Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E79BA38
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987166; cv=none; b=iAh9Efd3IZfHRZOtvS1OTu7nRT+v9ooXdMzx9oKu0kfaj0QIKcFowca8+lvyt87FNnzvKzSDoPQ/TQCozNWgRRPijmdpMogaM1KRYR+ZGL1GUpDSam3jstB6LpwFTY4fdjiuAv164z3h7OMw/jeaoKHnDE1ySgtGAL4MHqeJCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987166; c=relaxed/simple;
	bh=ofnXm1U6lXAM57tUVMA1x4zireLZaejqR0YKqafssx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Uo0c1tJfemPQtY+aPVFU+Yqn7dohx3MjgdVQECr4xN/PIQxaskji7gzHTHSfz3doPc3wThjXFPIPOzqCMuxSUs1pDT0PUyPPkBvwW9ei/C5OHvUomK6uEAxlC9Nnw2ALyb2bCtB6s/494W7hmwGvp7fpJSJtbVR4Mx6Oa8IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6t7M1Me; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6t7M1Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA3DC4CEE3;
	Fri, 14 Mar 2025 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741987165;
	bh=ofnXm1U6lXAM57tUVMA1x4zireLZaejqR0YKqafssx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6t7M1MedjUNUPvCjRh+mL43pfmSasp1QMelunZxYrHIwfZ+mR5sE695+VwpFSJGo
	 CxeIfwu5R+8YptqDYvXraQLSTY5sof6BzApmmWHmqs/DmzTmNj8So0QW803IOUR3t0
	 6M+2qsWDL1RA00J1Btbyc1wrG6Rfkc73ZX5Yuj6BKWvjUUoQxCzfnz6RXj/LY49cst
	 kgVBwjRswYKzDjyHNb0ENxWxtiheMfK5cN/WLUSlRjdrIOXY7xpAQ2ehgp2WDzRg9S
	 tQEDT9iaOEDVM7lFIWO4+GI8weSghsiTik+WRkr+j6x9EVONHmMT/29U2ItGO4ptDW
	 8etw4Z7YKz+yg==
Date: Fri, 14 Mar 2025 14:19:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH V3] common/rc: explicitly test for engine availability in
 _require_fio
Message-ID: <20250314211925.GM2803740@frogsfrogsfrogs>
References: <3d35c97d-8c04-4d0b-b7d7-bc689edbc1ed@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d35c97d-8c04-4d0b-b7d7-bc689edbc1ed@sandeen.net>

On Fri, Mar 14, 2025 at 01:37:45PM -0500, Eric Sandeen wrote:
> The current test in _require_fio (--warnings-fatal --showcmd) does not
> fail if an invalid/unavailable io engine is specified.
> 
> Add an explicit test that every requested io engine in the job file
> is actually available.
> 
> Also, remove the "ioe_e4defrag" entries in the [global] stanza of several
> ext4 tests which use fio jobfiles. While ioengines can be set in the
> [global] section, they can also be overridden in individual, subsequent
> stanzas. In each affected test (ext4/301, ext4/302, ext4/303, and
> ext4/304) every individual stanza after [global]re-specifies an ioengine;
> either with ioengine=e4defrag or ioengine=libaio.
> 
> Because of this re-specification, the ioengine in the [global] section
> is ignored. This is a good thing, because ioe_e4defrag is not a valid
> ioengine, and would fail this new hand-rolled check, even though fio
> did not complain.
> 
> So rather than over-complicate this new check, simply remove the unused,
> invalid "ioengine=ioe_e4defrag" lines in these tests.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

I appreciate this extra bit in the commit message explaining that the
removed lines were previously defunct.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> 
> V2: Be Better at Bash, thanks Zorro. Also add | sort | uniq to ensure
>     we only test each requested engine once.
> V3: I've got a fever, and the only prescription is more pedantry!
> 
> diff --git a/common/rc b/common/rc
> index ca755055..ac443ec2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3977,12 +3977,19 @@ _require_scratch_dev_pool_equal_size()
>  _require_fio()
>  {
>  	local job=$1
> +	local eng
>  
>  	_require_command "$FIO_PROG" fio
>  	if [ -z "$1" ]; then
>  		return 1;
>  	fi
>  
> +	# Explicitly check for every ioengine listed in the job
> +	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort | uniq`; do
> +		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
> +			_notrun "fio engine $eng not available"
> +	done
> +
>  	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
>  	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
>  }
> diff --git a/tests/ext4/301 b/tests/ext4/301
> index abf47d4b..a05b8e8a 100755
> --- a/tests/ext4/301
> +++ b/tests/ext4/301
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/302 b/tests/ext4/302
> index 87820184..e0f5f2f9 100755
> --- a/tests/ext4/302
> +++ b/tests/ext4/302
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/303 b/tests/ext4/303
> index 2381f047..0a83e86c 100755
> --- a/tests/ext4/303
> +++ b/tests/ext4/303
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/304 b/tests/ext4/304
> index 53b522ee..5f2ae4bd 100755
> --- a/tests/ext4/304
> +++ b/tests/ext4/304
> @@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> 
> 
> 
