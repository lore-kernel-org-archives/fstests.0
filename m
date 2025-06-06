Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1219005E
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174696; cv=none; b=oMQVmpvT7I2J4jAytM8hxkyzNic79yMbzyq9vjgu/pSE9Wd/dzAxOpKOVrShc+IahqjAB+Pc5XYgzhRHCAcC1X8TSJYFRaeMsE3y6d6V9U6HEdDyDeSMSSrxz/6a2le/c0r6LY9r1BsVnrWR1x8vPU/z3KPNt0Z6Y0wc000k9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174696; c=relaxed/simple;
	bh=snf1HFWgYGZrPfXrg+HYxpnOuNuUW5jRQO8YT6vm1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSkWAgtNT0507O7qybDjHPWzN9jjDX1kn4BxjZ0AadN7cQ0Y7pkkGwCOfb7ug5vKPcugJsr2bds24/wFq7480eNfibtt9LWKj7hxqMIG584+WewreM07eNlKdJ79u3tg9Mw3vFtcVBZp460XdyV7jU0vusRmPLAcvJYqt9G7GEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IavI1idI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IavI1idI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749174692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIZr15jOeprMr6PV5YuDUVJe7eTuCQJY3uMhNJ19IL4=;
	b=IavI1idI3kVe6rMGiA+4N909Chd8JwHmPhVxiWLqOQJ+8AsnDnVaLVav8dxQybESFlRU1v
	y5C2YzW+5e0Np/JDehMWEO1gLqz4KXUaIuWcFOgrn8qKo9yZMgzgRRZOszVQPwIDaZfAqz
	SzGC3zD78LURBJkbzfnFo6//kp1xWY4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-RXBxHLPFNAqS8gtlvf3ckA-1; Thu, 05 Jun 2025 21:51:31 -0400
X-MC-Unique: RXBxHLPFNAqS8gtlvf3ckA-1
X-Mimecast-MFC-AGG-ID: RXBxHLPFNAqS8gtlvf3ckA_1749174690
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2349498f00eso21818735ad.0
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 18:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749174690; x=1749779490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIZr15jOeprMr6PV5YuDUVJe7eTuCQJY3uMhNJ19IL4=;
        b=YK2NM3d9LwqbeU7C1UJIVaHUL04QfWueeE4T/h30ScYEdA2piLbOLD6+G/66vl+/ZL
         svtQ1zKp5fst2Z/0V3ldFCEcTB4f2xFyMLy/CCfMTXWpSkCqFjdTMvaiMCBUuLUD29zG
         5ptwQP0+JfiuQ011fa2WeN4mGespeCGAt1P/bbsL8q5zIggTrGSVROVUYwoZ1hsWNlQI
         81W1fZiD7vGPguifnKvBHxKe4VmnEkSaYHzSbIdXM5QRjoKBszUF/nExcP86aIUvi6O2
         +4LGJe7BgEF9Zg9MUmAihPchlkyccPukdiBDDSz8fmdmamAR+RHRuJHl7HpuZcz7ZZ3e
         vbPw==
X-Gm-Message-State: AOJu0YyEGudK/uLZK+Zq9nzQyR3b7aqwDT2JS93UelXbbNFLp2UfyiC7
	QNTE8gEWe9Oi4OwXRZlVu9Py2TrRHGL4iGXDWRzCaqAdLdRRrkFWiWF1wKOW37qyOR+PaeESjtv
	h3V9+StBp3itGXg3hlgzRw1lwGshj6nIU+8TTc3ksw7Cr5xKqEhfFaaGMBTs=
X-Gm-Gg: ASbGncs8RBhhkhdJ/woOfAHK0VF9wvBGiURnNv7uhMT+t5VwYfkpaFkMaz8HcHhh5eW
	Xx3A2EmFDwKmlVrTQYowNKx1zE1w3bLM94jhtgXQSAd38cRX1k5PJZuVUY7IgmPIj6blPAgCGg5
	R8E1QaRVGineU317EhaOGF8qBt/LV7aSGYWmz2eURCpRwsPf7JzSTWcFXqXY6AuGij143FlhuUa
	67qM3nlToJKbjXuf4xDh5VJyZfC8UPbtcqt97B//1vk39gnh/2ZT/sAfPvqno+gUmPOpgG24c/8
	0x3hKp+RV89QCC5W0xveKk+caDVw69r4Xz+8Cjzv1bIXSupU3rQr
X-Received: by 2002:a17:903:244c:b0:234:9fee:af95 with SMTP id d9443c01a7336-23601f3aa68mr21734345ad.0.1749174690227;
        Thu, 05 Jun 2025 18:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/SsAvxU6p010vJ7jiA1Y9evRRygCrtsKtSziCURXh3/ucio2u4ZXSfI46zVBA3+WjRhb/vQ==
X-Received: by 2002:a17:903:244c:b0:234:9fee:af95 with SMTP id d9443c01a7336-23601f3aa68mr21734045ad.0.1749174689798;
        Thu, 05 Jun 2025 18:51:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc747sm2385925ad.121.2025.06.05.18.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 18:51:29 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:51:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic/738: warn & lazy-umount if thaw hangs on buggy
 XFS
Message-ID: <20250606015125.4pxin67m4zxofmsi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250601070059.341669-1-me@linux.beauty>
 <20250605154947.bddkusxeryj2emzb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <87a56lpspx.wl-me@linux.beauty>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a56lpspx.wl-me@linux.beauty>

On Fri, Jun 06, 2025 at 09:24:42AM +0800, Li Chen wrote:
> Hi Zorro,
> 
> On Thu, 05 Jun 2025 23:49:47 +0800,
> Zorro Lang wrote:
> > 
> > On Sun, Jun 01, 2025 at 03:00:59PM +0800, Li Chen wrote:
> > > From: Li Chen <chenl311@chinatelecom.cn>
> > > 
> > > If `xfs_freeze -u` goes D-state (because of freeze-reclaim deadlock)
> > > the test never finishes and the harness stalls.
> > > Run thaw in background, wait 10 s, and when it’s still alive:
> > > 
> > >   * emit a warning plus the fixing commit
> > >       ab23a7768739  “xfs: per-cpu deferred inode inactivation queues”
> > >   * `umount -l` the scratch FS so the rest of xfstests can proceed
> > >   * skip any `wait` that would block on the hung tasks.
> > > 
> > > Fixed kernels behave as before; broken ones no longer wedge the run.
> > > 
> > > The hung task call trace would be as below:
> > > [   20.535519]       Not tainted 5.14.0-rc4+ #27
> > > [   20.537855] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [   20.539420] task:738             state:D stack:14544 pid: 7124 ppid:   753 flags:0x00004002
> > > [   20.540892] Call Trace:
> > > [   20.541424]  __schedule+0x22d/0x6c0
> > > [   20.542128]  schedule+0x3f/0xa0
> > > [   20.542751]  percpu_rwsem_wait+0x100/0x130
> > > [   20.543516]  ? percpu_free_rwsem+0x30/0x30
> > > [   20.544259]  __percpu_down_read+0x44/0x50
> > > [   20.545002]  xfs_trans_alloc+0x19a/0x1f0
> > > [   20.545747]  xfs_free_eofblocks+0x47/0x100
> > > [   20.546519]  xfs_inode_mark_reclaimable+0x115/0x160
> > > [   20.547398]  destroy_inode+0x36/0x70
> > > [   20.548077]  prune_icache_sb+0x79/0xb0
> > > [   20.548789]  super_cache_scan+0x159/0x1e0
> > > [   20.549536]  shrink_slab.constprop.0+0x1b1/0x370
> > > [   20.550363]  drop_slab_node+0x1d/0x40
> > > [   20.551041]  drop_slab+0x30/0x70
> > > [   20.551600]  drop_caches_sysctl_handler+0x6b/0x80
> > > [   20.552311]  proc_sys_call_handler+0x12b/0x250
> > > [   20.552931]  new_sync_write+0x117/0x1b0
> > > [   20.553462]  vfs_write+0x1bd/0x250
> > > [   20.553914]  ksys_write+0x5a/0xd0
> > > [   20.554381]  do_syscall_64+0x3b/0x90
> > > [   20.554854]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [   20.555481] RIP: 0033:0x7f90928d3300
> > > [   20.555946] RSP: 002b:00007ffc2b50b998 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > > [   20.556853] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f90928d3300
> > > [   20.557686] RDX: 0000000000000002 RSI: 000055a5d6c47750 RDI: 0000000000000001
> > > [   20.558524] RBP: 000055a5d6c47750 R08: 0000000000000007 R09: 0000000000000073
> > > [   20.559335] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> > > [   20.560154] R13: 00007f90929ae760 R14: 0000000000000002 R15: 00007f90929a99e0
> > > 
> > > localhost login: [   30.773559] INFO: task 738:7124 blocked for more than 20 seconds.
> > > [   30.775236]       Not tainted 5.14.0-rc4+ #27
> > > [   30.777449] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [   30.779729] task:738             state:D stack:14544 pid: 7124 ppid:   753 flags:0x00004002
> > > [   30.781267] Call Trace:
> > > [   30.781850]  __schedule+0x22d/0x6c0
> > > [   30.782618]  schedule+0x3f/0xa0
> > > [   30.783297]  percpu_rwsem_wait+0x100/0x130
> > > [   30.784110]  ? percpu_free_rwsem+0x30/0x30
> > > [   30.785085]  __percpu_down_read+0x44/0x50
> > > [   30.786071]  xfs_trans_alloc+0x19a/0x1f0
> > > [   30.786877]  xfs_free_eofblocks+0x47/0x100
> > > [   30.787727]  xfs_inode_mark_reclaimable+0x115/0x160
> > > [   30.788708]  destroy_inode+0x36/0x70
> > > [   30.789395]  prune_icache_sb+0x79/0xb0
> > > [   30.790056]  super_cache_scan+0x159/0x1e0
> > > [   30.790712]  shrink_slab.constprop.0+0x1b1/0x370
> > > [   30.791381]  drop_slab_node+0x1d/0x40
> > > [   30.791924]  drop_slab+0x30/0x70
> > > [   30.792469]  drop_caches_sysctl_handler+0x6b/0x80
> > > [   30.793328]  proc_sys_call_handler+0x12b/0x250
> > > [   30.793948]  new_sync_write+0x117/0x1b0
> > > [   30.794471]  vfs_write+0x1bd/0x250
> > > [   30.794941]  ksys_write+0x5a/0xd0
> > > [   30.795414]  do_syscall_64+0x3b/0x90
> > > [   30.795928]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [   30.796595] RIP: 0033:0x7f90928d3300
> > > [   30.797090] RSP: 002b:00007ffc2b50b998 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > > [   30.798033] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f90928d3300
> > > [   30.798852] RDX: 0000000000000002 RSI: 000055a5d6c47750 RDI: 0000000000000001
> > > [   30.799703] RBP: 000055a5d6c47750 R08: 0000000000000007 R09: 0000000000000073
> > > [   30.800833] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> > > [   30.801764] R13: 00007f90929ae760 R14: 0000000000000002 R15: 00007f90929a99e0
> > > [   30.802628] INFO: task xfs_io:7130 blocked for more than 10 seconds.
> > > [   30.803421]       Not tainted 5.14.0-rc4+ #27
> > > [   30.803985] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [   30.804979] task:xfs_io          state:D stack:13712 pid: 7130 ppid:  7127 flags:0x00000002
> > > [   30.806013] Call Trace:
> > > [   30.806399]  __schedule+0x22d/0x6c0
> > > [   30.806867]  schedule+0x3f/0xa0
> > > [   30.807334]  rwsem_down_write_slowpath+0x1d8/0x510
> > > [   30.808018]  thaw_super+0xd/0x20
> > > [   30.808748]  __x64_sys_ioctl+0x5d/0xb0
> > > [   30.809292]  do_syscall_64+0x3b/0x90
> > > [   30.809797]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [   30.810454] RIP: 0033:0x7ff1b48c5d1b
> > > [   30.810943] RSP: 002b:00007fff0bf88ac0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > [   30.811874] RAX: ffffffffffffffda RBX: 000055b93ae5fc40 RCX: 00007ff1b48c5d1b
> > > [   30.812743] RDX: 00007fff0bf88b2c RSI: ffffffffc0045878 RDI: 0000000000000003
> > > [   30.813583] RBP: 000055b93ae60fe0 R08: 0000000000000000 R09: 0000000000000000
> > > [   30.814497] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > > [   30.815413] R13: 000055b93a3a94e9 R14: 0000000000000000 R15: 000055b93ae61150
> > > ---
> > >  tests/generic/738 | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/738 b/tests/generic/738
> > > index 6f1ea7f8..9a90eefa 100755
> > > --- a/tests/generic/738
> > > +++ b/tests/generic/738
> > > @@ -11,8 +11,24 @@ _begin_fstest auto quick freeze
> > >  
> > >  _cleanup()
> > >  {
> > > -	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> > > -	wait
> > > +    # Thaw may dead-lock on unfixed XFS kernels.  Run it in background,
> > > +    # wait a tiny bit, then decide whether it is stuck.
> > > +    xfs_freeze -u $SCRATCH_MNT 2>/dev/null &
> > > +    _thaw_pid=$!
> > > +
> > > +    sleep 8
> > > +
> > > +    if [ -e "/proc/$_thaw_pid" ]; then
> > > +            # still running → stuck in D-state
> > > +            if [ "$FSTYP" = "xfs" ]; then
> > > +                    echo "generic/738: known XFS freeze-reclaim deadlock; " \
> > > +                         "fixed by kernel commit ab23a7768739 " \
> > > +                         '"xfs: per-cpu deferred inode inactivation queues"' \
> > 
> > If want to mark a known fix, you can add below line to this case:
> > 
> > _fixed_by_kernel_commit ab23a7768739 \
> > 	"xfs: per-cpu deferred inode inactivation queues"
> 
> I have already tried that way, but it doesn't have any chance to output the fixd commit
> because it already hang inside xfs_freeze, that's why I change to run this
> command in background then sleep.

At least someone can find this message (and some comments if you like) when he check the
test case source code :)

# ...
[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit ab23a7768739 \
	"xfs: per-cpu deferred inode inactivation queues"

> 
> > 
> > But for this patch, I don't think we should do this for a bug. If it blocks your
> > testing on someone downstream system, you can skip this test. CC xfs list if you
> > need more review points for this xfs bug.
> 
> Without this patch, users will not know the cause of the hang easily from the stdout/stderr.
> I have already bisected and confirms this patch resolves the issue.

CC xfs list to confirm that.

> 
> Regards,
> Li
> 

