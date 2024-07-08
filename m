Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB2AD2C
	for <fstests@vger.kernel.org>; Mon,  8 Jul 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460065; cv=none; b=LxOcFi/j9Y44aUpYlH/4XELwFxyi2CbXcZwZciYIRbk6wbymoEfJZkz+PG3nTBksePmv8E4FUdhTb7OFb4rLRrvTJL8tueByxq4bw4rAIspWYPL8f7QivOpkynFyt9mg8mRMmOO0fcTvB/zwVFg4IxOMhgyBJpducdJoZ3W8hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460065; c=relaxed/simple;
	bh=fRT5iLffeqgAWLbJpcOgt/MD+jnix4/jQ+H2OkE4w1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYcOrLVkrUS2gE2RdoMqAh1ge4RteC5qWoLt2sEZhbnIg/0QXOcoRNqKN8LWi+LM9TKSDEUma5QIzgo0RMPiT5+ksWfyCKhXbNS7Ls4/aXM4zN4DSMPeFJN8eBWMe3RmoZXtETXaChJdhgZn9oJH8IkXRQj/PK5B6lhYxM4UlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxSKJDJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxSKJDJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F6EC116B1;
	Mon,  8 Jul 2024 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720460064;
	bh=fRT5iLffeqgAWLbJpcOgt/MD+jnix4/jQ+H2OkE4w1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxSKJDJG6Jkbppab8SuaMldC/23N0AhrnDum506sdG8L1M/n2Km6CMC9cRN639bYO
	 +mWd07yEz1EkIph+Qi2krE87nqoryATeZobspGM7Q1VM9BULPlp0VnTnCXgOAE8yUK
	 +FlkZ2iEqQQ6J4NCKzA1ZU4Y5GuY95bgUc3NAc1IAumKzG47+P8kLNA27+B12H4ed1
	 +lUxIPPKkJ3CcVHma4HOTaKblM2elGkUO9nBzrApT7qUu/Wfc//opzAoX3BAJA71V4
	 s/KmV5NtRoBKHwNFHCZ+J/wwLjrfSSBE6tPUnUWKpbKksEhFAr6ey70mnoeDzNU2mV
	 BvxbAxzSXWhig==
Date: Mon, 8 Jul 2024 10:34:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Cc: da.gomez@samsung.com, fstests@vger.kernel.org,
	Zorro Lang <zlang@redhat.com>, mcgrof@kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH v2 2/5] common/rc: add recreation support for tmpfs
Message-ID: <20240708173423.GM103020@frogsfrogsfrogs>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
 <20240630-common-fixes-v2-2-16d26fb1dee0@samsung.com>
 <20240701223628.GJ103020@frogsfrogsfrogs>
 <CABj0suCz-JDfPzUO7NUQXsxkE+9+TTiUAeXDb7oT_Y2eQRAdhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABj0suCz-JDfPzUO7NUQXsxkE+9+TTiUAeXDb7oT_Y2eQRAdhA@mail.gmail.com>

On Fri, Jul 05, 2024 at 11:46:53PM +0200, Daniel Gomez (Samsung) wrote:
> On Tue, Jul 2, 2024 at 12:36 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sun, Jun 30, 2024 at 11:52:41PM +0200, Daniel Gomez via B4 Relay wrote:
> > > From: Daniel Gomez <da.gomez@samsung.com>
> > >
> > > Add support for test device recreation (RECREATE_TEST_DEV=true) for
> > > tmpfs.
> > >
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  common/rc | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 163041fea..51827119c 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -604,6 +604,9 @@ _test_mkfs()
> > >      pvfs2)
> > >       # do nothing for pvfs2
> > >       ;;
> > > +     tmpfs)
> >
> > Indentation problem here.
> 
> What's actually the format for indentation in bash scripts across
> xfstests-dev project? I see a mix of tabs and spaces everywhere. For
> this particular _test_mkfs(), I see:
> <spaces>overlay)
> <tabs># do nothing for overlay
> <tabs>;;
> <spaces>pvfs2)
> <tabs># do nothing for pvfs2
> <tabs>;;
> <spaces>udf)
> <spaces><spaces>$MKFS_UDF_PROG ...
> <tabs>;;
> <spaces>btrfs)
> <spaces><spaces>$MKFS_BTRFS_PROG...

I don't think there's a set convention anywhere, I usually just copy the
thing above it.  I was reacting to the diff; if you actually just copied
the pvfs2 clause and then s/pvfs2/tmpfs/ then I withdraw the comment.

> > > +     # do nothing for tmpfs
> >
> > If we're recreating the test filesystem, shouldn't that unmount and
> > remount for tmpfs?  Or at least rm -rf everything underneath it?  That's
> > generally the effect of _test_mkfs for disk filesystems.
> 
> I thought this was already supported. When I enable recreation, I get
> the following error:
> 
> ./check -s tmpfs_huge_always -R xunit generic/003
> SECTION       -- tmpfs_huge_always
> RECREATING    -- tmpfs on /media/test
> our local _test_mkfs routine ...
> mkfs: failed to execute mkfs.tmpfs: No such file or directory
> check: failed to mkfs $TEST_DEV using specified options
> Interrupted!
> Interrupted!
> Passed all 0 tests
> Xunit report: /result.xml
> SECTION       -- tmpfs_huge_always
> =========================
> Passed all 0 tests
> 
> So, adding the tmpfs) case to _test_mkfs() just lets recreation go
> through, and mount and umount when the test is finished. I'm not sure
> if I'm missing something or maybe I should rename this patch as a fix?

Ah!  Yes, you're right, I forgot that there is no mkfs.tmpfs, everything
is done by mount -t tmpfs.  Can you change the comment to explain why
_test_mkfs does nothing for tmpfs?

    tmpfs)
	# mount initializes the fs, no need to format anything
	;;

for dunces like me? :)

> >
> > (That said, I'm much less familiar with non-disk filesystems...)
> 
> When umounting a tmpfs mount dir, data is lost. So in the recreation
> case, _test_unmount() would take care of that.

<nod>

--D

> >
> > --D
> >
> > > +     ;;
> > >      udf)
> > >          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> > >       ;;
> > >
> > > --
> > > 2.43.0
> > >
> > >
> > >
> 
