Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564310A12
	for <fstests@vger.kernel.org>; Wed,  4 Sep 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418730; cv=none; b=W/Ifk7Y6ixtFm++r++qiFwvFD7TR4AeV5nqxhFy/iAcE2eworNTvLSxA0QeHVzK+OE4kFsdULshO4Fksb3h2x0m9ok6Q4uGC43hYVLryeZTHT/5lc4t2koe3jnduKL8RpxmH9CRYqGi79Asj8PFpjvNBg2gA8D6kwmk1K3Feywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418730; c=relaxed/simple;
	bh=AN3TAe/ckSYX3B/kStTwMufkgYhcRZ+GzVajfZDGNxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/+GI22Rg4bxNlSfYuZbNSQZhTm5l9VLKwE0/w8Yi9OKa/cUvyMw44kmV2m03Hb/Dw0engwE+87Xzq/fqkQ9xDvV173qVEe67/tRbREEXDAmn0MWkvk5aOI0KZ1lUbXn8GzCoRgQzBatwycSr1tjCZ2S4n5AQmTSpBwEo2/N9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqRSZDBU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqRSZDBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725418727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=976+1Bdlh8YgW83JbcHZ4IcQ843ryczUpppiuQ/ioa0=;
	b=AqRSZDBUjr4RvwyqwScSuXYLn55JhW/OtABe/7eqssggDJmFRqyEyPWU6QuoS3Q4s38/zf
	6HhJEKdcEgZlyy5dVMn38hsVbx5IFaIRcJbnxUinwXUanVbwtotvIoy1Z88Ar2f+PaNoKO
	P1km3V1wnvj4RYSpeDM0m8F4i2jp+JU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-PgDb2dN0PTmU-3NeWONAJQ-1; Tue, 03 Sep 2024 22:58:46 -0400
X-MC-Unique: PgDb2dN0PTmU-3NeWONAJQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7d4f9e1a1a0so919957a12.1
        for <fstests@vger.kernel.org>; Tue, 03 Sep 2024 19:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725418725; x=1726023525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=976+1Bdlh8YgW83JbcHZ4IcQ843ryczUpppiuQ/ioa0=;
        b=l/jO1wrHKrVI9zP2QULJqmOS7uscDC3fGPnY7wSdOX2mKqF/PMjMyuUIoRYDvSEBpV
         4Dy+c9xc8MpMnH39vIAcrXTGSDeiIkISWXxG9UJ2+f5MqaGzMX9apS+X3LgLbavUDeP7
         jqFl9S4ZqVdHRK/gEjHPdJxUUZ1eSdHiqc1dLWhBklWy2CsDLSOBSjotXidkiCrCKDfi
         aqPEqd+bdSJiEVyg7NNFMboVimkiSnRvcy3MsO/J+04U1A/7fnakVm1kD8WamZUq/HtI
         rl9tpoIMQu0Z9o2Kq9WX4giDiHEovIh5Lj+VZWuP7yZqrq9k/6ukZja6YCvM8qz0X6Fn
         HNZw==
X-Forwarded-Encrypted: i=1; AJvYcCUFxEbB306+w575935kXXb9WSdiT03WrzrWLqkIov4aWOXTOv6YLOwMhViKwhMk+6Wp53L2RFkw@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5OPgj8uvv/AJmfXICrIxyEzk4KD2uuP8ELFl02seIxfFYxDq
	AuS0E1lqe2CwADl5NPONlavcvrWuqygXPA+5pQQPfWgE5tm8VNzcK8IclL9eYTdEFXtRBiQQo0f
	gwg5nSp0CRJ6FsHlpBFqAtFi/2iy9ZEx/3yhpHcMNmNK6x3ueZ1Pe8Go=
X-Received: by 2002:a17:902:f70f:b0:205:84a4:bf6b with SMTP id d9443c01a7336-20584a4bfc3mr96425755ad.17.1725418725186;
        Tue, 03 Sep 2024 19:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsrhg5ufW0kVfzTl5CCnyWtN/tW0PsVRPbESNI2YUYceYfTeYbqGmj5dKvl9wdcXY/fpOqkg==
X-Received: by 2002:a17:902:f70f:b0:205:84a4:bf6b with SMTP id d9443c01a7336-20584a4bfc3mr96425485ad.17.1725418724481;
        Tue, 03 Sep 2024 19:58:44 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea574dbsm4585725ad.214.2024.09.03.19.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 19:58:44 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:58:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] overlay: create a variant to syncfs error test xfs/546
Message-ID: <20240904025840.obxcbe22bud6ga2i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240830180844.857283-1-amir73il@gmail.com>
 <20240903042128.ksqua6ha47iayolq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxifYDgCmKEUQrbZWwL8JxmRnmPK3dGtVpMhq2cgGQ_etg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxifYDgCmKEUQrbZWwL8JxmRnmPK3dGtVpMhq2cgGQ_etg@mail.gmail.com>

On Tue, Sep 03, 2024 at 08:41:28AM +0200, Amir Goldstein wrote:
> On Tue, Sep 3, 2024 at 6:21 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Aug 30, 2024 at 08:08:44PM +0200, Amir Goldstein wrote:
> > > Test overlayfs over xfs with and without "volatile" mount option.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Zorro,
> > >
> > > I was going to make a generic test from xfs/546, so that overlayfs could
> > > also run it, but then I realized that ext4 does not behave as xfs in
> > > that case (it returns success on syncfs post shutdown).
> > >
> > > Unless and until this behavior is made a standard, I made an overlayfs
> > > specialized test instead, which checks for underlying fs xfs.
> > > While at it, I also added test coverage for the "volatile" mount options
> > > that is expected to return succuss in that case regardles of the
> > > behavior of the underlying fs.
> > >
> > > Thanks,
> > > Amir.
> > >
> > >  tests/overlay/087     | 62 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/overlay/087.out |  4 +++
> > >  2 files changed, 66 insertions(+)
> > >  create mode 100755 tests/overlay/087
> > >  create mode 100644 tests/overlay/087.out
> > >
> > > diff --git a/tests/overlay/087 b/tests/overlay/087
> > > new file mode 100755
> > > index 00000000..a5afb0d5
> > > --- /dev/null
> > > +++ b/tests/overlay/087
> > > @@ -0,0 +1,62 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > +# Copyright (c) 2024 CTERA Networks.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 087
> > > +#
> > > +# This is a variant of test xfs/546 for overlayfs
> > > +# with and without the "volatile" mount option.
> > > +# It only works over xfs underlying fs.
> > > +#
> > > +# Regression test for kernel commits:
> > > +#
> > > +# 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
> > > +# 2d86293c7075 ("xfs: return errors in xfs_fs_sync_fs")
> > > +#
> > > +# During a code inspection, I noticed that sync_filesystem ignores the return
> > > +# value of the ->sync_fs calls that it makes.  sync_filesystem, in turn is used
> > > +# by the syncfs(2) syscall to persist filesystem changes to disk.  This means
> > > +# that syncfs(2) does not capture internal filesystem errors that are neither
> > > +# visible from the block device (e.g. media error) nor recorded in s_wb_err.
> > > +# XFS historically returned 0 from ->sync_fs even if there were log failures,
> > > +# so that had to be corrected as well.
> > > +#
> > > +# The kernel commits above fix this problem, so this test tries to trigger the
> > > +# bug by using the shutdown ioctl on a clean, freshly mounted filesystem in the
> > > +# hope that the EIO generated as a result of the filesystem being shut down is
> > > +# only visible via ->sync_fs.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick mount shutdown
> > > +
> > > +
> > > +# Modify as appropriate.
> > > +_require_xfs_io_command syncfs
> > > +_require_scratch_nocheck
> > > +_require_scratch_shutdown
> > > +
> > > +[ "$OVL_BASE_FSTYP" == "xfs" ] || \
> > > +     _notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"
> > > +
> > > +# Reuse the fs formatted when we checked for the shutdown ioctl, and don't
> > > +# bother checking the filesystem afterwards since we never wrote anything.
> > > +echo "=== syncfs after shutdown"
> > > +_scratch_mount
> > > +# This command is complicated a bit because in the case of overlayfs the
> > > +# syncfs fd needs to be opened before shutdown and it is different from the
> > > +# shutdown fd, so we cannot use the _scratch_shutdown() helper.
> > > +# Filter out xfs_io output of active fds.
> > > +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> > > +     grep -vF '[00'
> > > +
> > > +# Now repeat the same test with a volatile overlayfs mount and expect no error
> > > +_scratch_unmount
> > > +echo "=== syncfs after shutdown (volatile)"
> > > +_scratch_mount -o volatile
> > > +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> > > +     grep -vF '[00'
> >
> > Oh, the test steps are much different from xfs/546. If we move x/546 to generic/,
> > can overlay reproduce this bug by that?
> 
> Yes and no.
> 
> For overlayfs to support this as a generic test, the helper
> _scratch_shutdown_handle must be used and the shutdown+syncfs
> command must be complicated to something like this:
> 
> $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f
> ' -c close -c syncfs $SCRATCH_MNT | \
>        grep -vF '[00'
> 
> This is because overlayfs itself does not support the shutdown ioctl.
> If the test is moved to generic as it is we get an error when running
> overlayfs:
> 
>     XFS_IOC_GOINGDOWN: Inappropriate ioctl for device
> 
> because _require_scratch_shutdown is "supported" by overlayfs
> but only when the _scratch_shutdown helpers are used.

Yeah, I know this.

> 
> If the test is to be moved as is, it will need to opt-out of overlayfs
> explicitly.

I mean you have a "-o volatile" option test, that's an overlayfs specific
mount option. If you need that test, that's an overlay specific test, that
part can be an overlay specific test case. If not, we can use a generic
case (from xfs/546) to cover overlay and other fs.

BTW, we actually we have a common _scratch_shutdown helper, I'm wondering
if it works for this test? Likes:

  _scratch_shutdown -f
  $XFS_IO_PROG -c syncfs $SCRATCH_MNT

Can this work?

Thanks,
Zorro

> 
> > If not, I think we can have this overlay
> > specific test case at first, and "move x/546 to generic" can be another job.
> >
> 
> The reason I posted the overlayfs test is because for a while I noticed
> that we do not have test coverage for "volatile" mount option
> and adding this test coverage to this test was a very low hanging fruit.
> So I would like to keep the overlayfs test regardless of the decision
> about moving x/546 to generic.
> 
> Thanks,
> Amir.
> 

