Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715F37EFFD
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431926; cv=none; b=cdBODl2lsOimeG7qUPAg3Iu4fNAL1HcJ9mBQZ1SiwyxzHixwZJUSjfPwZVsJE4IabxpI0QSU2Ts5jHlcnQVNuvaCnShnfYWXIREjln/rP8deI+3NyndTWkXFa4vlYxPPlZOUdB7Z86QT49UNDVQmfjpKAfns1qDLJlwrI8eNiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431926; c=relaxed/simple;
	bh=ulpiiinO3HHoK/5FL1+B63toiXydTBiBiNhcV6oTI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqyWAKZ5hrwCg+ebgMe4k+n2xhNLGGWCjJ+ajDhi3DZsP6ihE7D3t3u0P+eY0+S4LAwPnlNhC/rbwxSi9Faq2rL0J5WNQCIc1avFR7LA+vy810xMJEDP8YqP2Uvr64i534iI5os6VKOC1VCerzVEXPxLDCzm5kf0jxKUC8lSlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+NVylbf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nw6DcL2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+NVylbf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nw6DcL2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773431924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Vj1K7t5rwco+YwvuNQR9DjJFhAc83UqmR3jgcugowI=;
	b=I+NVylbfvs5zQlPmht0PElyVOUymMnFB6alAmwnpp6csBXD0mHYM5ywWRP6ubtn3H4s4TO
	5Ay3V4Zr2ysQQ+bFGfM1kZgCwvHSU0EMww9iJED01NTEDVHrzj+j4LOoLZdZ8CfMDZ4lHr
	gc0qxcDnO8mUpZjkeayKaVFV54Sm7zU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-YVZEJA5JMo-R7vKjulZHWg-1; Fri, 13 Mar 2026 15:58:42 -0400
X-MC-Unique: YVZEJA5JMo-R7vKjulZHWg-1
X-Mimecast-MFC-AGG-ID: YVZEJA5JMo-R7vKjulZHWg_1773431921
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358e425c261so2822418a91.3
        for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773431921; x=1774036721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Vj1K7t5rwco+YwvuNQR9DjJFhAc83UqmR3jgcugowI=;
        b=nw6DcL2tK1UeiKfHlbPdMcUW1nmOB2FQsn1umtjPnIxM+4gNPVc/urrWYZNoLv4fmO
         ld8ck0dIvTthuanpUQtQ6gK34TduVCgIt08iqOISM0ZBKXoeVqWX1tMnImt/2eNGHHAn
         LYB+kBZWS+Vf3S4O/1FyQfv5D4fnCfA39y+c+UM57rtGiJ2FNMFVR7o4LA3X1ebphEHV
         vNuJpeBDr8tU9vTDM//Ol11oq+73YNGLl7wXdJJCjwVsRhlKkBchmHVDP2PD13RSlfcy
         2ru9gnD6kZ42ieFkS6lZuXlCyqOugzfWfFnuqhHkP86MLV2URkFb2NcGGW0vS3tkE/yJ
         Fhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773431921; x=1774036721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vj1K7t5rwco+YwvuNQR9DjJFhAc83UqmR3jgcugowI=;
        b=PgXQdpDteDaxiVtJxV36H1cU0CnqLvCeKO0lq9r9wLUG/KVaSiQvZCw85mEAib6ykz
         mtd3zC9E8wfkhoKpIPYksBKXq9lro+sGlDSAHIKHGwRfbrXGpZKuKAQLhTVGl8fp+Ix0
         cF/hd+KT+l3vpIFcROtTsc0d2WVjxIt5W6+POjh9KL0ycrOVR27LKuJe0CJ+pNMeaY5J
         YdIHYcww1i1eIHR1mm89sHs3o8ovXs950+gVk/sb8MOKPcg7gCkEaBx3Hlq9LNsVZkAH
         1pDMvRccAJpGSKTkgKF0ijm0OfeDuxrIqL9cq1fhXiRCijS53hwVNPZdE80DNoa27KcC
         HaMA==
X-Gm-Message-State: AOJu0YzB60OwWVbKMdaiVl2d3/qBi5NLDu1LVf/gTdo728NCEoRxYRQR
	+45QgrfHXC3vv2+uH0rBpii+VU7aTUMp2wA9CZM8Tvwp7wt8o8tGQ1Xfl8Zsg1iLkLjIJIWmoUE
	ctV8akbYq8IAIET1m0beebgUYdET77hZC88AEAV2eyJcjJuRsdHmjNJabv7A=
X-Gm-Gg: ATEYQzxJZQ5s1EiyW1qcTm+hXYINGTMDMW7HLXqc6MysrVlRhV1lARdIfTJa9IsgY53
	m3A2aqAkKcfbfKuvEBRN6WQhIvxtHtEtYRo/qsAnVnEoYHLriON4bPwfUhG1WhCdsfvCqqYeDMW
	wfAlfjJhBNpnEPvcYFknYcCPxmdBo6u+DwqGXi5hxQpAEtD5yPVVFXacT5KTIqqoaCOixcCPEI0
	jgSGsUsx2KNc1lymqNV0qf1SGJ13Kte0GyjwgffYBItHS6lM7pCKkVjNotasFhAC8kNlFCCpJYC
	uPAkhm4a4vLT96oocWCUneJ0O1cNafwqc4W9wzepa1wo7ESUnPifsvgOrKSUkrP21eO9LikC5gx
	GI2XOcenybhMFftIk6XVq5p8RvAsV8MrWQeMwR9fnuHQKoeyHiDV1RQ6QRTq8fA==
X-Received: by 2002:a17:90b:4d86:b0:359:7b9a:2cf4 with SMTP id 98e67ed59e1d1-35a21c654d5mr4621627a91.0.1773431921341;
        Fri, 13 Mar 2026 12:58:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4d86:b0:359:7b9a:2cf4 with SMTP id 98e67ed59e1d1-35a21c654d5mr4621615a91.0.1773431920895;
        Fri, 13 Mar 2026 12:58:40 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24acecadsm1614407a91.2.2026.03.13.12.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:58:40 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:58:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 14/14] xfs: test xfs_healer startup service
Message-ID: <20260313195836.lib5ccb7mfzaqwhz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177311403712.1186408.7032564474004561606.stgit@frogsfrogsfrogs>
 <177311404033.1186408.15997052827273603644.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177311404033.1186408.15997052827273603644.stgit@frogsfrogsfrogs>

On Mon, Mar 09, 2026 at 08:53:46PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure that xfs_healer_start can actually start up xfs_healer service
> instances when a filesystem is mounted.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Tests and looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/1903     |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1903.out |    6 +++
>  2 files changed, 130 insertions(+)
>  create mode 100755 tests/xfs/1903
>  create mode 100644 tests/xfs/1903.out
> 
> 
> diff --git a/tests/xfs/1903 b/tests/xfs/1903
> new file mode 100755
> index 00000000000000..d71d75a6af3f9d
> --- /dev/null
> +++ b/tests/xfs/1903
> @@ -0,0 +1,124 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 1903
> +#
> +# Check that the xfs_healer startup service starts the per-mount xfs_healer
> +# service for the scratch filesystem.  IOWs, this is basic testing for the
> +# xfs_healer systemd background services.
> +#
> +
> +# unreliable_in_parallel: this appears to try to run healer services on all
> +# mounted filesystems - that's a problem when there are a hundred other test
> +# filesystems mounted running other tests...
> +
> +. ./common/preamble
> +_begin_fstest auto selfhealing unreliable_in_parallel
> +
> +_cleanup()
> +{
> +	cd /
> +	test -n "$new_healerstart_svc" &&
> +		_systemd_unit_stop "$new_healerstart_svc"
> +	test -n "$was_masked" && \
> +		_systemd_unit_mask "$healer_svc" &>> $seqres.full
> +	if [ -n "$new_svcfile" ]; then
> +		rm -f "$new_svcfile"
> +		systemctl daemon-reload
> +	fi
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/populate
> +. ./common/fuzzy
> +. ./common/systemd
> +
> +_require_systemd_is_running
> +_require_systemd_unit_defined xfs_healer@.service
> +_require_systemd_unit_defined xfs_healer_start.service
> +_require_scratch
> +_require_scrub
> +_require_xfs_io_command "scrub"
> +_require_xfs_spaceman_command "health"
> +_require_populate_commands
> +_require_command "$XFS_HEALER_PROG" "xfs_healer"
> +_require_command $ATTR_PROG "attr"
> +
> +_xfs_skip_online_rebuild
> +_xfs_skip_offline_rebuild
> +
> +orig_svcfile="$(_systemd_unit_path "xfs_healer_start.service")"
> +test -f "$orig_svcfile" || \
> +	_notrun "cannot find xfs_healer_start service file"
> +
> +new_svcdir="$(_systemd_runtime_dir)"
> +test -d "$new_svcdir" || \
> +	_notrun "cannot find runtime systemd service dir"
> +
> +# We need to make some local mods to the xfs_healer_start service definition
> +# so we fork it and create a new service just for this test.
> +new_healerstart_svc="xfs_healer_start_fstest.service"
> +_systemd_unit_status "$new_healerstart_svc" 2>&1 | \
> +	grep -E -q '(could not be found|Loaded: not-found)' || \
> +	_notrun "systemd service \"$new_healerstart_svc\" found, will not mess with this"
> +
> +find_healer_trace() {
> +	local path="$1"
> +
> +	sleep 2		# wait for delays in startup
> +	$XFS_HEALER_PROG --supported "$path" 2>&1 | grep -q 'already running' || \
> +		echo "cannot find evidence that xfs_healer is running for $path"
> +}
> +
> +echo "Format and populate"
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +_require_xfs_healer $SCRATCH_MNT
> +
> +# Configure the filesystem for background checks of the filesystem.
> +$ATTR_PROG -R -s xfs:autofsck -V check $SCRATCH_MNT >> $seqres.full
> +
> +was_masked=
> +healer_svc="$(_xfs_healer_svcname "$SCRATCH_MNT")"
> +
> +# Preserve the xfs_healer@ mask state -- we don't want this permanently
> +# changing global state.
> +if _systemd_unit_masked "$healer_svc"; then
> +	_systemd_unit_unmask "$healer_svc" &>> $seqres.full
> +	was_masked=1
> +fi
> +
> +echo "Start healer on scratch FS"
> +_systemd_unit_start "$healer_svc"
> +find_healer_trace "$SCRATCH_MNT"
> +_systemd_unit_stop "$healer_svc"
> +
> +new_svcfile="$new_svcdir/$new_healerstart_svc"
> +cp "$orig_svcfile" "$new_svcfile"
> +
> +sed -e '/ExecStart=/d' -e '/BindPaths=/d' -e '/ExecCondition=/d' -i $new_svcfile
> +cat >> "$new_svcfile" << ENDL
> +[Service]
> +ExecCondition=$XFS_HEALER_START_PROG --supported
> +ExecStart=$XFS_HEALER_START_PROG
> +ENDL
> +_systemd_reload
> +
> +# Emit the results of our editing to the full log.
> +systemctl cat "$new_healerstart_svc" >> $seqres.full
> +
> +echo "Start healer for everything"
> +_systemd_unit_start "$new_healerstart_svc"
> +find_healer_trace "$SCRATCH_MNT"
> +
> +echo "Restart healer for scratch FS"
> +_scratch_cycle_mount
> +find_healer_trace "$SCRATCH_MNT"
> +
> +echo "Healer testing done" | tee -a $seqres.full
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/1903.out b/tests/xfs/1903.out
> new file mode 100644
> index 00000000000000..07810f60ca10c6
> --- /dev/null
> +++ b/tests/xfs/1903.out
> @@ -0,0 +1,6 @@
> +QA output created by 1903
> +Format and populate
> +Start healer on scratch FS
> +Start healer for everything
> +Restart healer for scratch FS
> +Healer testing done
> 

