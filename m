Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90A64B
	for <fstests@vger.kernel.org>; Fri, 29 Mar 2024 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752784; cv=none; b=u9EDqfd6x21Clmajv2s4+qYCCRGlbwVka+/ZPw7wAlRY6KyJIR5RzQD5qeIHg5LaeQtypAeH8CZlyMyvGq/+qRcPbDHwO40xpxqUE9KUqeaKFDKDO2khQP4soIxQDSeVfgLYoiOZr0tUfYReD6/yr6u5ygquWFbwMuSGDTwyQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752784; c=relaxed/simple;
	bh=7DScxyScPxH7P2rF0VhezjEBkPVE8gSudAeU+8mWPpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+4bG51rK6HgKvdwBN2jO4iv0rlq8u4u7hXe+EE1UZFOrF0X3BLn9f15Y70qcWUnNGSYzuNaAz3EoXoxpic65PmIClWTg2irsomg3FA0PJSupOSZsUPMhB2Ykc8ft4hrX+kSWMNKUU9QknCaJRX2+ci9jixnufNn9Uz31IVYmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SRuUmuFX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SRuUmuFX"
Received: from cwcc.thunk.org (pool-173-48-114-139.bstnma.fios.verizon.net [173.48.114.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42TMoLPj017735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1711752622; bh=JCx4qLPboZbuw9eVEKxIRdcFBNO0oqdrKa9d4VC8N68=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SRuUmuFX17TMg4l1t/WOVtsxpsGdIy2abaxNe3WHpeVQE3HQZmjHcEVYtGPBZ5cve
	 iANRUR+WQ1xW5+byghKamO5fEpiqRg3/T7aNChJta6XT7//tJP8yvJtqEbo+VvGanp
	 Np1Mul5+TFYDuLQ2e66koPLzeGrTKFIlS4iv8WPWvJdLP7Q+wgal3DskJRYb+ePeS8
	 2I6Sq+LRzIv5fgXClOgDiVGclguJ1VBVCSvROrLjtiq+X8ngQkvigjjWpWAuEk/Hxv
	 XiB0ckKAKRNc/rBD6FVWiRWSIfLq0MQjHZhMLebW7SGPglwf5kN6OEMUm6KGQ6e5Ft
	 IdRbQk8etknYQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DD36B15C00DC; Fri, 29 Mar 2024 18:50:20 -0400 (EDT)
Date: Fri, 29 Mar 2024 18:50:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>, djwong@kernel.org
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/01{2,9}: remove invalid filesystem option 'journal'
Message-ID: <20240329225020.GB1189142@mit.edu>
References: <20240328170620.334-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328170620.334-1-luis.henriques@linux.dev>

On Thu, Mar 28, 2024 at 05:06:20PM +0000, Luis Henriques (SUSE) wrote:
> Creating an ext4 filesystem using '-O journal' will fail with:
> 
>     Invalid filesystem option set: journal
> 
> I didn't do any archaeological investigation to check if this option ever
> existed, but the two tests using it will fail to create the scratch
> filesystems.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

The feature name has never been journal, but rather has_journal.  The
reason why no once noticed is because the file system was created by
the _require_attrs before the attempted _scratch_mkfs_ext4.  So when
_scratch_mkfs_ext4 failed, it was a no-op that didn't actually do
anything, and there was still a file system the default configuration
for the test scenario.

What puzzles me is why there was an attempt to enable the journal
feature in the first place.  As near as I can tell, the tests don't
change what gets tested whether or not the journal is enabled.
Darrick; you had added these tests were you were working on ext4's
metadata checksum feature; do you remember your thinking at the time?

In any case, either better fix is to replace:

_scratch_mkfs_ext4 -O journal > /dev/null 2>&1

with:

_scratch_mkfs_ext4 -O has_journal >> $seqres.full 2>&1

Or:

_scratch_mkfs -O has_journal >> $seqres.full 2>&1

My preference would be latter, since I'm regularly testing with and
without the journal, and I'd much rather run the test with whatever
configuration I'm currently testing (e.g., ext4/4k, ext4/1k,
ext4/nojournal, ext4/ext3conv, ext4/bigalloc, etc.)

						- Ted

