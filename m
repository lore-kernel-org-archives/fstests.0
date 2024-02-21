Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949947D401
	for <fstests@vger.kernel.org>; Wed, 21 Feb 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524640; cv=none; b=dBTySondt6zEZJDth/t75zxQuv1jH04OpbqGYj8gXKDwOfSL0eJGaZOHWcvRdHoOdn5Nc32GP0lLMEQVp8Gr9Bb9fvbAaKSjwTMi7uINC68wZm/jvI91h+H32Ok+DWHIgt6S/BKwcIHvQkss0PNUAmR3uXoV9eOPflcmeTv9AKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524640; c=relaxed/simple;
	bh=Zz2jGkUJhyq7BD+ErNQZRXNUj2zxn27RRmEVk8rMbFY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IElINEMNJBEhge3AiTmt2JMSmSLG9KLhzD0TV2eTsylHy9CTe8243WYaXUIoelfOdU6BbfIEoEL0I3q+oOcRtADfK6ELGJqelYHMZ7CGNNgSr7ryhTOgH4+n2DLPVuCUsAd6lTqsfQ8/iIyVX9Uu+nAqLMg9IBbJxqxKumxC4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pBPmAol3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhmLR9GW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pBPmAol3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhmLR9GW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pBPmAol3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhmLR9GW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pBPmAol3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhmLR9GW"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4B52210E9;
	Wed, 21 Feb 2024 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708524636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mQ37BimbNDaBDqoIp4pL5Dn0btXGSiQ4te/cpoDWDgE=;
	b=pBPmAol3h3lQEi+Cd8WjezYLMgmD/awL6HQUrDed/vqes5ESN9V1MsvYVLXl1zJjiBHPFD
	E8cPB3sTAN+3T6NcpwR7jB3x2wb7Un0eVFLpo+0kObOzT4jymW/JBEVL9qoUXkaxiSsanK
	g4Jr6V8W8bFyLwwh2O9JnihYLinSr2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708524636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mQ37BimbNDaBDqoIp4pL5Dn0btXGSiQ4te/cpoDWDgE=;
	b=vhmLR9GWqrSgBkxREBhS999H+1BZitci4FFozBFIb828D2EzNSpn8JjgE6hroSESmPJtOO
	mKDlvx7ecvrG4uCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708524636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mQ37BimbNDaBDqoIp4pL5Dn0btXGSiQ4te/cpoDWDgE=;
	b=pBPmAol3h3lQEi+Cd8WjezYLMgmD/awL6HQUrDed/vqes5ESN9V1MsvYVLXl1zJjiBHPFD
	E8cPB3sTAN+3T6NcpwR7jB3x2wb7Un0eVFLpo+0kObOzT4jymW/JBEVL9qoUXkaxiSsanK
	g4Jr6V8W8bFyLwwh2O9JnihYLinSr2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708524636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mQ37BimbNDaBDqoIp4pL5Dn0btXGSiQ4te/cpoDWDgE=;
	b=vhmLR9GWqrSgBkxREBhS999H+1BZitci4FFozBFIb828D2EzNSpn8JjgE6hroSESmPJtOO
	mKDlvx7ecvrG4uCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A9C31139D1;
	Wed, 21 Feb 2024 14:10:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Xa3OKFwE1mVtRwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 21 Feb 2024 14:10:36 +0000
Date: Wed, 21 Feb 2024 15:09:51 +0100
From: David Sterba <dsterba@suse.cz>
To: fstests@vger.kernel.org, zlang@redhat.com
Subject: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch updated
 to v2024.02.04)
Message-ID: <20240221140951.GJ355@suse.cz>
Reply-To: dsterba@suse.cz
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.04 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.24)[72.91%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.04

Hi,

reading [1] and how late it was found that effectively a "rm -rf /" can
happen makes me worried about what I can expect from fstests after git
pull. Many people contribute and the number for custom _cleanup()
functions with unquoted 'rm' commands is just asking for more problems.

[1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

Unquoted arguments in shell scripts is IMO a big anti-pattern,
unfortunately present everywhere in xfstests since the beginning.
Rewriting all scripts would be quite a lot of work, could you at least
provide safe versions of the cleanup helpers?

For example:

_rm_tmp() {
    rm -rf -- $tmp
}

and used as

_cleanup() {
    _rm_tmp
}

or at least mandate the "--" separator and quoting arguments in new code
and gradually fix the existing code.

I can send patches at least for btrfs and generic as this affects me but
first I'd like to know that this will become standard coding style
requirement in fstests.
