Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB622111
	for <fstests@vger.kernel.org>; Sun,  2 Feb 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738510027; cv=none; b=E6nB9Xuqooh/YbJx1MRqJc7GUgMHL11ZiSpmfVfTqAkBHo71bJ0hNjB8J/9SueNoe8cKb9frxA0DKCkhUOVPB2FRLX4DdWLTSisLzdG5tnd41w2drEO43UKcnglmBbz1Ax5GrU1KNvjTnxinpYzJiNvvF5QMACHIn5YqHnk3hoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738510027; c=relaxed/simple;
	bh=obeS34KniWi/wmRUTIL9apthidjUZMP/WLj9wi3uci8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bh6kYhhX7WnaQeC6WcNVNUd/44krzq1U2lHAiY7UqzRvgEtyAsg0mtUIPDQt6Na7eArHKqbd372vtBhW4+93/z5cVWFDWUpCDFaEJITgTYoZfjv8neqrt0tyjSi/rSXWAfSg+6D4O0TwEyoYfRt4qgM6YjYVHLV/frJzt3VFhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DExWEd4E; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DExWEd4E"
Received: from cwcc.thunk.org (pool-173-48-82-91.bstnma.fios.verizon.net [173.48.82.91])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 512FQTM7019900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Feb 2025 10:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738509995; bh=JUMulcP2dijOkUxApYb72vlPwMEgWNqNfp3FATtYrzU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DExWEd4E8PgJNcFxMyCg8JMJ2QqErG69nscSEJOq0qJHPYDdy2e/BT81EVZEpy3c5
	 zCXi5Ctbq/AulZ5P8i0moDau7YSUkHpTH2yJjeV3OrSSg6f40Htm3Si5rocLVZ0/XM
	 /eDGUrBYPo6BX0EID9k+nMfCRRcyRXRPgw2JGMN5ZWCfuDaPUyN39TqqJCfFvnUt34
	 0D+ocFMdqvWZbECA2bBJBuM8XUQksHGXoWJV0vWjLUmM6cwlRNnrovOX4mcGedf7dg
	 imxTovsB7awDDAdZjsXsgzFbKbIrhcwnj4x2ZSSCd2HrwfJfAeZzizai+U5/6Rpseq
	 I+HJ0krux1spw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EC98B15C013F; Sun, 02 Feb 2025 10:26:28 -0500 (EST)
Date: Sun, 2 Feb 2025 10:26:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Day, Timothy" <timday@amazon.com>,
        Andreas Dilger <adilger@ddn.com>,
        Christoph Hellwig <hch@infradead.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jsimmons@infradead.org" <jsimmons@infradead.org>,
        "neilb@suse.de" <neilb@suse.de>, fstests <fstests@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <20250202152045.GA12129@macsyma-2.local>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201135911.tglbjox4dx7htrco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, Feb 01, 2025 at 09:59:11PM +0800, Zorro Lang wrote:
> Thanks Amir, I think fstests has nothing to lose to support one more testing :)

Well, in the past I attempted to land a "local" file system type that
could be used for file systems that were available via docker (and so
there was no block device to mount and unmount).  This was useful for
testing gVisor[1] and could also be used for testing Windows Subsystem
for Linux v1.  As I recall, either Dave or Cristoph objected, even
though the diffstat was +73, -4 lines in common/rc.

[1] https://gvisor.dev/

So if it is really simple, it's also not hard to keep it in an
out-of-tree patch.  I've been maintaining [2] in my personal xfstests
branch, and kept it rebased on top of next, for years.  I figured it
was easier to keep it out of tree than to try to fight through Dave or
Cristoph's objects to get it upstream....

[2] https://github.com/tytso/xfstests/commit/7f8047273c8c963fdb9c3d441fe6d0f2a50cd4a3

So even if we can't get Lustre support upstream, I'm happy to maintain
it at my xfstests tree on github, much like I have with the "local"
file system type, for the past 8+ years.

Cheers,

						- Ted

