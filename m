Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD128C5CB
	for <fstests@vger.kernel.org>; Thu, 25 Jun 2026 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413117; cv=none; b=X/gSNjKcB+Di7tYV7dbJExLu9iMcOktkZs79tI2AQc8UDleYqkteqGIZ0NOrUtImZYm29hRHYTcV1k9IRuX2wRVTVgBGLLEmRd5hPquWRswiSmz4tgdj17tViS4deRk9gQHOTNCkKp57IoBWxUrJpotYzxCg/heYI9Gdx3vieeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413117; c=relaxed/simple;
	bh=wYAWT98k6S+nZE40YhjaMpXOzLWdLlThiF1Fo8Nietg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaP5qcxbQq23sje/8WfZ9X/ihZQo+54hoz76azK0mAhmizzYOwisT5tznnyNyoLbQsykYciwdWQdjOqJKNjAQ07q9XojvxybzZtZbEemRU3AYRn8whap+BP7H7UZ2xpdaML9VuKXC4j1OXZZLxAS70Wza7zR6rk0PI1RHT9dQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCVX2TJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCVX2TJi"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B50DC1F000E9;
	Thu, 25 Jun 2026 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782413116;
	bh=V3GP5bgfFjJ/BOXY9Sh4Vq+cenhWON+j/yvnyRRISn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCVX2TJi9bngbyM0F4H2muUydJHoyfEs5+ig+FKFwiihhpFzkkXQ7T7nAk83uG5Fo
	 dvGGrOj4RKliTtT94vJEIUtYQocch+nRib4Ytt//9QUV0bKZ0RMXJOYzJTKDL4zUW6
	 Z0NJl1cSHJDKciSgepx0MuJKIdjFRErQwB8eWkuQkxPCJuIMeZmTfoZPRk46WqtGA1
	 wzcJk/fgpQJuOr+1Y3bD1Js/wyAIWe570PUd9/n/9hiGhtP74ikZmOWqsaVwv+gzYT
	 L3yAOJsohR7oi6ql1N4olYVPbYnWG7h1veHv999pNgxEqFoF7MoRson4rb/jTXCfr8
	 UbY+zOLxiaJmg==
Date: Thu, 25 Jun 2026 11:45:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: David Timber <dxdt@dev.snart.me>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic/740: set env for mkfs.exfat
Message-ID: <20260625184516.GQ6070@frogsfrogsfrogs>
References: <20260618192236.654082-1-dxdt@dev.snart.me>
 <20260619045306.GA24829@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619045306.GA24829@lst.de>

On Fri, Jun 19, 2026 at 06:53:06AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 19, 2026 at 04:22:35AM +0900, David Timber wrote:
> > Foreign filesystem detection is added in exfatprogs version 1.4.1. To
> > maintain backward compatibility, mkfs.exfat refuses to format the device
> > only when it's run from terminal with a tty associated to it.
> > 
> > This is similar to how e2fsprogs work around the issue. However,
> > with exfatprogs, this behaviour can be overridden with the special
> > environment variable EXFAT_TTY_OVERRIDE to simulate shell invocation by
> > user.
> > 
> > Signed-off-by: David Timber <dxdt@dev.snart.me>
> > ---
> >  tests/generic/740 | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/740 b/tests/generic/740
> > index ce55200f..4f8bf099 100755
> > --- a/tests/generic/740
> > +++ b/tests/generic/740
> > @@ -28,6 +28,18 @@ _require_block_device "${SCRATCH_DEV}"
> >  # not all the FS support zoned block device
> >  _require_non_zoned_device "${SCRATCH_DEV}"
> >  
> > +mkfs_preop=""
> > +mkfs_preargs=""
> > +mkfs_postargs=""
> > +
> > +case "$FSTYP" in
> > +exfat)
> > +	# For backward compatibility, mkfs.exfat refuses to format only when run
> > +	# from a tty. This env var should override the behaviour if supported.
> > +	mkfs_preop="EXFAT_TTY_OVERRIDE=1"
> > +	;;
> > +esac
> > +
> >  echo "Silence is golden."
> >  for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
> >  do
> > @@ -83,7 +95,8 @@ do
> >  		# next, ensure we don't overwrite it
> >  
> >  		echo "=== Attempting $FSTYP overwrite of $fs..." >>$seqres.full
> > -		${MKFS_PROG} -t $FSTYP $SCRATCH_DEV >>$seqres.full 2>&1
> > +		eval $mkfs_preop ${MKFS_PROG} -t $FSTYP $mkfs_preargs $SCRATCH_DEV $mkfs_postargs \
> 
> breaking up the long line still would be nice here, i.e. keep at 80
> characters.  Else looks good.

I wonder why we don't just redirect stdin from /dev/null, it's not like
we want to capture user input anyway...

--D
