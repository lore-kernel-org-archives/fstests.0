Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266CBA36
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797581; cv=none; b=KIIYW7vpY2CKzAI2LBJEYNp836kDUIQTWqx1CQMZ6tfHA86IFnLRHTzwmUesRH0s/JvqfAigEPcGOW4MXTK+qJBejDpQ7nCWqkRcdSru78RZUZsddGOMfU6J9QvYyMAydqw646WWNtp63hS/OZj3f2O8dBCvgKZmPmys6aa3NNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797581; c=relaxed/simple;
	bh=tVA2JwCgzi5+V8BN2//pbRQTpfH1zU/bwghjAd+nJ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHSqbR56/xSdz3nRzGspks5yR1QU1BtJomqmtyp0rj8ZIMZQQD+sJSgzzMHbdFW4DgxJARRwyF+8wNUMxlEEKi1scn2mH7cvSZ36v4OKGTXvcjyLh8G2szK7ajJztTkLUkpcBJ1drPM9A3C+/Z59rXHnDOUjBs4Ixn00Ti9kKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+GR4QxQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+GR4QxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B27C4CEE4;
	Wed, 21 May 2025 03:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747797580;
	bh=tVA2JwCgzi5+V8BN2//pbRQTpfH1zU/bwghjAd+nJ+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+GR4QxQbyIIq6isac3ccllRAhAiBvUJtSzUIzFdK7rLyWSIHz05WR7o0QyU+LCw3
	 Gmx7MkTHzs1l9PbjvyKp5adeFfR9htddpXc2/N64KVO1NhSkKSdMaZUW0Y8DwTKkT+
	 GdLZW//2TMUYAp4XArsflyOs798Ou6OO+xHhWyE/VzzcwlCBNA7J5h80OrKx35vDDk
	 q4ONGdGLITWNQ2aAJ/grpMCkr3TL4YAhpCu+L2Gy32K7utGu4OMjb/Xo9QytajmVNi
	 k+IRBN6uCNOWWeI2/AiA5iuuVRFsImQzjOM9zRPkYeycEAxKFtiQucOahRJc9zWQcw
	 w6KywUm1tW71w==
Date: Tue, 20 May 2025 20:19:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: xfs/566 execution time
Message-ID: <20250521031940.GF9730@frogsfrogsfrogs>
References: <aCyM-p06c99rJ04g@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCyM-p06c99rJ04g@infradead.org>

On Tue, May 20, 2025 at 07:08:58AM -0700, Christoph Hellwig wrote:
> Hi Darrick,
> 
> we regularly see execution times of more than half a day for xfs/566
> on a 30ish TB SMR HDD.  Do you think there might be a useful way to
> scale down the load on rotational devices?

Hrmm.  Is that the only one that does that, or do the other scrub tests
take a while too?  If it's just that one, and setting SOAK_DURATION=2m
results in the test cutting off after 2min, then I'll craft some sort of
fix to constrain the runtime.

--D
