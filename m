Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA253D0B6
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176704; cv=none; b=qNJLmdruaBMnW+3rjl+9vVBS6k7HmqFOZ0ji5o//LtRz+xU4t2D580RiEEyFAXtzAljcCjZuRLI2eHBvlUzelhLXIvkSNnUW/B5r94pPCb/4Krc0nwjGwhvrcmWm0/2HDHBWk4ZysE1qfQFmONMqXAMT90loTTB6jCN+uUN3rIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176704; c=relaxed/simple;
	bh=pUT6K5jsnKutA5wys0QukUbNqXKAxfZS0Qp9/zbwpUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4oPsplX4GkOe2LjgTxYNhXZUxFWYeCdjiBohWCoCOCdiUcNdJtfxaxAWDvidbRTwSUAzHtIAKerOswX/ExQjb3Q6n9LwYJd/IxZeJNgdeM5jf6Xx0vDDbTjemY7aoOfgQWTg8sMSLGlXzLuxT/g7qg4vgBrRYxakmHFhFIqD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKfIex9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKfIex9C"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 11BBE1F00893;
	Wed, 23 Sep 2026 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176703;
	bh=Y7M/zWqHLTthi7HwDlJl+WG91ZyzFRdzUj7lPYymTBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eKfIex9C48bcna40X+aotHNhDthfaPQIIiFPGzd82Wx/hedDOXiR+Z5/TtI2sAGVP
	 lXKFca1L6Q2sY1qwDwmyikB7BF493pIxftCrWRtm62XGzFzfke4CKeM0S/FW7rRsf6
	 GeGKuu3qOhgfSArFLb2CdCmh7HXdYWuRZwFNCRP+B0v7LqbQ90nkEr7MSDunP0kvSk
	 SE0u0hNaNBahFf3IPQI8u8hjC7/hLl30lDxvGO58n3gDNoAoKbD5UJpULzV3mL7l7V
	 jNs9etWIT4K3NEHbgnBF0bJfTYnfMrnxynYMCLR84ar96bLVkUdNsz4lzcU63sKztU
	 Sp8Wa6Kx55ggw==
Date: Wed, 23 Sep 2026 08:18:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/4] common: link .out file to the output directory
Message-ID: <20260923151822.GD6253@frogsfrogsfrogs>
References: <20260923093259.16199-1-aalbersh@kernel.org>
 <20260923093259.16199-3-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923093259.16199-3-aalbersh@kernel.org>

On Wed, Sep 23, 2026 at 11:32:53AM +0200, Andrey Albershteyn wrote:
> On immutable systems with read-only system packages 'ln' will fail to
> link .out files into system xfstests root directory. Fix this by linking
> golden output file to the results output directory as a .out.good.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  check     | 12 ++++++++----
>  common/rc |  4 ++--
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/check b/check
> index bca302151955..aaed9f4af2ac 100755
> --- a/check
> +++ b/check
> @@ -1181,7 +1181,11 @@ function run_section()
>  		$timestamp && _timestamp
>  		stop=`_wallclock`
>  
> -		if [ ! -f $seq.out ]; then
> +		local out=$seq.out
> +		if [ -f $seqres.out.good ]; then
> +			out=$seqres.out.good
> +		fi
> +		if [ ! -f $out ]; then
>  			_dump_err "no qualified output"
>  			tc_status="fail"
>  			rm -f "$seqres.mountfail?"
> @@ -1193,7 +1197,7 @@ function run_section()
>  		# from `foo' to 'foo'. Filter old versions to match the new
>  		# version.
>  		sed -i "s/\`/\'/g" $tmp.out
> -		if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
> +		if diff $out $tmp.out >/dev/null 2>&1 ; then
>  			if [ "$tc_status" != "fail" ]; then
>  				echo "$seqnum `expr $stop - $start`" >>$tmp.time
>  				echo -n " `expr $stop - $start`s"
> @@ -1202,13 +1206,13 @@ function run_section()
>  		else
>  			_dump_err "- output mismatch (see $seqres.out.bad)"
>  			mv $tmp.out $seqres.out.bad
> -			$diff $seq.out $seqres.out.bad | {
> +			$diff $out $seqres.out.bad | {
>  			if test "$DIFF_LENGTH" -le 0; then
>  				cat
>  			else
>  				head -n "$DIFF_LENGTH"
>  				echo "..."
> -				echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
> +				echo "(Run '$diff $here/$out $seqres.out.bad'" \

Should this be $out not $here/$out , since $out is really just
$seqres.out.good ?

echo "(Run '$diff $out $seqres.out.bad' to see the entire diff)"

--D

>  					" to see the entire diff)"
>  			fi; } | sed -e 's/^\(.\)/    \1/'
>  			tc_status="fail"
> diff --git a/common/rc b/common/rc
> index 3958ac934980..1eccd60c0bc0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3907,8 +3907,8 @@ _link_out_file_named()
>  		print $result
>  		' <$seqfull.cfg)
>  	rm -f $1 || _fail "_link_out_file_named: failed to remove existing output file"
> -	ln -fs $(basename $1).$suffix $1 || _fail "$(basename $1).$suffix: could not setup output file"
> -	test -r $1 || _fail "$(basename $1).$suffix: output file for feature set \"$2\" not found"
> +	ln -fs $(realpath $1).$suffix $seqres.out.good || _fail "$(basename $1).$suffix: could not setup output file"
> +	test -r $seqres.out.good || _fail "$(basename $1).$suffix: output file for feature set \"$2\" not found"
>  }
>  
>  _link_out_file()
> -- 
> 2.54.0
> 
> 
