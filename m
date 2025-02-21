Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C871FF7CC
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123635; cv=none; b=kmzk9ZKK5mfCssAOCc2FOrevOZS3wJXk05sU3FufTxOnOU+Ew3bv9R6Q26831LRVvn+lfQCXdSfWGVo6ToJlc82g9mT9IxkVb5scdo+O1qfitX17tIkJ9kSL3CUUZBvslQ7zIENrkWZg5rxzKtC50Ah+0jXxc7eDPR7/Bp9WqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123635; c=relaxed/simple;
	bh=F9em5c/IsvL/ssxaXMrUXlNqF9SlOYHQdrzjKHJTKs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3KLySAvx1Q2r3b7N3pGgycozzNG775VhYYjnL3pLjSl5BEqc+7taIF5gapAY9dApIWMatrx4HSKfL9KF4qYH+sIRjmKECc9Xes72zXM4rO2qY7kc7j2kCtZkAHKgsgRCm6X+C2CwwNvcAU9TGlUoeSlIa3f5YeIZXZwAg3gh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VAbuqSgI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VAbuqSgI"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso2749398a12.3
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 23:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740123631; x=1740728431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7QIoMV8b3NHnIzXgAtJmy7Iy9kOWxAtm72suSqSJEQ=;
        b=VAbuqSgIkSAWAriMNg7l70LmuAKTVzf6OhOmmkIGHdXO9zuAvDYP7yDuPZ+895x3X6
         OfmOXLsyTIwh5g08IAB8fCt562RhBlTE8Bv5TchiGcem+Bc0MOFR5iF2g8VBTFgZCdYp
         E/bUAOuu49HdTg3lyCLi1VU5FFjZEkKCROQEwwZyiCZ97hS/QR3HLJ5qHakR/ZBFCIQL
         FAPpOhmKwU0FcTmsQyi8ACPAbnzjrCsZPVb9Gt9pMPmfrFWBF3Dv7kX7jPP8eoWUSxsC
         /85qYhCHJoQirnCgVezduJEnKKEnqPSeEVXuL/dniFtzeSg2TcuSCUnOES7f/ijS+lnr
         bLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740123631; x=1740728431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7QIoMV8b3NHnIzXgAtJmy7Iy9kOWxAtm72suSqSJEQ=;
        b=Mzyk7W20NaiX9QN6vEgLbHNAlKGJGBA83RvUYuJzSty0+f7k9slbABGGIXjXmBYMGz
         X00OiIvClfCo+Go1mBzrGMQmBqJksa5hX464gz9jfttNkITH9xgQEj8pcmLou18bgZO4
         rk6SFNmSryBBh/n5vA59JtXurJwy9mSwkTzpibMOcCildESedTiUXkv5fVxVslzk2QwI
         UnPSacTOGvo0/dQyQdbgRFHJDPBgdLv/ixK9aZcke2Po1Z7ZRDUfrQdFzYgejRfwIzkW
         OqP4PJcAzQQq4pperiF3JoUruRmCB9+5SwmP5QidJR63H5sjJQDlUWXe9SKFldFBJS3o
         XVmg==
X-Gm-Message-State: AOJu0Yx6PpuEcqumMIBl1EX57U0Lx++JM+YKmQInqj4BQtKBqmOhEYvb
	gO0BWPZ7QAizMJpvoH5+wwmwjOWM6oO/RRsllPBWKi/LoOr1JGSlXHE7t2O/pkewyk1XKp9I/sN
	jrIJBcfzdQ6AfYswfJ2sEq+xDUrdV/PQDtQwBrbPUubsQGD3A
X-Gm-Gg: ASbGncvM9H8/7e234GbhWBRRZWjwsgw/usHg6koX1yRzLksPDsYZB0yXj6H4GpJ7cLH
	dCw9H7zCOFxAVdpHgaecXILnBIRCSX4AVptFYpZgB0nen3m7R1Fb+0jdVqmKUynANzSsLzB/MJh
	qp5kbZIg==
X-Google-Smtp-Source: AGHT+IGm9DcsqUF63IzY6q9Hn7t6gmR/2o5qjG59Ne37mELgsvSM8qBY0qfDqk+Oa/+5w0XWUbgG9qsw9PwqF+vGyis=
X-Received: by 2002:a17:906:30d4:b0:ab7:f2da:8122 with SMTP id
 a640c23a62f3a-abc099f0b31mr202230166b.3.1740123630809; Thu, 20 Feb 2025
 23:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
 <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com>
In-Reply-To: <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Feb 2025 08:40:20 +0100
X-Gm-Features: AWEUYZl3NrlB6A71sAyFDuafK3zhb4lMN28XT0STNlQ6BlH5f-25mLE-domIWTs
Message-ID: <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 at 22:54, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/2/21 08:06, Qu Wenruo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2025/2/21 01:27, Daniel Vacek =E5=86=99=E9=81=93:
> >> When SELinux is enabled this test fails unable to receive a file with
> >> security label attribute:
> >>
> >>      --- tests/btrfs/314.out
> >>      +++ results//btrfs/314.out.bad
> >>      @@ -17,5 +17,6 @@
> >>       At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >>       Receive SCRATCH_MNT
> >>       At subvol snap1
> >>      +ERROR: lsetxattr foo
> >> security.selinux=3Dunconfined_u:object_r:unlabeled_t:s0 failed:
> >> Operation not supported
> >>       Send:    42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/
> >> tempfsid_mnt/foo
> >>      -Recv:    42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> >>      +Recv:    d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
> >>      ...
> >>
> >> Setting the security label file attribute fails due to the default mou=
nt
> >> option implied by fstests:
> >>
> >> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdb /mn=
t/
> >> scratch
> >>
> >> See commit 3839d299 ("xfstests: mount xfs with a context when selinux
> >> is on")
> >>
> >> fstests by default mount test and scratch devices with forced SELinux
> >> context to get rid of the additional file attributes when SELinux is
> >> enabled. When a test mounts additional devices from the pool, it may n=
eed
> >> to honor this option to keep on par. Otherwise failures may be expecte=
d.
> >>
> >> Moreover this test is perfectly fine labeling the files so let's just
> >> disable the forced context for this one.
> >>
> >> Signed-off-by: Daniel Vacek <neelx@suse.com>
> >
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> > Thanks,
> > Qu
> >
> >> ---
> >>   tests/btrfs/314 | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> >> index 76dccc41..cc1a2264 100755
> >> --- a/tests/btrfs/314
> >> +++ b/tests/btrfs/314
> >> @@ -21,6 +21,10 @@ _cleanup()
> >>   . ./common/filter.btrfs
> >> +# Disable the forced SELinux context. We are fine testing the
> >> +# security labels with this test when SELinux is enabled.
> >> +SELINUX_MOUNT_OPTIONS=3D
>
> Wait for a minute, this means you're disabling SELINUX mount options
> completely.
>
> I'm not sure if this is really needed.
> >> +
> >>   _require_scratch_dev_pool 2
> >>   _require_btrfs_fs_feature temp_fsid
> >> @@ -38,7 +42,7 @@ send_receive_tempfsid()
> >>       # Use first 2 devices from the SCRATCH_DEV_POOL
> >>       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >>       _scratch_mount
> >> -    _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >> +    _mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]}
> >> ${tempfsid_mnt}
>
> The problem of the old code is it doesn't have any SELinux related mount
> option, thus later receive will fail to set SELinux context.
>
> But since you have already added SELINUX_MOUNT_OPTIONS, I think you do
> not need to disable the SELINUX_MOUNT_OPTIONS.
>
> Have you tested with only this change, without resetting
> SELINUX_MOUNT_OPTIONS?

Yes, I tested both. Actually resetting this option was the first fix I
came up with, that's why I kept it. This option breaks the test case
when SELinux is enabled.
But then I figured the other way around (using the option consistently
with all the mounts) also works. So I added it for consistency.
At that point, resetting the option is not really strictly needed
anymore (as you correctly suspect).

So there are two possible solutions. Each one makes the testcase 314
pass. But they can as well be combined.

Anyways, this test is fine without forcing the default mount context,
which is more a bandaid for other fstests, IIUC. There's no need for
this option in this case, at least with my testing. Hence I disabled
it. Does it fail for you?

> Thanks,
> Qu
> >>       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo |
> >> _filter_xfs_io
> >>       _btrfs subvolume snapshot -r ${src} ${src}/snap1
> >
> >
>
