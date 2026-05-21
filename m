Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E653839B4
	for <fstests@vger.kernel.org>; Thu, 21 May 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374852; cv=none; b=WuZ/WqS+IPDgHEhpcpQaBnbbuXpd8eHku3xz/xD6fjJOr/NUac30UAMS0ClMJlPIlIBfsStzxNsksIIBKpiZmxMVeyAHlvq9W2+zw/v6mATuAAK3BokgrSyS4uiGLexOM9HJYjVFtDHBrjeat4Qh7HZHWLNWTdQAFhkPyFeytjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374852; c=relaxed/simple;
	bh=z0KzjkjFy5EPEBQJyZy9AGl1Z6vlxQWoBasnIP/8Xmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnwr883cllBGwre021SvZIy4cH1FpIL4azojidOxxEzSISb0Y9mHaJICw9vGZwv5UPIrSD/5aKvKo7BNSNfpU5PBXFY4bKojbeeXqQux8gQfh7oDS/F6gk+KIt7d+2qKsgoa124LWYb8vQSVECV+6Ff2+jMeYeIkQA2hcIcAQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGP7ZMtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGP7ZMtz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 15E831F00A3F;
	Thu, 21 May 2026 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374851;
	bh=Le1hpQw5ZDMUEhggC4BFWnqGQZYWsZGbWQsym8srOEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jGP7ZMtzpAZgBEsiPi48klDuRk7DK72bJt14+ddyGbKIRxaD7yslFU0XGv+8/11Bh
	 M5kwCSsxVREaVeZdjUa6sjyG9H0Sv3dadBLgHjEClpQRj5ofEDOG9P9YvLJ2g5Lc+G
	 eAuk/8DNPElk7ZvW6cXPiRIlHKNjGJnHZQiCxAQZAfIUa7oPLs/E7FiRYxFSW4WpLC
	 kxJC1LmVIcP1CvrRpwxtZ9uL54A4Aa+OILfZq8e1NK5nCeAAH91lz3ckglDDXlPd43
	 ffJqiJvcxO9FeLviaGwY40NATaLQsW2ABX3WYAtvYEdZT9FR0faM9uwqNh7l8BxhTG
	 g3oO4NvwBAzpw==
Date: Thu, 21 May 2026 07:47:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/791: don't run if kernel misses FANOTIFY
Message-ID: <20260521144730.GR9568@frogsfrogsfrogs>
References: <20260521082648.843312-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521082648.843312-1-aalbersh@kernel.org>

On Thu, May 21, 2026 at 10:26:46AM +0200, Andrey Albershteyn wrote:
> If FANOTIFY=no in the kernel, then fs-monitor will fail to start. Fix
> fs-monitor error codes to detect and skip the test on "Function not
> implemented" code.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
> Changes from v1:
> - Remove returning of errno
> - Instead of checking for error code add new -c argument to fs-monitor

Looks good to me now!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> ---
>  src/fs-monitor.c  | 19 ++++++++++++++++++-
>  tests/generic/791 |  3 +++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/src/fs-monitor.c b/src/fs-monitor.c
> index 0cf09677a3ef..dd91a5d7f623 100644
> --- a/src/fs-monitor.c
> +++ b/src/fs-monitor.c
> @@ -117,6 +117,8 @@ next_event:
>  int main(int argc, char **argv)
>  {
>  	int fd;
> +	int opt;
> +	int check = 0;
>  
>  	char buffer[BUFSIZ];
>  
> @@ -125,14 +127,29 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> +	while ((opt = getopt(argc, argv, "c")) != -1) {
> +		switch (opt) {
> +		case 'c':
> +			check = 1;
> +			break;
> +		default:
> +			fprintf(stderr, "Usage: %s [-c] path\n",
> +				argv[0]);
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
>  	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
> +	if (check)
> +		exit(fd < 0);
> +
>  	if (fd < 0) {
>  		perror("fanotify_init");
>  		errx(1, "fanotify_init");
>  	}
>  
>  	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> -			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
> +			  FAN_FS_ERROR, AT_FDCWD, argv[optind])) {
>  		perror("fanotify_mark");
>  		errx(1, "fanotify_mark");
>  	}
> diff --git a/tests/generic/791 b/tests/generic/791
> index 90242292cba2..edefbb7767c3 100755
> --- a/tests/generic/791
> +++ b/tests/generic/791
> @@ -65,6 +65,9 @@ _dmerror_mount >> $seqres.full 2>&1
>  
>  test $FSTYP = xfs && _xfs_force_bdev data $SCRATCH_MNT
>  
> +$here/src/fs-monitor -c $SCRATCH_MNT &> /dev/null || \
> +		_notrun "fanotify too old"
> +
>  # Write a file with 4 file blocks worth of data, figure out the LBA to target
>  victim=$SCRATCH_MNT/a
>  file_blksz=$(_get_file_block_size $SCRATCH_MNT)
> -- 
> 2.51.2
> 
