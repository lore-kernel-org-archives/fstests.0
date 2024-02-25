Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FC16415
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880585; cv=none; b=MVLGjUkNefKL4gJbwKIgKdWnxtwDKvtDO/hOyBaNLfpfw7z+WxQQt5GmvXXBScGDiS9BydoKRekhbp6IKQ/dAqhaPG/MSqp3db4DsUkLTiknZR5ta93g7TO+Y2vV5KFfiMa6xzbKh493bfBasNWvj8jiA79wAzNTQUpvoU/vU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880585; c=relaxed/simple;
	bh=7y4WFcUZqhu2eoE6Mhi7ZtnR++wOlajGzudyraHHAYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKoP62DcdSdqztsE4Ptnpkc+tFs01fzq1irGVKFdraCJMHiRMJiqt49uuXvDIO/b1JrKsm9YFmmlhM5/nzK/oY6K7GeeIJh6/sXnSnBi2gDqutIs/F7OktoO8hD+NQ5BYTlHJdcJzhIJF7Zi/RrkEEQ7vgDWgX7REgdhfEQjI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuyRCAkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuyRCAkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ADEC433F1;
	Sun, 25 Feb 2024 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708880585;
	bh=7y4WFcUZqhu2eoE6Mhi7ZtnR++wOlajGzudyraHHAYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuyRCAkIrlaB505UFrIWjNoRI0ZfXFgi9254UlQvXaCLUqXusoaAGCWr3LBLm9D5V
	 B77nFgWWUWIEbCgdchD5S/hdpn75DYuVi2UvG6h41reqDqSf7gq4c6yfVm6XozjEO/
	 z2Dtrkf8z9Ncfz6bOi/fq0Nu+bGbd3LPtwu4mavbdbYm7ih16B4pr98y2C3wp1ePBq
	 vPx18xg5dWLHu5Vetz2GebJGUMqWqpIRxqpf1SL4TI72SKMGgik+r7CkWS5+iYlZXE
	 0eSfhaTl7SLlY6mHzMI5+0aZr3mqKHr/QTYlhP/MZBf5Lyrxu9nqbMRod5kq3GtbAd
	 lDJVvom8hkaEg==
Date: Sun, 25 Feb 2024 09:03:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>,
	fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240225170304.GO6188@frogsfrogsfrogs>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240225165128.GA1128@sol.localdomain>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225165128.GA1128@sol.localdomain>

On Sun, Feb 25, 2024 at 08:51:28AM -0800, Eric Biggers wrote:
> On Sun, Feb 25, 2024 at 11:16:16PM +0800, Zorro Lang wrote:
> > On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > > Hi,
> > > 
> > > reading [1] and how late it was found that effectively a "rm -rf /" can
> > > happen makes me worried about what I can expect from fstests after git
> > > pull. Many people contribute and the number for custom _cleanup()
> > > functions with unquoted 'rm' commands is just asking for more problems.
> > > 
> > > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > > 
> > > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > > unfortunately present everywhere in xfstests since the beginning.
> > > Rewriting all scripts would be quite a lot of work, could you at least
> > > provide safe versions of the cleanup helpers?
> > 
> > Hi David,
> > 
> > Thanks for taking care about it :)
> > 
> > > 
> > > For example:
> > > 
> > > _rm_tmp() {
> > >     rm -rf -- $tmp
> > 
> > It's "$tmp.*"
> > 
> > May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
> > "rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
> > of situation does the "--" hope to fix?
> > 
> > The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
> > in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.
> > 
> > I thought some ways to avoid that:
> > 1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
> > 2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
> > 3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
> > does "cd /".
> > 4) Think about bringing in someone "Static program analysis" tool about bash
> > script, but I don't know if there're someone good, feel free to give me
> > suggestions.
> 
> "--" prevents the following arguments from being interpreted as options if they
> begin with "-".  That's a good practice, but it doesn't help with ${FOO} being
> empty.  To cause the script to exit if ${FOO} is empty, it can be written as
> ${FOO:?}.  Alternatively, 'set -u' can be used.

I said that four days ago.  Did nobody receive that reply?

https://lore.kernel.org/fstests/20240225165128.GA1128@sol.localdomain/T/#m0efd851c5a1fb0dbe418f4aff818d20f4355638b

--D

> - Eric
> 
