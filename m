Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FE19BAF
	for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVvtQ6mQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649538226
	for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 05:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699624622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkBe2/uLSA+w6T92ie2OnmQtjDN0moqsVzizFE4ajKg=;
	b=VVvtQ6mQhFLBOqDtiMcnQ4cSC6pVk8PKUvG7kzQ1eTkxP3psQoqoaFHJFE1SW6gXTS6HiH
	+b63cStFy2oa26kO1UoGZU082mjsaDs4KMdBJCFCpm85edt3QZxhVXx8S06USWnmOqYcdC
	8vqtEo9dIO1nZPlToXJy1m4S4L40DAQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-X-odzDs0OGqsIzytGQ9oFg-1; Fri, 10 Nov 2023 08:57:00 -0500
X-MC-Unique: X-odzDs0OGqsIzytGQ9oFg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc3ad55c75so22215605ad.0
        for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 05:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624620; x=1700229420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkBe2/uLSA+w6T92ie2OnmQtjDN0moqsVzizFE4ajKg=;
        b=IFpITdnd9gidG6RzbudfMI445oAlK6tYHxaV/V2aN4eIDZGt93nrcTmgGn+ViBkNk0
         kKX3zl9NOAkX89WFALXNtA6+NsHyezK+C5Xzw47VJfEXEloFMZ41FvKgbDnbSnN/ZKgx
         xHAAUgAavNvJrzrSjKnm3u9GrCdWJjHUr2q+pWWWdJh1cGJhFfm6Vr2UB8Q8Tf6GtW7B
         WJSLeeKF+mZspzea3leBrjaEn6jLbP+fqHXfBq2VEjnZYiM8pKdJGHvUyglqUug6eYhp
         uzhdClxS0QCbGjxO4XpY4GLrAPiFke7UQ3wM1eOQY45CN0s6kX3CZD++iNo871VbfTjN
         j5bw==
X-Gm-Message-State: AOJu0YyM1RXhIgCjD0oNkb/DkZrIbK4a6Ym2j13mKzl0Ua08vn+xpmK0
	/XMob90g0Oo/LuZaI6qrn29bdgoK7Hb6eeg+OC/KXCWwgIkZZHSZsU4BocQcHC3sRGQbJXjf1Yy
	F/N0oXZh8SC8rS63+xw==
X-Received: by 2002:a17:902:a9ca:b0:1cc:3fce:8aa8 with SMTP id b10-20020a170902a9ca00b001cc3fce8aa8mr7213832plr.6.1699624619774;
        Fri, 10 Nov 2023 05:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvnibCFGLD2LcrWpIyyqBVGGUrCAA1OS5JcLToi16rJYWpgNia3pmRKEPmzhNrQrfoynXqrQ==
X-Received: by 2002:a17:902:a9ca:b0:1cc:3fce:8aa8 with SMTP id b10-20020a170902a9ca00b001cc3fce8aa8mr7213816plr.6.1699624619397;
        Fri, 10 Nov 2023 05:56:59 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001bbd1562e75sm5401702plg.55.2023.11.10.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:56:59 -0800 (PST)
Date: Fri, 10 Nov 2023 21:56:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <carlos@maiolino.me>
Subject: Re: [Bug report][fstests generic/047] Internal error !(flags &
 XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.
 Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]
Message-ID: <20231110135654.26yq5s5ttp7dautk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231107080522.5lowalssbmi6lus3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUnxswEfoeZQhw5P@dread.disaster.area>
 <20231107151314.angahkixgxsjwbot@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUstA+1+IvHJ87eP@dread.disaster.area>
 <CAN=2_H+CdEK_rEUmYbmkCjSRqhX2cwi5yRHQcKAmKDPF16vqOw@mail.gmail.com>
 <ZUx429/S9H07xLrA@dread.disaster.area>
 <20231109140929.jq7bpnuustsup3xf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZU1nltE2X6qLJ8EL@dread.disaster.area>
 <20231110013651.fw3j6khkdtjfe2bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZU2PhTKqwNEbjK13@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU2PhTKqwNEbjK13@dread.disaster.area>

On Fri, Nov 10, 2023 at 01:03:49PM +1100, Dave Chinner wrote:
> On Fri, Nov 10, 2023 at 09:36:51AM +0800, Zorro Lang wrote:
> > The g/047 still fails with this 2nd patch. So I did below steps [1],
> > and get the trace output as [2], those dump_inodes() messages you
> > added have been printed, please check.
> 
> And that points me at the bug.
> 
> dump_inodes: disk ino 0x83: init nblocks 0x8 nextents 0x0/0x0 anextents 0x0/0x0 v3_pad 0x0 nrext64_pad 0x0 di_flags2 0x18
> dump_inodes: log ino 0x83: init nblocks 0x8 nextents 0x0/0x1 anextents 0x0/0x0 v3_pad 0x1 nrext64_pad 0x0 di_flags2 0x18 big
>                                                      ^^^^^^^
> The initial log inode is correct.
> 
> dump_inodes: disk ino 0x83: pre nblocks 0x8 nextents 0x0/0x0 anextents 0x0/0x0 v3_pad 0x0 nrext64_pad 0x0 di_flags2 0x18
> dump_inodes: log ino 0x83: pre nblocks 0x8 nextents 0x0/0x0 anextents 0x0/0x0 v3_pad 0x0 nrext64_pad 0x0 di_flags2 0x18 big
>                                                     ^^^^^^^
> 
> .... but on the second sample, it's been modified and the extent
> count has been zeroed? Huh, that is unexpected - what did that?
> 
> Oh.
> 
> Can you test the patch below and see if it fixes the issue? Keep
> the first verifier patch I sent, then apply the patch below. You can
> drop the debug traceprintk patch - the patch below should fix it.

Great, Dave! It works, below testing [1] passed on my s390x now. Maybe I should
write Tested-by, but as a reporter, so Reported-by might be proper, so...

Reported-by: Zorro Lang <zlang@redhat.com>

Anyway, I'm doing a full round fstests "auto" group testing on s390x with this
patch, to check if there're more issue on big endian machine. If you have
any specific concern (testing condition) hope to test, please tell me, I'll
enhance the testing of that part.

Thanks,
Zorro

[1]
# ./check generic/047 generic/039 generic/065
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x ibm-z-507 6.6.0+ #1 SMP Wed Nov  8 12:51:20 EST 2023
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,rmapbt=0,reflink=1,bigtime=1,inobtcount=1 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/039        0s
generic/047 10s ...  10s
generic/065        1s
Ran: generic/039 generic/047 generic/065
Passed all 3 tests

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> xfs: recovery should not clear di_flushiter unconditionally
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because on v3 inodes, di_flushiter doesn't exist. It overlaps with
> zero padding in the inode, except when NREXT64=1 configurations are
> in use and the zero padding is no longer padding but holds the 64
> bit extent counter.
> 
> This manifests obviously on big endian platforms (e.g. s390) because
> the log dinode is in host order and the overlap is the LSBs of the
> extent count field. It is not noticed on little endian machines
> because the overlap is at the MSB end of the extent count field and
> we need to get more than 2^^48 extents in the inode before it
> manifests. i.e. the heat death of the universe will occur before we
> see the problem in little endian machines.
> 
> This is a zero-day issue for NREXT64=1 configuraitons on big endian
> machines. Fix it by only clearing di_flushiter on v2 inodes during
> recovery.
> 
> Fixes: 9b7d16e34bbe ("xfs: Introduce XFS_DIFLAG2_NREXT64 and associated helpers")
> cc: stable@kernel.org # 5.19+
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_inode_item_recover.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
> index f4c31c2b60d5..dbdab4ce7c44 100644
> --- a/fs/xfs/xfs_inode_item_recover.c
> +++ b/fs/xfs/xfs_inode_item_recover.c
> @@ -371,24 +371,26 @@ xlog_recover_inode_commit_pass2(
>  	 * superblock flag to determine whether we need to look at di_flushiter
>  	 * to skip replay when the on disk inode is newer than the log one
>  	 */
> -	if (!xfs_has_v3inodes(mp) &&
> -	    ldip->di_flushiter < be16_to_cpu(dip->di_flushiter)) {
> -		/*
> -		 * Deal with the wrap case, DI_MAX_FLUSH is less
> -		 * than smaller numbers
> -		 */
> -		if (be16_to_cpu(dip->di_flushiter) == DI_MAX_FLUSH &&
> -		    ldip->di_flushiter < (DI_MAX_FLUSH >> 1)) {
> -			/* do nothing */
> -		} else {
> -			trace_xfs_log_recover_inode_skip(log, in_f);
> -			error = 0;
> -			goto out_release;
> +	if (!xfs_has_v3inodes(mp)) {
> +		if (ldip->di_flushiter < be16_to_cpu(dip->di_flushiter)) {
> +			/*
> +			 * Deal with the wrap case, DI_MAX_FLUSH is less
> +			 * than smaller numbers
> +			 */
> +			if (be16_to_cpu(dip->di_flushiter) == DI_MAX_FLUSH &&
> +			    ldip->di_flushiter < (DI_MAX_FLUSH >> 1)) {
> +				/* do nothing */
> +			} else {
> +				trace_xfs_log_recover_inode_skip(log, in_f);
> +				error = 0;
> +				goto out_release;
> +			}
>  		}
> +
> +		/* Take the opportunity to reset the flush iteration count */
> +		ldip->di_flushiter = 0;
>  	}
>  
> -	/* Take the opportunity to reset the flush iteration count */
> -	ldip->di_flushiter = 0;
>  
>  	if (unlikely(S_ISREG(ldip->di_mode))) {
>  		if ((ldip->di_format != XFS_DINODE_FMT_EXTENTS) &&
> 

