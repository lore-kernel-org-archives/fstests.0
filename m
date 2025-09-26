Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A0233D9C
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902957; cv=none; b=XgyOsx4KYJPQRfhO96XiXleDgEHEq1GJQhL07kibvJJ5bYquSCjrS0L/lrAyb+HC+5K82Y1ycvK2ZjVLCMucOdxo5okov0lDD7pi8OU1es60KLkp7N2vJgkHTKniaiohcDnYTn0Szr+aWJlmsjhyxYswKPAfOHtbUzyHsxBS2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902957; c=relaxed/simple;
	bh=sdZEV8lpdPNxfc2PvMtJTM1dMISgdor1ClebA7Oa9HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvm5kuy3bWoZW+orNk/pJ4isQoF4695hky0uocOjOTQM3PHbxAyjeDXCl9upIs+XhcC7PyAWvlpSLyrcUSPDS60M680WQ5XIctBy8XJhXfNcwjnVwi1/p3Xq4c9dGzAfmomymjjjpVPJOequb6eJfPeSEM/qApK6qM8c23wWsAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDPR/ExH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDPR/ExH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A736C4CEF7;
	Fri, 26 Sep 2025 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758902956;
	bh=sdZEV8lpdPNxfc2PvMtJTM1dMISgdor1ClebA7Oa9HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDPR/ExH33w5HXypWUfReRfTfuddzX60yT9ZeKODrAQ8rnB6Vl7R8XERztoUub9MN
	 GDLyeVo27ZB3cWMlJuU2vBuyAPuLrgkZhkHoSOjJo2wZobIqauC4+nKMN1RWc2VYFI
	 QxXqNwTBawG3T/Xg7CaUxiLKYz1HGCoUd82zta2Ip/FTTFQyHca4k/866Yp4VEsX01
	 EDl8AEue8eESmbHVC6nQqRBvc+J7cEPBAFH0Y6vBkvbu/ERoSrlTQzFu86yo/F0/K0
	 RKCTbDSZeDlpSLZSwTW2IIombxrJrZVYF5iqk4NKrqkLFPKgjKSnWMp8EeyYQVtrXg
	 IF+DOskOf4IkQ==
Date: Fri, 26 Sep 2025 09:09:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: destroy loop dev before fallback recreation
Message-ID: <20250926160915.GP8117@frogsfrogsfrogs>
References: <20250926121249.214798-1-bfoster@redhat.com>
 <20250926150844.7mp2soi2koanxyxe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926150844.7mp2soi2koanxyxe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Sep 26, 2025 at 11:08:44PM +0800, Zorro Lang wrote:
> On Fri, Sep 26, 2025 at 08:12:49AM -0400, Brian Foster wrote:
> > When running fstests on an s390x box I observed failure to unmount
> > filesystem errors due to stale loop devices being left around. This
> > root caused down to generic/361 leaving around an attached loop0
> > device. On further inspection, the test actually created two loop
> > devices (loop0 and loop1), and executed on and cleaned up the
> > latter.
> > 
> > The origin of the former appears to be that the initial losetup
> > command in _create_loop_device() fails due to $dio_args in this
> > environment, but still creates the loop device. For example:
> > 
> >  # losetup --direct-io=on -f --show /mnt/scratch/fs.img
> >  /dev/loop0
> >  losetup: /dev/loop0: set direct io failed: Invalid argument
> >  # losetup -a
> >  /dev/loop0: [64771]:131 (/mnt/scratch/fs.img)
> > 
> > The helper then goes on to create loop1, but it or the test never
> > deals with loop0. To avoid this problem, detach any old loop device
> > if one was set up before the fallback losetup command.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> 
> 
> 
> > 
> > v2:
> > - Add comment to document wonky losetup behavior.
> > v1: https://lore.kernel.org/fstests/20250924181235.152502-1-bfoster@redhat.com/
> > 
> >  common/rc | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 81587dad..1ec84263 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4596,6 +4596,9 @@ _create_loop_device()
> >  	# size to the directio alignment of the underlying fs, so if we want to
> >  	# use our own sector size, we need to specify that at creation time.
> >  	if ! dev="$(losetup $dio_args $args -f --show $file 2>/dev/null)"; then
> > +		# losetup can return error for certain configuration settings
> > +		# but still create a loop device.
> > +		test -n "$dev" && losetup -d "$dev" > /dev/null 2>&1
> 
> I'm not sure if "-b" is better than "-n", anyway "-n" makes sense too.

I doubt it makes much difference, as long as nobody races us to delete
and recreate the same loopdev.

Thanks for adding the comments,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> >  		dev="$(losetup $args -f --show $file)" || \
> >  			_fail "Cannot assign $file to a loop device ($args)"
> >  	fi
> > -- 
> > 2.51.0
> > 
> > 
> 
