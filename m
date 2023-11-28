Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964644412
	for <fstests@vger.kernel.org>; Tue, 28 Nov 2023 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9dEZfUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE7BC433C8;
	Tue, 28 Nov 2023 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701193056;
	bh=iqGIqWIZdwt8UzruQhVAgt2uzh4kn0OEgp8LzcPnA0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9dEZfUy61vIRNQRroqSYjEe1r7+M7rIhLIBYpl9Mifo95/bEGvsoXcOTxY9s8J14
	 xioNWCq6F+ivdlxpKLJQ7qtAtgMQ+dwHSgAg8b0UQUS+3hez9zjaXOicWjYUtw6kzE
	 0AXySqmXRBynrYmhVKvDi4lCL+7fpz4JfIvAWTL+rCuSo8rKi7qsIRoth0dvOX2tEf
	 oDPreJ5hsxoImcAx7c+InVOjm2Eezc4JvgamtzaHx2LYX2LtlAnWwu/K4mNri+fzB7
	 ICU3plNEeWYNnP0MSamWdHIfoFEhwk8l+loa3mGqTCK32hl/8T2iMlD/JVabp7E/q7
	 OQRE9Kd0LgjNQ==
Date: Tue, 28 Nov 2023 09:37:34 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/581: remove extra escape character from awk line
Message-ID: <20231128173734.GD1148@sol.localdomain>
References: <ZV40XOGNJdru13XE@suse.de>
 <20231122231648.GA1541@sol.localdomain>
 <ZV87sT0lz0QqupDO@camandro.org>
 <87plzurmib.fsf@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plzurmib.fsf@suse.de>

On Tue, Nov 28, 2023 at 02:16:44PM +0000, Luis Henriques wrote:
> >
> > Yeah, looking closer it makes sense.  Sorry for the noise.  I'm currently
> > investigating a test failure (which I can't reproduce locally) where
> > 'orig_key' unexpectedly is set to '1' and makes the test fail because it
> > was supposed to be '0'.  That's when this caught my attention.  Anyway,
> > I'll go look somewhere else.
> 
> OK, I'm not 100% sure yet, but I've an idea about what's going on with
> this test failure.
> 
> I _think_ that even after the following is done in the test:
> 
>     _user_do_rm_enckey $SCRATCH_MNT $keyid
>     _scratch_cycle_mount
> 
> the key garbage collector may not have finish running.  And then, when we
> read '/proc/key-users', we can race against key_user_put(), which needs
> key_user_lock, which is also grabbed while the proc file seq_operations
> are run.
> 
> Eric, does this make any sense?  There is a loop in the test to wait for
> invalidated keys, but I believe it's not relevant anymore since commit
> d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
> fscrypt_master_key").  But I might be misunderstanding the code.

Thanks for looking into this!  I had noticed this test is still flaky on arm64
but haven't had a chance to look into it.  Yes, it's probably related to the key
garbage collector again.  The test needs to wait for the fscrypt "user" keys
(key_type_fscrypt_user in the kernel) to be released from the quota.  I think
that loop in the test does not have the intended effect because it waits for
"invalidated" keys, but the fscrypt "user" keys (which are charged to the quota)
are never invalidated; they're just released normally.  There used to be another
key (in the "keyrings" subsystem sense of the word "key") associated with each
fscrypt key, and that key was indeed invalidated, but that's no longer the case.

Maybe there's a better way to wait for the key garbage collector to finish.

Or the kernel could be changed to make releasing the key quota be synchronous.
Unfortunately the keyrings subsystem doesn't seem to work that way, and fscrypt
is tying into the key quota from the keyrings subsystem, so it is subject to its
limitations.  But maybe there's a way to do it.

- Eric
