Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2E12C815
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971492; cv=none; b=kHRlQsaQ8xCLNrs0a6HwbWdaJIs9+bDxrABymi4BVxm6QJwExAPzSo+hVsVXCFN4u9Mbilfq/pCHU0zfb+PlKdrPjOpZuJRHy40P4ZOjiG7ZUhi025in05C2BkHKi6uh0/nzuHHbfqcPrdGFsSO5qPAxUv+Anhongxl7RQOonN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971492; c=relaxed/simple;
	bh=81VgLstUKyJm5J4Zk72zdMYMZcABshDjRorkQzCFXLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS40UveZIHFnY7QrtfPyr/jg3S6fH9CJv4cj0vtb7P++qRjlLcOtalPbnOzTmOP7NghuVTQPaSnQxAAcjm0L6FVA3XxRFeGGA164stnEK9BX+mRgeK3hiCmYvcaa6IC9B1P4ysGZNsIMkf/gTgyezLK/s83q2U7Zxhz841ES7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGqk5JM+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGqk5JM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A70C433C7;
	Mon, 26 Feb 2024 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708971491;
	bh=81VgLstUKyJm5J4Zk72zdMYMZcABshDjRorkQzCFXLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGqk5JM+ee2pSrhsQ669MDxh1CChgKoJ0znq18Rz0JNFg6dRxFkxYbEEX3XUowiAN
	 bIOJ5zjpFQvq8ZvAan7JfQ2qp1iHNw46HK35+ff0GozRABqmY4zrggYKE0r3KiaDIV
	 cuYqJ8E1MJY+2qfiWwyhI0x+mSXn88LGRZmQe7hn8g1arfLjkcMQ6ji8xv3LpdpMXV
	 5RkCATogtbg5Cx1LWdJzko6uYjHG+wnBh+xGZ66HTF3CWRvYuYLVeKo7pXZEdqYAHf
	 dWoDJGRYPb/OV9cpRjj8x7fatnADFL9zRGzXDfiPwbWRWEcq+2h3t7YJMpsWG/WIFT
	 gV8xtjriIl+3Q==
Date: Mon, 26 Feb 2024 10:18:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, David Sterba <dsterba@suse.cz>,
	fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240226181810.GR6188@frogsfrogsfrogs>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240225165128.GA1128@sol.localdomain>
 <20240225170304.GO6188@frogsfrogsfrogs>
 <20240225174527.GB1128@sol.localdomain>
 <20240226025629.2a2dn6fksjywyqjz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226025629.2a2dn6fksjywyqjz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Feb 26, 2024 at 10:56:29AM +0800, Zorro Lang wrote:
> On Sun, Feb 25, 2024 at 09:45:27AM -0800, Eric Biggers wrote:
> > On Sun, Feb 25, 2024 at 09:03:04AM -0800, Darrick J. Wong wrote:
> > > On Sun, Feb 25, 2024 at 08:51:28AM -0800, Eric Biggers wrote:
> > > > On Sun, Feb 25, 2024 at 11:16:16PM +0800, Zorro Lang wrote:
> > > > > On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > reading [1] and how late it was found that effectively a "rm -rf /" can
> > > > > > happen makes me worried about what I can expect from fstests after git
> > > > > > pull. Many people contribute and the number for custom _cleanup()
> > > > > > functions with unquoted 'rm' commands is just asking for more problems.
> > > > > > 
> > > > > > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > > > > > 
> > > > > > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > > > > > unfortunately present everywhere in xfstests since the beginning.
> > > > > > Rewriting all scripts would be quite a lot of work, could you at least
> > > > > > provide safe versions of the cleanup helpers?
> > > > > 
> > > > > Hi David,
> > > > > 
> > > > > Thanks for taking care about it :)
> > > > > 
> > > > > > 
> > > > > > For example:
> > > > > > 
> > > > > > _rm_tmp() {
> > > > > >     rm -rf -- $tmp
> > > > > 
> > > > > It's "$tmp.*"
> > > > > 
> > > > > May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
> > > > > "rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
> > > > > of situation does the "--" hope to fix?
> > > > > 
> > > > > The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
> > > > > in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.
> > > > > 
> > > > > I thought some ways to avoid that:
> > > > > 1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
> > > > > 2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
> > > > > 3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
> > > > > does "cd /".
> > > > > 4) Think about bringing in someone "Static program analysis" tool about bash
> > > > > script, but I don't know if there're someone good, feel free to give me
> > > > > suggestions.
> > > > 
> > > > "--" prevents the following arguments from being interpreted as options if they
> > > > begin with "-".  That's a good practice, but it doesn't help with ${FOO} being
> 
> Thanks Eric, I know "--" can do that, just didn't understand how it helps the
> empty variable problem. So looks like it doesn't.
> 
> > > > empty.  To cause the script to exit if ${FOO} is empty, it can be written as
> > > > ${FOO:?}.  Alternatively, 'set -u' can be used.
> > > 
> > > I said that four days ago.  Did nobody receive that reply?
> > > 
> > > https://lore.kernel.org/fstests/20240225165128.GA1128@sol.localdomain/T/#m0efd851c5a1fb0dbe418f4aff818d20f4355638b
> > > 
> > 
> > You didn't mention the :? option, and I thought that would be worth mentioning.

I wasn't even aware that existed.  It seems like a good way to enable
erroring on unset variable on a case by case basis.  Though TBH I
suspect that setting -u and using ${FOO:-} for the cases where we're
actually ok with unset variables is better practice.

Too bad it's going to be a lot of work to do /that/.

> Actually:
> 
> [ -n "$FOO" ] && rm -rf ${FOO}*
> 
> or
> 
> rm -rf ${FOO:?}*
> 
> Both of them are good to me, depends on what's expected. The 1st one ignore empty $FOO and
> keep running, the 2nd one breaks case running if $FOO is empty.
> 
> But they all need the programer to realize that his variable might be dangerous if
> it's empty, and write as that. So it still depends on the programer or the reviewers
> to notice that.

<nod>

--D

> Thanks,
> Zorro
> 
> > 
> > Of course ideally -u would be used everywhere, as you said.
> > 
> > - Eric
> > 
> 
> 
