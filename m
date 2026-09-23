Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96404334DD
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166539; cv=none; b=KeKDQneJzlSFKt9RKuvTv1OWWF/DgiVoBLuGRYTOZEykltB3R09faK4PXTHzISNL8ajeXZ7FGruy0DMu4FA7iAppjSFxF3B3GEOcrjTPMP6nYrHXd+IPaxJhsOc+7kvWHIqA4l5l/o7wdxBx8zW+tNEAdJWU/TTtkb60EfMaKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166539; c=relaxed/simple;
	bh=Wi8T0PsImQolwPTOIAFkUCnf6rCFehZxO4kohPGKlBU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FejVX+ypXgZpvLFLmFSGazQ/48vMJDn0t0DhOBKty95LLiUOPcTnybekuT5CwIP7hd+aFEM9O+yRl7wUnVPl9yxPXbpbt909ZClPSBwnv+bfTZAHJPMucZ1LbDVJOc5w5dcHgWEz8sFrsHMR6D6StR7ioKfOJ90jEBqygyjtNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUtouCzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUtouCzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF101F000FF;
	Wed, 23 Sep 2026 12:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166538;
	bh=5w/kWaZk5r+TUNtLUpYnR2eMMi+9+5ypprIHfVvodBI=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=EUtouCzwghByL23yyuAubRHrqDA6CnqIncIfJUC+O8itK4FLDgCpHns2kWqKwu2Sa
	 FtJRd5qXEdep7yAb4aDjBlRo22n1ktiYNWuSdLCqwiJMaYNtYNhnMPwGRduMMim96E
	 82RrRGs1KOMFu1C5vEhmiGtbyNfC/hKuL1XV0YocK0RoqI08oe6V+ib8/Ri4AxdQHy
	 NSPqhb6xtwy++N6b+Z4e8RnmxWApPTx/OqmCeFlnsNYlcqZYI/EFDiMjf5IbOZUP/O
	 ibjClDKSN9ngzrnOkPfbDLQv78rJ2yCJfZlZKL6/zs4WwZt+As7/plmLufKCAKAZkk
	 V3qPPpfOs5jFw==
Date: Wed, 23 Sep 2026 14:28:55 +0200
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/4] common: link .out file to the output directory
Message-ID: <arPFeQnDjD80tumQ@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260923093259.16199-1-aalbersh@kernel.org>
 <20260923093259.16199-3-aalbersh@kernel.org>
 <arOjWJbkDT5Y-MNy@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOjWJbkDT5Y-MNy@zlang-mailbox>

On 2026-09-23 18:42:55, Zorro Lang wrote:
> On Wed, Sep 23, 2026 at 11:32:53AM +0200, Andrey Albershteyn wrote:
> > On immutable systems with read-only system packages 'ln' will fail to
> > link .out files into system xfstests root directory. Fix this by linking
> > golden output file to the results output directory as a .out.good.
> 
> I was wondering, did you install xfstests into a read-only directory/fs and
> then redirect results to a writable directory by setting
> RESULT_BASE=/path/to/rw_dir?

Yes

> 
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
> 
> Since we are introducing this new .out.good file, although it works fine in
> most cases, I think we should probably clean it up before each test starts,
> just like we already do for .out.bad and .hints in ./check .

Yeah, sure, I will do that in v3

-- 
- Andrey
