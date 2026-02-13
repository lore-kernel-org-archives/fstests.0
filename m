Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB11B81D3
	for <fstests@vger.kernel.org>; Fri, 13 Feb 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013676; cv=none; b=Lz051bfv4n3Q6WJn+sIb2GKlclajHDAfi81ywkZ0/fJ3+8PKtauKbiLf5Dzamym1cg0hmJz2qMWuXDUPyDhMQhRM9nXj2+26RkxR/CdgCRGrh8yxdGB4xjT0RKgNMrTGQKjjXbIuAgE+QQzv1UsbV5cRYVr5t8PSZPP/HasIgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013676; c=relaxed/simple;
	bh=2yWBR7+6uAiJGZh1+gaD/4Oxl4AB92Rb/uWzQN6SEVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GilGIRBCU9kdqyOhU6qscI6aZ1f+r8EtcX2qP6ENg+XT9Vw1RXcULKtKNzq5eIrh6nQdFw7mxsUhxXT6w2Yb5a2B+6ugmrx291VSdRi562gw/y+lrhsIwzxdN1JUuk2NPHT36A2ceRiIv7gtizCdExqmb0CbXX2q2+gQGQVzZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAO+WVuH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kvg+aizJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAO+WVuH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kvg+aizJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771013674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+Sx9VmchKCkAbDF8WdRHlLXOLo0NV/E7WV9Z+vjBJg=;
	b=FAO+WVuHuDleg/WrSkBTZhtkxrAfZfd5DOMTuQym9zKJINrjIZSDJWZQakD3PGG16i4Lmc
	EiO2CeKlgPuspqdh8hdqGg1gMOIO/9gI5vCKzdy09UOPC2oLFf1Mej9Eb94GMdf9F/PtJ/
	zujQFGMfjJHacwl+6h6IGFghhgeNeus=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-9fjWIfQeOXGr5AYaY_wefw-1; Fri, 13 Feb 2026 15:14:32 -0500
X-MC-Unique: 9fjWIfQeOXGr5AYaY_wefw-1
X-Mimecast-MFC-AGG-ID: 9fjWIfQeOXGr5AYaY_wefw_1771013672
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c7a38429so2492331a91.0
        for <fstests@vger.kernel.org>; Fri, 13 Feb 2026 12:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771013672; x=1771618472; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+Sx9VmchKCkAbDF8WdRHlLXOLo0NV/E7WV9Z+vjBJg=;
        b=kvg+aizJSqAo2/mt3//2RslgvnhDERbS3TadMdlm1OGLQdvaVBbahxSBuxNu1des+c
         ZvYlzFMz3Y7n8nO8HA1Q6DsFyIE+BVWHCSn2w0WjFREjR0x3XAsujrYrmTdKC6bONMLF
         /t0ABWpKCj40V9RI5pjH+8ALOfM8flJaPgYbCGFC0OBWWmZIxnJQDKmmzQPa6ICH1HId
         8ewYP6Ynmk9qT3gpFhhHirbwCPWv3pJFl8yQpr/CaCPFeg2O9Y/7nevsekkl+GwiPCxS
         PcF01TgMlGsX5qzlTfMuQWCu5GZPpBP/EqpTgPENY9MjVihx4oYGVQ2ImL7s1eE6+cuq
         qijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771013672; x=1771618472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Sx9VmchKCkAbDF8WdRHlLXOLo0NV/E7WV9Z+vjBJg=;
        b=MhV9ERr99fs511t0WTOnekV22yjWx/J9BrOLc5Q2sugjqL32dvnQoTFWusOI6IttIl
         Js4KCLqu63T8V8gdD+Vdq95zzMWInvt0cqBTCY9Xqicr5o7LkbMXZp5myHnJpy7Y3syr
         vyzGIF1f8birnofdAvLV5EHyNg7N6jTJsESLNNT7nzS8T7cQx+fSPzi9I19jd5+ahUhX
         8/72AcMXpkWT8bldBvjWAj7xvOQ9Yi366FLoJLaEEcp6DlszDTar0XvTPKKpJEhhfI9P
         R2d3HimrVr/VQEYyXbkFAI46oKF6IbC+cTT0Ra++m2HKFJouszDFRsKf+b6oqgHKxG0u
         rwoA==
X-Forwarded-Encrypted: i=1; AJvYcCW0t+9YItZlU8x0SJQuCmN2dK00AyhO6SOLZetTaXvxJ89UT6Kc3cRlVLHXGEr5EniVTymQ0JUo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AlaiOku6SJbFlXmP8XO6WffIrhyN1hFKKjlO5RzGVKamxf7n
	P/SaB4R3Id2THCp1VRfVTGZfS06vefnskK3tfywP4F+h1Q4v2LAgE0Q9gLP0pErQ3eXijcTBu8M
	BsnCcGIxfcjRwRsheufr5v5RwQa1XeOoJpI7tds98YDZ/3qdEN932f91ZgPQ=
X-Gm-Gg: AZuq6aLhIc9QivfcNgSToT6vkQ60L8FFCQFlRl0VWfftmIXIWCG/jpjmUS/yi5wfQiS
	rpL+l0W0qrx+y+bbYp6DJzW3k+W87n+0zLjzwlw2HRTmO31L4ob0lhGqn2ymRrekoPQS0skRNAT
	nNWoOXZh/pTwSjeMgPA6M+KkewyEyssFHwVzp/V6FVMoXORCHkIkWaxRKpddFX4VM83gLSCD/cK
	Pd4zM9un/xcLYTnlWjcq4FdBwAkqIFX6suNqdihw+DejpE21+SA9ecINCYq0q14pPBOFthSAWNm
	gffcTO0wqyk9UUfMfDYIQVfEDVLBxqqW2v5Ea3ThwTVMSyjkweIncxaXdMU4myTfNRVEpntv2rM
	CupRkCi7bZNv9FGhr2PgJffIsGwoZkDqdrW1n5ABJ5swkHtD1rpj0rolg6BRwkw==
X-Received: by 2002:a17:90b:53cf:b0:34c:2aac:21a7 with SMTP id 98e67ed59e1d1-357b50c4fb4mr1093927a91.7.1771013671764;
        Fri, 13 Feb 2026 12:14:31 -0800 (PST)
X-Received: by 2002:a17:90b:53cf:b0:34c:2aac:21a7 with SMTP id 98e67ed59e1d1-357b50c4fb4mr1093908a91.7.1771013671115;
        Fri, 13 Feb 2026 12:14:31 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356629314fbsm12715216a91.0.2026.02.13.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:14:30 -0800 (PST)
Date: Sat, 14 Feb 2026 04:14:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] fstests: btrfs: add a regression test for incorrect
 inode incompressible flag
Message-ID: <20260213201425.d6dz4ovcx25zdzjp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260209095735.130049-1-wqu@suse.com>
 <20260212184006.5pyxjnwxd5n5uad2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <74b8dbc6-34cc-470b-9812-b595af95c5b6@gmx.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74b8dbc6-34cc-470b-9812-b595af95c5b6@gmx.com>

On Fri, Feb 13, 2026 at 07:24:17AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/2/13 05:10, Zorro Lang 写道:
> [...]
> > > +
> > > +blocksize=$(_get_block_size $SCRATCH_MNT)
> > 
> > Do you mind I replace _get_block_size with _get_file_block_size when I merge it?
> 
> Sure, and I'll try to remember to use that newer helper in the future.
> 
> And if needed, I can replace the existing callsites with the newer helper in
> a dedicated patch.

Don't worry, since some cases might genuinely need the bare _get_block_size, so I
didn't do a blanket replacement, just keep an eye on it during code reviewing :)
Anyway, I'll review this patch at first.

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > Even though btrfs currently doesn't require special handling to get the correct block
> > size, using this interface is more future-proof. It will help us to easily add specific
> > logic later if btrfs ever needs it. Others are good to me,
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > > +
> > > +# Create a sparse file which is 2 * blocksize, then try a small write at
> > > +# file offset 0 which should not be inlined.
> > > +# Sync so that [0, 2K) range is written, then write a larger range which
> > > +# should be able to be compressed.
> > > +$XFS_IO_PROG -f -c "truncate $((2 * $blocksize))" -c "pwrite 0 2k" -c sync \
> > > +		-c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
> > > +ino=$(stat -c "%i" $SCRATCH_MNT/foobar)
> > > +_scratch_unmount
> > > +
> > > +# Dump the fstree into seqres.full for debug.
> > > +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV >> $seqres.full
> > > +
> > > +# Check the NOCOMPRESS flag of the inode.
> > > +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> > > +grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
> > > +[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
> > > +
> > > +# Check the file extent at fileoffset 1m.
> > > +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> > > +grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compression 0"
> > > +[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
> > > +
> > > +echo "Silence is golden"
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/btrfs/343.out b/tests/btrfs/343.out
> > > new file mode 100644
> > > index 00000000..2eb30e4f
> > > --- /dev/null
> > > +++ b/tests/btrfs/343.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 343
> > > +Silence is golden
> > > -- 
> > > 2.51.2
> > > 
> > > 
> > 
> > 
> 
> 

