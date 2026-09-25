Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610ED3DE431
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366652; cv=none; b=Z+aiu2XChP7Ucw/4m0lvR6w16WEBcn0QIY7rLa09GxvsHYHDtoFBm9BJMJB5riAM/Z3dYMZRgqsdHXth1u49JBWOTcQ/VTcEbii8bw7xom8Td2BeQWc2BMH3CekgfJJd7zwazgAVu96nw1lVxM9Xh7BStJUn0fAkTJh7IjbXMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366652; c=relaxed/simple;
	bh=LOYMJdW+MJL0lU0PrfizpdK5Inti62YunMTTwn7R4XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBfG/VPMEUASWUcqCE6JzxQp5usceRW2MXARXZcA3Jj92Lw12H1ozAqgEvOJjAAIVp7sd/aHfS7w6mNEbS536emXKSdcGfUGycQukd9rOIs13PA4++bOZckffjoGheq0UzwVGeCRBcKz50AYURkTuymi6zIJ/KbR99+Lh0MeAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJZmgxDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJZmgxDD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E136B1F00893;
	Fri, 25 Sep 2026 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366651;
	bh=i7cpcYeSRdu9swp/BRIXXnkNypfx/bhmVrZOHVQqtq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SJZmgxDD1j50BmTS5n3mokdnSYyTBqHziBf5kktEDyDADScNIcOiizBhmhYtexDIk
	 qgAH7BJi6qS2cGklS/J27436AsDedDn2W83ofZSl1h7AJRHdji3WpB64AUTdNYxbfl
	 eP/pEA50T57Kf2hQGB5wVkMHTmmIuBALZwW6kuYfffrFFggfoRR+gwZPT+EjjF4qMt
	 fu8cipCnABuCdUuITIKyyNabfrRQPRx41XZhpxbMA2Zejm8B4V8B5ARurDApl7Tdcz
	 7yZsmMcsIGVsMd8G3JcELo7y5XRkXbFAC4d+U/RGwGrzZTC68l8MCFnG6bT91H/7GI
	 W5NV+QFoPTdng==
Date: Fri, 25 Sep 2026 13:04:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/4] common: link .out file to the output directory
Message-ID: <20260925200410.GN6253@frogsfrogsfrogs>
References: <20260925104514.664260-1-aalbersh@kernel.org>
 <20260925104514.664260-3-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925104514.664260-3-aalbersh@kernel.org>

On Fri, Sep 25, 2026 at 12:45:10PM +0200, Andrey Albershteyn wrote:
> On immutable systems with read-only system packages, 'ln' will fail to
> link .out files into system xfstests root directory. Fix this by linking
> golden output file to the results output directory as a .out.good.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good, thanks for fixing the diff instructions.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  check     | 14 +++++++++-----
>  common/rc |  4 ++--
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/check b/check
> index bca302151955..534c2cdf7a06 100755
> --- a/check
> +++ b/check
> @@ -1050,7 +1050,7 @@ function run_section()
>  		mkdir -p $RESULT_DIR
>  		rm -f ${RESULT_DIR}/require_scratch*
>  		rm -f ${RESULT_DIR}/require_test*
> -		rm -f $seqres.out.bad $seqres.hints
> +		rm -f $seqres.out.bad $seqres.hints $seqres.out.good
>  
>  		# check if we really should run it
>  		if _expunge_test $seqnum; then
> @@ -1181,7 +1181,11 @@ function run_section()
>  		$timestamp && _timestamp
>  		stop=`_wallclock`
>  
> -		if [ ! -f $seq.out ]; then
> +		local out=$here/$seq.out
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
> +				echo "(Run '$diff $out $seqres.out.bad'" \
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
