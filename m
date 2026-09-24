Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D894485CED
	for <fstests@vger.kernel.org>; Thu, 24 Sep 2026 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256327; cv=none; b=hGnIr89+MtH+T0i3TPxfIu9TqIkj77FHnGkOjKCLUoSRPdA04fmWoUBpD+5lFJ34eJ5N1MlJnm2uVb6E+pUnggxUvjrwOGNR61Ijf+BTL4Zo3dR3jOsQgG72Rlp2pF55erl4jY1mJXpmXNAvSEGBJycRh/eUU5aMBmQW4XndDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256327; c=relaxed/simple;
	bh=s3eI0I28Q3u2bGQMm8SR2BwoZmfb4o/U6fW/H2oNuF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlb2QWGEaR9hCI0XCqNgovOGmg2oRPBZevm3PBVCyImWdz2gG0ISi8hRFCQon83zTMjXh4O69kgjlV+gGwkwdtte0fLB0+p6uXKMrxN5x1cr1ON6j+ODDWiypZ6n/TmvyYZLMoZ4BZJIkxjxACDyU8Sp/46r2ZQPaBLRjWNbSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtqIq0kY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtqIq0kY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782D21F00893;
	Thu, 24 Sep 2026 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256324;
	bh=YX+g/E51GRavW7AyLn9gj7OVq5Gwg+Pn8zTE6Wt39QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtqIq0kYQGrRIX2Y5dv9rxWak4uRgkIm7BMTLykSyRvQVBoV/uO2Hy1p7f1KjQ3Tg
	 OlkiZVTYBsT6gJ1h9iVIngEFVC5CjzH5u9TpRzQgE/CRDoEkbe+nafjBup0VFHCCuT
	 Tnlj1X5utoVKQns1ewxDQzqNg87Xe3HZWS5WJ2lNP6Ct/V9vOBHd5dWCVZbUU/TUaH
	 RUfb7o6vWnG9YTu/cc5Z+daAFdAapJVabGecEUv0b0XR7k7afJvXH7NPlljhYCoKuh
	 axKYVEgiNdxGfEaPVzGB4qUyagcpLXMKia2SQjxF37oZybP9NykwvT47+MW2YK3Zx0
	 mpu3TJg8ghsLQ==
Date: Thu, 24 Sep 2026 21:25:15 +0800
From: Zorro Lang <zlang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, fstests@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/4] common: link .out file to the output directory
Message-ID: <arUgKeVGm3PmIlIy@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, 
	Andrey Albershteyn <aalbersh@kernel.org>, fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20260923093259.16199-1-aalbersh@kernel.org>
 <20260923093259.16199-3-aalbersh@kernel.org>
 <20260923151822.GD6253@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923151822.GD6253@frogsfrogsfrogs>

On Wed, Sep 23, 2026 at 08:18:22AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 23, 2026 at 11:32:53AM +0200, Andrey Albershteyn wrote:
> > On immutable systems with read-only system packages 'ln' will fail to
> > link .out files into system xfstests root directory. Fix this by linking
> > golden output file to the results output directory as a .out.good.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  check     | 12 ++++++++----
> >  common/rc |  4 ++--
> >  2 files changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/check b/check
> > index bca302151955..aaed9f4af2ac 100755
> > --- a/check
> > +++ b/check
> > @@ -1181,7 +1181,11 @@ function run_section()
> >  		$timestamp && _timestamp
> >  		stop=`_wallclock`
> >  
> > -		if [ ! -f $seq.out ]; then
> > +		local out=$seq.out
> > +		if [ -f $seqres.out.good ]; then
> > +			out=$seqres.out.good
> > +		fi
> > +		if [ ! -f $out ]; then
> >  			_dump_err "no qualified output"
> >  			tc_status="fail"
> >  			rm -f "$seqres.mountfail?"
> > @@ -1193,7 +1197,7 @@ function run_section()
> >  		# from `foo' to 'foo'. Filter old versions to match the new
> >  		# version.
> >  		sed -i "s/\`/\'/g" $tmp.out
> > -		if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
> > +		if diff $out $tmp.out >/dev/null 2>&1 ; then
> >  			if [ "$tc_status" != "fail" ]; then
> >  				echo "$seqnum `expr $stop - $start`" >>$tmp.time
> >  				echo -n " `expr $stop - $start`s"
> > @@ -1202,13 +1206,13 @@ function run_section()
> >  		else
> >  			_dump_err "- output mismatch (see $seqres.out.bad)"
> >  			mv $tmp.out $seqres.out.bad
> > -			$diff $seq.out $seqres.out.bad | {
> > +			$diff $out $seqres.out.bad | {
> >  			if test "$DIFF_LENGTH" -le 0; then
> >  				cat
> >  			else
> >  				head -n "$DIFF_LENGTH"
> >  				echo "..."
> > -				echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
> > +				echo "(Run '$diff $here/$out $seqres.out.bad'" \
> 
> Should this be $out not $here/$out , since $out is really just
> $seqres.out.good ?

Makes sense, looks like $out should already be an absolute path at here.

> 
> echo "(Run '$diff $out $seqres.out.bad' to see the entire diff)"
> 
> --D
> 
> >  					" to see the entire diff)"
> >  			fi; } | sed -e 's/^\(.\)/    \1/'
> >  			tc_status="fail"
> > diff --git a/common/rc b/common/rc
> > index 3958ac934980..1eccd60c0bc0 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3907,8 +3907,8 @@ _link_out_file_named()
> >  		print $result
> >  		' <$seqfull.cfg)
> >  	rm -f $1 || _fail "_link_out_file_named: failed to remove existing output file"
> > -	ln -fs $(basename $1).$suffix $1 || _fail "$(basename $1).$suffix: could not setup output file"
> > -	test -r $1 || _fail "$(basename $1).$suffix: output file for feature set \"$2\" not found"
> > +	ln -fs $(realpath $1).$suffix $seqres.out.good || _fail "$(basename $1).$suffix: could not setup output file"
> > +	test -r $seqres.out.good || _fail "$(basename $1).$suffix: output file for feature set \"$2\" not found"
> >  }
> >  
> >  _link_out_file()
> > -- 
> > 2.54.0
> > 
> > 
