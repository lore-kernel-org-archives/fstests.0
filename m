Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403412376E4
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111440; cv=none; b=ONHYZd4dtBnNfUP1/Cn2sjtC0G6R1fmI0qofakXbfXdTPEIvFeYPbOnhyD6AakjGmCjtG+NgLKwLQsEFYdEGoeYr/MBQksp/fgqwjwvvpQHkO9SEZ/UrfgiKcq2nbwa2FwGB0ucaGZFLnQJHIdwG2DxxcfaZZSSqcsnkTLNMmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111440; c=relaxed/simple;
	bh=qqsIRsI/bVTYUYajJ3oPrCmdnl17xOE4EEFIT2+v4tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSzQuVjm8hG8CqTsQY/4eYeQ/ki+FisOEoDyBsqjPuMPbLfTGcrInyyQhz1oelhFjZh0LZYg9WCwspamNmnhx6gZreR6xGlFN1le4+S4Lhx2klU+rAjqChTtTNM6AxbohqOXNtnDdPUHOTTuc0drUpbtPsmrf3aJI25IplM1Jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSuVA+b8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSuVA+b8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40F9C4CEE5;
	Tue,  4 Mar 2025 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741111439;
	bh=qqsIRsI/bVTYUYajJ3oPrCmdnl17xOE4EEFIT2+v4tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSuVA+b8Wq9GTqWLgjLYwbe0d1IAGrfBMyIK9qqh1JqyNRfDfpdG0Sj3m1AEyTudx
	 w7aotU+lS+Dr7X+hn8k9V7OyEGDpU/fG+QBIvMf6K/m1Rd8Fb0Nack0dLJmevIkSwM
	 +aMqIooR0r8+0ycZU37OBnGse1sjqk4MBc+Mqk/gHxefy/bR2a7gCKHKTiUwLNPPks
	 FGkDYp8SFmId9I4EfH2d5T+aFBttaEwwuvpIbp8Dn2h3MgNhdWq2DI8hrw/Ad1x8o4
	 IuIJTGZvlbotV/iReC+mK1S13hkL30rMlInevR6r0BsxdryGJW8Xy9lUj9hQiWcZNM
	 MQzU0zLcPft0Q==
Date: Tue, 4 Mar 2025 10:03:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] tools/run_privatens: check if it is mount point for
 --make-private
Message-ID: <20250304180359.GA2803740@frogsfrogsfrogs>
References: <20250303064209.602577-1-naohiro.aota@wdc.com>
 <20250303101047.qjugaez6c7ythpd6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <D86O11SKYP75.1NJE84UIKCEYD@wdc.com>
 <D873JHORR7IB.2VEFHOF3HQMMY@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D873JHORR7IB.2VEFHOF3HQMMY@wdc.com>

On Tue, Mar 04, 2025 at 01:38:48AM +0000, Naohiro Aota wrote:
> On Mon Mar 3, 2025 at 10:29 PM JST, Naohiro Aota wrote:
> > On Mon Mar 3, 2025 at 7:10 PM JST, Zorro Lang wrote:
> >> On Mon, Mar 03, 2025 at 03:42:09PM +0900, Naohiro Aota wrote:
> >>> While /tmp is mounted with tmpfs in the most setup, it still can be a non-mount
> >>> point. For example, I'm running the fstests in a container, which does not
> >>> mount /tmp inside the container.
> >>> 
> >>> Running any test case on such system results in having the following error
> >>> printed, which leads to all the test cases fail due to the output difference.
> >>> 
> >>>   mount: /tmp: not mount point or bad option.
> >>>          dmesg(1) may have more information after failed mount system call.
> >>> 
> >>> These lines are printed by the "mount --make-private" command. So, fix that by
> >>> using mountpoint command to check if the directory is a mount point or not.
> >>> 
> >>> Fixes: 247ab01fa227 ("check: run tests in a private pid/mount namespace")
> >>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> >>> ---
> >>>  tools/run_privatens | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>> 
> >>> diff --git a/tools/run_privatens b/tools/run_privatens
> >>> index df94974ab30c..c52e0128b8f9 100755
> >>> --- a/tools/run_privatens
> >>> +++ b/tools/run_privatens
> >>> @@ -8,7 +8,7 @@
> >>>  
> >>>  if [ -n "${FSTESTS_ISOL}" ]; then
> >>>  	for path in /proc /tmp; do
> >>> -		mount --make-private "$path"
> >>> +		mountpoint "$path" >/dev/null && mount --make-private "$path"
> >>
> >> Oh, if /tmp isn't a mountpoint on your system, don't you need to think about ...
> >>
> >>>  	done
> >>>  	mount -t proc proc /proc
> >>>  	mount -t tmpfs tmpfs /tmp
> >>         ^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >> ... this step? I think the first run_privatens process will remain a "mounted"
> >> /tmp on your system.
> >>
> >> And then later tests will use this tmpfs. That's nearly equal to "We always
> >> make sure there's a tmpfs mount on /tmp at the beginning of fstests running".
> >
> > That does not happen because we are already in a mount namespace created
> > by nsexec. The mounted "/tmp" is local to each test, and each test
> > showed the error above.
> >
> >>
> >> But if we don't run that "mount tmpfs" step, I think it's not what this script
> >> wants (to isolate the data in /tmp). Right?
> >
> > I guess we can do these instead?
> >
> > mount --make-private -t proc proc /proc
> > mount --make-private -t tmpfs tmpfs /tmp
> >
> > Actually, I'm not quite confindent that we really need "--make-private"
> > here. As we mount new instance of proc and tmpfs and we don't bind them,
> > I don't see much point making them private.
> 
> No, I was wrong. We still need to make them private, not to propagate
> "mount tmpfs" or "mount proc" to the outside. If not, we will see new
> instance of tmpfs mounted on /tmp in the PID 1 environment, which
> breaks several applications :(.
> 
> So, in the end, I think my patch did it correctly, no?

Yes.  The "mount --make-private" prohibits propagation of changes to
this mount outside of the mount namespace.  The "mount -t tmpfs tmpfs
/tmp" creates a new tmpfs that is not exposed to the outside world.

This should've been documented better, Zorro could you please add a few
comments on commit:

	if [ -n "${FSTESTS_ISOL}" ]; then
		# Don't allow changes to these mountpoints to propagate
		# outside of our mount namespace...
		for path in /proc /tmp; do
			mountpoint "$path" >/dev/null && \
				mount --make-private "$path"

		done

		# ...because here we create new mounts that are private
		# to this mount namespace that we don't want to escape.
		mount -t proc proc /proc
		mount -t tmpfs tmpfs /tmp
	fi

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> >
> >>
> >> Thanks,
> >> Zorro
> >>
> >>
> >>
> >>> -- 
> >>> 2.48.1
> >>> 
> >>> 
