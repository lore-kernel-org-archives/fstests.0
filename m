Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61316A395
	for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756968; cv=none; b=RVsp9W2lVflVrVmdeSDjI0o8yEkc1PcGOpIOnH0WOdZ64Da+z5yvVTvyEzUax9E5DH7gVwzVH74rhyOTUtUUbuabiz8AZ83YSV/02KD4m2z4o4VW7YZxlbFHf2ISiLQRlDc5WU+OV0kkRRIW6QDchoLPwN6MDtVo6ggJ83pbt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756968; c=relaxed/simple;
	bh=ySjC3Kacyyqqr2LjJ8mgi4dk6bil1EMNbIEvsbbxC7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlrGRe8iFC1eQTKzkPBSnFCgaKpjjPK3bkL3EVmfL+i2avSspKWqukjwheEWMeA+QMl1tInICdHRLNKogrUekF353Zxn9N9n/umlz46tDK4il+5qzjKo6H7KA66yWe1IX5eqaR2TvOv3JzUxgBL4jmpRDQmhmcKakNHe2I0OOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO0QPxrC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qhjhyrUU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO0QPxrC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qhjhyrUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768756966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EB+wqXLTENqzoyUnpDkg82jF7PKC0gnv1oGoBYtLAdo=;
	b=MO0QPxrCSgs5Dut77MCtkGTVWtT28ubm26KqdpanoVbgspiu9chf5OE7GxzRrq+E860KNG
	fJ6iDaPR6xLXMEGHsxitEoKvwUxeisjutACdnPzB4mipPNTnafYThcqkx1Duya0j42vx5i
	dSue29q7a/tijvXU2NUsv5B1PVQO7LE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-U9Kpev69NW-oWeah2KxlfQ-1; Sun, 18 Jan 2026 12:22:44 -0500
X-MC-Unique: U9Kpev69NW-oWeah2KxlfQ-1
X-Mimecast-MFC-AGG-ID: U9Kpev69NW-oWeah2KxlfQ_1768756964
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f25a008dbso24284425ad.1
        for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768756963; x=1769361763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EB+wqXLTENqzoyUnpDkg82jF7PKC0gnv1oGoBYtLAdo=;
        b=qhjhyrUU/2Vk0iCPQyiWx3XBTcMcSyKH3vXo3Zx5jhpZNggk89dSngfB5B2pg3RK3y
         9WzYUO1JZ+DCkJ4wPL0VRr19eYKhwg10v3qOiQvA5tfhoxdlfP1OYvWOWqCc6xdxPd+j
         w9Zsi55zD1NO2NJb4gkp4yvVGHlXf2aCzVMEsg/CpauNbMY3hmMPUQt+VAAnPr+Vs9DQ
         aXfxHgN6Vyi1gsV/mFKJ2+SQ/iusKOSXBBTNrVycWZb7N0wcOYorlzlfA4snVZvHGNqf
         TkHpZEZqaVUu+Rrqe2isM/P0qrw/0myNCyhanfAl3BoySzrIKtZcAT2UPj74lvtzHUYm
         lNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768756963; x=1769361763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB+wqXLTENqzoyUnpDkg82jF7PKC0gnv1oGoBYtLAdo=;
        b=nVCFxkZc2ryVE96vdKhmwaETVdaF2NwPLJ9XAA1SOgFTWPuYMkh3xzPF3qpvxbqZ1C
         /WQBDFtSeVe1NADn2HMCiB3Fjh5ayZAbmQ5a0tfJKsCzBAexk2JGhqNaZ3NEPF8MUb5J
         3uBAfTSL5Q+b//rjmDpKF0R3EV3jIPchMks+ZLmKE4x5SHlcutJyX5RqcRyts9wz/nIL
         s3IXH0U4dabt7UB05oBNztivZ9JFJSWUIF/8oIOaE5MEMcsg+gaURRlsUrlGjCUkYgw3
         lPNtK24MQFoqnGLaMOBPUIIpRpLC1umxdJcb6kQupPAkaO10rzh+ZyEMU3d0xPrEmHR9
         XnCA==
X-Gm-Message-State: AOJu0YxEEHDGjjC1VI7ybwUIt5GpZN0SKiDUf4x2wIdxw+O2hxOIapti
	Asm0/As4oUoDWBP41goQSv5IR32Tx590W1aiEg8QcwgaqygnQbnHT0z3f6ENotsc8UPtHPbmVNU
	giqcVu82znbCsqv3NcoDN775rPQwUw3J56u+89mZe3Stg+DzMEA2SwDnLeOU0XTKwxXY=
X-Gm-Gg: AY/fxX5JT+Vm+/z3XgMk/5IVDY2cLCucD69ZSRkcTO1zfYe+qcYWpsd6zKN6PRs2ND9
	kCJnx1g27IewRnu3KvJ+2l7AZCCcNbaPWEMiw3h6aStGU6prbCiQSy9qq9VC+ETo15z/SgKr55x
	s2PSLUy6vZwA23nVgaNV6M3suxv3QeCqNNOZteWIDQBRicpv0P4Xhq3HzuUZdL4nywwcX+n/Euz
	QgkYpOA6Rn0WAhAaqfETPGjXUzdI9yIKxNGnGjWTRDzuLGHTYuRoIVgtF6XMri5pxs9ht699zMK
	eucP0wOl6JZjF3pvumHSdRrACLfFhIKrIs8ayVBJ1aRDsJG5GI91u7MmbVNjS+3Lrqm0XZj0vMn
	ywia9PjpqsxMU5zl9AUV3Hm5UzsWlwznMKC0O6SAaR9MvS+QoAA==
X-Received: by 2002:a17:903:2343:b0:2a0:f83d:c321 with SMTP id d9443c01a7336-2a718896b3fmr78264555ad.23.1768756963069;
        Sun, 18 Jan 2026 09:22:43 -0800 (PST)
X-Received: by 2002:a17:903:2343:b0:2a0:f83d:c321 with SMTP id d9443c01a7336-2a718896b3fmr78264325ad.23.1768756962170;
        Sun, 18 Jan 2026 09:22:42 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fab79sm72540215ad.67.2026.01.18.09.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:22:41 -0800 (PST)
Date: Mon, 19 Jan 2026 01:22:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH v2] generic/108: fix test hand upon failure to create LV
Message-ID: <20260118172237.mezbn4rchgthtqdr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>

On Wed, Jan 07, 2026 at 04:07:44PM +0530, Ojaswin Mujoo wrote:
> In case the lvcreate operation fails, we don't catch the error and
> proceed as usual. The test then tries to wait for the LV to come up
> but it never does, causing a hang.
> 
> To fix this:
> 1. Add a check to ensure SCSI_DEBUG dev is of required size
> 2. Additionally, fail if there are errors while creating the LV.
> 
> Context for completeness:
> 
> This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
> of =m, causing it to create an 8MB SCSI debug device. This led to the
> lvcreate operation to fail with:
> 
>   Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
> 
> However the test never caught this resulting in a hang.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> ---

Thanks for re-sending this V2, this version looks good to me now.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/108 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index 4f86ec94..05d743a9 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -50,6 +50,11 @@ SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 $size`
>  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
>  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
>  
> +got_size_kb=$(_get_device_size $SCSI_DEBUG_DEV)
> +
> +[[ $got_size_kb -lt $((size * 1024)) ]] &&
> +	_notrun "Need SCSI debug device of size $(( size * 1024 )) KB. Got $got_size_kb KB"
> +
>  # create striped volume with 4MB stripe size
>  #
>  # lvm has a hardcoded list of valid devices and fails with
> @@ -60,7 +65,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
>  yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
> -	>>$seqres.full 2>&1
> +	>>$seqres.full 2>&1 || _fail "Failed to create LVM lv"
>  _udev_wait /dev/mapper/$vgname-$lvname
>  
>  # _mkfs_dev exits the test on failure, this makes sure test lv is created by
> -- 
> 2.51.0
> 

