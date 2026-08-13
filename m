Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4F48665F
	for <fstests@vger.kernel.org>; Thu, 13 Aug 2026 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635028; cv=none; b=lolSz1LKLZdEAdplURrqHOt17fpsJUTef+B0jKU3NTXeIXUgUK6ERq/SWR8j5aQ+li6Vuc5WyHmAKwCXIx+9N7A1CSuf72FV03lgQWzY6WJlUP7d7/CquC0uB1wW5amc5UWcIvECsAKsUkj+xt6tHs/ZPJ7NnWcGY4jP0vmqu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635028; c=relaxed/simple;
	bh=1pC9eYGGaDxausC03j9A0R93yS9YlHsXl04pUru54ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEEFVdvpTM6ekDNJyGaBTZJlzCfU18PxqUvkNLQJNVRR+KuS3xR7yycw8c0caviZKDoJyxs6buyD4FDfRLi4nWBwMT61mwcA2vo+9eh3dVTX/mrpVfsw8VwCR79+PiBtHh9gLJhEBAXboTPAqjZDZ46r0FDPFWJ523lbaUrPWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqr5Zgsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqr5Zgsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14A21F000E9;
	Thu, 13 Aug 2026 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786635027;
	bh=f6xdeqNXQxF2s4oMMMAC8LyRMEAp0vaDp21ALMaW8KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kqr5ZgspReSr+arJWrNb44XuFx5pZwnBxjH9R3W1/D9W+pHz18t0xYKrAz8MEm0nV
	 3HPD2/odWNmOPrQAcJLusBUwehdcQuSM9Z5lLhq4CArPBZ/CCiiofz2FuzcHA+D2et
	 vC2M08K4Qt7GVhgfonk+lixhvYX3hYhyW1m1IvgaUz4QT6zXUmJG3YVZqLlXsxARrj
	 zM2hOrOBuvAsMyMqDdn9mRxkGWONJrYHMb/jWK0hHkWsLAmJFm4AoFmsVyyY4VFO/+
	 KaM/V9QJbmJFlKy/+o9cxxwyJ/Bu6sg93uLufm4BD+fatfde3v99kPMpJtOXKLCUTs
	 VAGd1BHIfHaSw==
Date: Thu, 13 Aug 2026 23:30:19 +0800
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 0/4] Rewrite the check argument parsing
Message-ID: <an3ir0ZLiV260AFu@zlang-mailbox>
Mail-Followup-To: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20260512132539.931482-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132539.931482-1-zlang@kernel.org>

Friendly ping ...

Any review points about this patchset :)

Thanks,
Zorro

On Tue, May 12, 2026 at 09:25:35PM +0800, Zorro Lang wrote:
> The patchset here were motivated by a previous RFC discussion regarding:
> https://lore.kernel.org/fstests/afzmt7SFA4jWhi6U@zlang-mailbox/T/#t
> 
> This patchset refactors the argument parsing logic in the 'check' script.
> The current positional parameter handling is becoming hard to maintain as
> we add more options.
> 
> I've replaced the manual parsing loop with *getopt* to provide a more
> standard CLI experience, and ensured the functionality remains identical
> to the previous implementation.
> 
> Besides that, I also tried to make below 3 changes:
> 1) Introduced --fs <fstyp> option, to replace all those filesystem-specific
>    options, e.g. -nfs, -overlay, -cifs and so on.
> 2) Updated all long-format options to strictly use the double-dash (--) prefix.
> 3) For backward compatibility, I tried to support legacy non-standard options
>    to ensure existing user workflows aren't broken. A deprecation warning is
>    now issued when these old options are used.
> 
> I hope this patchset can facilitate future additions and adjustments to
> arguments, making the code logic cleaner and more standardized.
> 
> Any concerns or review points, please feel free to tell me :)
> 
> Thanks,
> Zorro
> 
> Zorro Lang (4):
>   check: refactor argument parsing with getopt
>   check: update usage and README to reflect new argument parsing
>   check: consolidate argument handling into function
>   check: add deprecated options warning
> 
>  README         |  10 +-
>  README.overlay |  18 +-
>  check          | 435 ++++++++++++++++++++++++++++++++-----------------
>  common/config  |   8 +-
>  common/rc      |   2 +-
>  5 files changed, 303 insertions(+), 170 deletions(-)
> 
> -- 
> 2.54.0
> 
> 
