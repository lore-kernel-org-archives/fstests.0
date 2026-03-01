Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C097430BA8
	for <fstests@vger.kernel.org>; Sun,  1 Mar 2026 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370958; cv=none; b=tYOY42JodlA4s8rXN5rmOFs0D115NszRQOqQMDQu44A9aemFQZSiq/NYGjWAIu/d9M7DrVd0v/q4yTjqPo/itFRUYiVuIaVhA1+1OQskEpePrgPCTvbNHIJq6QwlMT7eisW9LK4KjrDUwn4Dkd8h0CMciSCCVIk4CQXM0GBpFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370958; c=relaxed/simple;
	bh=ZLZQE0GXeHZvnuR3V3ClHur20ND39tVVF7L8YuUrOM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loMmwPqOIeTkuhqZA+EMmfcQYDVYRUoaYOi1sXL6l8xyK0yhr9YXvy9nnsVJcmT2chjW0vCsRWreMSwl2pd+dcFI2GR+PKxHndf4GVNvkoirs9U710tPsE6o1ccyku5K5Ga4UuWKL97bxmp1ORoHplv2fnEFxoYwbydBiCxBpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imd7PUpA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imd7PUpA"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b935b8dcab7so553179166b.1
        for <fstests@vger.kernel.org>; Sun, 01 Mar 2026 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772370954; x=1772975754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZuHbNxrjmmINf1/XZXGIBer5llHrVS+trrV0cr48Gc=;
        b=Imd7PUpAx5LizhFfyaFyReG0dwWtsm2/CbGzRc88/Mwjsd6QRJnR9b8RhV4Pu84VJI
         suv3MAJFGAlRbqgASpEP+PQnTWd14JM811thsOr7ZRSpFIYn+YwXsWiHKOQzdn95nYcZ
         FgcZxfTxAgv0bQhpRrUT6TGfIYP6cn2Vghr9MX6A76sMcFsKxQlQ39afmurWDp32jr1v
         TyRNr5U7UsTWoh4O4Ioc2+HV4D91aptkTUcKDYJdKHUFrPY52QxWKFxb9cK/fNmgieku
         8PwgXVkh+Ce4o1BlFv6Et1tDt5PAzE5e89anQ83fZCxpnTqD5HH8riYqo2GxpbDBXH9K
         IXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772370954; x=1772975754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZuHbNxrjmmINf1/XZXGIBer5llHrVS+trrV0cr48Gc=;
        b=s6ymATx+D7ZGK7eHifVyhG6E+0Uq/RF4+1xXp69vOHoeNATIvwCp7MiN8TJ06z1ihm
         XYum3opaCOLEX6WdDUpAWSEHTqYbE2cyhohwiWUSVCfhHf14aL0uCsy+IWKx4QzIFhLU
         dmGwWZvVBetkDwIAlAMuJnIVRh/YX17BQf7QlrXs3iqT+aojuhCr0y+hUoifQto3Sduj
         vw9s8VPIoJdEugND5/3n0BY9s9l/xucO1QII9fOlbiLOhSYKqxltveO316mO3wINPEv/
         LggRrdsFypdXZjetkwQrnYaZC45FqrbQE4wtWjL03bSwwicTc/EOIyb5GbpkDtNspa6P
         0Etg==
X-Gm-Message-State: AOJu0YxNDXqC+w2TG43H7q88bkScEMyGCzjsZ1fH0n32glRnmOuxlmsC
	QJNH1WmCv/GKAqTrfXr+IkHpyfYnSnandrPIvIUdFxaPcZuGun0VEgL3
X-Gm-Gg: ATEYQzzTqEnRKyd0THHEuGFdvhAn+22ciUnDS/MpaoImclK4FzQ5m9dc6dLHGabrFca
	8iDQV6pbKhucKjZ3KmTyB/e9odbZdfA9mFT6/Pp4BFo4f9r8HPOOVrZ5pcX99qmoeqXnC1HSrEj
	b24FX7jubeZonwHkrfAbnAQW9QyVSUzJH31Mj8Jg+f0+rqmBBcpBLvn9KEMBnkpvubCk0TaeWd0
	LKxd8fDTLGWkF0/EedYkksxRlj1vzG2CRSc1Ff8MatdBcZ2WdFSUovooXwf9R9LeK1FaxK1t+LR
	KLGB2U7s2Xv0wLHulNyLUs4c5Xm8wDndwORaXgPqTbKJzAavvIukWoSyyaegahjdhQ+iphSx4kc
	bp8KLGOSmLWe889PFnjPRFtROhMJrNwC6a1MO4iYEmR8hzjGJEQ/wa4mZmIMfJBZugpKtoC2Qsn
	VzBZD0eIj7JeDs768rUsy6503SkUAa611xM4r9iIZY2wwddLWlVq7UPvg68Nb4atqQHT5zEZknw
	XgVKMFr9Bo5s9816czT/XHkboA1
X-Received: by 2002:a17:906:ad7:b0:b88:775c:bd6b with SMTP id a640c23a62f3a-b9376553e7amr432998666b.46.1772370953329;
        Sun, 01 Mar 2026 05:15:53 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-d118-5ff5-6236-8e43.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:d118:5ff5:6236:8e43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac51431sm360050666b.17.2026.03.01.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 05:15:52 -0800 (PST)
Date: Sun, 1 Mar 2026 14:15:52 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5/9] fstests: verify fanotify isolation on cloned
 filesystems
Message-ID: <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
References: <cover.1772095513.git.asj@kernel.org>
 <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>

On Thu, Feb 26, 2026 at 10:41:46PM +0800, Anand Jain wrote:
> Verify that fanotify events are correctly routed to the appropriate
> watcher when cloned filesystems are mounted.
> Helps verify kernel's event notification distinguishes between devices
> sharing the same FSID/UUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/fanotify.c        | 66 +++++++++++++++++++++++++++++++++
>  tests/generic/791     | 86 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/791.out |  7 ++++
>  5 files changed, 161 insertions(+), 1 deletion(-)
>  create mode 100644 src/fanotify.c
>  create mode 100644 tests/generic/791
>  create mode 100644 tests/generic/791.out
> 
> diff --git a/.gitignore b/.gitignore
> index 82c57f415301..7f91310ce58b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -212,6 +212,7 @@ tags
>  /src/dio-writeback-race
>  /src/unlink-fsync
>  /src/file_attr
> +/src/fanotify
>  
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/src/Makefile b/src/Makefile
> index d0a4106e6be8..ff71cde936a7 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> -	rw_hint
> +	rw_hint fanotify

Check if you already have fsnotifywait installed on your system
most likely you do. It was added to inotify-tools quite some time ago.
Could save you from adding a custom prog.
Not 100% sure about fsnotifywait, but quite sure that
fsnotifywatch --verbose prints the FSID of events.

Thanks,
Amir.

>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/fanotify.c b/src/fanotify.c
> new file mode 100644
> index 000000000000..e30c48dc0e52
> --- /dev/null
> +++ b/src/fanotify.c
> @@ -0,0 +1,66 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + * Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> + *
> + * Simple fanotify monitor to verify mount-point event isolation.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <sys/fanotify.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd;
> +	char buf[4096] __attribute__((aligned(8)));
> +	setlinebuf(stdout);
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "Usage: %s <path>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	// Initialize with FID reporting
> +	fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> +	if (fd < 0) {
> +		perror("fanotify_init");
> +		return 1;
> +	}
> +
> +	if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +			  FAN_CREATE, AT_FDCWD, argv[1]) < 0) {
> +		perror("fanotify_mark");
> +		return 1;
> +	}
> +
> +	printf("Listening for events on %s...\n", argv[1]);
> +	while (1) {
> +		struct fanotify_event_metadata *metadata = (struct fanotify_event_metadata *)buf;
> +		ssize_t len = read(fd, buf, sizeof(buf));
> +
> +		if (len <= 0) break;
> +
> +		while (FAN_EVENT_OK(metadata, len)) {
> +			// metadata_len is the offset to the first info record
> +			if (metadata->event_len > metadata->metadata_len) {
> +				struct fanotify_event_info_header *hdr =
> +(struct fanotify_event_info_header *)((char *)metadata + metadata->metadata_len);
> +
> +				if (hdr->info_type == FAN_EVENT_INFO_TYPE_FID) {
> +					struct fanotify_event_info_fid *fid = (struct fanotify_event_info_fid *)hdr;
> +					printf("FSID: %08x%08x\n",
> +						fid->fsid.val[0], fid->fsid.val[1]);
> +				}
> +			}
> +			metadata = FAN_EVENT_NEXT(metadata, len);
> +		}
> +	}
> +
> +	fflush(stdout);
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/generic/791 b/tests/generic/791
> new file mode 100644
> index 000000000000..fe8109083732
> --- /dev/null
> +++ b/tests/generic/791
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 791
> +# Verify fanotify FID functionality on cloned filesystems by setting up
> +# watchers and making sure notifications are in the correct logs files.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick mount clone
> +
> +_require_test
> +_require_scratch_dev_pool 2
> +
> +[ "$FSTYP" = "ext4" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"ext4: derive f_fsid from block device to avoid collisions"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	umount $mnt1 $mnt2 2>/dev/null
> +	_scratch_dev_pool_put
> +}
> +
> +_scratch_dev_pool_get 2
> +_scratch_mkfs_sized_clone >$seqres.full 2>&1
> +devs=($SCRATCH_DEV_POOL)
> +mnt2=$TEST_DIR/mnt2
> +mkdir -p $mnt2
> +
> +_scratch_mount $(_clone_mount_option)
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +fsid1=$(stat -f -c "%i" $SCRATCH_MNT)
> +fsid2=$(stat -f -c "%i" $mnt2)
> +
> +[[ "$fsid1" == "$fsid2" ]] && \
> +	_notrun "Require clone filesystem with unique f_fsid"
> +
> +log1=$tmp.fanotify1
> +log2=$tmp.fanotify2
> +
> +echo "Setup FID fanotify watchers on both SCRATCH_MNT and mnt2"
> +$here/src/fanotify $SCRATCH_MNT > $log1 2>&1 &
> +pid1=$!
> +$here/src/fanotify $mnt2 > $log2 2>&1 &
> +pid2=$!
> +sleep 2
> +
> +echo "Trigger file creation on SCRATCH_MNT"
> +touch $SCRATCH_MNT/file_on_scratch_mnt
> +sync
> +sleep 1
> +
> +echo "Trigger file creation on mnt2"
> +touch $mnt2/file_on_mnt2
> +sync
> +sleep 1
> +
> +echo "Verify fsid in the fanotify"
> +kill $pid1 $pid2
> +wait $pid1 $pid2 2>/dev/null
> +
> +echo fsid1=$fsid1 fsid2=$fsid2 >> $seqres.full
> +cat $log1 >> $seqres.full
> +cat $log2 >> $seqres.full
> +
> +if grep -q "${fsid1}" $log1 && ! grep -q "${fsid2}" $log1; then
> +	echo "SUCCESS: SCRATCH_MNT events found"
> +else
> +	[ ! -s $log1 ] && echo "  - SCRATCH_MNT received no events."
> +	grep -q "${fsid2}" $log1 && echo "  - SCRATCH_MNT received event from mnt2."
> +fi
> +
> +if grep -q "${fsid2}" $log2 && ! grep -q "${fsid1}" $log2; then
> +	echo "SUCCESS: mnt2 events found"
> +else
> +	[ ! -s $log2 ] && echo "  - mnt2 received no events."
> +	grep -q "${fsid1}" $log2 && echo "  - mnt2 received event from SCRATCH_MNT."
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/791.out b/tests/generic/791.out
> new file mode 100644
> index 000000000000..9725c99bcb4b
> --- /dev/null
> +++ b/tests/generic/791.out
> @@ -0,0 +1,7 @@
> +QA output created by 791
> +Setup FID fanotify watchers on both SCRATCH_MNT and mnt2
> +Trigger file creation on SCRATCH_MNT
> +Trigger file creation on mnt2
> +Verify fsid in the fanotify
> +SUCCESS: SCRATCH_MNT events found
> +SUCCESS: mnt2 events found
> -- 
> 2.43.0
> 
