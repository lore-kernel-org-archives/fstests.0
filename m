Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BE33987
	for <fstests@vger.kernel.org>; Wed, 29 Jan 2025 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129202; cv=none; b=NZzPXgEkH/NMUqJFaqSf9NuzTSLn47YKpyNiNP5yCfaSHjq8Y+YQCNwayNM/wdEAW1v8XDxinYo3Fvn+737iDUvIDXj0Qnw7bk/GVpYgtpMQCxxOqdw1vYxXEFJlWjeRc7014N6F9aGBxQXR40zA1f5BnhHhZANm8I6JQakPgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129202; c=relaxed/simple;
	bh=LCurJ6cdzqw1ZqronoRJa1SaQaDSRMHdxMfb/oat6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApGbf4y8MEXmsDZ1lt1kBvjrbdGY+q51Ut+p/ZNdgbkwiTDWzgRyEwOkzF/P+jt4vBbERqz4M+yUiEcuzqyRPEf6Ko1CT3Bu1/pcfcWWdAbWMBNcIPjGEQzWoEaW8exh3sab3XaxlBpd/HqEpJQvXbEWFqgqRQ4B0nURvyul24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUj/4SQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUj/4SQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F88DC4CED3;
	Wed, 29 Jan 2025 05:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738129201;
	bh=LCurJ6cdzqw1ZqronoRJa1SaQaDSRMHdxMfb/oat6zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUj/4SQLorsOneM7U2x5a+fzJ8olW9oacR1jxWyzkEMs7LTqOZtDHOVs3SK0qklCo
	 dWs4s6r7TBcD0ZJxjgqUA+E+a01SCVqSVbNstiejYwufwMsg5nPSedqjI+JZZOsfCV
	 G9GfosD09GAoMRRPq+vBrFm5YQFEityK2p/0Yjc2zaqr6Lebfc/4xiANLPRGII6Ma+
	 AfZ8Vyt7M7tOvzIzsxzNXqvds22mFErJIpIffs9M3nk1hGPq4WE9KrBZEyw+XDKi+E
	 J0yhUvD6dKbhQUjw/ys3T4V/8i24V/+7AragzwU2i8dKg22LHtmT7Dxywwu+jwd4ts
	 umxysM1EIltcg==
Date: Tue, 28 Jan 2025 21:40:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: skip tests using LVM when the device is no known
Message-ID: <20250129054000.GW3557695@frogsfrogsfrogs>
References: <20250128071609.676581-1-hch@lst.de>
 <20250128193122.GU3557695@frogsfrogsfrogs>
 <20250129052443.GA28621@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129052443.GA28621@lst.de>

On Wed, Jan 29, 2025 at 06:24:43AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 28, 2025 at 11:31:22AM -0800, Darrick J. Wong wrote:
> > Should this get turned into a common helper?
> 
> > I guess the downside is that pvcreate on my system (Debian 12) will trip
> > over any existing disk label and ask if you want to wipe it.  If you say
> > no then it returns nonzero, and if you say yes then it goes into an
> > infinite loop.
> > 
> > You can of course $WIPEFS_PROG -a $bdev but ugghh.
> 
> Honestly, for now I just want to avoid the tests failing due to lvm
> stupidity.  If someone has the time to do something more elaborate
> (I don't right now), the proper thing is to stop using lvm and replace
> it with something less stupid.  That might be direct use of dm,
> or simulating failures with null_blk or scsi_debug.

Eh, I'm not that into a weird wipefs and pvcreate --test.  If someone
feels so motivated to test that on a bunch of distros they can do that
refactoring.  I already have too many patches stuck in djwong-dev.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D
