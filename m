Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617919D8BB
	for <fstests@vger.kernel.org>; Thu, 19 Sep 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754302; cv=none; b=t0Ok5BEqrPwPiZiR2FAqPJIWnBMaAgUX+6MYh/3Q6BrOTR91v83p9Vq+9hlHDIcvl/9mgmrgvEhCOEgWd0qjxCOYLyjJT4yiJHZYOIwNatB9jBCtG1WXflUuvUmal7UHvM2PiEgBaLqhxbamd6IMT8QZm3thvX7cEhFrzeA4DaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754302; c=relaxed/simple;
	bh=5+U7y3oxwAfbhqVRGmkxI2VALtbRPrDDhWYFudYw0mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8zD2UjLAOHKxr0WsJoPpytzrCY6SKBEDR1cIl4achLBY9IwaPCFDvJjgKrKWCCm9aLwT4PurAxbW1KRd1x5wzLT6aqqguuBRmC3cIpSpmY24acc8l6Z0ugq29tBXdhesFaIoxWoBt6X5/MKdjos0Q88zYu8zHkbktXv4Y9J/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iB/jlH13; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB/jlH13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726754298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/2MUtsiKyHauds2qqhS4UYk3RhAKaGmJDq2PzewGaI=;
	b=iB/jlH13HkcwZuYcsl8Kai9UpTzCOr7e+RVgGbgS+O9ncOSKf0uKYKkZzcer2mN0Ja/N80
	BSFByw71DSHE+9btZQ97RebETexR1+6T10M5b19g6qbCn+5cEcxlQuTCtPr90rqpt63E9Z
	XfMg+tlKFlfjtO+NclXAqpKceOjD+gk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-3cD5WkQZPymQqU-NGo592w-1; Thu, 19 Sep 2024 09:58:17 -0400
X-MC-Unique: 3cD5WkQZPymQqU-NGo592w-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20537e42b7aso14366275ad.2
        for <fstests@vger.kernel.org>; Thu, 19 Sep 2024 06:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754296; x=1727359096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/2MUtsiKyHauds2qqhS4UYk3RhAKaGmJDq2PzewGaI=;
        b=c6jXdG0wl5WI6u4uowMceR7ByNUejjQqVNjFaUrOih2Pocz4Cyfbnsz4OPfn318i8u
         bBr8zchOo9nNgCFXTYzfHqewUspa4cL43KBCeJ+8DJXxcuCaC/8XJk1BLWmWHrdXdvYj
         NviL3Un4rOB6jPSht3wsAYt7YaDeveY5IYzmBXmigRwVb8ieWbO0yLJkC77aG0Yi64Az
         Lpl/vn0W+AA5CnmywUbAArW70015wczbc80jOKfekPCduzlswTkcJHqs4C/761EFg9Y8
         Hvnc2WRsxYz3qkEEpUT7sD90+rtKo/WGOvjCvdPV0GhDBO/tkh0F8qdL4G3CXT6XSqVE
         2XBA==
X-Forwarded-Encrypted: i=1; AJvYcCWf6XmN4WXZE2VNC04D5PKR1TVb5AGbkDJIDvwcyVwsy9u1UfZsLlE3c150EL4t4b6wfDd8xJw8@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjtLJWbuVwXaFrZb6XUcaYtvmRhBgragAr+/PKbhww5saX/1I
	NIJ58pF4lIk3VTvzs/0oBwuXgK8qXzyhKkB8fIZk3I82/9BuKbm1In7Pr+OuY9yvQfwXj3bmdOs
	HVLpdGJF9awvSPL7fb6u5Ek1bEGSpZgYyRVavqG/VAC1a82wiygjsF8k=
X-Received: by 2002:a17:902:d2ca:b0:206:c2f4:afb7 with SMTP id d9443c01a7336-2076e36db8cmr357695465ad.26.1726754296480;
        Thu, 19 Sep 2024 06:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9dcn3RFdB1lBsuCSr12seiM0TbXN495EpkIABcOP+ECeICu2gSbHZDViogc2ewLqWPwHO5w==
X-Received: by 2002:a17:902:d2ca:b0:206:c2f4:afb7 with SMTP id d9443c01a7336-2076e36db8cmr357695165ad.26.1726754296078;
        Thu, 19 Sep 2024 06:58:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794730becsm80456675ad.267.2024.09.19.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:58:15 -0700 (PDT)
Date: Thu, 19 Sep 2024 21:58:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] overlay: create a variant to syncfs error test xfs/546
Message-ID: <20240919135810.givimomj6vgvotzk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240830180844.857283-1-amir73il@gmail.com>
 <20240903042128.ksqua6ha47iayolq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxifYDgCmKEUQrbZWwL8JxmRnmPK3dGtVpMhq2cgGQ_etg@mail.gmail.com>
 <20240904025840.obxcbe22bud6ga2i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxjDcgm9preuBY_5b+bbHpiLzVw+yKNj7KaeWs_1ye1Tqw@mail.gmail.com>
 <20240904112533.vbzp3nclece2sukg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxiTKJjgL16tL2iUzxBFAK+bLCsgfGaj3HGKq+nYWFMAnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiTKJjgL16tL2iUzxBFAK+bLCsgfGaj3HGKq+nYWFMAnQ@mail.gmail.com>

On Tue, Sep 17, 2024 at 04:37:04PM +0200, Amir Goldstein wrote:
> On Wed, Sep 4, 2024 at 1:25 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Sep 04, 2024 at 10:23:16AM +0200, Amir Goldstein wrote:
> > > On Wed, Sep 4, 2024 at 4:58 AM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 03, 2024 at 08:41:28AM +0200, Amir Goldstein wrote:
> > > > > On Tue, Sep 3, 2024 at 6:21 AM Zorro Lang <zlang@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 30, 2024 at 08:08:44PM +0200, Amir Goldstein wrote:
> > > > > > > Test overlayfs over xfs with and without "volatile" mount option.
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Zorro,
> > > > > > >
> > > > > > > I was going to make a generic test from xfs/546, so that overlayfs could
> > > > > > > also run it, but then I realized that ext4 does not behave as xfs in
> > > > > > > that case (it returns success on syncfs post shutdown).
> > > > > > >
> > > > > > > Unless and until this behavior is made a standard, I made an overlayfs
> > > > > > > specialized test instead, which checks for underlying fs xfs.
> > > > > > > While at it, I also added test coverage for the "volatile" mount options
> > > > > > > that is expected to return succuss in that case regardles of the
> > > > > > > behavior of the underlying fs.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Amir.
> > > > > > >
> > > > > > >  tests/overlay/087     | 62 +++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  tests/overlay/087.out |  4 +++
> > > > > > >  2 files changed, 66 insertions(+)
> > > > > > >  create mode 100755 tests/overlay/087
> > > > > > >  create mode 100644 tests/overlay/087.out
> > > > > > >
> > > > > > > diff --git a/tests/overlay/087 b/tests/overlay/087
> > > > > > > new file mode 100755
> > > > > > > index 00000000..a5afb0d5
> > > > > > > --- /dev/null
> > > > > > > +++ b/tests/overlay/087
> > > > > > > @@ -0,0 +1,62 @@
> > > > > > > +#! /bin/bash
> > > > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > > > > > +# Copyright (c) 2024 CTERA Networks.  All Rights Reserved.
> > > > > > > +#
> > > > > > > +# FS QA Test No. 087
> > > > > > > +#
> > > > > > > +# This is a variant of test xfs/546 for overlayfs
> > > > > > > +# with and without the "volatile" mount option.
> > > > > > > +# It only works over xfs underlying fs.
> > > > > > > +#
> > > > > > > +# Regression test for kernel commits:
> > > > > > > +#
> > > > > > > +# 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
> > > > > > > +# 2d86293c7075 ("xfs: return errors in xfs_fs_sync_fs")
> > > > > > > +#
> > > > > > > +# During a code inspection, I noticed that sync_filesystem ignores the return
> > > > > > > +# value of the ->sync_fs calls that it makes.  sync_filesystem, in turn is used
> > > > > > > +# by the syncfs(2) syscall to persist filesystem changes to disk.  This means
> > > > > > > +# that syncfs(2) does not capture internal filesystem errors that are neither
> > > > > > > +# visible from the block device (e.g. media error) nor recorded in s_wb_err.
> > > > > > > +# XFS historically returned 0 from ->sync_fs even if there were log failures,
> > > > > > > +# so that had to be corrected as well.
> > > > > > > +#
> > > > > > > +# The kernel commits above fix this problem, so this test tries to trigger the
> > > > > > > +# bug by using the shutdown ioctl on a clean, freshly mounted filesystem in the
> > > > > > > +# hope that the EIO generated as a result of the filesystem being shut down is
> > > > > > > +# only visible via ->sync_fs.
> > > > > > > +#
> > > > > > > +. ./common/preamble
> > > > > > > +_begin_fstest auto quick mount shutdown
> > > > > > > +
> > > > > > > +
> > > > > > > +# Modify as appropriate.
> > > > > > > +_require_xfs_io_command syncfs
> > > > > > > +_require_scratch_nocheck
> > > > > > > +_require_scratch_shutdown
> > > > > > > +
> > > > > > > +[ "$OVL_BASE_FSTYP" == "xfs" ] || \
> > > > > > > +     _notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"
> > > > > > > +
> > > > > > > +# Reuse the fs formatted when we checked for the shutdown ioctl, and don't
> > > > > > > +# bother checking the filesystem afterwards since we never wrote anything.
> > > > > > > +echo "=== syncfs after shutdown"
> > > > > > > +_scratch_mount
> > > > > > > +# This command is complicated a bit because in the case of overlayfs the
> > > > > > > +# syncfs fd needs to be opened before shutdown and it is different from the
> > > > > > > +# shutdown fd, so we cannot use the _scratch_shutdown() helper.
> > > > > > > +# Filter out xfs_io output of active fds.
> > > > > > > +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> > > > > > > +     grep -vF '[00'
> > > > > > > +
> > > > > > > +# Now repeat the same test with a volatile overlayfs mount and expect no error
> > > > > > > +_scratch_unmount
> > > > > > > +echo "=== syncfs after shutdown (volatile)"
> > > > > > > +_scratch_mount -o volatile
> > > > > > > +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> > > > > > > +     grep -vF '[00'
> > > > > >
> > > > > > Oh, the test steps are much different from xfs/546. If we move x/546 to generic/,
> > > > > > can overlay reproduce this bug by that?
> > > > >
> > > > > Yes and no.
> > > > >
> > > > > For overlayfs to support this as a generic test, the helper
> > > > > _scratch_shutdown_handle must be used and the shutdown+syncfs
> > > > > command must be complicated to something like this:
> > > > >
> > > > > $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f
> > > > > ' -c close -c syncfs $SCRATCH_MNT | \
> > > > >        grep -vF '[00'
> > > > >
> > > > > This is because overlayfs itself does not support the shutdown ioctl.
> > > > > If the test is moved to generic as it is we get an error when running
> > > > > overlayfs:
> > > > >
> > > > >     XFS_IOC_GOINGDOWN: Inappropriate ioctl for device
> > > > >
> > > > > because _require_scratch_shutdown is "supported" by overlayfs
> > > > > but only when the _scratch_shutdown helpers are used.
> > > >
> > > > Yeah, I know this.
> > > >
> > > > >
> > > > > If the test is to be moved as is, it will need to opt-out of overlayfs
> > > > > explicitly.
> > > >
> > > > I mean you have a "-o volatile" option test, that's an overlayfs specific
> > > > mount option. If you need that test, that's an overlay specific test, that
> > > > part can be an overlay specific test case. If not, we can use a generic
> > > > case (from xfs/546) to cover overlay and other fs.
> > >
> > > I need the -o volatile test regardless of moving xfs/546 to generic.
> > > That's why I posted this patch.
> >
> > OK, let's have two patches, one moves xfs/546 to generic/, the other
> > is this overlay specific test case.
> >
> 
> Hi Zorro,
> 
> I thought that you agreed to include the overlay specific test overlay/087,
> but I still do not see it in for-next.
> 
> Did I misunderstand you, or was it accidently left out of for-next?
> 
> Regarding moving xfs/546 to generic/, I had sent a patch to ext4 [1],
> but no comment from Ted yet.
> 
> [1] https://lore.kernel.org/linux-ext4/20240904084657.1062243-1-amir73il@gmail.com/

If this's accepted by ext4, do you still this notrun?

  [ "$OVL_BASE_FSTYP" == "xfs" ] || \                                                                                                    
	_notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"

And what about other fs (besides xfs and ext4).

Thanks,
Zorro

> 
> > >
> > > >
> > > > BTW, we actually we have a common _scratch_shutdown helper, I'm wondering
> > > > if it works for this test? Likes:
> > > >
> > > >   _scratch_shutdown -f
> > > >   $XFS_IO_PROG -c syncfs $SCRATCH_MNT
> > > >
> > > > Can this work?
> > >
> > > Nope, because $XFS_IO_PROG -c syncfs $SCRATCH_MNT
> > > will fail (EIO) to open the directory after shutdown.
> > > That's why the dance with -c open -c close is needed.
> >
> > Oh, although below line:
> >   $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT
> >
> > trys to shudown on $(_scratch_shutdown_handle), then syncfs on $SCRATCH_MNT too.
> > But the difference is it opens $SCRATCH_MNT before shutdown, so that's what you
> > need.
> 
> Correct, this is why the dance with -c open -c close is needed when the test is
> overlayfs specific and/or generic.
> 
> Thanks,
> Amir.
> 

