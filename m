Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A434A3D41
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367622; cv=none; b=lSAxVvwLU4K50nBMySgvRygDGVhw7FdzTn0rI29YKDCN6m201k9Uw1fcuMVScNiU1Trc61hJKdTkRfUsWyCC+KCZcIIIxSB98gDUTii5HGNavD0JOzaY8MxwAqGtn3TKnuHdk6M+46x8b20uXl7F0Pdf/jYEsId8dBNjD6ljrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367622; c=relaxed/simple;
	bh=S83VzJN6pu+JVrCHDuvXNJPWwQPI//9pNGdOrB9xw+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlVo7aqKKWMYaucubM3U0qofKwX9LJev7gFCJcjNHeq1lzbAi0Ysi+zpV8O8aCrrIMzok2D3nvcSYYs/kkalzBITuSNkSJ4dct/fMfUvNpocImuqyPOa1neQN2krsGV5IfxKYW68YoJa8R1MCEdAlfMVrnMwDLNhgzWFLz6XdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN+zrEn8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN+zrEn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AABB1F000E9;
	Wed,  2 Sep 2026 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367620;
	bh=HkLuAVFGaRkBQQZ2DruHV9zz1tswZ0g2rv3gt1D7IgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AN+zrEn8Nf1xBujsxXtATOzwPOvgR3ekDwm5KJrYMUhc5MMhZUkjR4aVfl1oEhpcE
	 in+wlHonBwATQb4rw2q+eD3WbCNejwqJA7XvpWYS5yBKpPkUD/+vpPGrltnNwNk5jq
	 GXGg6IUUDOph7wkG/z24xzMx+xZQs5LI5uINYDrfvxFivZN1f59am67JhYL2VhvPFj
	 BmHHxl/1m738pAIHBfAzsMb4Vdfi9xfO8w/I3SQXZq6miKhVWxqQVD+SrXpg0C6Wzx
	 si7s8wa2IzjduxP0gKIkiiNwl/lT4I46fyzcEa6vH+qooIU4gxGz7HTMD0rJgN74HZ
	 Xsf7ObvEYdbcg==
Date: Thu, 3 Sep 2026 00:46:54 +0800
From: Zorro Lang <zlang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] generic/091: enable sub-block reads
Message-ID: <aphR1JHVpfU9_zTG@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-4-hch@lst.de>
 <20260831171931.GD839663@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831171931.GD839663@frogsfrogsfrogs>

On Mon, Aug 31, 2026 at 10:19:31AM -0700, Darrick J. Wong wrote:
> On Mon, Aug 31, 2026 at 09:51:06AM +0300, Christoph Hellwig wrote:
> > The description of generic/091 claims that it tries to exercise sub-block
> > direct I/O, but the test currently limits reads to PAGE_SIZE alignment.
> > 
> > Use the new min_dio_alignment -r option to query the minimal read
> > alignment and only limit the read alignment to that.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I've long wondered about why reads are the page size when xfs could
> easily do smaller...

Maybe we should rename psize/PSIZE in _run_fsx_on_file helper (and cases
call *run_fsx* function) as well? Keeping that name for DIO read alignment
doesn't quite match the new semantics introduced by this series.

Thanks,
Zorro

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  tests/generic/091 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/091 b/tests/generic/091
> > index 5cdf04890c0e..b2fba09d39ef 100755
> > --- a/tests/generic/091
> > +++ b/tests/generic/091
> > @@ -15,8 +15,8 @@ _begin_fstest rw auto quick
> >  _require_test
> >  _require_odirect
> >  
> > -psize=`$here/src/feature -s`
> >  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> > +psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`
> >  
> >  # fsx usage:
> >  # 
> > -- 
> > 2.53.0
> > 
> > 
