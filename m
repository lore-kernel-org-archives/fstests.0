Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300261D5CC6
	for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760546; cv=none; b=KqAU/AEMMLRRWsuAu0YZf8yYCndW+vXZWXmr++7zcZqerRmSDXaL6acIK3KYyyMlbcggidxiHeAaB3JBH0f11yIgTlMMNZw7GJ3z1dIPcF7tFXiXhhGqF5aO05N0aXczEHZFiE10EodcZwpzLPnaCTtMbGpgk/Xj2l3zyXtbBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760546; c=relaxed/simple;
	bh=PXRnTimARoXdGjf8tptxGLTR52Lp6+O3zvN3t5spgqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAV/k9efuO70dZKZqInJiphjAfyVq7kz/dMKaGjeKA2JPoGcXwlHXS3sgZst5ICEqIn1w+cacMt9GUG6qVd2z3RFa4lWoFMeeVgtmRT+XfxOydn1HMtoHif/PJqvyjYsj/gieyrIXF654Yl7R5Qk+atrGHL0AIA1kvxORKYEG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQncmOez; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nUPCeOw8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQncmOez";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nUPCeOw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768760544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3cPznKhxLcPOEDJuE6PYris9P+09IQN560sSkeVya4=;
	b=SQncmOezbydyhpGkQy5tozhPwXjphJWqXe8LgD/5abE93CwmLyB+FFdBEuzHLtvkUba7Qt
	4NYqk6mto9t7TjiM6rf6CYzxzJgBRZopScfYCvlIGGb2QkMHVLrmQdSuz2fu5STlBzmLQw
	QhmQkDQjLMzm8jsnL87Zap48iZ/sj0k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-YxEN3n1JOdClASom4FaSdA-1; Sun, 18 Jan 2026 13:22:22 -0500
X-MC-Unique: YxEN3n1JOdClASom4FaSdA-1
X-Mimecast-MFC-AGG-ID: YxEN3n1JOdClASom4FaSdA_1768760541
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f46844106so3629483b3a.0
        for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 10:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768760541; x=1769365341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3cPznKhxLcPOEDJuE6PYris9P+09IQN560sSkeVya4=;
        b=nUPCeOw8nfmuGJOG+4uxP6QQO0Bg/2TBoxEGOvqXTR89umPo8otKeIiE4tIt6lDx+m
         /4PTvmidqS5kHwA8A+JLnHPS2mjJIb9BYz39uUjZgdmsbnViHfqF6Z/LMqwo1fhR2KWK
         03kWhP/yoZIVke/Zr5AIJlGflJm743jgj3xMs+/EpHFxv0finz1bA5MUoCfqJMFLZbNb
         ncIG1ejioyTjPXu6N88fng8fktJRkVFW38RSvHtxGR/yVML7DX5aPZwAxow9rU5lmyA3
         57jjqY8DENYVLBVWBwbAxVViHgJboZsgcKLTCrLnBZQnE74RXXthmcAhIXXyEh+mLAUB
         l0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760541; x=1769365341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3cPznKhxLcPOEDJuE6PYris9P+09IQN560sSkeVya4=;
        b=tLV+mylqH1nBxssZNrdCwiuUK6iFDoH4V6evqZlC9skUz/T8j5NnxCbeJqmZrOl2tm
         xg+VslufUhHnmwFU/k5t9CRJNMCt3z6HtPINfpOO/VcPsE4tt3SkGdoI+oS4j+/dTtzE
         R8ih1XRkiWO8Pf6WqoyCOaO3XbC5wGQCIu1B+7FpWC60Qwdse8N2XLO1xN3hbTmV4B4z
         pODiLauH1IYBHuAGs2tQ3F2v68/ro4AFwZgc1as/zZTxQGboGJUdz2ev+8idWa23RnX2
         hT0dw5Ye1e6c/HNg1hSCAbtbAFV2vXmboNOBqwnnmZoQUOsRRiY7JHDFM+wyGKpwXWVL
         IbzA==
X-Forwarded-Encrypted: i=1; AJvYcCU/VEAqpvB5OKfGaD4se3PY1S5+r5uFask2+/xwkWl2uxDPBFE1RqgnvauUmn9W3ABDB3+LL48r@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFds3iEytgg9ahkaPGTRe931ePSbPUJcaS4UlcPXA9hn72UTC
	dRq5qr7ew+Io3fOCr8+oZSpBrnx1joxOGOU8/wagS8Ur4h53wJhup7E9jt7oweS+Pf7oG4fXaTi
	nJkz188QqrjpRbSMbKmVhDtfsvGTARw+PmilAs5YomR+c0sTgr6ONjagoPTM=
X-Gm-Gg: AY/fxX7y9hxqpi19wRwutAryt39vFdwBoXIFN+ucnTa374uqfJmx0TKIWfcq4mlVxd6
	4z5N+DLTePbbHM+XOWhsG9ySr1vJULUb31MsaWFmPxCXT6857cpG32w4uxcXlLjy0mGOD+eJkdX
	oF7EaqETdK2/hdNHn9g/OHTEwkQSCCBPUaLRbkXUt/pOtDX0sXQRFaHoiA2SWG0WDX3SEUXho0M
	7lJ9r+SkEDd5CC4Anxqa+7a6xA4ELoBEwZ9FsO0snA25DjZ/8jfxcpe4BqpGsK0AT/HLo8t8bGh
	D4bLVN8jE+3a/JCBQzkK9b6T0JZOwpe1wPhZECPgR+dejC+Ui/OmYgmm3fM7BkCHm09b0S9hEO+
	GwfnSoV9kn8YbmvLutonrdCERZiPmGwWSmIgoeEsPjuXYv1NfYg==
X-Received: by 2002:a05:6a00:2d17:b0:81f:4fda:1f87 with SMTP id d2e1a72fcca58-81f8f011a6fmr12085884b3a.8.1768760541195;
        Sun, 18 Jan 2026 10:22:21 -0800 (PST)
X-Received: by 2002:a05:6a00:2d17:b0:81f:4fda:1f87 with SMTP id d2e1a72fcca58-81f8f011a6fmr12085865b3a.8.1768760540651;
        Sun, 18 Jan 2026 10:22:20 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278056sm7141967b3a.34.2026.01.18.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:22:19 -0800 (PST)
Date: Mon, 19 Jan 2026 02:22:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	fdmanana@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org
Subject: Re: [PATCH 1/4] generic/371: Fix the test to be compatible block
 sizes upto 64k
Message-ID: <20260118182213.sfd4k6zq6olmf6ez@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>
 <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <b3d93d75-9c39-44ac-9c7e-0346b3a970cf@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d93d75-9c39-44ac-9c7e-0346b3a970cf@gmail.com>

On Mon, Dec 15, 2025 at 10:34:14AM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 11/1/25 17:06, Zorro Lang wrote:
> > On Tue, Oct 21, 2025 at 02:27:46PM +0530, Nirjhar Roy (IBM) wrote:
> > > On 9/26/25 22:07, Zorro Lang wrote:
> > > > On Tue, Sep 16, 2025 at 03:30:09PM +0000, Nirjhar Roy (IBM) wrote:
> > > > > When this test was ran with btrfs with 64k sector/block size, it
> > > > > failed with
> > > > > 
> > > > >        QA output created by 371
> > > > >        Silence is golden
> > > > >       +fallocate: No space left on device
> > > > >       +pwrite: No space left on device
> > > > >       +fallocate: No space left on device
> > > > >       +pwrite: No space left on device
> > > > >       +pwrite: No space left on device
> > > > >       ...
> > > > > 
> > > > > This is what is going on:
> > > > > 
> > > > > Let us see the following set of operations:
> > > > > 
> > > > > --- With 4k sector size ---
> > > > > $ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
> > > > > $ mount /dev/loop0 /mnt1/scratch/
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
> > > > > 
> > > > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
> > > > > wrote 83886080/83886080 bytes at offset 0
> > > > > 80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)
> > > > > 
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
> > > > > 
> > > > > $ sync
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M   82M   95M  47% /mnt1/scratch
> > > > > 
> > > > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
> > > > > wrote 83886080/83886080 bytes at offset 0
> > > > > 80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)
> > > > > 
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M  137M   40M  78% /mnt1/scratch
> > > > > 
> > > > > $ sync
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M  162M   15M  92% /mnt1/scratch
> > > > > 
> > > > > Now let us repeat with 64k sector size
> > > > > --- With 64k sector size ---
> > > > > $ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
> > > > > $ mount /dev/loop0 /mnt1/scratch/
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M   24M  175M  12% /mnt1/scratch
> > > > > 
> > > > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
> > > > > wrote 83886080/83886080 bytes at offset 0
> > > > > 80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
> > > > > $
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M   24M  175M  12% /mnt1/scratch
> > > > > 
> > > > > $ sync
> > > > > $ df -h /dev/loop0
> > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > /dev/loop0      256M  104M   95M  53% /mnt1/scratch
> > > > > 
> > > > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
> > > > > pwrite: No space left on device
> > > > > 
> > > > > Now, we can see that with 64k node size, 256M is not sufficient
> > > > > to hold 2 files worth 80M. For 64k, we can also see that the initial
> > > > > space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
> > > > > because of higher node size, more metadata space is getting used.
> > > > > This test requires the size of the filesystem to be at least capable
> > > > > to hold 2 80M files.
> > > > > Fix this by increasing the fs size from 256M to 330M.
> > > > Thanks for this detailed explanation. As this's a ENOSPC test, so we
> > > > must make sure this case still can uncover the original bug, before
> > > > increasing the fs size. Can you make sure that? Or maybe we can replace
> > > > that "80M" with a variable (according to "Avail" size).
> > > Hi Filipe, Zorro, Wang,
> > > 
> > > The original commit message of generic/371 says that this test catches some
> > > excess space usage issues. Is(Are) there any patch(es) that fix this issue -
> > > so that I can remove the commits and check if the test expectedly fails with
> > > slightly large fssize i.e, 330M?
> > > 
> > > I did find some related commits [1] and I ran the test with 330M and
> > > 256M(the default size) after removing the commits[1] but the test passes
> > > with both the filesystem sizes. So I am guessing, this is not the patch that
> > > can test generic/371.
> > > 
> > > [1] https://lore.kernel.org/linux-btrfs/cover.1610747242.git.josef@toxicpanda.com/
> > Hi,
> > 
> > I'm not familiar with btrfs patches, but from the commit history, I suspect
> > it *might* be related with below commit:
> > 
> > commit 18513091af9483ba84328d42092bd4d42a3c958f
> > Author: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> > Date:   Mon Jul 25 15:51:40 2016 +0800
> > 
> >      btrfs: update btrfs_space_info's bytes_may_use timely
> > 
> > Or "c0d2f6104e8ab2eb75e58e72494ad4b69c5227f8" :)
> > 
> > Thanks,
> > Zorro
> 
> Hi Zorro, Filipe and Qu
> 
> Thank you for the pointers. I tried running the test reverting the above 2
> mentioned commits, but the test seems to pass without these commits, so
> probably these are not the ones. I am not able to find any other relevant
> commits and the test case is also very old. Any further ideas?

Thanks, I don't have any objection on this patch now :) As this patchset still
has unresolved review points from btrfs list, I think you can change and resend
this patchset to get further reviewing.

Thanks,
Zorro

> 
> --NR
> 
> > 
> > > --NR
> > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > > > ---
> > > > >    tests/generic/371 | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tests/generic/371 b/tests/generic/371
> > > > > index b312c450..95af308e 100755
> > > > > --- a/tests/generic/371
> > > > > +++ b/tests/generic/371
> > > > > @@ -19,7 +19,7 @@ _require_scratch
> > > > >    _require_xfs_io_command "falloc"
> > > > >    test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
> > > > > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> > > > > +_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
> > > > >    _scratch_mount
> > > > >    # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > -- 
> > > Nirjhar Roy
> > > Linux Kernel Developer
> > > IBM, Bangalore
> > > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 

