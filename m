Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F610D0
	for <fstests@vger.kernel.org>; Thu, 30 Nov 2023 03:03:10 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B7BBC1FCEE;
	Thu, 30 Nov 2023 11:03:07 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AAFC138E5;
	Thu, 30 Nov 2023 11:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id D7dIH+traGVIPQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 30 Nov 2023 11:03:07 +0000
Date: Thu, 30 Nov 2023 12:02:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] Remove mongo test framework
Message-ID: <20231130110257.GA3217381@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231013070404.695418-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013070404.695418-1-pvorel@suse.cz>
X-Spamd-Bar: ++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of pvorel@suse.cz) smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [12.16 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 DMARC_NA(1.20)[suse.cz];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MID_RHS_NOT_FQDN(0.50)[];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_SPAM_LONG(3.48)[0.994];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[48.45%]
X-Spam-Score: 12.16
X-Rspamd-Queue-Id: B7BBC1FCEE

Hi,

> Nearly 20 years old code for testing reiserfs, ext2 and jfs has never
> been properly integrated into LTP properly (not in runtest file).

> The main motivation was probably to test reiserfs, which has been
> deprecated and no longer used in the production.

FYI merged.

Kind regards,
Petr

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,

> I'm not sure if algorithm in reiser_fract_tree.c or anything else from
> this very old testsuite would be useful for folks in fstests, I doubt,
> but just for sure Cc them.

> Kind regards,
> Petr
...
