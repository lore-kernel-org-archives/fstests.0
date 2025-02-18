Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5326D5DC
	for <fstests@vger.kernel.org>; Tue, 18 Feb 2025 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900391; cv=none; b=f7Qy+2ViY3vTYzHlLcKqzH+DM0xbHmXn7TgAevWs/Iu+s/Y54fagJRyZEiEKS4VM3W4f8vIGu7HA3YJXlTgE9xiLqxouAtE3DoZUO3kcmI3tBkLkHlyd9HqyjkbtDKPXL4jzzuiV/czw6SLWZCAqtj1y5C79Msjt6kAzXQt8nU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900391; c=relaxed/simple;
	bh=1YLGRftFE1KDpikmwJi5IxzCNkUbPlETyh8uQCFrZeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIPlUftYzWUCEQXq0LIxA9ITVnWVaSitXuIIvREA8Uz7+WRu+JLnqNBfPcMmiBKxIyJq3/8O+L5GMY2YLWSFmEMTyK0c+eFYjGr1SZKSDEWqYQqAJtbYXvt2iuIx1JBkWrY9rZ6kkKIzNMGkKEjp3Efi2QAv356U7qQ4djNiIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQAO+s1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQAO+s1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E838C4CEE2;
	Tue, 18 Feb 2025 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900391;
	bh=1YLGRftFE1KDpikmwJi5IxzCNkUbPlETyh8uQCFrZeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQAO+s1b1ZGCM3kq++AmennxFFk46aoyTbP0KQQu6OQ7JzgitVjQW+zNN+3q1ahOZ
	 OsdUpkCi1Ya3mHyJtI7O4HkQq66kaJ1ToUL8xP9z9z7IjYx/NMsDn/NybhfBcZEY8w
	 +5EI8Q6XSo6S8gNqkkj6iuUXUWZ3mufHVUL/66ZBsL/n2WTcPV2/9TBTN+uMkwl6+N
	 RpFJV6XC9Zi4cVqNEIxdeKjSJUdIbli8MytumqJxjtHkMqoKL0zRiVYjOiTf1J3dbv
	 v+9YQQiOcJGaIEM8dU3nMEwOQwMoWPalvkZ6/lAXaf1oqnlOt/vJOgOhRsTdnuYi1V
	 I9q5dBr3dDrXg==
Date: Tue, 18 Feb 2025 09:39:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] generic: test zero-byte writes to new file
Message-ID: <20250218173950.GL21799@frogsfrogsfrogs>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <20250213195129.GZ21799@frogsfrogsfrogs>
 <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
 <f05f9875-1552-4d77-8403-7b191da24141@redhat.com>
 <20250214040220.GA21799@frogsfrogsfrogs>
 <65457d9b-c435-40eb-9531-6fd23c48ae75@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65457d9b-c435-40eb-9531-6fd23c48ae75@sandeen.net>

On Fri, Feb 14, 2025 at 08:36:25AM -0600, Eric Sandeen wrote:
> On 2/13/25 10:02 PM, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2025 at 09:17:28PM -0600, Eric Sandeen wrote:
> >> On 2/13/25 2:50 PM, Eric Sandeen wrote:
> >>> On 2/13/25 1:51 PM, Darrick J. Wong wrote:
> >>
> >> ...
> >>
> >>>>> +rm -f $TEST_DIR/testfile.$seq
> >>>>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
> >>>>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
> >>>>
> >>>> When does the file not get created?
> >>>
> >>> In some unknown error case? ;)
> >>> There's probably no reason for that test, though of course
> >>> it's still expected to pass.
> >>>
> >>> In the various discussions of the exfat bug scattered around
> >>> the internet people kept pointing out that "well, the file does
> >>> get created" so I probably had that on my mind.
> >>
> >> To put a finer point on it, because I can't tell for sure - are
> >> you asking me to take that test out?
> > 
> > Nah, I was just wondering if there was something about the buggy exfat
> > code that either prevented the file from being created, or if the bug
> > was that the empty file got deleted after the zero-byte pwrite and I
> > misunderstood what's going on.
> 
> Ah, I see. No, the observable problem was an -EFAULT on the write,
> and the file /does/ get created as expected. The test probably is
> extraneous to the original bug, because of course open(O_CREAT) and
> write(0) are two separate operations. I was just a bit over-eager
> when writing the test.

<nod> Would you mind resending, but with the rm removed?

--D

> Thanks,
> -Eric
> 
> > (IOWs I think this test is fine, but could the exfat maintainer
> > clarify?)
> > 
> > --D
> > 
> >> Thanks,
> >> -Eric
> >>
> >>
> > 
> 
> 
