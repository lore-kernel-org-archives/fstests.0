Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAF3A1B1
	for <fstests@vger.kernel.org>; Wed, 21 Feb 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532039; cv=none; b=pbPwFt+fYmvjiTsqnILrlX4M/hcn4LKPHOstPcHfMQfekEdVKIutc/+yY30TmubG70K/Oo0sMRVMfYUYO5jat2Z39n6WwN9LmfiVDIVRxs4GcK3IVOzLXiAeUI6fy4HwlzvbbBelXAFzDfVfdG4OI7j27FvPN0zpwfyP3gQfie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532039; c=relaxed/simple;
	bh=ih/PAJhl6BJA26bgXKADYMSYoemtUeM+EUN4QsjTHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=darcjXBBqbWN/B2uEo1FfXuL9Vb6CQpM5XMDd91q8tnlkwkwiMGZhZM4RUr+9RdirmOf6W6hlEFeipq6KgSDaLInviBL4M5N66BCWBs1FNHx3w+83tx0U0sEe9ArQHgQjBCcrPALCNbdtMg83os+YSb6KGU/7wFPjOTR/1IJj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdcvFSBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdcvFSBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8F0C433C7;
	Wed, 21 Feb 2024 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532038;
	bh=ih/PAJhl6BJA26bgXKADYMSYoemtUeM+EUN4QsjTHMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdcvFSBHCx3rJM8QTolUcubEOXour7flRxj/SKQlJoP+K31cvHmgd5WObuffjuOBU
	 KWTXp2g12Q4yhCzk4yV18DC5BjoSsvjliu7JhejMxF8hXLHWytlRFXefPwQkCgfRMl
	 yAN58NH2GcbttmZ+IuD4tXCIKif3AF1C4/OxZLireN2TiktNj0mqoTd+Db94OS4OqF
	 3DxtZ+uFyCJh0n8dR+5ijHFw9A+kB52nWQpqTRtlBh3sO1n6bO2JnsnsdZVtQe/4ah
	 MisYvfLd6HziZO6/pxha0hIpCjrFw9HZUERatIlXyIYuV1MMkaTB3DfdwbcLBffKS+
	 NtF1o7m1LW2HA==
Date: Wed, 21 Feb 2024 08:13:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240221161358.GM6188@frogsfrogsfrogs>
References: <20240221140951.GJ355@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140951.GJ355@suse.cz>

On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> Hi,
> 
> reading [1] and how late it was found that effectively a "rm -rf /" can
> happen makes me worried about what I can expect from fstests after git
> pull. Many people contribute and the number for custom _cleanup()
> functions with unquoted 'rm' commands is just asking for more problems.
> 
> [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> Unquoted arguments in shell scripts is IMO a big anti-pattern,

That wasn't even the problem there.  I temporarily forgot my shellfu and
did the equivalent of:

<never set FUBAR>

rm -rf "$FUBAR"*

The shell helpfully expands the never-set FUBAR to an empty string, then
globs the star to everything in the current directory.  rm has
safeguards to prevent you from "rm -rf /" but that offers no protection
from what happens above.

The argument was quoted "properly", but what I think you're really
asking for is "set -u":

#!/bin/bash -u

unset FUBAR
echo -- rm -f "$FUBAR"*

$ /tmp/a.sh
/tmp/a.sh: line 8: FUBAR: unbound variable

Unfortunately you can't just set that unconditionally for all of fstests
and call it a day because now you have to test every line of shellcode
to make sure nothing breaks on unset variables that would have been fine
otherwise.  That turns into a mess of:

test -n "$FUBAR" && rm -f "$FUBAR"*

Oh but then there's the other bad shell habit of setting variables to
the empty string -- sometimes you really want that empty string, other
times authors seem to have used that in place of unset.  We've gotten
away with that bit of bad hygiene for ages, likely due to -u being a
nondefault option.

> unfortunately present everywhere in xfstests since the beginning.
> Rewriting all scripts would be quite a lot of work, could you at least
> provide safe versions of the cleanup helpers?

I worried about this a long time ago, and tried running shellcheck on
the entire codebase.  Thousands of error messages about sloppy quoting
later I gave up.  Later I turned that into a patch in djwong-wtf that
runs it only on the files changed by the head commit.

It **didn't notice** the cleanup error!  So that wouldn't have saved me.

Long term we ought to rewrite fstests in any language that isn't as much
of a foot gun.  Or someone starts a project to set -e -u and deals with
the massive treewide change that's going to be.

> For example:
> 
> _rm_tmp() {
>     rm -rf -- $tmp

Um, isn't this /also/ an unquoted variable?

I guess one could make safe(r) wrappers so at least rm won't get mixed
up by dashes at the start of filenames:

_rm_files() {
	rm -f -- "$@"
}

_rm_dirtree() {
	rm -r -- "$@"
}

But then you do

moopath="foo bar"
_rm_files $moopath

and we've lost the battle yet again.

(On the plus side, that's four separate "f*king bash" invocations in one
email! :))

--D

> }
> 
> and used as
> 
> _cleanup() {
>     _rm_tmp
> }
> 
> or at least mandate the "--" separator and quoting arguments in new code
> and gradually fix the existing code.
> 
> I can send patches at least for btrfs and generic as this affects me but
> first I'd like to know that this will become standard coding style
> requirement in fstests.
> 
