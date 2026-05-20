Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BF3F20E9
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288923; cv=none; b=jI+rHj8jHVPwgEuJYkEYnjs+u4sOISPvf4hPoBXurPmJI1YSCcxgsDv4YLFPvbVktijdoRhaE6IEfrI+kiZvgah3fUcRIFGeutaG7Vg4lSXbPOVcF7hXKNsnrxTCTozbj0xDuVq/2pwa+8KNbY6sWUZPsCClq43604lWUURDcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288923; c=relaxed/simple;
	bh=iqf3Q179EFFN0jS6cA+fLOj+88eG6jpVXnBpiahn4Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz7PdWoz7MEKXoinN/lLdZuOy9nDfqd9LdH3IzwwysSpthf6m9n0WMAqGeVun6uV5hXvU6evMnMsBAQsmI9duXXlh7+2qrl7ueiCivNqnX+e/vzGraT/Ye2NRSc4zYqmYgYyFKH5GiZ+B3TDJhMP3+aTa+OotcyjWUxD398sm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB5eMvNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB5eMvNr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3E2341F00893;
	Wed, 20 May 2026 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288922;
	bh=Rd+9j0rijBVh0Bt8BdBU3go3SmDvroABNYiaY+YGahE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UB5eMvNrnDWhs+JZkMRDbv/KWJcxsnYxjVWj8LdUq6Jnv4s8maNxhn5UZqFpOPhly
	 JHCBydvg0DB9L7wTsvY912sf7DGxQdxnlp/FSGbrdd+qmdIXWR6E1nRUJkIvLS5nTs
	 X5vOj0pTqAqCCJ4GOj+9CnLGtZScOZimUQoZ1Ak9wA3KRyw+GvHg/3RxdftY5xGSeL
	 u+MWgkoZ6gKd95W7UPnuf0dDJsouxtiNWaUEkIyCHxTWsRmw/9s0NCci8JCDFGCbA/
	 3+viXMRrv6F9O0r/uDi35DLrs+uOTOp2/3z00iP49/22uFNonT3639iUH2MvU2OLon
	 2LtNDhtEpN7dg==
Date: Wed, 20 May 2026 07:55:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/791: don't run if kernel misses FANOTIFY
Message-ID: <20260520145521.GK9568@frogsfrogsfrogs>
References: <20260520133719.573809-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133719.573809-1-aalbersh@kernel.org>

On Wed, May 20, 2026 at 03:37:15PM +0200, Andrey Albershteyn wrote:
> If FANOTIFY=no in the kernel, then fs-monitor will fail to start. Fix
> fs-monitor error codes to detect and skip the test on "Function not
> implemented" code.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  src/fs-monitor.c  |  9 ++++++---
>  tests/generic/791 | 10 +++++++++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/src/fs-monitor.c b/src/fs-monitor.c
> index 0cf09677a3ef..28436ec2336f 100644
> --- a/src/fs-monitor.c
> +++ b/src/fs-monitor.c
> @@ -117,6 +117,7 @@ next_event:
>  int main(int argc, char **argv)
>  {
>  	int fd;
> +	int error;
>  
>  	char buffer[BUFSIZ];
>  
> @@ -126,15 +127,17 @@ int main(int argc, char **argv)
>  	}
>  
>  	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
> +	error = errno;
>  	if (fd < 0) {
>  		perror("fanotify_init");
> -		errx(1, "fanotify_init");
> +		errx(error, "fanotify_init");
>  	}
>  
>  	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
>  			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
> +		error = errno;
>  		perror("fanotify_mark");
> -		errx(1, "fanotify_mark");
> +		errx(errno, "fanotify_mark");
>  	}
>  
>  	printf("fanotify active\n");
> @@ -144,7 +147,7 @@ int main(int argc, char **argv)
>  		int n = read(fd, buffer, BUFSIZ);
>  
>  		if (n < 0)
> -			errx(1, "read");
> +			errx(errno, "read");
>  
>  		handle_notifications(buffer, n);
>  	}
> diff --git a/tests/generic/791 b/tests/generic/791
> index 90242292cba2..1d3a6c181011 100755
> --- a/tests/generic/791
> +++ b/tests/generic/791
> @@ -123,10 +123,18 @@ fi
>  _dmerror_unmount
>  _dmerror_mount
>  
> -$here/src/fs-monitor $SCRATCH_MNT > $tmp.fsmonitor &
> +$here/src/fs-monitor $SCRATCH_MNT > $tmp.fsmonitor 2>&1 &
>  fsmonitor_pid=$!
>  sleep 1
>  
> +if ! kill -0 $fsmonitor_pid 2>/dev/null; then
> +	wait $fsmonitor_pid
> +	# Function not implemented
> +	if [ $? -eq 38 ]; then

error numbers aren't the same across architectures, so you generally
have to strerror/perror and grep for that in the output.

Alternately we could add a getopt loop to main() so that you could pass
in a --check that would do the setup and exit(0) just before the while
loop; and then you could add:

$here/src/fs-monitor $SCRATCH_MNT --check &> /dev/null || \
	_notrun "fanotify too old"

--D

> +		_notrun "Kernel doesn't support fanotify"
> +	fi
> +fi
> +
>  _dmerror_mark_range_bad $bad_sector $bad_len
>  
>  cat >> $seqres.full << ENDL
> -- 
> 2.51.2
> 
