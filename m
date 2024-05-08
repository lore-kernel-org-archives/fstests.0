Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B17FBB4
	for <fstests@vger.kernel.org>; Wed,  8 May 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162744; cv=none; b=dJ3RbVF0lYYKBrZIcw6ZVmGT3Oemk+uNDF4hfUyT7RLoK+hL+aTNzlgS9YNMGqjQ7vYlPxJTGp6luadCsqnHjguxshMkllOk2Y2cjA+NBKtgB0lu2CGuZIqw1sO49sW19QTtpcFKDshKL3zkb5+IN506nEDtykbcsFQwsfMFlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162744; c=relaxed/simple;
	bh=BAStZPVzrk+uz6g0vrYuvOe8pNEkmYBJvVdeBSV4Khc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nedJWh/3uOlFD8YMoQ/SYA8djR+/eEQKn7FP+MnQGY6Mjkc+zIAFExxn1yfEHV7lg27TWV3yYBAhBBHM6UVSSS0f8VyH+9LO/BOtHqGMbhSg3H8TXU8r0gFvJIfO+Ds45i5wRfSqDXNg0Zf3tQsDK5Gi8gEYjbAl5uDtJARfn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=qum2xZ4s; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="qum2xZ4s"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VZ9kj48vCz9sqj;
	Wed,  8 May 2024 12:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715162733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uzOH4IHAIOTUu9zgBJRXVj7NyXms0+6RSklC7p4aWJo=;
	b=qum2xZ4sRW1yeN1WJWCPCXuq7HCoIO213XWVx/PSLMfSjscsSpJrq9LhaNgoNH35A52/I8
	eQqTqEbWVp1ekJqJHyBzG6yacWLRZX2fnhuq2FxqdeQQDQWeJ+gdEPKHXMruqUK2AYNgmm
	XmhBzBzJtJIAbjl+kz4aarmgZ6aOtsOoCZev1Ijd/7mWjIcVo0MgqIIYHCoW2quL6miQSz
	0b82O/+rwIelSiBJhmiYfzDwRVhGCgIXDo1GOlY62+KAgN1PkKK0rM4UK/D+L67Ff+klXx
	Pq0Y5jFVHKCoiVsfi1DlnQT9EQT9AUNi5Y5G7YHpImU2/Qm3gDGPDp73Cw0UMA==
Date: Wed, 8 May 2024 10:05:30 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/3] generic/436: round up bufsz to nearest filesystem
 blksz
Message-ID: <20240508100530.xzdnzeajraborji2@quentin>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-3-kernel@pankajraghav.com>
 <20240507222407.GD2049409@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507222407.GD2049409@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4VZ9kj48vCz9sqj

On Tue, May 07, 2024 at 03:24:07PM -0700, Darrick J. Wong wrote:
> On Mon, May 06, 2024 at 05:01:18PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
> > while filling up the buffer for test 13 - 16, round up the bufsz to the
> > closest filesystem blksz.
> > 
> > As we only allowed blocksizes lower than the pagesize, this was never an
> > issue and it always aligned. Once we have blocksize > pagesize, this
> > assumption will break.
> > 
> > Fixes the test for LBS configuration.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  src/seek_sanity_test.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> > index 48b3ccc0..bc30f77c 100644
> > --- a/src/seek_sanity_test.c
> > +++ b/src/seek_sanity_test.c
> > @@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE);
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
> 
> Why is the page size multiplied by 14?

Ah, that is a copy pasta error from test 14 and test 15. I will change
it in the next version. Thanks.

> 
> --D
> 
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > @@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE);
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > @@ -643,7 +643,7 @@ static int test14(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > @@ -692,7 +692,7 @@ static int test13(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > -- 
> > 2.34.1
> > 

-- 
Pankaj Raghav
