Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B83CF5E
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137876; cv=none; b=KJmh6e/OExDCPSaSXhRBxoe34tPsXnVrX8wKmBz4M2QRPfyYzRKWNQk7oWIA11IgZVxmiUb6qqgN2z2ez9VQdXoPi7lCK378kwJsOy6K4B20/z8xT48oBIT3+/jBQxOXVdsh6ON72/W70PW9FhldZ56dNzM049oCCt3cTOemFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137876; c=relaxed/simple;
	bh=qtnty7SW45mB94/qGeZQN45jV4x/smdMjtPsNhln9wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va5tvl5ix5Jk8Fo/K6rOHdAzveXoi74f0YQa+n0+K/9bV2lkrTr9CsW9cV0l2a0ItymgFculmOmJYXW81H3AJL5CZpUdHkmvqBjWqQENtZShVDTna0ggQrH6emPm2bZrL4kNlcECfK1A1YQnoGW4m5KWkabe/d7BKQ39NU0528Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCcmzJFf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCcmzJFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707137873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6L99uG/ML9ccz6+lvt2A7loL3xXmrYxT9Fsxughx4I=;
	b=VCcmzJFfKyJxknqps6FlsGRJV9uThSdeDoGAxh1JeUQ34mOTY7l0Xp7PzwEIB6mpyXJRKs
	baKoq4tiw2lJMwtlx30qdJuUFeP+94ExlAGHlmmQPCdhDvzyAW95tT9/evgS4VAvvdS+F/
	ifxlQiZktfOs9C+ZhLE0Nv5r6yctavk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Ue-2MqIRMWqBUPL6ynB7Ew-1; Mon, 05 Feb 2024 07:57:51 -0500
X-MC-Unique: Ue-2MqIRMWqBUPL6ynB7Ew-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29687cdf9e2so1037925a91.0
        for <fstests@vger.kernel.org>; Mon, 05 Feb 2024 04:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137870; x=1707742670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6L99uG/ML9ccz6+lvt2A7loL3xXmrYxT9Fsxughx4I=;
        b=mNvEo6au+2LQ3deO5KJSOtNIyMqnAhYka8LapaW6cxkKsaDy/ZqkwMGxSMdS9kTpd9
         kSCpVoa2f4kLSl7ouoTyBXSuOWLWvRYJ99Jfu7kwyYJAYTjhi5Dv8rwwNu5IgvV/10Sg
         rVgbKLZwegJWXdTPM/joNa8D591NPs5ZmRL1jLmPQgaVrgyRlzfQ7e6bwHZ/IfrFIs+Z
         hUL0fTBn9JP3KO/6m+zZ9LX+MeY5Sw+YIr5jJF/szSLwzgJhwJAtLQ/SA4pnIsLztLZq
         ilEcf8icvKKxkxB/t/PuUMjD/03xvooDPGiTLz7fKBsPXp8PCOylm8L2mtSqcrOAcf6X
         8vzw==
X-Gm-Message-State: AOJu0YyLyimv1jVNXoGjEeFrDwSlYToSrxgGNJ0+lX8FXXtAb95voTUq
	gqjDEFiX/Ty4IzafCEdxNyDRlGkmxWioLz9M3XIw+LbpQIDsZFdZI7jBSC2AtdQq1nkeURIbcPJ
	oRYN3N1+J0M55p/5wcJz3+ZW0WlhqLCdQYnHf4RgB4vjlEfO84ijVk8Q=
X-Received: by 2002:a17:90a:ee8a:b0:296:2d18:315f with SMTP id i10-20020a17090aee8a00b002962d18315fmr7213997pjz.24.1707137869797;
        Mon, 05 Feb 2024 04:57:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8kbhOgVj3s0S/B0A7xSyMFQWW8PRS2w9Ev/Qqr4Lt1ok+2rU/MgH5Ntyb9lTgmV+YVihbPQ==
X-Received: by 2002:a17:90a:ee8a:b0:296:2d18:315f with SMTP id i10-20020a17090aee8a00b002962d18315fmr7213980pjz.24.1707137869419;
        Mon, 05 Feb 2024 04:57:49 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090adf8100b0028df5c748e4sm5083986pjv.44.2024.02.05.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:57:49 -0800 (PST)
Date: Mon, 5 Feb 2024 20:57:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.02.04
Message-ID: <20240205125746.tmr6wvhut5oiraut@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <65bfa42f.050a0220.ab271.eb3aSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240205054502.rsc5rnkkifpr3hn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205061626.mve2cp5btbpiijgy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205065642.3hqhipmnxkg442kg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxiJRkSzOFEDpSC25R2wh8A_v-JSB4h=W3OB6NvihOdMbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiJRkSzOFEDpSC25R2wh8A_v-JSB4h=W3OB6NvihOdMbA@mail.gmail.com>

On Mon, Feb 05, 2024 at 12:19:57PM +0200, Amir Goldstein wrote:
> On Mon, Feb 5, 2024 at 8:56 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Mon, Feb 05, 2024 at 02:16:26PM +0800, Zorro Lang wrote:
> > > On Mon, Feb 05, 2024 at 02:00:16PM +0800, Zorro Lang wrote:
> > > > On Mon, Feb 05, 2024 at 01:45:02PM +0800, Zorro Lang wrote:
> > > > > On Sun, Feb 04, 2024 at 10:48:47PM +0800, Zorro Lang wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > The for-next branch of the xfstests repository at:
> > > > > >
> > > > > >         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > > > >
> > > > > > has just been updated and tagged as v2024.02.04 release.
> > > > > >
> > > > > > Release Notes:
> > > > > > 1) There's 4 new test cases in this release -- btrfs/310, generic/740, xfs/601,
> > > > > >    and xfs/606.
> > > > > > 2) btrfs/303 is removed.
> > > > > > 3) Supports XFS metadump V1 and V2 testing, refer to common/xfs_metadump_tests
> > > > > >    new file (might be renamed to common/metadump if more other fs need).
> > > > > > 4) Some fixes and updates for UBIFS, BCACHEFS and NFS testing, welcome more
> > > > > >    updates for more filesystems.
> > > > > > 5) Some updates/fixes for source building, if anyone find building issues in
> > > > > >    this release, please report to us.
> > > > > >
> > > > > > More details refer to below, thanks for all your contributions!
> > > > > >
> > > > > > Thanks,
> > > > > > Zorro
> > > > > >
> > > > > > The new head of the for-next branch is commit:
> > > > > >
> > > > > > 9b63adb69add t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> > > > > >
> > > > > > New commits ([N]ew, [U]pdate, [D]elete):
> > > > > >
> > > > > > Alexander Aring (1):
> > > > > > [N]      [56625c897fd9] generic: add fcntl lock corner cases tests
> > > > > >
> > > > > > Anthony Iliopoulos (2):
> > > > > > [U]      [42f3cb7e56e3] src/af_unix: drop unused offsetof macro definition
> > > > > > [U]      [79d98d94e58c] build: remove unused m4 macros
> > > > > >
> > > > > > Boris Burkov (1):
> > > > > > [D]      [a6e196af46cc] btrfs: Remove btrfs/303
> > > > > >
> > > > > > Darrick J. Wong (10):
> > > > > > [U]      [e7eadc3ee835] generic/256: constrain runtime with TIME_FACTOR
> > > > > > [U]      [8c8be04c1065] common/xfs: simplify maximum metadump format detection
> > > > > > [U]      [42f797643529] common/populate: always metadump full metadata blocks
> > > > > > [U]      [56ccc8cc69d1] xfs/336: fix omitted -a and -o in metadump call
> > > > > > [N]      [85c1e0f518ff] common: refactor metadump v1 and v2 tests
> > > > > > [U]      [1bdc3a5f1c9a] xfs/{129,234,253,605}: disable metadump v1 testing with external devices
> > > > > > [U]      [329671426287] xfs/503: test metadump obfuscation, not progressbars
> > > > > > [N]      [c31a500edc04] xfs/503: split copy and metadump into two tests
> > > > > > [U]      [7e2bf5955c2d] common/xfs: only pass -l in _xfs_mdrestore for v2 metadumps
> > > > > > [U]      [6f4223b6865f] xfs/122: fix for xfs_attr_shortform removal in 6.8
> > > > >
> > > > > Note: A regression problem on this release sometimes after running xfs/605 or
> > > > > xfs/129, it only affect XFS testing, it might kill all later testing, I'm
> > > > > looking into it, and fix ASAP, please linux-xfs don't not update to this
> > > > > release temporarily, wait for a fix. Sorry for this trouble.
> > > >
> > > > !!! It's a critical dangerous bug! Please don't use this release on xfs testing, it might
> > > > kill your system!
> > > >
> > > > The problem comes from common/xfs_metadump_tests:_cleanup_verify_metadump():
> > > >
> > > >    rm -f "$XFS_METADUMP_FILE" "$XFS_METADUMP_IMG"*
> > > >
> > > > The XFS_METADUMP_FILE and XFS_METADUMP_IMG are set in _setup_verify_metadump(), but
> > > > if the _setup_verify_metadump isn't called due to someone case _notrun before calling
> > > > it, its _cleanup will still do _cleanup_verify_metadump, likes this:
> > > >
> > > >   _cleanup()
> > > >   {
> > > >         cd /
> > > >         rm -r -f $tmp.*
> > > >         _cleanup_verify_metadump
> > > >
> > > > Then boooomb, it does "rm -f *" in "/" .... The "*" after "rm" must be written
> > > > carefully. I'll send a patch to fix this problem soon, please don't update
> > > > fstests until the fix be merged.
> > >
> > > I decide to make a respin, I think this bug is dangerous enough due to it might kill
> > > the whole testing system. If someone use fstests without the fix, that's too dangerous.
> > >
> > > I think most of people haven't shifted to the new release, and this version hasn't
> > > been merged into master branch. So I decide to do a respin with a manually fix to
> > > avoid this problem ASAP. Then we can do more jobs later. Sorry for this trouble,
> > > hope it hasn't affected you.
> >
> > I've reset the for-next branch to last v2024.01.14 version. Please don't worry, the
> > patches already got RVBs are in my local branch, I'll make a new release in this
> > week soon, after some discussion and testing.
> >
> 
> Would you consider including my ovl test fix in this release:
> https://lore.kernel.org/fstests/20240203081228.1725872-1-amir73il@gmail.com/
> 
> Without this fix, overlay/084 fails on master and on v.6.7.3.

Sure, I've noticed that failure, thanks for this fix :) I'll look into it
and give it a basic test. I think it can catch the next release.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

