Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBB49E13F
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160200; cv=none; b=VtXBIYDd9RZrTBAml1WeromsHybfuNiWpc65QUNtYqVz9ylDrTLcX5h1c2KlmZM/WE+Ecjy3AvZ2mUUv+QAFYVUtPZhrGCJhqw04xeQ6/wu11Y0QRJLhlb9XEzDBeR1GxaO8HRx8kFQN5LR83vPBIlrg4vB0+rQbqCGHDI9DLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160200; c=relaxed/simple;
	bh=xhu71nnUjQ6Tq0qnxTos0MdzdVHfFgrYOyqWpXO1xRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCG62wboiJy9BhaUOqr6uxRaMe1VmA6vFeV3ky+2uHKUI5LKa/iu+huOzg7uXsD0Wt7SjmNTEm9orVvNtVQu8e6B0duU8W8FXwSH7QpqSVpTd6r51WFYKOfo47jYTEEftbRx6o1fLxlmcCSEPshYunYzjHH5PTgbJ19laR7fk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7l2WRy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7l2WRy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D21F000FF;
	Wed, 23 Sep 2026 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790160179;
	bh=SfqfP4rriNJulAPwVitTsxSxf/dxUCv8zAK7Kxq5+fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e7l2WRy4mImjJ8u5k+xhNwRgkZZY7Wf2dAaldsc4hVEPc50IItX0qQeSjzlrcSQDV
	 U+Xe3aKohfqjg8SpKhE/ysg81xHyFu0QpGt/m4mIGNr+cXORyepAga1ldRQXRvgweW
	 J0ZIZlpHWebt5A7Mb3AU927fbBte107R1j6moNlndPpq4jFKxXg7OlPvzPpMzha2tB
	 GM0kUpmdcD8qu00stBbvvXfhA4ROsQKP6sLNt6ukz7c9US+kuoWtvTWdFVILZkW3xM
	 TU4AsVGW1dgo/JveeA+wYrWkkUKtcgJm9DpDBg+wXtLxvNhRBsefpJhSnX5uWju6Op
	 RQt5aTXagTZvA==
Date: Wed, 23 Sep 2026 18:42:55 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/4] common: link .out file to the output directory
Message-ID: <arOjWJbkDT5Y-MNy@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
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

I was wondering, did you install xfstests into a read-only directory/fs and
then redirect results to a writable directory by setting
RESULT_BASE=/path/to/rw_dir?

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

Since we are introducing this new .out.good file, although it works fine in
most cases, I think we should probably clean it up before each test starts,
just like we already do for .out.bad and .hints in ./check .

Thanks,
Zorro

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
