Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B552620F9
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726136; cv=none; b=pdOwzmxLWBL30sUBMp9M25Syxrtn4fcZr7xd3ymVP/++qMkk3DhxsV5RkvQuFXh/bsg3wkv1O77UMGK8uTt1zhKZYRS6Xzly70QCYQJ+w0hY+0dZro0YdQCDSnymiRGyx/ZlM7jsSia/ki4OSo2XN1JuWzAPVs19pGRHnbQNeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726136; c=relaxed/simple;
	bh=k0jrNNW6g+Emfc/5qu2lpVME5kRHpft6PLjRejKGpRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/+5yNm4T1A0pB7yRh1fMogr0khYNvWkGCKRIAPODio+phpogT7fgBZR4c2YRGXTUN7I61xDzkDPCgb2PsvXfab2vjkBmMoX4YvCekCRzxuysJRerP7FTeXIE9VpL8rcaqVynVq5llP6cWpZZ3xwEht/PkcDoO/Jh7CZ4Cp0Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Jj2IeGrk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Jj2IeGrk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225a28a511eso15785785ad.1
        for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741726134; x=1742330934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A41jK0hv/dY/20SIs/rShB67Ygs4/TeS4b/uxOa4UG0=;
        b=Jj2IeGrkd0eFZpfCLl8MrARQgpCCh9gIRkm4yb8cSAMnJkdfMGOPCuDDkRQGnVzFAL
         boOYg1WYce40vcZHi9NrgG3KHv69I2zWzMt0QTYIwtjM1arLGfXQ/ciQ7+Doqe3oJuu1
         XZsVSC4Tp8que+/fU7I90mju45d4CdyzQ2tqGKz2KqrdjNpu09O+u517lk6E2xY6anX5
         uq8VKhFJ8VjaxmmNdMz+8I/xX7PJ+KVND8njzShWtPk042FfgHYsU17OTjHtgEZbWv9h
         tyiPAiSeZDvySfVfGe4p1UKQ5rKGcSH+Ih++7STXKM7jFzr2PumvCZjQk1+GHa7kdjTU
         JQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741726134; x=1742330934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A41jK0hv/dY/20SIs/rShB67Ygs4/TeS4b/uxOa4UG0=;
        b=mlg8coE0DXhcryNuH7UhQ0coTHwU53LKMln1kkogVfS6ghFs6NahWS5O3wyLJFtAHp
         jnCeF7iMXuumo/SkjNXoIHUX0jZDSqLaRi4QLwaWWTwWGcPZxgF0KB72PgjXm27JZtaf
         lAoU3EemU6p7yRkA4vj8nWUqhjcNguy7lFQzZD8Zhc1YdrSgZbb8YdxnylQgty58LvoB
         caQyzmIKU43BD1+2uZcgPukGgYeGEqFplBxZG/YhHsJ877ZpJ77D1RW7pAfLAHdMb+Ay
         zF8nQKmrQXCHCPsF8OcaAUY5SP+NS0wIYwz+v8328D7plG2qAmR4qeFXzapa5lD3ZWMV
         oHeA==
X-Gm-Message-State: AOJu0Yxwg3ChTKFITzwSKD8LoFAu6pKKw5LoDclaa9wFgCHmsMbDP7ac
	liyGAuIUmYTkn09tkyvZHyqH6WLm2tZJCo7O9nGvmHZW9qAA+0jlnigAytUWqkM=
X-Gm-Gg: ASbGnct/QBUDFDoI8ELApg8cgitbuvXU9EGXBXj3fqflf9pfpUd1lKWLZV7kMsW+pnL
	9X+1TRcdG/cGf94Vv/1y4RZktE14O59bzvUIDevXWbejJWzlPjlUXym7ykGtu5r2onL4lQhbp1g
	jxiLmhfLKufTfXHezKamBV+oTRubXcULhggPiAjHe65BAq7E3AXyjb2vS0Qztc/duiy6HGC6x2v
	srApEn0PIeMHXyLBb+YwiIlHxVm8h7RR6qTWaFplMoQmZX8rMYip98l4Q1v2hqfp7JBLxX/kuza
	dKF2vgcouGsI0DiWy49BRSXf0bUc9A7TS3QtLYZFlTJPFLHoRcdsVOntQP6tQGq6pLf6WEUqwKB
	DPNMfjoRa9rNfFBLIoVAc
X-Google-Smtp-Source: AGHT+IFBjv1Buu0qgRkjiUUYSCI3OqA4JVRqIb9TLkr8uU7XvCY2VDQ7FKHF0oIb+eaWUWi/ymo3FQ==
X-Received: by 2002:a17:902:e750:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22428be5a43mr273882875ad.39.1741726134518;
        Tue, 11 Mar 2025 13:48:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7fc7csm102894615ad.120.2025.03.11.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:48:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ts6Wx-0000000Bs8e-0jNr;
	Wed, 12 Mar 2025 07:48:51 +1100
Date: Wed, 12 Mar 2025 07:48:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Subject: Re: [PATCH] f2fs/008: avoid endless wait
Message-ID: <Z9Chs5qdOg7rXevY@dread.disaster.area>
References: <20250311050346.5868-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311050346.5868-2-ddiss@suse.de>

On Tue, Mar 11, 2025 at 04:03:47PM +1100, David Disseldorp wrote:
> "udevadm wait <dev>" without a --timeout=SECONDS parameter will wait
> endlessly. Endless wait can be triggered in f2fs/008 by e.g. using a
> zram device as a SCRATCH_DEV, where "device type is unknown" failure
> sees the /dev/mapper/$vgname-$lvname node never appear.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
> It might make more sense to add a default timeout to _udev_wait(), but
> that could also call udev{adm }settle.

One of the points of moving to _udev_wait was to explicitly wait for
the specific device to appear or disappear, indicating that the
previous admin operations have completed. 'udevadm settle' does not
do that - it waits for the global queue of events to drain and
dev config failure doesn't generate udev events.

Hence tests that silently fail dm/lvm device setup will continue to
run on something they shouldn't have, and nobody will realise that
the LVM setup did not run correctly.

OTOH, _udev_wait() will hang in that situation because it's waiting
for the device node to appear (or disappear) so it can be
immediately used. We don't need udev to finish draining queues - we
only need to wait for the device node to appear and the test is good
to go.

This behaviour provides obvious failures when device setup/teardown
fails in some way. This should not happen, and when it does
_udev_wait hanging forces that failure to be triaged and fixed
immediately....

If we add a timeout to _udev_wait(), then we're back to the old
behaviour where device config failures get ignored and the test runs
incorrectly. Except now it is worse because we have to wait a
timeout before the test is then run....

> 
>  tests/f2fs/008 | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/f2fs/008 b/tests/f2fs/008
> index 47696f2b..fdb0b0c2 100755
> --- a/tests/f2fs/008
> +++ b/tests/f2fs/008
> @@ -35,9 +35,12 @@ _cleanup()
>  	rm -f $tmp.*
>  }
>  
> -$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
> -$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> -$LVM_PROG lvcreate -y -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
> +$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1 \
> +	|| _notrun "unabled to create LVM physical volume"
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1 \
> +	|| _notrun "unabled to create LVM volume group"
> +$LVM_PROG lvcreate -y -L 1024m -n $lvname $vgname >>$seqres.full 2>&1 \
> +	|| _notrun "unabled to create LVM logical volume"

These should be _fail calls, IMO.

AFAICT, there is no reason for LVM config to fail on a valid block
device.  If there is a block device that doesn't support LVM, then
we've got lots of tests that are going to fail the same way and we
should have a _require_scratch_lvm() to notrun those tests for that
type of block device (or fix the block device...).

-Dave.
-- 
Dave Chinner
david@fromorbit.com
