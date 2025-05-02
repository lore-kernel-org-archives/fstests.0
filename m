Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E18828
	for <fstests@vger.kernel.org>; Fri,  2 May 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746174733; cv=none; b=RVQL3R3X+tQjBlZ3pPfHQJfWTa89vDYZuxXAIZnpXDR+yupMJMCjiibNLTR912cTes1U8Ht44/jeF5OskkeRfhKwMLd1/TliR8rLaKn2bNEnkfaKoS0OszYqk2ZCUfhx50l6jLQMLkkCmXOTaoy71FNrrfd8GnRR4IZeOifoD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746174733; c=relaxed/simple;
	bh=FjTRoh4mDFIijGMor+U5vhOa/IpLTrCaYwc59FUnT88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLH9hH42qvgMV+xmRNzi6WKA0eZQUDG7eObnbz++iQ6NVgOKcppraDmD79iKv/jrRzTgS+Kgqcs62mKVY+7scX5abodZRD5imBJ2ZV0nopywd1jqRpkmBr0lFGfQtpCsV5gK09g3EPf7LAO3pAcio/wjcb/5rsTYa36s2OGghvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IbYBtjxJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hLrJL5m8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IbYBtjxJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hLrJL5m8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IbYBtjxJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hLrJL5m8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IbYBtjxJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hLrJL5m8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65A5A211E3;
	Fri,  2 May 2025 08:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746174728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghNeC+MG9IlvRYK0ofUl0CH49yiAXbaCcQhz5nsE1ds=;
	b=IbYBtjxJ06IE7vZsge5QDZy9JmI/fVCmcHPhXEt7LEBephLZGM4FY0xiLlbYLM66+EUJ8S
	wo3TYgTcAzj7hoQtTqFab7Zs3qwYRtauSHHrHN+XXzqpdOFUIB7NKjdOaWyyqFzNomOtfk
	R0RudGv3zVEZrIseWRwJz9DZCmQ9TzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746174728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghNeC+MG9IlvRYK0ofUl0CH49yiAXbaCcQhz5nsE1ds=;
	b=hLrJL5m89P4YbdRPOGpB8zehA930/FwyIMptNUR0b4ZGghqZZ2Lt0CTwHkjxrqZVMAUQ16
	0NJSF5JWj+YLcWCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IbYBtjxJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hLrJL5m8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746174728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghNeC+MG9IlvRYK0ofUl0CH49yiAXbaCcQhz5nsE1ds=;
	b=IbYBtjxJ06IE7vZsge5QDZy9JmI/fVCmcHPhXEt7LEBephLZGM4FY0xiLlbYLM66+EUJ8S
	wo3TYgTcAzj7hoQtTqFab7Zs3qwYRtauSHHrHN+XXzqpdOFUIB7NKjdOaWyyqFzNomOtfk
	R0RudGv3zVEZrIseWRwJz9DZCmQ9TzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746174728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghNeC+MG9IlvRYK0ofUl0CH49yiAXbaCcQhz5nsE1ds=;
	b=hLrJL5m89P4YbdRPOGpB8zehA930/FwyIMptNUR0b4ZGghqZZ2Lt0CTwHkjxrqZVMAUQ16
	0NJSF5JWj+YLcWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21F9A13687;
	Fri,  2 May 2025 08:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D4svMwWDFGg7SgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 02 May 2025 08:32:05 +0000
Date: Fri, 2 May 2025 18:31:56 +1000
From: David Disseldorp <ddiss@suse.de>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, Daeho Jeong
 <daehojeong@google.com>
Subject: Re: [PATCH] f2fs/013: test to check potential corruption on
 atomic_write file
Message-ID: <20250502182729.2f6ec951.ddiss@suse.de>
In-Reply-To: <20250430024731.2722027-1-chao@kernel.org>
References: <20250430024731.2722027-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 65A5A211E3
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Chao Yu,

On Wed, 30 Apr 2025 10:47:31 +0800, Chao Yu wrote:

> This is a regression testcase to check whether we will handle database
> inode dirty status correctly:
> 1. make sure disk quota is enabled
> 2. create a regular file, and write data into the file
> 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> 4. write transaction data to the file
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> 6. meanwhile loop call fsync in parallel
> Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
> file"), database file may become corrupted after atomic write while
> there is concurrent dirty inode flush in background.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/013     | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/013.out |  2 ++
>  2 files changed, 75 insertions(+)
>  create mode 100755 tests/f2fs/013
>  create mode 100644 tests/f2fs/013.out
> 
> diff --git a/tests/f2fs/013 b/tests/f2fs/013
> new file mode 100755
> index 00000000..3db8448c
> --- /dev/null
> +++ b/tests/f2fs/013
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/013
> +#
> +# This is a regression testcase to check whether we will handle database
> +# inode dirty status correctly:
> +# 1. make sure disk quota is enabled

Where is the check that disk quota is enabled?

> +# 2. create a regular file, and write data into the file
> +# 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> +# 4. write transaction data to the file
> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> +# 6. meanwhile loop call fsync in parallel
> +# Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
> +# file"), database file may become corrupted after atomic write while
> +# there is concurrent dirty inode flush in background.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	[ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
> +	wait
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_fixed_by_kernel_commit f098aeba04c9 \
> +	"f2fs: fix to avoid atomicity corruption of atomic file"
> +
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +# note that it relis on FAULT_TIMEOUT fault injection support in f2fs
> +_scratch_mount "-o fault_injection=1,fault_type=4194304" >> $seqres.full

This requires CONFIG_F2FS_FAULT_INJECTION=y, although now I see that
parse_options() just ignores them and the test still passes fine with
CONFIG_F2FS_FAULT_INJECTION unset. Does it make sense to run without
FAULT_TIMEOUT injection? It'd likely make sense to just _notrun if fault
injection is unavailable.

> +dbfile=$SCRATCH_MNT/file.db
> +
> +# initialize database file
> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $dbfile >> $seqres.full
> +
> +# sync filesystem to clear dirty inode
> +sync
> +
> +# start atomic_write on src.db database file and commit transaction
> +$F2FS_IO_PROG write 1 0 2 zero atomic_commit $dbfile >> $seqres.full &
> +atomic_write_pid=$!
> +
> +# call fsync to flush dirty inode of database file in parallel
> +for ((j=0;j<1000;j++)) do
> +	$F2FS_IO_PROG fsync $dbfile >> $seqres.full
> +done
> +
> +wait $atomic_write_pid
> +unset atomic_write_pid
> +
> +# flush dirty data and drop cache
> +sync
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +newsize=`stat $dbfile -c %s`
> +if [ "$newsize" != "8192" ]; then
> +	_fail "filesize is inconsistent:"$newsize
> +fi

nit: I think it'd be simpler to do:
  stat $dbfile -c %s
...and just put the 8192 in the golden output.

> +rm $dbfile
> +sync
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
> new file mode 100644
> index 00000000..3e66423b
> --- /dev/null
> +++ b/tests/f2fs/013.out
> @@ -0,0 +1,2 @@
> +QA output created by 013
> +Silence is golden

