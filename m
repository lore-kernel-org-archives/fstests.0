Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8120DD9
	for <fstests@vger.kernel.org>; Thu,  4 Jan 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y6+jZ4pE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zAA5OIoF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y6+jZ4pE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zAA5OIoF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AA4E1F7FC;
	Thu,  4 Jan 2024 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704364757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuRGa8JYfVrC/3lKKOAX8swmHXfmoqOLcl9KOmlgdk4=;
	b=Y6+jZ4pEvFNsYJNVDjOmwBSRbfRmYQuwEmcGh17oc1ptsmbaPwnKsq7VdZZPHAUxQkPF8D
	eAGg0DYFujnESpG/QmApKhlnS/E42o2rai9chT9ZCCyycDHMyCqSnK+JQpv9St2MiKgK1Q
	j8xhZbvEu3u73+oBtE16F5ag+eOOnlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704364757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuRGa8JYfVrC/3lKKOAX8swmHXfmoqOLcl9KOmlgdk4=;
	b=zAA5OIoF+fQXrh4lEVFwIEKzm9geWdYvcdn7GNK3gOKpT0dXbPtjPAHuvlb9awlW6tCf0F
	ezkBx2wb7PYo5lAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704364757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuRGa8JYfVrC/3lKKOAX8swmHXfmoqOLcl9KOmlgdk4=;
	b=Y6+jZ4pEvFNsYJNVDjOmwBSRbfRmYQuwEmcGh17oc1ptsmbaPwnKsq7VdZZPHAUxQkPF8D
	eAGg0DYFujnESpG/QmApKhlnS/E42o2rai9chT9ZCCyycDHMyCqSnK+JQpv9St2MiKgK1Q
	j8xhZbvEu3u73+oBtE16F5ag+eOOnlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704364757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuRGa8JYfVrC/3lKKOAX8swmHXfmoqOLcl9KOmlgdk4=;
	b=zAA5OIoF+fQXrh4lEVFwIEKzm9geWdYvcdn7GNK3gOKpT0dXbPtjPAHuvlb9awlW6tCf0F
	ezkBx2wb7PYo5lAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46A9913C96;
	Thu,  4 Jan 2024 10:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1gNLOtKKlmVadQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 04 Jan 2024 10:39:14 +0000
Date: Thu, 4 Jan 2024 21:39:02 +1100
From: David Disseldorp <ddiss@suse.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Chung-Chiang Cheng <cccheng@synology.com>, fstests@vger.kernel.org,
 shepjeng@gmail.com, kernel@cccheng.net
Subject: Re: [PATCH] README: add a missing necessary package
Message-ID: <20240104213902.4e2a2386@echidna>
In-Reply-To: <20240104084108.m3ts24cee7nb7wom@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240104054236.1311678-1-cccheng@synology.com>
	<20240104084108.m3ts24cee7nb7wom@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[synology.com,vger.kernel.org,gmail.com,cccheng.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.18%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.40
X-Spam-Flag: NO

On Thu, 4 Jan 2024 16:41:08 +0800, Zorro Lang wrote:

> On Thu, Jan 04, 2024 at 01:42:36PM +0800, Chung-Chiang Cheng wrote:
> > src/dbtests.c requires 'gdbm-ndbm.h' or 'ndbm.h', both of which are
> > supplied by 'libgdbm-compat-dev' in the latest Ubuntu LTS. However,
> > this package is not a dependency of the currently listed packages.
> > Therefore, add it explicitly to the necessary packages list.
> > 
> > $ dpkg -L libgdbm-compat-dev
> > /.
> > /usr
> > /usr/include
> > /usr/include/dbm.h
> > /usr/include/gdbm-ndbm.h
> > /usr/include/ndbm.h
> > 
> > Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> > ---
> >  README | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/README b/README
> > index e0dabe96503a..c46690c4eabb 100644
> > --- a/README
> > +++ b/README
> > @@ -11,7 +11,8 @@ Ubuntu or Debian
> >     $ sudo apt-get install acl attr automake bc dbench dump e2fsprogs fio gawk \
> >          gcc git indent libacl1-dev libaio-dev libcap-dev libgdbm-dev libtool \
> >          libtool-bin liburing-dev libuuid1 lvm2 make psmisc python3 quota sed \
> > -        uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3
> > +        uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3 \
> > +        libgdbm-compat-dev  
> 
> Oh, We call it "gdbm-devel" in Fedora. Thanks for this updating for Debian!
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

While you're there, please feel free to collapse in:

--- a/README
+++ b/README
@@ -76,7 +76,8 @@ SUSE Linux Enterprise or openSUSE
 
    $ sudo zypper install acct automake bc dbench duperemove dump fio gcc git \
         indent libacl-devel libaio-devel libattr-devel libcap libcap-devel \
-        libtool liburing-devel libuuid-devel lvm2 make quota sqlite3 xfsprogs
+        libtool liburing-devel libuuid-devel lvm2 make quota sqlite3 xfsprogs \
+        gdbm-devel

Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks, David
