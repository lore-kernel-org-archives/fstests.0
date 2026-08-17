Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D93B585F
	for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951267; cv=none; b=ULOSm6Yn7CzWSiigHKyF2KF6UrwfTog50PGZ1XgcDKOafQzbXqLCAbquqJ+IqNzQY4yeacrfCAhf9uvsgTPTz8yHzlFf7z7df1E3bSX9BlTQ0ivcdZMaJ9xe2lcgPPbLuCjbEjC8+tBuNx0W1tvnqDgPdU90qxnw0Xch4yq+aRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951267; c=relaxed/simple;
	bh=TkeTl/yoIad3EOjldOZ+eiJXdRea0PcevRlcUC5QXSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEx1CzONJca3vdF0WCkUisdr4fMlSo6I5t+78HCmTBmz4/qj+UHLbdbxpFGwFZWhsAKIkLa31hQ6PQdAGQv8wYATxkcrFX7kyNXOlrzRLVqQAul4azGOectOrCop7cZrVTLwliBdoZ3y4hnjoEB4BRaVE4y7DApBuhBVmQKTa7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKRoHgOI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKRoHgOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1911F000E9;
	Mon, 17 Aug 2026 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951266;
	bh=RBfWC6bfOU2edw+jsS88tmdhj9vMWPEUz34v0ZLQ8TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FKRoHgOIDz5S1waES5iinchr7BcNUMykQrmiVpuvbANI1ty/IsmOFPX6gm7/H/ds4
	 +UnltpxdcfbNvYitpNWYT/lVh2eslLa07usQ+8K2sPYi4qnwJLbpPlQhK5o32puDn2
	 GDO6b/aUKYEacapsO/0RXxX+byiB2sa23J5f29Y3xYpoeQCpLXp2itWmIk+z9NubyG
	 uvRwRYzpypYwfsVdudatPx8epff99BzZcUHZEgPaJ0R5lGhNjgd4m8T6C2hk4QTmTi
	 mO/U9VvW5eRhe4X6d6kdmORcgIGDuCOqo2e6AIDEnxUOhX5M1PQrgo+B+cTh10bhCX
	 U6TsV3QEf8j3Q==
Date: Mon, 17 Aug 2026 15:21:01 +0800
From: Zorro Lang <zlang@kernel.org>
To: Long An <lan@suse.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] common/rc: fix mount options quoting in _mount
Message-ID: <aoK2EaRYTDf4F994@zlang-mailbox>
Mail-Followup-To: Long An <lan@suse.com>, fstests@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>
References: <20260629155812.GW6070@frogsfrogsfrogs>
 <20260701061413.10531-1-lan@suse.com>
 <20260701163446.GC6517@frogsfrogsfrogs>
 <CAHLNDm3bTGowGmp46GMbpJz8_Eew+sGsH173D0PnnFKt=fWB_A@mail.gmail.com>
 <20260813192746.GZ7398@frogsfrogsfrogs>
 <CAHLNDm1ch4X4V6krcJiU8ciiXhd-6inX8zecAuVV+8CVtLwK=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLNDm1ch4X4V6krcJiU8ciiXhd-6inX8zecAuVV+8CVtLwK=A@mail.gmail.com>

On Fri, Aug 14, 2026 at 05:32:52PM +0800, Long An wrote:
> Hello Zorro,
> 
> Friendly ping on this patch.
> Any feedback would be appreciated.

This patch has been merged in fstests v2026.07.21, as:

  b2e97cf3 common/rc: fix mount options quoting in _mount

Thanks,
Zorro

> 
> Thanks,
> An
> 
> 
> On Fri, Aug 14, 2026 at 3:27 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Aug 14, 2026 at 12:32:43AM +0800, Long An wrote:
> > > Hi Darrick,
> > >
> > > Thank you for your comments last month. Just following up on this patch. Is
> > > there anything else needed from my side?
> >
> > Please talk to Zorro about that, he's the fstests maintainer.
> >
> > --D
> >
> > > Thanks,
> > > An
> > >
> > > On Thu, Jul 2, 2026 at 12:34 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > > On Wed, Jul 01, 2026 at 02:14:07PM +0800, lan@suse.com wrote:
> > > > > From: An Long <lan@suse.com>
> > > > >
> > > > > In commit 078f320 ("treewide: convert all $MOUNT_PROG to _mount"),
> > > > > direct calls to $MOUNT_PROG were converted to call the helper function
> > > > > _mount.
> > > > > However, the _mount helper was implemented using `$*` instead of `"$@"`.
> > > > > This unquoted argument expansion triggers word splitting on any arguments
> > > > > containing spaces (such as the overlay mount options containing spaces in
> > > > > tests `overlay/083` and `overlay/086`), causing the mount to fail with
> > > > > "mount: bad usage".
> > > > > Fix this regression by using `"$@"` in the _mount helper, which correctly
> > > > > preserves argument boundaries exactly as they were provided by the
> > > > caller.
> > > > >
> > > > > Signed-off-by: An Long <lan@suse.com>
> > > > > ---
> > > > > v2: Revert the error log to "$*"
> > > >
> > > > Very good!
> > > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > > >
> > > > --D
> > > >
> > > > >  common/rc | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/common/rc b/common/rc
> > > > > index 79189e7e..b9a07324 100644
> > > > > --- a/common/rc
> > > > > +++ b/common/rc
> > > > > @@ -296,7 +296,7 @@ _has_dmesg_since_option()
> > > > >
> > > > >  _mount()
> > > > >  {
> > > > > -     $MOUNT_PROG $*
> > > > > +     $MOUNT_PROG "$@"
> > > > >       ret=$?
> > > > >       if [ "$ret" -ne 0 ]; then
> > > > >               echo "\"$MOUNT_PROG $*\" failed at $(date)" >>
> > > > "$seqres.mountfail?"
> > > > > --
> > > > > 2.51.0
> > > > >
> > > > >
> > > >
