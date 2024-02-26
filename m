Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA11E866
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973781; cv=none; b=nC69n7XcETo9sA+tR/7kBZi+sQHIt9GFC/oj8+/3QLzSqr4KEuKWCUpT/VEjb+wfJ6wmDJ3+pmkpEwrUJAZ0G0EtA2jho/KuzkUHIKTQ7PN6ngX/v8wa8CbaVjwHEGPppU6KFQ75NM9xbaZ3GaRSQ9ETgiGJO8zyJEA5ElnooN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973781; c=relaxed/simple;
	bh=fmNVpGFuXTIUMyIURNdjfLA0zsyPVBhunX7oILEP3SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYfkio0Yk4UPWI8o/SkSKgFOmhABDdSK1yBlFpbnmagsVgCXuK0Z87Qc3F4aGdaH5oe/uJ7wl7FP3Fcn8H26yTkwVtU7qzQPrAToOU6O/dtBwfFRjdbY4DhRrwjSIiYl0Hv0SqlmxHQNRBQRklKhqWFe+HFcY0MT8zb8nPxC1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb19pvQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb19pvQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240F8C433C7;
	Mon, 26 Feb 2024 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708973781;
	bh=fmNVpGFuXTIUMyIURNdjfLA0zsyPVBhunX7oILEP3SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cb19pvQgBtiLgEfqfNxgS15BcWfHPRI2d5cJcTjjDr6yF4HsEKKKIF6OXdp9twWft
	 K2gDKyha/jJPNLb8OYozyd1dYrVHzK4Z9DYyUsNPFF7TaHPrcpbGV2oMkAPQxCgu29
	 2yNgOYMdwoQRw9UqOqA3Bv2e9R2L7boWNqH9toMNRlYRi2XyqhEGwgIb4fpasFJ4ki
	 +wAbMKzs0Y1DpSbAp7vUugivELBkf2gQmFxDkgWHmlBhE1jtQbbUip5NR/skvoJaFj
	 MZwLQRv1GxSM0P7Ct3EDIxnDa95yQ7wczcJOthvpnfVQ2ULc86sAMy5t6hvPbbrR5I
	 vE5j9/rOyFLyA==
Date: Mon, 26 Feb 2024 10:56:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>,
	fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240226185620.GS6188@frogsfrogsfrogs>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240225165128.GA1128@sol.localdomain>
 <20240225170304.GO6188@frogsfrogsfrogs>
 <20240225174527.GB1128@sol.localdomain>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225174527.GB1128@sol.localdomain>

On Sun, Feb 25, 2024 at 09:45:27AM -0800, Eric Biggers wrote:
> On Sun, Feb 25, 2024 at 09:03:04AM -0800, Darrick J. Wong wrote:
> > On Sun, Feb 25, 2024 at 08:51:28AM -0800, Eric Biggers wrote:
> > > On Sun, Feb 25, 2024 at 11:16:16PM +0800, Zorro Lang wrote:
> > > > On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > > > > Hi,
> > > > > 
> > > > > reading [1] and how late it was found that effectively a "rm -rf /" can
> > > > > happen makes me worried about what I can expect from fstests after git
> > > > > pull. Many people contribute and the number for custom _cleanup()
> > > > > functions with unquoted 'rm' commands is just asking for more problems.
> > > > > 
> > > > > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > > > > 
> > > > > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > > > > unfortunately present everywhere in xfstests since the beginning.
> > > > > Rewriting all scripts would be quite a lot of work, could you at least
> > > > > provide safe versions of the cleanup helpers?
> > > > 
> > > > Hi David,
> > > > 
> > > > Thanks for taking care about it :)
> > > > 
> > > > > 
> > > > > For example:
> > > > > 
> > > > > _rm_tmp() {
> > > > >     rm -rf -- $tmp
> > > > 
> > > > It's "$tmp.*"
> > > > 
> > > > May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
> > > > "rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
> > > > of situation does the "--" hope to fix?
> > > > 
> > > > The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
> > > > in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.
> > > > 
> > > > I thought some ways to avoid that:
> > > > 1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
> > > > 2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
> > > > 3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
> > > > does "cd /".
> > > > 4) Think about bringing in someone "Static program analysis" tool about bash
> > > > script, but I don't know if there're someone good, feel free to give me
> > > > suggestions.
> > > 
> > > "--" prevents the following arguments from being interpreted as options if they
> > > begin with "-".  That's a good practice, but it doesn't help with ${FOO} being
> > > empty.  To cause the script to exit if ${FOO} is empty, it can be written as
> > > ${FOO:?}.  Alternatively, 'set -u' can be used.
> > 
> > I said that four days ago.  Did nobody receive that reply?
> > 
> > https://lore.kernel.org/fstests/20240225165128.GA1128@sol.localdomain/T/#m0efd851c5a1fb0dbe418f4aff818d20f4355638b
> > 
> 
> You didn't mention the :? option, and I thought that would be worth mentioning.
> 
> Of course ideally -u would be used everywhere, as you said.

Yes, but why not reply to my reply instead of replying to the original
patch as if I'd never said anything at all?

The background on that -- I've been noticing the last couple of years
that every now and then I'll reply to something; then a day or two go
by; and then someone else will say the exact same thing I said.

However, they don't simply reply to my email with "Yes, what Darrick
said".  Often the reply literally reiterates what I said.  That makes me
feel invisible, which isn't great.  Then I do some digging and usually
find out that actually no, it's that Microsoft or Google or vger smtp
servers are either (a) broken or (b) their AI have decided that I am a
spammer or (c) maybe I actually /am/ in everyone's killfiles due to the
sheer volume of patches that I send to the lists.

Regardless, every time I see that I start worrying that email is broken
yet again.

That said, I'm not complaining about your specific behavior, Eric; I'm
putting out there that I don't trust our review process at all anymore.
<sadface>

--D

> - Eric
> 
