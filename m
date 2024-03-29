Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0713FD75
	for <fstests@vger.kernel.org>; Fri, 29 Mar 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753740; cv=none; b=P+BB9VyphC9RHxDWICFGbd1j24o0jr3RwqhLf26OoYJHDR+LjGERT2j9E5gKICvly3/X1ox0yIHiXfQAIlwiEagrFHS/8QohnHKm1JM1S3HmEyR+JkwXMaKauuFFJRTpzVcA6BWGy++uvNxXlIu8ogBNKlNA2O6QBS8hkqa/sJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753740; c=relaxed/simple;
	bh=+SfaYb87LwmPudlwlBslVccmpg6/aPTRkc/7YLFcFWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owYotKuH6L9ToqwYktqIUhnqvlWWxOKLFvfrHgVCZUh/HfcyV8AXskb1AdViHgs9pgAOrisdcgTVIog+iDR9DSbZcjxT+dgUAttXsKaKlCLgaeb8M+tVutO/1CAEOWNqaF+/iEFzxu/gSUCEW+PrH19Xy7yUQ6UzsbaH4g7ZDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzCqW8Uc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzCqW8Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0725EC433F1;
	Fri, 29 Mar 2024 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711753740;
	bh=+SfaYb87LwmPudlwlBslVccmpg6/aPTRkc/7YLFcFWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzCqW8UcMRo321W376r98ZER+qoUb0SUaM8OPJvrGBTbpzRulwHzt5hVIPAifu6SF
	 dj4uZ7pA7QVjQUBxa66R8pRH0PCkoQGAIpT0SO3dWMBxb9DJwqxjNLezZOFLkWjd25
	 6fZEleDHWZjUuaCOZMjQOFDyQph9/rgagVvxus/7L4lP3TUS/Js4a1WiBf6UylHEye
	 V5KIAu2Fx6SVX/69MTvE0ps7K8uTCtMqG1M42EQlWMgGKDeHQ0HS48Nv4OqrK8vDax
	 PzuDMQ7o+jxOFwi+/yoWA2hnXC/dZ3/wHWvznBk/zpcbbpXWOc2VSVTcTDU4MkIpK8
	 FMnKItd0JjV/A==
Date: Fri, 29 Mar 2024 16:08:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
	fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/01{2,9}: remove invalid filesystem option 'journal'
Message-ID: <20240329230859.GF6379@frogsfrogsfrogs>
References: <20240328170620.334-1-luis.henriques@linux.dev>
 <20240329225020.GB1189142@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329225020.GB1189142@mit.edu>

On Fri, Mar 29, 2024 at 06:50:20PM -0400, Theodore Ts'o wrote:
> On Thu, Mar 28, 2024 at 05:06:20PM +0000, Luis Henriques (SUSE) wrote:
> > Creating an ext4 filesystem using '-O journal' will fail with:
> > 
> >     Invalid filesystem option set: journal
> > 
> > I didn't do any archaeological investigation to check if this option ever
> > existed, but the two tests using it will fail to create the scratch
> > filesystems.
> > 
> > Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> 
> The feature name has never been journal, but rather has_journal.  The
> reason why no once noticed is because the file system was created by
> the _require_attrs before the attempted _scratch_mkfs_ext4.  So when
> _scratch_mkfs_ext4 failed, it was a no-op that didn't actually do
> anything, and there was still a file system the default configuration
> for the test scenario.
> 
> What puzzles me is why there was an attempt to enable the journal
> feature in the first place.  As near as I can tell, the tests don't
> change what gets tested whether or not the journal is enabled.
> Darrick; you had added these tests were you were working on ext4's
> metadata checksum feature; do you remember your thinking at the time?

"Qwklgjwlqaetwqjetlweqqlgqgqtrrt", most likely.

> In any case, either better fix is to replace:
> 
> _scratch_mkfs_ext4 -O journal > /dev/null 2>&1
> 
> with:
> 
> _scratch_mkfs_ext4 -O has_journal >> $seqres.full 2>&1
> 
> Or:
> 
> _scratch_mkfs -O has_journal >> $seqres.full 2>&1
> 
> My preference would be latter, since I'm regularly testing with and
> without the journal, and I'd much rather run the test with whatever
> configuration I'm currently testing (e.g., ext4/4k, ext4/1k,
> ext4/nojournal, ext4/ext3conv, ext4/bigalloc, etc.)

I'm ok with either, though _scratch_mkfs -O has_journal is more
consistent with the way XFS fuzz tests do things.

Sorry about that. :/

--D

> 						- Ted
> 
> 
