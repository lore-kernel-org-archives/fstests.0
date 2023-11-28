Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5949D
	for <fstests@vger.kernel.org>; Tue, 28 Nov 2023 10:25:02 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF01219A5;
	Tue, 28 Nov 2023 18:25:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 113BB13763;
	Tue, 28 Nov 2023 18:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rMKxAH0wZmVyBwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Tue, 28 Nov 2023 18:25:01 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 76b3bab5;
	Tue, 28 Nov 2023 18:25:00 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/581: remove extra escape character from awk line
In-Reply-To: <20231128173734.GD1148@sol.localdomain> (Eric Biggers's message
	of "Tue, 28 Nov 2023 09:37:34 -0800")
References: <ZV40XOGNJdru13XE@suse.de> <20231122231648.GA1541@sol.localdomain>
	<ZV87sT0lz0QqupDO@camandro.org> <87plzurmib.fsf@suse.de>
	<20231128173734.GD1148@sol.localdomain>
Date: Tue, 28 Nov 2023 18:25:00 +0000
Message-ID: <87edg9spkz.fsf@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ++
X-Spam-Score: 2.73
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of lhenriques@suse.de) smtp.mailfrom=lhenriques@suse.de;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 5AF01219A5
X-Spamd-Result: default: False [2.73 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-0.98)[-0.984];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[4];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_HAM_SHORT(-0.08)[-0.375];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

Eric Biggers <ebiggers@kernel.org> writes:

> On Tue, Nov 28, 2023 at 02:16:44PM +0000, Luis Henriques wrote:
>> >
>> > Yeah, looking closer it makes sense.  Sorry for the noise.  I'm curren=
tly
>> > investigating a test failure (which I can't reproduce locally) where
>> > 'orig_key' unexpectedly is set to '1' and makes the test fail because =
it
>> > was supposed to be '0'.  That's when this caught my attention.  Anyway,
>> > I'll go look somewhere else.
>>=20
>> OK, I'm not 100% sure yet, but I've an idea about what's going on with
>> this test failure.
>>=20
>> I _think_ that even after the following is done in the test:
>>=20
>>     _user_do_rm_enckey $SCRATCH_MNT $keyid
>>     _scratch_cycle_mount
>>=20
>> the key garbage collector may not have finish running.  And then, when we
>> read '/proc/key-users', we can race against key_user_put(), which needs
>> key_user_lock, which is also grabbed while the proc file seq_operations
>> are run.
>>=20
>> Eric, does this make any sense?  There is a loop in the test to wait for
>> invalidated keys, but I believe it's not relevant anymore since commit
>> d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
>> fscrypt_master_key").  But I might be misunderstanding the code.
>
> Thanks for looking into this!  I had noticed this test is still flaky on =
arm64
> but haven't had a chance to look into it.  Yes, it's probably related to =
the key
> garbage collector again.  The test needs to wait for the fscrypt "user" k=
eys
> (key_type_fscrypt_user in the kernel) to be released from the quota.  I t=
hink
> that loop in the test does not have the intended effect because it waits =
for
> "invalidated" keys, but the fscrypt "user" keys (which are charged to the=
 quota)
> are never invalidated; they're just released normally.  There used to be =
another
> key (in the "keyrings" subsystem sense of the word "key") associated with=
 each
> fscrypt key, and that key was indeed invalidated, but that's no longer th=
e case.
>

Awesome, thanks for confirming this.  That loop probably made sense back
when keys were invalidated -- that behaviour was changed by the commit I
mentioned, I believe.  Anyway, it's probably better to keep it the loop
for testing old kernels, as it doesn't really hurt.

>=20
> Maybe there's a better way to wait for the key garbage collector to
> finish.
>
> Or the kernel could be changed to make releasing the key quota be synchro=
nous.
> Unfortunately the keyrings subsystem doesn't seem to work that way, and f=
scrypt
> is tying into the key quota from the keyrings subsystem, so it is subject=
 to its
> limitations.  But maybe there's a way to do it.

Hmm... yeah, that requires a closer look at that subsystem to see if
something can be done.  I'll try to find something there that would make
that test more reliable.

Cheers,
--=20
Lu=C3=ADs
