Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1136AF5
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927046; cv=none; b=RdR0AmbtnDHR9nnzMlwQxwZHF/N5XSsDbcCPr+GB14T+wBMRgPCpuCOOz21d1+VyoWALQx0CpYYneI+t25OeaP6jQx5H9qbe/cxZGFce+wuG2zd301FSALYc09U0LwFqfWuBTetpvEY1xzUHH3OF6xuxzFvhDKpT+RfVD6F00ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927046; c=relaxed/simple;
	bh=/13JQnNsSxdhUHb9L+renjiNfuTIgGknWgit0Fp6a/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtSYKIYsv9/hpLKWeDX7tOj57Q/ptsDGebhR5/uEyv0qmqdKreVBJvwZp28ywK6Fv6m6hrcxo4aZwQ+XL7mmX6h3fs91caHsrUxKiX+XTYBt692f+PXL5a7vB5970+xROcTtQtW4Y7ZV6QmaClHLGsoY3h6sw0CncKG5rojHyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-92.bstnma.fios.verizon.net [173.48.112.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 522EoGb5028266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Mar 2025 09:50:17 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8FAEE2E010B; Sun, 02 Mar 2025 09:50:16 -0500 (EST)
Date: Sun, 2 Mar 2025 09:50:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250302145016.GA153209@mit.edu>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
 <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>

On Sun, Mar 02, 2025 at 01:13:43PM +0000, Filipe Manana wrote:
> Or another example, a fix from Ted, for a generic test case that
> always failed on ext4:
> 
> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=023070744cef1fde8a5b4fbd8fa134cd5098843e
>

Actually, this fixed a bug which affected file systems for all file
systems *except* xfs, since the generic bug was injecting an
XFS-specific mkfs option into _scratch_mkfs.  This was a *really*
obvious bug, but the problem was that commit 000813899afb ("fstests:
scale some tests for high CPU count sanity") made *huge* number of
changes, which made it hard to review the change, and also made it
harder for Dave to rebase the change, which is why, apparently,
pressure was applied to merge commit 000813899afb right before Dave
diappeared on vacation for a month.  This is why I nated that there
appeared to be a double standarrd in place; I can't help but suspect
that if anyone *else* had sent in this commit, it would have been
rejected.

As far as testing, my understanding is that the huge amount of testing
happens between the promotion from for-next to the master branch.
This is why I used to make a point of upgrading my test appliance to
for-next, so I could help point out problems before most other
deveopers would see it in the master branch.

The fixes that you pointed out was all reasons why the master branch
hadn't been updated in months; it was because for-next still had
breakages.  There is the challenge that when master hasn't gotten
updated for 2 or 3 months, it becomes harder to tell whether a test
failure was caused by a test bug, or a kernel bug.  (It's not
impossible; for a while I was going to older versions of for-next, and
the comparing the results to newer versions of for-next, and then
filtering out new tests, but it's a bit of a pain.)

Ultimately, like most engineering tradeoffs this was a pain allocation
exercise.  Dave didn't want to deal with rebasing changes, so the
check-parallel changes got merged to for-next early.  This inflicted
pain on other xfstests developers.

					- Ted
