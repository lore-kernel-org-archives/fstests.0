Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BB2F361B
	for <fstests@vger.kernel.org>; Thu, 13 Aug 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649268; cv=none; b=kWlCyEFaA+sPdhl187oncK90X9pG7MmP8/Cm/Vodd4SiAWpji8J1QujszpFM3jRPpHMJJW0XSKXNkpnmWLBzaostlL1O+mX/l3lc8VWrU1wMK6P3GNd0H1l7ThUWmzVcNj6iQOjQ4LmVfev0JKGTcbb03XJwTcqXxj6zMksgUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649268; c=relaxed/simple;
	bh=I35Kd41Yqy4wJhX/ElRyFNtIrK7OdNbvI+JSv/Xeofo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqKSlrzBXFztFpKRJKmidXLM606tpkjuNW61MC+GR+E9YfFxKlyQrhTbLunlcEIaTH6RO6mOOE6AIddXDdQB2aosamX1b0GlzW24EZ2l0P1Di1Ifinar9JFQchbfbB1sWKX+jf0/EeMrql9ZMfwOfJ2BvaIEBQtJN9tv6JvHYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mss1c7yg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mss1c7yg"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CCE421F000E9;
	Thu, 13 Aug 2026 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786649266;
	bh=oL3EyP8hrceTshh0H9tGGQFo8JUAn/lzIa1+jUk3g04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mss1c7ygWlx+yt+J8JtPgnApJUiwGrZn2jmmhkT/1yNnp7e7wDm45vsM8l7+h5Yxv
	 692mxiFjdM6kHDDa2ZltLGt2/W0v/ilugWURV9TwDULgAJyeNKokuZ2NJuN2lAlybh
	 9ufWup9188u0XAe7BYLT/yr4expDfi7P//hwYVGg5REHaTV/++zSRrXl6xOfCBfmZA
	 sHhEL3eI8kzCyA9NjNqcUgIPTdvbJCaic/fe8FYhwtacDK51vvoRPm3Mo9998ZABCM
	 f0t0bkidWCr2g+Nsr3eE8S9eILMshkgxE0zwIAFXBGfFmqdXhYWW216kEXZZu7HHcS
	 wO4ahlZpFRz8g==
Date: Thu, 13 Aug 2026 12:27:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Long An <lan@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: fix mount options quoting in _mount
Message-ID: <20260813192746.GZ7398@frogsfrogsfrogs>
References: <20260629155812.GW6070@frogsfrogsfrogs>
 <20260701061413.10531-1-lan@suse.com>
 <20260701163446.GC6517@frogsfrogsfrogs>
 <CAHLNDm3bTGowGmp46GMbpJz8_Eew+sGsH173D0PnnFKt=fWB_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLNDm3bTGowGmp46GMbpJz8_Eew+sGsH173D0PnnFKt=fWB_A@mail.gmail.com>

On Fri, Aug 14, 2026 at 12:32:43AM +0800, Long An wrote:
> Hi Darrick,
> 
> Thank you for your comments last month. Just following up on this patch. Is
> there anything else needed from my side?

Please talk to Zorro about that, he's the fstests maintainer.

--D

> Thanks,
> An
> 
> On Thu, Jul 2, 2026 at 12:34 AM Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > On Wed, Jul 01, 2026 at 02:14:07PM +0800, lan@suse.com wrote:
> > > From: An Long <lan@suse.com>
> > >
> > > In commit 078f320 ("treewide: convert all $MOUNT_PROG to _mount"),
> > > direct calls to $MOUNT_PROG were converted to call the helper function
> > > _mount.
> > > However, the _mount helper was implemented using `$*` instead of `"$@"`.
> > > This unquoted argument expansion triggers word splitting on any arguments
> > > containing spaces (such as the overlay mount options containing spaces in
> > > tests `overlay/083` and `overlay/086`), causing the mount to fail with
> > > "mount: bad usage".
> > > Fix this regression by using `"$@"` in the _mount helper, which correctly
> > > preserves argument boundaries exactly as they were provided by the
> > caller.
> > >
> > > Signed-off-by: An Long <lan@suse.com>
> > > ---
> > > v2: Revert the error log to "$*"
> >
> > Very good!
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > --D
> >
> > >  common/rc | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 79189e7e..b9a07324 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -296,7 +296,7 @@ _has_dmesg_since_option()
> > >
> > >  _mount()
> > >  {
> > > -     $MOUNT_PROG $*
> > > +     $MOUNT_PROG "$@"
> > >       ret=$?
> > >       if [ "$ret" -ne 0 ]; then
> > >               echo "\"$MOUNT_PROG $*\" failed at $(date)" >>
> > "$seqres.mountfail?"
> > > --
> > > 2.51.0
> > >
> > >
> >
