Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6C2753EA
	for <fstests@vger.kernel.org>; Fri, 14 Feb 2025 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505742; cv=none; b=fVeAbV1VCjF/ulGDus4bwNpRbL/iTe7Y9t/nxqTiVlCe8S8Jw2DUJ5KYWtXCkXBJwkoyLISmd7jMzB/NyGbvf5fxdT3C99L0GGVpY08mOX0NQ/yczDknDpBb+f7TLOqXnNlVrdqD6rPyCyww4Q2W+k2rpDgUZAzq/cZeZCFUFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505742; c=relaxed/simple;
	bh=67qZwcEpGw6/LTsLRpYFv4EoYzvUdKGk4dHQiNOaYWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU6594w2PhN8bSYj5BMuyFAAcjAFy5BJGXMy1kWEhrpBWdksHTn1XUCbGufL4KdZNvgUOQjG9DWjkbHJTtv8hQkXSSFMJldl/OJFaBu0NcGkY3xhOPDmCRH10GtW78Y3Ywi8BoRgKsLhukVq54MWKfmmiM55bUIbTVxo7mJ7tD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhNN0gSx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhNN0gSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FD1C4CED1;
	Fri, 14 Feb 2025 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739505741;
	bh=67qZwcEpGw6/LTsLRpYFv4EoYzvUdKGk4dHQiNOaYWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhNN0gSxSkTJn95jjtTnVG7eXOV70QcxKQMHw+0cry69k56e5UBhqDiihxIM7Ecs6
	 OUdhoOyXAURJvlBIn4HRiQyFi3rjRa0OdlPpPRdKoEIgzwTPsw8Dwi5VbiREZP5P+Q
	 CuPvB9mfQJQLGl1RoOTDFaNr38pBKzFfqIDqtVH3Pa+5vDjK7ogqOc37YZ3VqrUecQ
	 8LcSh65TU2d4XLqF4nV6cVLTRTPV9ivsNzeq2I8SwNyN8dlYNu0MnY8Jn57RGM/w4b
	 h+PRMnTuPhhHTyrWHaU/aTBLCG86nGr1fd2qNVrWcs+7NiKIJHq9aWGZlz0G59Vp/9
	 ibXVBq9WYiCZg==
Date: Thu, 13 Feb 2025 20:02:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] generic: test zero-byte writes to new file
Message-ID: <20250214040220.GA21799@frogsfrogsfrogs>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <20250213195129.GZ21799@frogsfrogsfrogs>
 <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
 <f05f9875-1552-4d77-8403-7b191da24141@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05f9875-1552-4d77-8403-7b191da24141@redhat.com>

On Thu, Feb 13, 2025 at 09:17:28PM -0600, Eric Sandeen wrote:
> On 2/13/25 2:50 PM, Eric Sandeen wrote:
> > On 2/13/25 1:51 PM, Darrick J. Wong wrote:
> 
> ...
> 
> >>> +rm -f $TEST_DIR/testfile.$seq
> >>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
> >>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
> >>
> >> When does the file not get created?
> > 
> > In some unknown error case? ;)
> > There's probably no reason for that test, though of course
> > it's still expected to pass.
> > 
> > In the various discussions of the exfat bug scattered around
> > the internet people kept pointing out that "well, the file does
> > get created" so I probably had that on my mind.
> 
> To put a finer point on it, because I can't tell for sure - are
> you asking me to take that test out?

Nah, I was just wondering if there was something about the buggy exfat
code that either prevented the file from being created, or if the bug
was that the empty file got deleted after the zero-byte pwrite and I
misunderstood what's going on.

(IOWs I think this test is fine, but could the exfat maintainer
clarify?)

--D

> Thanks,
> -Eric
> 
> 
