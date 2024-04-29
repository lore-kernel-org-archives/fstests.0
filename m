Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C76839F1
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406395; cv=none; b=eOpGxrEYnFVGuKfF/994pD/zLIRaHBAhV9GIJxy5NsDfjAtEithAFte8QuPZL7SylkVH4zjeDh6MYfJJiUxygniK935ST7ExyBMdk2s2Rt801LehXtolLffv3GQoH1zFvMHKobGLcLrAijcbR1S+u2xkAzhgzFblbJRdaHEAE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406395; c=relaxed/simple;
	bh=cArORkU/I1ZB3aeNVAQHQFeEy3p38mPgUz8qOhT4Bqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV4DHeYQC4Xsyac/XqnxodxQWY4uVajvDaTZrX74xXpqxC43f/hehEdNmyPFZ2zyIBihcfxG9T16zTY4v49oMI6YUf/6N9ly5qeFil5QfoNtBZErtX3SFH4n5yDHroPhXNzJTzBsTa9HrUwe8tDX8KTgfPr+Xe+TiyxE9mcSFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCo/SwD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCo/SwD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D29C116B1;
	Mon, 29 Apr 2024 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406395;
	bh=cArORkU/I1ZB3aeNVAQHQFeEy3p38mPgUz8qOhT4Bqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCo/SwD53amBe5W+545kK00LmR3OGZEq+p0YTbMhiYGHRUmMuplPV6EIVvh06CDA4
	 I846Yq6lYlHqeglEHjxjfctfKTnw4ZfYy9J+IE+1+fI/FCA/q26QqUHm92pElI7jnp
	 kADRJiS1AU1mB2/PESj/Ch4fcGBYydA0C3NLYrof2aKc+8ypBPe3MJLrj1UyalzDEb
	 fHMCGBkBylfR5i2j7EhhhW8oUZEeTeRZUZxMBUbCHsJaGjY3RD9OgMoxjdyc0KfTJR
	 OCaLaCbguCLPKHuQKk8c+YbaG6RKa9WBQ70YwMrVeQYfLnQXWygvf44o51vpMKusiP
	 YbFtg4Y4Ue8BQ==
Date: Mon, 29 Apr 2024 08:59:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: add to the quick group
Message-ID: <20240429155954.GB360908@frogsfrogsfrogs>
References: <20240427075530.1236045-1-hch@lst.de>
 <20240427174953.nlw5gfi36syp5jnw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427174953.nlw5gfi36syp5jnw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Apr 28, 2024 at 01:49:53AM +0800, Zorro Lang wrote:
> On Sat, Apr 27, 2024 at 09:55:30AM +0200, Christoph Hellwig wrote:
> > generic/095 doesn't take more than 4 seconds on any of my test setups,
> 
> Yeah, it generally takes ~5 seconds. But there's a "LOAD_FACTOR", so

On what kind of storage hardware?  If it's that fast even on spinning
rust then I guess you could double the iodepth*/numjobs computations.

(What happens if numjobs exceeds the 9 defined in the fio config file?)

> before we add it into quick group, I'd like to ask
> do you think if it's worth increasing the default LOAD_FACTOR a bit to
> give it more stress, or move it to quick group directly?

I'd move it to the quick group.

--D

> > but is exercises code that handles buffered write iterations interrupted
> > by concurrent direct I/O that no other test in the quick group does.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/generic/095 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/095 b/tests/generic/095
> > index 80448200b..9d0446e98 100755
> > --- a/tests/generic/095
> > +++ b/tests/generic/095
> > @@ -7,7 +7,7 @@
> >  # Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the same files
> >  #
> >  . ./common/preamble
> > -_begin_fstest auto rw stress
> > +_begin_fstest auto quick rw stress
> >  
> >  # Import common functions.
> >  . ./common/filter
> > -- 
> > 2.39.2
> > 
> > 
> 
> 
