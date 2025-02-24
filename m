Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4E1A76AC
	for <fstests@vger.kernel.org>; Mon, 24 Feb 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378668; cv=none; b=cDQQ5k+tHOgCMzAHCAYqga+ECzbYB1gZ6RKjvxq2sfEhw3KV1NIosG1ZUsaHFFvC1RFnvUGwllXIu7sKIsEBTaJ/nwRpDBJ7DwASwX9gTy6W0q2hqVF8B8ByR2OMIa85R7jEBUiYHF/9ZXE8Z8Yteu391iWMYGhGXFn/lLnPVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378668; c=relaxed/simple;
	bh=E1dIoHlKR/agJWLj3cGql40S1z8U1XpRW7oPQEEghfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+EIQHq/gCbUUlYrGuQhbJgiVpivoQA0LDJVOR6Y6eswA01MR25bKzi8PJ9eSX6SMy/QDntLJYlnJYRQRtITUeHqltpxSi+mQ3nFVjEM8vtcQwRPsDWB2ihV0V4QujORvVTLTpjfeWo0EfaL9NWpfRb6xt1Ddg80Sgm+koA3j8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bNYLekPp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bNYLekPp"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbb12bea54so720877466b.0
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2025 22:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740378659; x=1740983459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq+wki+MqXy/nndMCRwVQpc+5nJChRMlyfSHUzsL4QQ=;
        b=bNYLekPp3ysF/pkSf8RxamAoXTSobHaZR1rqeG/3h/ZUITEBjqo+Gb5mNlqb8Y3VCI
         fH0OSvrf05jkEoywUgJMbzR5Xh90xkZAyhpXFrn51jkjvW0W6mNyvgk5AGNz9f6J3HwG
         oAABiNXHpsc+HEU98aYFe61vcJcW497BeRQxGfFMZujzvMyCwchnxBtYV3vj3EA+b2Pu
         tHhIxKPWO7N5wI56wdwT0eDSYWUf4rz7idI80uOa0Jzb/yt0zY+lTqS8795HoXZKV01n
         Gp7QFPVbnW+b6jfuiCclNQlyD4CXvIHl9kG8JzXGcxPxXt8G/6KPBxafPPSakt3MVXZo
         wCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378659; x=1740983459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aq+wki+MqXy/nndMCRwVQpc+5nJChRMlyfSHUzsL4QQ=;
        b=S4qnG20AOUNGUIqSJWdnA46x7aQMiF1xRR209PzjMQvPD/92PlstUTRv4NCzXTr8Yv
         SnuydJov6FuBunNr+UVELktRQgt151DgTmHLRmnOQQFDk7lTzdrpPGyBObe5UeuLnEbN
         TxocejNcFuwgGfLYxeEBfQOYHlI8kOCOYwOrkzK1Ujei3GbkaQEIWbAXzX1l1Q3mGtoI
         FnW9eTFNkYJ5cZDrA147qvxmdMlrWg6ZlPuncpDa4RQVPfE3MzQXtDf8STHH/Zz3sPvE
         F3HLVnZj2sLQNqlioGJvdUAFi9iVA58TosuUnmcbpUEBWr0pO30ArP4zYZsg1BOZ1nLp
         xFtA==
X-Forwarded-Encrypted: i=1; AJvYcCWcIICe2QVewcCIVAPii1THgoyC81KrJIDigHP2hlsU1aHHFSfIxtTwddc3qqimnN0gpVnnL3JM@vger.kernel.org
X-Gm-Message-State: AOJu0YynDAm3zaPpGx371lRZWctzammBRZcdsXTXVMmsWvk/ZlgbAgjO
	wlb51HX6lnLcw+5Lis8YXqHZHLtiES+vlK76jU6UMHdl9mhLPEOJik7gMKPm4m+v3Kzxt0YSjBk
	OOCg7j/T9AMFdyeP6gzg/mdYrWuxeDvLvh4dDrMetO4u0Prtp
X-Gm-Gg: ASbGncveq6RzU7vyRzaQ/8F94Znkbc+EKaKyiYBc66rysynpU9b3mTBmzEM4zNDjKkJ
	FxJtfcQt+d/YRH7cbb8A92B2i48/NRcMTQfq5a1hNGKr6jAcH43vgOcST/QMGAdTXFZPNJEj1+S
	ioiyYOHA==
X-Google-Smtp-Source: AGHT+IFANUpl9PA24M96TCMpL3ASx4z9pMNb8ptEXkRZZYKabRXkwYX/5xYx9bv/y9Bn91SAl7DaCt3y+JqPPxhv1FQ=
X-Received: by 2002:a17:907:970f:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-abc09d2dcc1mr1280389266b.49.1740378659424; Sun, 23 Feb 2025
 22:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 24 Feb 2025 07:30:48 +0100
X-Gm-Features: AWEUYZkpzLQ7FCiwksIzEvMHAdiGua0Ki_0J-oKEt5dRO4_DBgZicOeGKk6Bah8
Message-ID: <CAPjX3FdRuUzq7L_ZoWMt3WctLBAZbGPhSjio+bXpYM7KF+T3mQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 09:38, Zorro Lang <zlang@redhat.com> wrote:
>
> On Thu, Feb 20, 2025 at 03:57:23PM +0100, Daniel Vacek wrote:
> > When SELinux is enabled this test fails unable to receive a file with
> > security label attribute:
> >
> >     --- tests/btrfs/314.out
> >     +++ results//btrfs/314.out.bad
> >     @@ -17,5 +17,6 @@
> >      At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >      Receive SCRATCH_MNT
> >      At subvol snap1
> >     +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
> >      Send:    42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
> >     -Recv:    42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> >     +Recv:    d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
> >     ...
> >
> > Setting the security label file attribute fails due to the default mount
> > option implied by fstests:
> >
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> >
> > See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> >
> > fstests by default mount test and scratch devices with forced SELinux
> > context to get rid of the additional file attributes when SELinux is
> > enabled. When a test mounts additional devices from the pool, it may need
> > to honor this option to keep on par. Otherwise failures may be expected.
> >
> > Moreover this test is perfectly fine labeling the files so let's just
> > disable the forced context for this one.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
>
> Take it easy, Thanks for both of you would like to help fstests to get
> better :)
>
> Firstly, SELINUX_MOUNT_OPTIONS isn't a parameter to enable or disable
> SELinux test. We just use it to avoid tons of ondisk selinux lables to
> mess up the testing. So mount with a specified SELINUX_MOUNT_OPTIONS
> to avoid new ondisk selinux labels always be created in each file's
> extended attributes field.

Well put. I was trying to explain that.

In fact it does not mess with this test and that's why originally I
kept it and I did not remove it after coming up with the other way to
address the bug. I thought a bit of diversity could be useful with the
testing after all.

> Secondly, I don't want to attend the argument :) Just for this patch review,
> I prefer just doing:
>
>           _scratch_mount
>   -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>   +       _mount $SELINUX_MOUNT_OPTIONS ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

I already agreed with dropping the other hunk before.

> or if you concern MOUNT_OPTIONS and SELINUX_MOUNT_OPTIONS both, maybe:
>
>           _scratch_mount
>   -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>   +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

That's even better. I'll send a v2 with this change.
Thanks for the hint.

> That's enough to help "_scratch_mount" and later "_mount" use same
> SELINUX_MOUNT_OPTIONS, and fix the test failure you hit.
>
> About resetting "SELINUX_MOUNT_OPTIONS", I think btrfs/314 isn't a test case
> cares about SELinux labels on-disk or not. So how about don't touch it.

Yup, as I said, I already agreed with that in the previous conversation.

> If you'd like to talk about if xfstests cases should test with a specified
> SELINUX_MOUNT_OPTIONS mount option or not, you can send another patch to talk
> about 3839d299 ("xfstests: mount xfs with a context when selinux is on").
>
> Now let's fix this failure at first :)
>
> Thanks,
> Zorro
>
> >  tests/btrfs/314 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/314 b/tests/btrfs/314
> > index 76dccc41..cc1a2264 100755
> > --- a/tests/btrfs/314
> > +++ b/tests/btrfs/314
> > @@ -21,6 +21,10 @@ _cleanup()
> >
> >  . ./common/filter.btrfs
> >
> > +# Disable the forced SELinux context. We are fine testing the
> > +# security labels with this test when SELinux is enabled.
> > +SELINUX_MOUNT_OPTIONS=
> > +
> >  _require_scratch_dev_pool 2
> >  _require_btrfs_fs_feature temp_fsid
> >
> > @@ -38,7 +42,7 @@ send_receive_tempfsid()
> >       # Use first 2 devices from the SCRATCH_DEV_POOL
> >       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >       _scratch_mount
> > -     _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > +     _mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >
> >       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
> >       _btrfs subvolume snapshot -r ${src} ${src}/snap1
> > --
> > 2.48.1
> >
> >
>
