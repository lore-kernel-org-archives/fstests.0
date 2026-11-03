Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708128;
	b=hjWHDAOflKcbG/eGgjVCkdZI83xqvU8biFgN6+2tIufHWn/IHdUdpjC6tQ0U2S0ZD7yH
	 27z1ntPjgn847GZZ/gvMk9q5CBp1P6rhjSJkge9VkMKT6MMalbibuY9xB7t9f+aeGhhf9
	 gmHKPHnjb2JShMvAde3718145x4W1mHn+KNSaoY+iAFFtNm9GQ+lLP+carTcgvzIPQn+N
	 sNStLeCcVTJbJpI03LPZSEug0VkQlchSzb0l4J7lmCT/YrU2g1GbFDKV7cfcxBVw8I7y5
	 MbHK7NRjAx54+J5HllSugeITXBcVoz7Dwdf8pr3uh0dZPAdO1MBHK4gZ/pqcfCQlbzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708128;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=R3yfT0Z5AizC5oWl6flmH7h7ox4+VVz1ugI9xf78nN4=;
	b=vHNXNQrxT4k1uPXN6BdTLTD2iZ/DLXE/G3P8zpSpEwWgmb7tlhxl4U8LxWW3flmoXayG
	 5qyfVmRA+a8W0EeCEzA22UHfU6CKd6xpYkg6G6tBDmL9VX08Pd7vWK0fEyob6u+GHT/1d
	 XiVVi8qpOg2oqb5Da3HoWAkxtghkK5RzybT27P9M21C5KGmb+jEPAuXNhfKR/jCf8u9Ll
	 u4HujLdx+8GM+h9U1V48ptVZwesq26B6IR+hnJ40XbhzO54aq1Dj62MNhu5DnV0EjCoNq
	 /C1Qs/bxTrjHfpH5fDRlZZC5VotnXB76fgbkHKnNcBn0V4zsUtpawN5jgBET//jnysA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMAYj6cY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF226606A328
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMAYj6cY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940021F000C1;
	Tue,  3 Nov 2026 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708127;
	bh=R3yfT0Z5AizC5oWl6flmH7h7ox4+VVz1ugI9xf78nN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FMAYj6cYazu3FiCkC86RcjKr7j2SAWIiX8PUGL8upflzKOMY6LZhHl04os0eSXvZd
	 siMOAcZ8YRFWko4f8XvauyBv44KhjTQ4D9RkT687X9GZSD1RsR0Bs6elIlp5qSK/3u
	 TraHACWPrvKSeoeuZEaAuZQs1lwpYGI3iXXuSE9udpywimHPV946um/yWA5VroO9dk
	 AOBwpt935NK4h/XoTLWMpIRfxJDedGczKL7dwbpfub1/9UiNF5MyhDW0e/HqOB5aP1
	 eMDNYUn4qNH53batw1bYoMmZyHmAT7LqqcLs7swmrW14ytxI88O2biokUAGZ1VfgqW
	 w/DWGEzJq+XFA==
Date: Tue, 3 Nov 2026 20:15:21 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, hch@lst.de
Subject: Re: [PATCH v2] check: set seqres before calling init_rc which could
 write there
Message-ID: <aunJIPo777UWbpd4@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests@vger.kernel.org, ojaswin@linux.ibm.com, hch@lst.de
References: <20261103093116.2850916-2-aalbersh@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103093116.2850916-2-aalbersh@kernel.org>

On Tue, Nov 03, 2026 at 10:31:17AM +0100, Andrey Albershteyn wrote:
> There's path where >>$seqres is used in init_rc:
> 
> -> init_rc
> 	-> _test_mount
> 		-> _prepare_for_eio_shutdown
> 			->_xfs_prepare_for_eio_shutdown
> 				-> _set_fs_sysfs_attr
> 
> Which will try to write to .full because $seqres is not set. Fix this by
> setting seqres first, this way it should go to $RESULT_DIR/check.full.
> 
> The init_rc is called in the top context and then per section, however,
> for top context we don't have environment set up yet. These logs are
> just a few sysfs_attr writes and aren't that important, so, let's save
> those to /tmp/xxx.check.full just in case.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
> Changes in v2:
> - remove The before init_rc in the comment
> ---
>  check | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index 534c2cdf7a06..afe855bcf0ed 100755
> --- a/check
> +++ b/check
> @@ -534,6 +534,10 @@ if ! . ./common/rc; then
>  	_fatal "check: failed to source common/rc"
>  fi
>  
> +# init_rc could write to the $seqres.full, however we don't have any context
> +# here yet, and no RESULT_BASE is setup. These logs aren't that important but
> +# let's keep them in /tmp anyway.
> +seqres=$tmp.check

The code around init_rc is definitely messy and deserves a proper refactor.
For this patch specifically, though, it looks good to me.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  init_rc
>  
>  # If the test config specified a soak test duration, see if there are any
> @@ -932,8 +936,6 @@ function run_section()
>  		_test_unmount 2> /dev/null
>  	fi
>  
> -	init_rc
> -
>  	seq="check.$$"
>  	check="$RESULT_BASE/check"
>  	seqres="$check"
> @@ -941,6 +943,8 @@ function run_section()
>  	# don't leave old full output behind on a clean run
>  	rm -f $check.full
>  
> +	init_rc
> +
>  	[ -f $check.time ] || touch $check.time
>  
>  	# print out our test configuration
> -- 
> 2.54.0
> 
