Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DB225A8
	for <fstests@vger.kernel.org>; Thu, 12 Dec 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970002; cv=none; b=D2FDV2saYpvIH3pQMMDZkW667+pYToFhmZqBUW4cQ456kP7wPQlV2xoFAGjjAn/9XTlFkks+MhvLL22JdD3YvSFXkPQiDdmU91JUwFx/4mKVCqVWkYsFl8PBgAfxJbWw6CsZEctXdJkih8n7A6IygT/7gWi8QPTIkknXCKjMpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970002; c=relaxed/simple;
	bh=S0EDgkYsiyPmmDC12n66dsllmz9LMQdGdGrhoed4Sgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJk6JY0P2xKgsdopndZE3LDsB5IkFEpix1nykRSWZbFRtlQOdTHAGHMQWtBaiW89SWsT5RlobafSRqKa6cS0Q/IzlYL4XBBYeQ7o9oJFbbTD6Gw1WTbfuhd2z/Gynr8ooncEFcjRvYHFmiPTXwl1pXg1wuC3/mOG6vxvNpbwyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Lm5itotk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Lm5itotk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725c86bbae7so87907b3a.3
        for <fstests@vger.kernel.org>; Wed, 11 Dec 2024 18:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733970000; x=1734574800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cigsmpcKu5f2evl4ng/5xeFHMT7REAuLtPvFFFok+Xg=;
        b=Lm5itotk5Aczd8Czaf73aeH29is/KbPPrmQ/x20Xl+FaAvz5XaHp5a2jQZzQpzo1yp
         4B/cqYDndT4xjgZCV+cMH7ySgjJVtmyc6IEfAoLEwsf4EWnlnqRJA5Tu13hrXGOZN0k0
         M8AQtcq3VEEbcbtPaFh3AbdgOh92g7eICpkIhLndGpGTnxcNGkcGmn25Y7CViXnS6q/x
         TlgrNs93+jc0MHHQrPftC0qqfPNmxgE0eQ5KCCb6one9NltS6BLl6KG4dIhf+i9n33br
         AexZfUkyNX0cU/kksmEqbUNUYAPd17PhchX1pyppreDOcwPrph9dLhnr9OxuFjRe2kPH
         w50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970000; x=1734574800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cigsmpcKu5f2evl4ng/5xeFHMT7REAuLtPvFFFok+Xg=;
        b=jsazJ9G/YUwCsgPkHGcf/z3Uzw3tao76Zbx9Ax8E7Y8JXujB6fWjII1KKX/BYjnhfL
         DtqTTE9ROP4s6v6Y9P5bPM3BC4w7J5auY4DaM0zk5Ibl/nrJHs+feELXQdf/ZoNbZ0YH
         siE8HTzJm8kk1ni+ngAtpNx8DwFALXUuNw3CMRkfQ6ju/drs6tSAEHYYHK/7RwD0EBrw
         uay0H9Ha10fiqucWCKuW/8EsfyQi/bgWdyyV1VKYSMGdwI7YKheG9jlTgUUhFyWulZ87
         5ew4t8RR8Cyq474zkWEzBsyEVkQTrWTjPZVj/1MyOTcGYsljAoKwp6ia70Jl2HjzpgaJ
         v65w==
X-Gm-Message-State: AOJu0YzUqHPq08CzzXMTjico53NOYsXlgiWbXg1dd9MWvUxhNCEqNXn/
	BIXYXOzy77h+wp8QcAfa15muih6f/h3Z+DCj/aEdMU/zYat5DwMPUeF12Xdgm1k=
X-Gm-Gg: ASbGncs4lTKhLzExEzVFx2kvywPBvpj32ncflSh2wHOe+9g58llOrS+RYDLlCFqaODH
	y0nsThxZfYrz29bfPRfiQRpOgtJFar76K45AMVbyrZMX3YvWX+ukoSoRLZt1GUrc9pafKBJju1w
	rR0HtCq5sbB0ftnhgKeHd7S9ctHEOYuS0s3wJwb0iuKUei5dcL9T/L23leOVjP9AwfNGuShnhAg
	lMZ1XYKyZCVNArpokC/UjrfwoNhhTd57aIIxSMpzLwbf7x9A6Pm6UcH+ZdtSIj/6rYJFQdGEKP6
	Cx8NQIMz9/TU6rnQfQM=
X-Google-Smtp-Source: AGHT+IHaQ1CKpfB1isgorB9dmqXH1ozYb2ocfno8yZsmgtYnel5ThZjLIus4e4VrpUynG5vcqq3MkA==
X-Received: by 2002:a05:6a00:3cd5:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-728faa09f09mr2546097b3a.14.1733969999643;
        Wed, 11 Dec 2024 18:19:59 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd443135d7sm5819151a12.61.2024.12.11.18.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:19:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLYo0-00000009dBU-1NWQ;
	Thu, 12 Dec 2024 13:19:56 +1100
Date: Thu, 12 Dec 2024 13:19:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	dchinner@redhat.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/590: fix test failure when running against fs
 other than xfs
Message-ID: <Z1pITJWBnXvj9DeB@dread.disaster.area>
References: <bcb3d3adeb36c732e807d876b82219c3c1350e2e.1733914512.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb3d3adeb36c732e807d876b82219c3c1350e2e.1733914512.git.fdmanana@suse.com>

On Wed, Dec 11, 2024 at 10:55:25AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> With commit ce79de11337e ("fstests: clean up loop device instantiation")
> we started to always call _destroy_loop_device at the very end of the
> test, but we only create a loop device if we are running against xfs,
> so the call to _destroy_loop_device results in an error since no loop
> device was setup.
> 
> For example running this test against btrfs or ext4 results in this
> failure:
> 
>    $ ./check generic/590
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    generic/590 29s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/590.out.bad)
>       --- tests/generic/590.out	2020-06-10 19:29:03.858520038 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//generic/590.out.bad	2024-12-11 10:48:43.946205346 +0000
>        @@ -1,2 +1,5 @@
>        QA output created by 590
>       -Silence is golden
>       +losetup: option requires an argument -- 'd'
>       +Try 'losetup --help' for more information.
>       +Cannot destroy loop device
>       +(see /home/fdmanana/git/hub/xfstests/results//generic/590.full for details)
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/590.out /home/fdmanana/git/hub/xfstests/results//generic/590.out.bad'  to see the entire diff)
>    Ran: generic/590
>    Failures: generic/590
>    Failed 1 of 1 tests
> 
> Fix this by removing the call to _destroy_loop_device at the end of the
> test, as it's unnecessary because we call it in the _cleanup function if
> we have setup a loop device.
> 
> Fixes: ce79de11337e ("fstests: clean up loop device instantiation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/590 | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tests/generic/590 b/tests/generic/590
> index 04d86e78..1adeef4c 100755
> --- a/tests/generic/590
> +++ b/tests/generic/590
> @@ -115,8 +115,6 @@ $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
>  # We need to do this before the loop device gets torn down.
>  _scratch_unmount
>  _check_scratch_fs
> -_destroy_loop_device $loop_dev
> -unset loop_dev
>  
>  echo "Silence is golden"
>  status=0
> -- 


Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
