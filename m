Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52386345
	for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625927; cv=none; b=B5FWSuyUtAXRXHV6Wka/iq7nCkKZPrF3NiDIcnTLjRu+C3klWQ/PtW288MFHKI5YPIxX7oAYOWj12Dwi97A+Q7mNdpafvoAVDLCXWGI4FCePbVMj89ykBGjvC+rcMWn3Wk1mfLZk1zsDrnmlqZP1LzbeZ7zwHATpo8nZYfodNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625927; c=relaxed/simple;
	bh=eAOjxw9yQAZM4SFJ0+wn/J7V/NdtSZ2pr1uNJMx1wlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfSpRN4bheNYW9g/3eB8fv/CrmU2Q93uo7lFxJIq/RHsEi0bDmCfhb5gP4Zrg4Uz6HF8/jrTjR/IjqMmVs6To2vLPXk1ysoSoBP1kCMugwkDPBI0ha26u1lNkVaRoABioxcqtR20v7SewkDUCA96x+E1n7R+Xuqei9k0icXb4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkfu1Y1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkfu1Y1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269D8C4CECE;
	Thu, 19 Dec 2024 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734625927;
	bh=eAOjxw9yQAZM4SFJ0+wn/J7V/NdtSZ2pr1uNJMx1wlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkfu1Y1yLZG89juYigbuHETTYXTaU78qX2NiVp2JxvnnmBbKcaRIf8I55goyIN8NJ
	 QfM1S2tZUzm7Jkz3oqIwpMKtYAFAMvvhN8TqnTdjoOcrHGXxuqtbCQzuDGAI921AdL
	 zhvsNTJ5Z8wMlkvjMxPr2fLk0CBW4fsee86OTqMEnuuGpIlteL0ai+Zf096mQGOSYA
	 HzzVLO/VaG6z3xvk7z9NgBY/sSMG5vSL8zTK7CrXMVVEI+lMe09xS8zIwoMpUXTG+I
	 E/1kkDnvW+z5n+mb7uc91K2RWJjFt+5DPCi8yllyAULALe0qIupJOHS395pwS+Jc5W
	 YLdeNFUIkxsEA==
Date: Thu, 19 Dec 2024 08:32:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <20241219163206.GD6160@frogsfrogsfrogs>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area>
 <Z2OxMQACnMgmBR1a@infradead.org>
 <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Thu, Dec 19, 2024 at 06:16:26PM +0800, Zorro Lang wrote:
> On Wed, Dec 18, 2024 at 09:37:53PM -0800, Christoph Hellwig wrote:
> > On Thu, Dec 19, 2024 at 09:26:06AM +1100, Dave Chinner wrote:
> > > On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> > > > On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > > > > +if [ $FSTYP = "xfs" ]; then
> > > > > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > > > > +else
> > > > > +    _scratch_mkfs >> $seqres.full 2>&1
> > > > > +fi
> > > > 
> > > > We really need to document why generic tests have file system specific
> > > > hacks.  And yes, that's a request for Dave who originally added it
> > > > without any explanation and not Ted.
> > > 
> > > Creating and then unlinking 50000 files is journal space bound
> > > when using default 64MB logs on small test filesystems. Increasing
> > > the journal size to 256MB halved the runtime of this test.
> > 
> > Please explain this in thet test.  And you probably also want to
> > ensure that you don't force the log smaller than 256 either, otherwise
> > people in 10 or 20 years will wonder why this test forces logs to
> > be so small.
> 
> I'll help to add this comment when I merge this patch, if Dave hope to
> keep "-l size=256m" for xfs.

What happens if someone runs fstests with a 128M external log device?
Is this one of those cases where _scratch_mkfs notices the mkfs failure
and formats without MKFS_OPTIONS?  And if that's true, what about my
test configs that set MKFS_OPTIONS to test new non-default features?

--D

> Thanks,
> Zorro
> 
> > 
> 
> 
