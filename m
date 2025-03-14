Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565812E3362
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970893; cv=none; b=Ypt+nYnej10ZldtagH5KlUqf2QjC/rU1tsDKprAKQ9tty6yrlOYepfc/yvcERxetCJuUW+br6XN8d9+GQ9vkxgn4P8BAKeCCLtmguGL5of0Sydb6TeofteHiNKOzJtgxPllGgAow/EQd4ekAev9SwMfu8mlNePMTpjAV1OrJivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970893; c=relaxed/simple;
	bh=pVYcOKHBzojbrddbezbcx+RXkHVCqy2zpwD4IUP4gHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMlcM0y1xBjP9Xvp5HYWZ/Of05/IuPGgp0YOeYZbaoVSwwHdadkQh5PRkv29mCxQx7QIUoLDTtYoz4LVMs/FcU2w2ufYn4E7lT8+efdgCvCOMWYjrflBUAlCIQtYtoyn+LgwK8aphyZrPB53fmT6hwH3VH+cL9RRz17JeR6LMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnFxd4IK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnFxd4IK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C703CC4CEE5;
	Fri, 14 Mar 2025 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741970892;
	bh=pVYcOKHBzojbrddbezbcx+RXkHVCqy2zpwD4IUP4gHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnFxd4IK+aIX77P6ZK6iEIHznh8It92qeY4MldwCtvKL4sZkuD2kGPne/1O8xavqD
	 YBVD1FopsH2gH++qJgfZs1MqkLrSEncIwdbBOrN+IIaxZ1ZAqZ3WElaoQHdwWRvtoK
	 7Npk2MfV0gstd8YyZexb8WZiwo3oudIs1SFNE4movC7PPsmW63dRFQ/CZkoWPBrHZY
	 88BWlf+g/Wj2chMkLZ9c6682iMjzFXbPowbjTp5wMm53eluZS58O3u39U6V0WdPhcM
	 Bcz0o1yJpYxvHm9bBNsYqYJaH21Q+lG8AfA+HpGbtYAlKHeVGg7Girgz6x02ANFmmN
	 64RK3nGco8gFg==
Date: Fri, 14 Mar 2025 09:48:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jeff Moyer <jmoyer@redhat.com>, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH V2] common/rc: explicitly test for engine availability in
 _require_fio
Message-ID: <20250314164812.GK2803740@frogsfrogsfrogs>
References: <7ca733f5-f33a-4b2e-a70d-4a48a4904391@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca733f5-f33a-4b2e-a70d-4a48a4904391@redhat.com>

On Fri, Mar 14, 2025 at 09:56:20AM -0500, Eric Sandeen wrote:
> The current test in _require_fio (--warnings-fatal --showcmd) does not
> fail if an invalid/unavailable io engine is specified.
> 
> Add an explicit test that every requested io engine in the job file
> is actually available.
> 
> Remove the "ioe_e4defrag" entries in ext4 tests - an engine with this
> name has seemingly never existed, but in each case later stanzas
> overrode the io engine, so it did not cause problems without this
> explicit parsing and checking.

Well, they override it with the correct name "e4defrag":

$ fio --enghelp
Available IO engines:
        cpuio
        mmap
        sync
<snip>
        falloc
        e4defrag

I think the commit message should call that out specifically "...but in
each case later stanzas provide the correct ioengine name 'e4defrag',
so...").

> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

With that amended, this all looks good to me so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> 
> V2: Be Better at Bash, thanks Zorro. Also add | sort | uniq to ensure
>     we only test each requested engine once.
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
