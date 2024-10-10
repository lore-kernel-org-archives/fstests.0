Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19363192D8C
	for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542250; cv=none; b=upSkiemgzRmuDqD0qfsX6BQQTaUyw6iDLXrgJ2QDB81bPKvy7TgbfaeIbLsU21tmKa525YrKs1gJyDWEe4ceZoEdYxvpJoPBl6sGeONfTj0pXBPEZ+agYckqX54gNdtvtOciG6z4yvtiJXhWHZ59cnu3UV7JjxlA7sZNBjcmxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542250; c=relaxed/simple;
	bh=rqPJBoyXFLYd/D/qLwQexRjKtGYlDJc5YVHFHrI+oH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5do9YwEYhyFphg/l2RhN4tUOqb4MA4dBvyrqvBqLXtOUez8lpNlt4+E51C3o1Y60hWxEyhlm+YASi/QSrb3ArXUnL6xyaGJJoPMc0K9PXQkTOFnq/K9FHLU6TrmC9heky6o0pi1k1KqvNgYH7GSAvXC1nP6rkKNeBIKGFmUCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF0S6k3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF0S6k3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFA8C4CEC5;
	Thu, 10 Oct 2024 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728542249;
	bh=rqPJBoyXFLYd/D/qLwQexRjKtGYlDJc5YVHFHrI+oH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cF0S6k3cKNM4uUD0GuVXYxNEYtFUQd9pZwyew22LAezgMlwTwsY3XdKqD007TaW5z
	 O14tuxuQDVPLCP5SdJvNKjx5iK9zn3AkrEXJJtvcXD6ZAeCWTBkWxhokO9vl1iW7ET
	 /4F60hFPDgVn463TwJW/11wWII3nc8ElhQIq+5AP9edV9zmqL8o6ANnrn6voLyryPy
	 hFpj1L8/ONz25Yvh5zEE8VsuZwNaSPdosIphZfLeZmNHrduRskK8mdkodScLvIGQSF
	 jIBlICwUnP936X41BHG8PBy2XR3K/d6/5ir0AGOAQxdwFdzP04KzH0wbo9x1x6rDZX
	 Tq2svT8PIVpXw==
Date: Thu, 10 Oct 2024 14:37:25 +0800
From: Zorro Lang <zlang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/694: sync before sampling i_blocks
Message-ID: <20241010063725.vshm3dkg2grzajay@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241008071209.160188-1-hch@lst.de>
 <20241009144817.GL21840@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009144817.GL21840@frogsfrogsfrogs>

On Wed, Oct 09, 2024 at 07:48:17AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 08, 2024 at 09:12:09AM +0200, Christoph Hellwig wrote:
> > Without a sync there might still be temporary blocks in i_blocks like
> > indirect block reservations or additional blocks reserved for out of
> > place writes.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/generic/694 | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tests/generic/694 b/tests/generic/694
> > index 02253ef75..b6bc8a75f 100755
> > --- a/tests/generic/694
> > +++ b/tests/generic/694
> > @@ -37,6 +37,10 @@ if [ $? -ne 0 ]; then
> >  	echo "Could not create 4G test file"
> >  fi
> >  
> > +# make sure indirect block reservations and other temporary block reservations
> > +# are release before sampling i_blocks
> 
> Nit: '...are released before...'
> 
> > +sync
> 
> Should this be more targeted since we only care about junk_file's
> i_blocks, not flushing everything in the system. e.g.
> 
> sync $junk_file

I can help to do this change, if you don't have more review points besides that.

Thanks,
Zorro

> 
> --D
> 
> > +
> >  iblocks=`stat -c '%b' $junk_file`
> >  
> >  _test_cycle_mount
> > -- 
> > 2.45.2
> > 
> > 
> 
