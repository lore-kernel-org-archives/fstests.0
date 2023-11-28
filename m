Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="egRXycHM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dNUGz5jY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9532B5
	for <fstests@vger.kernel.org>; Tue, 28 Nov 2023 06:16:48 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39C481F74B;
	Tue, 28 Nov 2023 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701181006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jl2YC6W6W3wySIER/o/p5C4JshzHeS/AZqPrlToeoA=;
	b=egRXycHMd0r3rOyF+sAQERUq4DUfyBWIs5QhWX3OS/y9NiLi8QevDZnP9dfrDNPPjxwHms
	j3apTLxonqMgmmbFFjekDCoJAizgia7e7Da5qWaSdnRTy3+zOk0L328wRH6qMgs0WGH61c
	XiaUa3v1mG+iMXjZhRVpYXvlvZVyUiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701181006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jl2YC6W6W3wySIER/o/p5C4JshzHeS/AZqPrlToeoA=;
	b=dNUGz5jY+XbUpmvEfDeqz+UhNZoUC9WK8ezKXCjBU6a1FkJaKf2ALOQPzWPn6HBNaPGHCa
	bAMEw3d9nPurwpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C26FB1343E;
	Tue, 28 Nov 2023 14:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ynMrKk32ZWUsOgAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Tue, 28 Nov 2023 14:16:45 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id d55bdbca;
	Tue, 28 Nov 2023 14:16:44 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/581: remove extra escape character from awk line
In-Reply-To: <ZV87sT0lz0QqupDO@camandro.org> (=?utf-8?Q?=22Lu=C3=ADs?=
 Henriques"'s message of
	"Thu, 23 Nov 2023 11:46:57 +0000")
References: <ZV40XOGNJdru13XE@suse.de> <20231122231648.GA1541@sol.localdomain>
	<ZV87sT0lz0QqupDO@camandro.org>
Date: Tue, 28 Nov 2023 14:16:44 +0000
Message-ID: <87plzurmib.fsf@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,camandro.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.30

Lu=C3=ADs Henriques <henrix@camandro.org> writes:

> (Sorry for replying from private email address)
>
> On Wed, Nov 22, 2023 at 03:16:48PM -0800, Eric Biggers wrote:
>> On Wed, Nov 22, 2023 at 05:03:24PM +0000, Luis Henriques wrote:
>> > Checking the keys in /proc/key-users is buggy, as there's an extra '\'
>> > character: in '{print \$4}' the '$4' shouldn't be escaped otherwise the
>> > 'awk' command will fail.  This has passed unnoticed because the output
>> > is sent to '_user_do' function and the result assigned to a variable.
>> >=20
>> > While there, replace 'awk' by $AWK_PROG.
>> >=20
>> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> > ---
>> >  tests/generic/581 | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > Hi!
>> >=20
>> > Please note that I'm not an 'awk' expert and I may be wrong!  But if I=
 do
>> > see an error if I run something like:
>> >=20
>> > $ awk '/^[[:space:]]*1000:/{print \$4}' /proc/key-users=20
>> > awk: cmd. line:1: /^[[:space:]]*1000:/{print \$4}
>> > awk: cmd. line:1:                            ^ backslash not last char=
acter on line
>> >=20
>> > But maybe this depends on the awk implementation, although I've tried =
a few.
>> >=20
>> > diff --git a/tests/generic/581 b/tests/generic/581
>> > index cabc7e1c69ab..1a4b571d40ce 100755
>> > --- a/tests/generic/581
>> > +++ b/tests/generic/581
>> > @@ -92,7 +92,7 @@ while grep -E -q '^[0-9a-f]+ [^ ]*i[^ ]*' /proc/keys=
; do
>> >  done
>> >=20=20
>> >  # Set the user key quota to the fsgqa user's current number of keys p=
lus 5.
>> > -orig_keys=3D$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4=
}' /proc/key-users | cut -d/ -f1")
>> > +orig_keys=3D$(_user_do "$AWK_PROG '/^[[:space:]]*$(id -u fsgqa):/{pri=
nt $4}' /proc/key-users | cut -d/ -f1")
>>=20
>> The backslash is needed to prevent $4 from being expanded by bash, becau=
se the
>> whole pipeline with 'awk' and 'cut' is in a double-quoted string:
>>=20
>>     "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | c=
ut -d/ -f1"
>>=20
>> Without escaping the $, bash would replace $4 with the empty string whil=
e it's
>> doing expansions on the whole double-quoted string.
>
> /me blushes
>
> Yeah, looking closer it makes sense.  Sorry for the noise.  I'm currently
> investigating a test failure (which I can't reproduce locally) where
> 'orig_key' unexpectedly is set to '1' and makes the test fail because it
> was supposed to be '0'.  That's when this caught my attention.  Anyway,
> I'll go look somewhere else.

OK, I'm not 100% sure yet, but I've an idea about what's going on with
this test failure.

I _think_ that even after the following is done in the test:

    _user_do_rm_enckey $SCRATCH_MNT $keyid
    _scratch_cycle_mount

the key garbage collector may not have finish running.  And then, when we
read '/proc/key-users', we can race against key_user_put(), which needs
key_user_lock, which is also grabbed while the proc file seq_operations
are run.

Eric, does this make any sense?  There is a loop in the test to wait for
invalidated keys, but I believe it's not relevant anymore since commit
d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
fscrypt_master_key").  But I might be misunderstanding the code.

Cheers,
--=20
Lu=C3=ADs
