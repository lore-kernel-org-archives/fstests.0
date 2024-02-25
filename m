Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B818E28
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883129; cv=none; b=af/CrPu1VkNivId1PFPEswI6hVQWuFVsVblfo0BVfFjXGWtK/qykeIK6AImmVfDriDT+Gce5J9Zz/x3tqbR1czYuXDjfNn6X4crBfLxPSBnnWj+BzwfTBdzfjs9Vmn71A3EN1zoAWemMTtgWG6yWO1gYZ7WneaXNeog0L0Q8Ruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883129; c=relaxed/simple;
	bh=Ms0klE4ndLxv3QiIViKozjiTmhbk1SAhfImWOo+8TGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5b56X6U+trxKZubODBZYUtErxNUWu1B6hfVsLRgqz8gLe/2LltdHsXiZHKYuYr8RXp97yUhYDZybCMZJz4GkBoX52+TvUfi3fPm9/aS1Dc0zDl0nFD9z/XytG8yocaNyba1UBIQdny6wfRjzcyhzpQcwRSIQ37c0xnTFZxIMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdgrS2A7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdgrS2A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD73C433F1;
	Sun, 25 Feb 2024 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708883128;
	bh=Ms0klE4ndLxv3QiIViKozjiTmhbk1SAhfImWOo+8TGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdgrS2A7T6+NKbvGDMU5VnDQ2mqCX7Gb9wNyQqYCY6XaI2C5kLoEUVfEbfH8pEHuU
	 YpABwnj6OXNllqyJ8WsbuN+uuvm6f6XRHZeqVO7ckI8YC774U2fWwnSb4tXZq/TXCh
	 bO78AcLxDJs6Af4V+LoKAlkScdFOfmpHVOPrs5DCEk1TxEvQIEWMdbcgDUqOJGDCjy
	 gvMa0HO09m+KZcPbRgoRzBhD49X1n8nRCo9jX4Xf12RzS+Cf9VJnhM+AftA6W2OU5S
	 uOEyT8j/lGm29pHmy6tsPfzQ2ZRXrMaVLM1WCUwmZ3dq50aVwSdIaZTjYGjly3q4ol
	 m+hxf3UAOpeVA==
Date: Sun, 25 Feb 2024 09:45:27 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>,
	fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240225174527.GB1128@sol.localdomain>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240225165128.GA1128@sol.localdomain>
 <20240225170304.GO6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225170304.GO6188@frogsfrogsfrogs>

On Sun, Feb 25, 2024 at 09:03:04AM -0800, Darrick J. Wong wrote:
> On Sun, Feb 25, 2024 at 08:51:28AM -0800, Eric Biggers wrote:
> > On Sun, Feb 25, 2024 at 11:16:16PM +0800, Zorro Lang wrote:
> > > On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > > > Hi,
> > > > 
> > > > reading [1] and how late it was found that effectively a "rm -rf /" can
> > > > happen makes me worried about what I can expect from fstests after git
> > > > pull. Many people contribute and the number for custom _cleanup()
> > > > functions with unquoted 'rm' commands is just asking for more problems.
> > > > 
> > > > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > > > 
> > > > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > > > unfortunately present everywhere in xfstests since the beginning.
> > > > Rewriting all scripts would be quite a lot of work, could you at least
> > > > provide safe versions of the cleanup helpers?
> > > 
> > > Hi David,
> > > 
> > > Thanks for taking care about it :)
> > > 
> > > > 
> > > > For example:
> > > > 
> > > > _rm_tmp() {
> > > >     rm -rf -- $tmp
> > > 
> > > It's "$tmp.*"
> > > 
> > > May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
> > > "rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
> > > of situation does the "--" hope to fix?
> > > 
> > > The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
> > > in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.
> > > 
> > > I thought some ways to avoid that:
> > > 1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
> > > 2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
> > > 3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
> > > does "cd /".
> > > 4) Think about bringing in someone "Static program analysis" tool about bash
> > > script, but I don't know if there're someone good, feel free to give me
> > > suggestions.
> > 
> > "--" prevents the following arguments from being interpreted as options if they
> > begin with "-".  That's a good practice, but it doesn't help with ${FOO} being
> > empty.  To cause the script to exit if ${FOO} is empty, it can be written as
> > ${FOO:?}.  Alternatively, 'set -u' can be used.
> 
> I said that four days ago.  Did nobody receive that reply?
> 
> https://lore.kernel.org/fstests/20240225165128.GA1128@sol.localdomain/T/#m0efd851c5a1fb0dbe418f4aff818d20f4355638b
> 

You didn't mention the :? option, and I thought that would be worth mentioning.

Of course ideally -u would be used everywhere, as you said.

- Eric
