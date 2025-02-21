Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F61DB366
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152742; cv=none; b=Gy8ZxOLP0qpOT7oLiIe/7Ll9dM9EjWv24taTo6/yXWYwXbF593pWVVqUlPoO18U+5fvH/KZOZjJxtCSJMZWKYWa4Lh5kOB0xFb0QgyjkKXfQrrT+L+2SmrksrqTtMfAOOx/P5jt9DCQ+8R8r/iv+/HwZco4WEvji9oSQpGFLHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152742; c=relaxed/simple;
	bh=ksfv6YzvdupOc1bWrOzF//l97YaYV8fOZAorUbDRUyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C60irHZeZ043SgWnAaoz8F7KEwuB8TU3MKGt7K1dxyxSiYJrH04cL6YoysEXJv5epqe2eH4jpxKuosn8oqweU2iDt4TH5Fm+WqBku0I6L7Pl1o2Jr4L+NPu2geBRvAdfIcPEptSQr5cRiLsjfD17OI4tTzO6Blt2X164VETOv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHiB82wG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHiB82wG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740152739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1p9jL0mjlXf5rK2lez3mIHuBB+KgscusQPQeuVa4JVc=;
	b=ZHiB82wGDSpuo8sD+biIPgMYT186WTeIRCiyej/8M7cWRa2H3URhGY5D8jBO2Fqz+BMVBC
	YreJrbIOZOC6CQicrSt1cvx+ARnBLdAVDXP+525pWgR0oHLsHi/7FU3hFsKKzK0AvMFFH3
	Tl4Y0bVNG4F3xBLJ3bVJFGqMH4E9CfQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228--AJYUjzLNoKWbz6KUuW3FA-1; Fri, 21 Feb 2025 10:45:37 -0500
X-MC-Unique: -AJYUjzLNoKWbz6KUuW3FA-1
X-Mimecast-MFC-AGG-ID: -AJYUjzLNoKWbz6KUuW3FA_1740152737
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1e7efe00so4974468a91.2
        for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 07:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152737; x=1740757537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p9jL0mjlXf5rK2lez3mIHuBB+KgscusQPQeuVa4JVc=;
        b=ZL+9ahFn8hn3JGEBhJx4TiGh8fu9kzit5k76utOOCFTr29dZjL7IE33sideiQpp7mD
         xVyUm7K7JE+1rjxy8ADL3hO1sKlo/pxvK0rOTH76IHNlyD8ZHVoPzOj4bNQKl+As08Tk
         dUI45AbYLs1Lla4qstBo0CN5pKrWgavJI68+1H+6Z5uIfuv+mGVPEmH+CdobBj4AOwhY
         7uKCiHZC/lBnlw8q7qCgRNUi8Z2+YVpSKW4o81FpH0tBuR8ahO6sK/qEekysZrj2MjxW
         HY0hJXbihGyTtdKLoxsylkTgv4WK6VGGgsLgDeIDYIUlCuCgFpg6LJx9VjBL46OlfpqJ
         L8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXHFGkucklchYLWsaBAurAThTCk0sHkL/KBSFPsWoL1V6LRJvQ1N+QU1PE4JRECh91ODfL4QfzL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VBhQlRFNhxzPhsX+STrzYrh5cf2STPXnt/6IXCXM2wFst8OW
	iOmkybiFSxSTnTjXa/RFdMWYQ4BW/4csfy+GE+irgQ+ouNol0I7GanaLCb7+DvGnAeSelfjfVLt
	ezbILegjLKuleUWop5D2LCjUwFJDAAv+e/HVDupKDFYiWFofggLjPCWg=
X-Gm-Gg: ASbGnctl+AAiUmhBumxMrpMO04jdC+fJR0y+pgicqCF5PJKL5teWump4twL7hOxs7sc
	p1eN3rH5MGLS5ukC+kckxEQt4DHt0NTL8CwsxuEZ4748M8jR8yoB208FMQGpsgiZUy6vA4nB1pl
	zdhn0LwejWRhhygPGvcnumwbBWmGpIHiol7aZW3uo+kLUiVYpb/gWXA4SGMcZTMPc3Z3B+SnOH4
	S4+77CwYn1mXURpwCEOAZFBpk9cDCQNPkMkExPtbpCaIQ9CklGCB/Omr1wQAJbwlqdXUQmxgU7j
	nlIUFKl98HUL3ZA+e7tQM977gCLo1xfxHTGBbXG7RTYpXEn0rPaAwxpc
X-Received: by 2002:a17:90b:5148:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2fce86cf0ebmr5989496a91.16.1740152736651;
        Fri, 21 Feb 2025 07:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5VgpC0pRbHz1uxKhIAqUm5gTEszULjGJzGNrF38CuayMd4qUtseHyVuXbON8w5bJLB0OBhw==
X-Received: by 2002:a17:90b:5148:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2fce86cf0ebmr5989450a91.16.1740152736221;
        Fri, 21 Feb 2025 07:45:36 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb12dc0fsm1670864a91.46.2025.02.21.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:45:35 -0800 (PST)
Date: Fri, 21 Feb 2025 23:45:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250221154531.ttch34qic7zsxyzv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250219221743.20161-1-dsterba@suse.com>
 <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250220203751.GH5777@suse.cz>
 <20250221051902.e7ft6iuvahfvvyza@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250221105918.GJ5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221105918.GJ5777@twin.jikos.cz>

On Fri, Feb 21, 2025 at 11:59:19AM +0100, David Sterba wrote:
> On Fri, Feb 21, 2025 at 01:19:02PM +0800, Zorro Lang wrote:
> > On Thu, Feb 20, 2025 at 09:37:51PM +0100, David Sterba wrote:
> > > On Fri, Feb 21, 2025 at 04:22:38AM +0800, Zorro Lang wrote:
> > > > On Wed, Feb 19, 2025 at 11:17:43PM +0100, David Sterba wrote:
> > > > > The linux kernel removed Reiserfs support in 6.13 so remove it from the
> > > > > tests as well.
> > > > > 
> > > > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > > > ---
> > > > > 
> > > > > Arguably reiser4 support could be removed as well as there's no recent
> > > > > upstream activity.
> > > > 
> > > > Thanks for doing this :) But even with this patch, I still can find more
> > > > "reiser*" related things as below. How about removing them all?
> > > > 
> > > > zorro@zlang-laptop:~/git/upstream/xfs/xfstests-dev$ grep -rsni reiser .
> > > > ./common/config:330:export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
> > > > ./common/config:390:       reiser4)
> > > > ./common/config:391:            # acls & xattrs aren't supported by reiser4
> > > > ./common/config:392:            echo $REISER4_MOUNT_OPTIONS
> > > > ./common/config:443:       reiser4)
> > > > ./common/config:444:            export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
> > > > ./common/config:472:    reiser*)
> > > > ./common/config:540:    reiser4)
> > > > ./common/config:541:            [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> > > > ./common/rc:1227:       ext2|ext3|ext4|reiser4|ocfs2)
> > > > ./common/rc:1331:       reiser4)
> > > > ./common/rc:1333:               $MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize "$@" $SCRATCH_DEV \
> > > 
> > > This is reiser4, the reasoning would be different as it's an out-of-tree
> > > module but still somehow developed so there's a chance somebody is using
> > > it.
> > 
> > Sorry I saw you said "Arguably reiser4 support could be removed as well
> > as there's no recent  upstream activity.", then removed reiser4 from
> > generic/740 [1], so I thought you want to remove it too :)
> 
> Oh I see,
> 
> >  -     reiserfs|reiser4)
> >  -             preop="echo y |"
> >  -             preargs="-f"
> >  -             ;;
> 
> this was not intentional, I mean to remove only the "reiserfs|" part.

No worry, if so I'll help to remove only the "reiserfs|" part when I merge
this patch.

> 
> This may bring the question what is the policy for filesystem support.
> I've seen "case $FSTYP" with widely inconsistent cases of filesystems,
> probably the longest list is in common/rc:_require_scratch_nocheck with
> 9p, virtiofs, afs, pvfs2 or ubifs.  It would be good to document that in
> README, I haven't found anything in that regard.

Good idea, maybe we should have a list about that.

There's not a limitation about what filesystems are supported or not.
Especially the generic test cases, some "not in list" filesystems might
run generic tests too. So we don't exclude any filesystem which wants
to try fstests.

Generally when someone wants to help fstests to support a new filesystem,
there're 3 phases:
1) Check if fstests can mkfs, mount, unmount and fsck on this fs natively.
   If it can't, add the fs to the "case...esac" list, to do special treatment.
2) Run generic test case on the new fs, fix some test failures which are
   not suitable for this fs.
3) Add more test cases for this fs, might need a new tests/$FSTYP directory
   and more common helpers.

Actually some of filesystems which are "supported" by xfstests, just satisfy
the phase#1, or a few phase#2. That depends on how deeply that fs list
would like to use xfstests.

But everything is still changing. For example, we don't support nfs much,
just in phase#1. But as more and more nfs folks start to use xfstests,
it's good to run on nfs now, even reach to part of phase#3. In contrast,
although cifs is in the list, and xfstests can be run on it, but too
many test failures, no one from cifs would like to care about that.

So about the "support list", what's the standard to count in a fs :)

Thanks,
Zorro

> 

