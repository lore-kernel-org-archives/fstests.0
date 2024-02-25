Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961117BB4
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879890; cv=none; b=MPH+9s/IOmTMznL9ML12kLgPNtPxGCjTyfY0qyrBq8aRcesAeUPtIhuBpnEQ6zVySEHGxbCSG0t38Up2amPnlyhFA8xCWLS0ADoj8Ev3dm3sfwoTLVrHx+szGO00K6Ai6MM2/VcvpGkIhO1q5PO8Rw25pCIDE1yyFcp4bsPr8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879890; c=relaxed/simple;
	bh=bKvF/hxZA+IOkRgFlAL5neUWGwYrfVAX96LrV2VLkLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEr2F5IskS9Rps2Yvh/SKto6d1P4zy3F5/uFWD4CjEkG4i9V2E7G8bE/KkBy+YrOWxjenhFIRDal1DiHvrFiXcqfcisTrMY+5tUGiAkmvHWTSm2N7z4p+L/0J7TlZpcctFEUBLDAKuSRsKAL3WdQNW/uGn58sxpqw45wpDQaJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBmWlBkP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBmWlBkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D93C433C7;
	Sun, 25 Feb 2024 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708879890;
	bh=bKvF/hxZA+IOkRgFlAL5neUWGwYrfVAX96LrV2VLkLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBmWlBkPnSs3oGuBtqaTXgP7mbaeTXZwI0MeHopYOa/A6ONZiwsRRRPhAinYeidc2
	 dzm9FdZkEMZd1Lyotih2vQbuQROqyHXgBKkqrW2ItomAR3mn8hGIK5Oe7MUUWMBBxN
	 PYdqfkYxInh7xAIaE0o71rXCaDPoHEdmDFGX6aoBHeIRaLhuCBdDm9RMa72uFvGTEP
	 +jDRUHkYNUdKRs4nKSGiXxoN1BfewT+lbpUWghKSVX3dgllPHnwDjN2uT3wkux3Ooi
	 zYeEijKPYOH7LmE1paHYDmjc6qbiVIWKEmQ1fToEbPoAM1UDc7W7pyFXmvIxGfXG9w
	 KH6OtWKGOoXAw==
Date: Sun, 25 Feb 2024 08:51:28 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240225165128.GA1128@sol.localdomain>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Feb 25, 2024 at 11:16:16PM +0800, Zorro Lang wrote:
> On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > Hi,
> > 
> > reading [1] and how late it was found that effectively a "rm -rf /" can
> > happen makes me worried about what I can expect from fstests after git
> > pull. Many people contribute and the number for custom _cleanup()
> > functions with unquoted 'rm' commands is just asking for more problems.
> > 
> > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > 
> > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > unfortunately present everywhere in xfstests since the beginning.
> > Rewriting all scripts would be quite a lot of work, could you at least
> > provide safe versions of the cleanup helpers?
> 
> Hi David,
> 
> Thanks for taking care about it :)
> 
> > 
> > For example:
> > 
> > _rm_tmp() {
> >     rm -rf -- $tmp
> 
> It's "$tmp.*"
> 
> May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
> "rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
> of situation does the "--" hope to fix?
> 
> The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
> in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.
> 
> I thought some ways to avoid that:
> 1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
> 2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
> 3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
> does "cd /".
> 4) Think about bringing in someone "Static program analysis" tool about bash
> script, but I don't know if there're someone good, feel free to give me
> suggestions.

"--" prevents the following arguments from being interpreted as options if they
begin with "-".  That's a good practice, but it doesn't help with ${FOO} being
empty.  To cause the script to exit if ${FOO} is empty, it can be written as
${FOO:?}.  Alternatively, 'set -u' can be used.

- Eric
