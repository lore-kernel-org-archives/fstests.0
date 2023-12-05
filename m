Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFB18D
	for <fstests@vger.kernel.org>; Tue,  5 Dec 2023 09:28:56 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC92222038;
	Tue,  5 Dec 2023 17:28:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB4661386E;
	Tue,  5 Dec 2023 17:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RKULJtZdb2X+EQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Tue, 05 Dec 2023 17:28:54 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 7b663b97;
	Tue, 5 Dec 2023 17:28:53 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/581: remove extra escape character from awk line
In-Reply-To: <87edg9spkz.fsf@suse.de> (Luis Henriques's message of "Tue, 28
	Nov 2023 18:25:00 +0000")
References: <ZV40XOGNJdru13XE@suse.de> <20231122231648.GA1541@sol.localdomain>
	<ZV87sT0lz0QqupDO@camandro.org> <87plzurmib.fsf@suse.de>
	<20231128173734.GD1148@sol.localdomain> <87edg9spkz.fsf@suse.de>
Date: Tue, 05 Dec 2023 17:28:53 +0000
Message-ID: <875y1c7e3u.fsf@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.21 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[4];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Level: 
X-Spam-Score: -3.21
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of lhenriques@suse.de) smtp.mailfrom=lhenriques@suse.de
X-Rspamd-Queue-Id: EC92222038

Luis Henriques <lhenriques@suse.de> writes:

> Eric Biggers <ebiggers@kernel.org> writes:
>
>> On Tue, Nov 28, 2023 at 02:16:44PM +0000, Luis Henriques wrote:
>>> >
>>> > Yeah, looking closer it makes sense.  Sorry for the noise.  I'm curre=
ntly
>>> > investigating a test failure (which I can't reproduce locally) where
>>> > 'orig_key' unexpectedly is set to '1' and makes the test fail because=
 it
>>> > was supposed to be '0'.  That's when this caught my attention.  Anywa=
y,
>>> > I'll go look somewhere else.
>>>=20
>>> OK, I'm not 100% sure yet, but I've an idea about what's going on with
>>> this test failure.
>>>=20
>>> I _think_ that even after the following is done in the test:
>>>=20
>>>     _user_do_rm_enckey $SCRATCH_MNT $keyid
>>>     _scratch_cycle_mount
>>>=20
>>> the key garbage collector may not have finish running.  And then, when =
we
>>> read '/proc/key-users', we can race against key_user_put(), which needs
>>> key_user_lock, which is also grabbed while the proc file seq_operations
>>> are run.
>>>=20
>>> Eric, does this make any sense?  There is a loop in the test to wait for
>>> invalidated keys, but I believe it's not relevant anymore since commit
>>> d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
>>> fscrypt_master_key").  But I might be misunderstanding the code.
>>
>> Thanks for looking into this!  I had noticed this test is still flaky on=
 arm64
>> but haven't had a chance to look into it.  Yes, it's probably related to=
 the key
>> garbage collector again.  The test needs to wait for the fscrypt "user" =
keys
>> (key_type_fscrypt_user in the kernel) to be released from the quota.  I =
think
>> that loop in the test does not have the intended effect because it waits=
 for
>> "invalidated" keys, but the fscrypt "user" keys (which are charged to th=
e quota)
>> are never invalidated; they're just released normally.  There used to be=
 another
>> key (in the "keyrings" subsystem sense of the word "key") associated wit=
h each
>> fscrypt key, and that key was indeed invalidated, but that's no longer t=
he case.
>>
>
> Awesome, thanks for confirming this.  That loop probably made sense back
> when keys were invalidated -- that behaviour was changed by the commit I
> mentioned, I believe.  Anyway, it's probably better to keep it the loop
> for testing old kernels, as it doesn't really hurt.
>
>>=20
>> Maybe there's a better way to wait for the key garbage collector to
>> finish.
>>
>> Or the kernel could be changed to make releasing the key quota be synchr=
onous.
>> Unfortunately the keyrings subsystem doesn't seem to work that way, and =
fscrypt
>> is tying into the key quota from the keyrings subsystem, so it is subjec=
t to its
>> limitations.  But maybe there's a way to do it.
>
> Hmm... yeah, that requires a closer look at that subsystem to see if
> something can be done.  I'll try to find something there that would make
> that test more reliable.

OK, I've finally spent some time looking at this and I see two options to
fix this.

- Option 1:

Add some logic to the test to try to close this race.  The loop that adds
keys and expects the last key to fail could be changed to update the keys
quota if the number of keys in '/proc/key-users' isn't the one it was
expected after adding a new one.  It's hacky and still racy, as the GC
could still run in between.  I've an attempt to implement this, which
_seems_ to be working, but I haven't spent too much time testing it,
because... it's ugly and option 2 looks better.

- Option 2:

Modify the '/proc/key-users' ->start() handler so that the first thing it
does is to call flush_work() and force the GC to run.  This doesn't
completely close the race window, but I think it makes things a bit more
reliable to userspace scripts/applications relying on the data.

Also, this flushing should probably be done for '/proc/keys' as well, but
the patch I've been hammering is doing it for '/proc/key-users' only.  So
far, it seems to do the job and I can't reproduce the test failure with it
applied.

Obviously, forcing GC to run will have a performance impact, but I'm also
not sure how bad that would be and how much userspace expects a read to
these procfs files to perform.

Anyway, just for reference, I'm attaching bellow the patch I've been
testing.  Let me know what you think about it.  I'm still running more
tests, but if the patch looks good to you I can send out a proper RFC.

Cheers,
--=20
Lu=C3=ADs

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 3c90807476eb..57b5a54490a0 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -44,6 +44,12 @@ struct key_type key_type_dead =3D {
 	.name =3D ".dead",
 };
=20
+void key_flush_gc(void)
+{
+	kenter("");
+	flush_work(&key_gc_work);
+}
+
 /*
  * Schedule a garbage collection run.
  * - time precision isn't particularly important
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 471cf36dedc0..fee1d0025d96 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -170,6 +170,7 @@ extern void keyring_restriction_gc(struct key *keyring,
 extern void key_schedule_gc(time64_t gc_at);
 extern void key_schedule_gc_links(void);
 extern void key_gc_keytype(struct key_type *ktype);
+extern void key_flush_gc(void);
=20
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
diff --git a/security/keys/proc.c b/security/keys/proc.c
index d0cde6685627..2837e00a240a 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -277,6 +277,7 @@ static void *proc_key_users_start(struct seq_file *p, l=
off_t *_pos)
 	struct rb_node *_p;
 	loff_t pos =3D *_pos;
=20
+	key_flush_gc();
 	spin_lock(&key_user_lock);
=20
 	_p =3D key_user_first(seq_user_ns(p), &key_user_tree);
