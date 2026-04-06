Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40858301717
	for <fstests@vger.kernel.org>; Mon,  6 Apr 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489949; cv=none; b=gkugrGsjBNVv7Np91p8xKewgKKqI5EItqIbgiuJkqMnrONFz59ILfRwqlDk3A5JBR86nZ3HauiQamkHnmmHsLsk0IpRqaToK2LkHfJ4rxw9aHRnz18R7ByeujYkONjItQ2lscJye0qAe605CxSMiL3gB3FuZ+B6sFpaKtRDBny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489949; c=relaxed/simple;
	bh=NlLzYnwgKQcS/rN5U/9FxbpDdv/VCU0VTPOzCO5jexI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3wnulbrRI1NNbB7hIJTYdO90rL6GO4WXTQgAJbvjW98kx8dy34jjml2sD38pMrog/vhmcaikVWZ9ne76KIvjEWg2xXCXrUqgU1pwq5AmAbHvaNSHBO0B9YQCewE7dC7R7VGN2iCek8bigsdUBijAh3H63aP23d6N+LyCQjB4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXdZxKvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXdZxKvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B68CC4CEF7;
	Mon,  6 Apr 2026 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489949;
	bh=NlLzYnwgKQcS/rN5U/9FxbpDdv/VCU0VTPOzCO5jexI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXdZxKvwxCj1FWbfRaxqKEPKA3QZZF3uRlIiAYYSeghV7W0wxpbxrSwAU/KJEd8nl
	 zxua9wFjgqKOpRU7cQ4uh4LV1O9d5Offk2RCAwYcBXOHPXf2LJJWpFwkGj+wGkX6/S
	 0qrfmequZ6aIu+m/lrt6elrneryyevVsoCopIkykrzWxo85mBO6vB8INknE9DEpXsQ
	 wYNyfwypCx+bVAYMpSQ0WwASleQjDfeteDOCs7hmoTlcKF//VsR3LMw4bWBOReuT5X
	 xxw0uh1OzNY+2i/IEd5BzqV1XmTK0k+kEGQYbKo38SjTniNrws+feqTnkALjQNLLO2
	 XrgytQMwy3IXg==
Date: Mon, 6 Apr 2026 08:39:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/4] generic/775: Fix an infinite loop due to variable
 name clash
Message-ID: <20260406153908.GM6212@frogsfrogsfrogs>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <d1a7045002ded5d9e68347ff0fec41a86ff3877e.1775039135.git.ojaswin@linux.ibm.com>
 <20260401143218.GI6212@frogsfrogsfrogs>
 <adJsjDpAxYGhyyrO@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adJsjDpAxYGhyyrO@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Sun, Apr 05, 2026 at 07:37:08PM +0530, Ojaswin Mujoo wrote:
> On Wed, Apr 01, 2026 at 07:32:18AM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 01, 2026 at 04:10:50PM +0530, Ojaswin Mujoo wrote:
> > > We use i as the iteration variable in the main test loop as well as some
> > > internal loops. Due to this clash, $i variable of main test loops was
> > > getting modified by the following loop in prep_mixed_mapping().
> > > 
> > > 	for ((i=0; i<num_blocks; i++)); do
> > > 
> > > If num_blocks is less than 10 (example ext4 with blocksize 4k and
> > > cluster size 8k) i would always be set as 3 and the main loop would
> > > never exit. Take the simplest approach of just renaming the variable.
> > > 
> > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/generic/775 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/775 b/tests/generic/775
> > > index 2a4287bb..19ae95e2 100755
> > > --- a/tests/generic/775
> > > +++ b/tests/generic/775
> > > @@ -41,7 +41,7 @@ prep_mixed_mapping() {
> > >  
> > >  	local operations=("W" "H" "U")
> > >  	local num_blocks=$((awu_max / blksz))
> > > -	for ((i=0; i<num_blocks; i++)); do
> > > +	for ((j=0; j<num_blocks; j++)); do
> > 
> > You're right that the single-letter variables are a really bad idea in
> > languages like bash/python/etc where functions can see variables in
> > caller's scope if they're not explicitly marked local.
> > 
> > But a) why not use "local i" to prevent that; and (b) if you're going
> > to rename it, why not "blkno"?
> 
> Hey Darrick thanks for the review.
> 
> Why not both a) and b) :).
> I probably shouldve done that in the first place. I'll fix in v2

Yeah, that works! :)

Thanks for making those fixes.

--D

> Thanks,
> ojaswin
> 
> > 
> > --D
> > 
> > >  		local index=$((RANDOM % ${#operations[@]}))
> > >  		local map="${operations[$index]}"
> > >  		local mapping="${mapping}${map}"
> > > -- 
> > > 2.53.0
> > > 
> > > 
> 
