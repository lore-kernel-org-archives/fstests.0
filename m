Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7320458A
	for <fstests@vger.kernel.org>; Mon, 13 Oct 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363728; cv=none; b=lZoFPMG2ZwlxFGfyh3DBmMoULgfxb4scJv7LFS35AL9ITu8lI337XrX4LR4MYdYYbwsNrgaRtobIRJ2tyGguB2HpvRGE4uoEy/6UjxU1nITCq/gYzdB+ZjSDOT5SMMhtU6GsRc30o+hQ++mW0WNr36p2wcljVYeAW7pBT18CBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363728; c=relaxed/simple;
	bh=7uoBloRVyZ5Guy6b1V3r+FZ+UW7jjjUu+MyPFMW/Q94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCk+2OzjGu9EcqWsMw/FVmrkuhiLHQ2ZPJmESYE5a9YBiSvM7hk4lZ/x5lPvy1Z+jwE5p28jX7dOYxgwSohY4BD6caVFsxlaYXRuII8G0MweYW6KiUNO5Rq051Q3gzHbUGVj5DL2wJuZmBNOecj5tQRknz3Aaj/BFPYzRUZv4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmIANbpw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmIANbpw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so3785075b3a.2
        for <fstests@vger.kernel.org>; Mon, 13 Oct 2025 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760363725; x=1760968525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNktDQJpwt2d0SAdhMEssU0chRq9xm2zJi9soknmR28=;
        b=ZmIANbpwaVygFPmUeoEbSs6GgYbRPqFu4MFOCZopS+lPalDz3EJtl8EM8gqVXHx1ct
         z/FGPvNu9WuEjPjcoVd8M8LTw4crzDbJoBNaunU10So2agAfq8SCfMlAmDmzi9cfyTFP
         y/2ccZpluy4O/i1hHF3QMiEiHE/r7BsLAM0OsoKqc5PNdRiPWDFhTu5BBurRKdBeVjeL
         jqFQ9JNIEyPhol8BF/Yv5hBaFQptIlwukgyFCWGdwL3IH4BTJNUxspyZuLEgihP1Czt2
         W//1bJBi0IxF7JyZcIsmRj4umXYuLcqN+w1FGDVTExVCzS6fVMiMejlRex9rzBwpcEjf
         FWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760363725; x=1760968525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNktDQJpwt2d0SAdhMEssU0chRq9xm2zJi9soknmR28=;
        b=jpbf/eCaPKe4sCb00ghNYHJfsufYyf8KGR5NHw3G33hDvvu0bYCE7tp2Q5b4w2WVqv
         J5gexkrDsRs7kK/q1MW7ZiOp6V/RZSYJVd8Qd5rHhaGnCOSGM8XsWbaRObDh7JmFcUZV
         DfTeMo22XyAaHcaWSWEcktyDK8AtofRhYR+BbawW0o8YcqArXsa8CnR3YwApIkT4RXIP
         On9oK4lPP8giEk0KjOgHL4I3n8HgSD/Dr6e0uSSXVNUPJEjxVIalM1Uw9OjhW+cf9CTm
         ljDjc9AHRAK/fwW36rh4IUKnWNFZOdvwoX3HTKqwr3rY5n+d9aElonV2i/P9UXDJ1KKR
         F5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVzWNOPyGBFNQGWOzWb79OZsBfIer3+MhTPBL/Pg6gKuWUsu3425z2XOvbzVDHfUdUaKS8jZqzS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2m3YGX9/doNBUHtxl0qmlydXuMtYusoqsWDDwI5EmZFKajSgW
	HxmPpx3zxShCvmq3KpuTmip6CwdPa06mp6ayOvhOcCJjtRDElBBaYX0S
X-Gm-Gg: ASbGncvhx1FAH10J1rY9EXbFgwckkpkUE0QKmFrWRTSAVDMKtcnaqmQqwFRG4k/1h+x
	xLQSLf7+PLnNKM/RGwWb6KD5AZyhORA2EdaRG087F1MHL3T8E8MoASe0ymzIIXpntbl4LFbpK2R
	L78nvneC3bhn43r22JmyTV2VrPxvoScfGyW6KIamHhLECarE5LVSJRWtRYecZOO9Icusdm3wnFx
	A6nE+G8p1IjMf1IO4xeZgo5PDxCwKG5w6ZXepBGR7jL5enVNOXfzdjWNzwwePGqSQ8tJ4wy5K3V
	38bp3+zI3+doNXWvAXMWF9aJrnuLD738TGn706q1XkQxxHdrgyS2LdoIFVCrE9gqkkEcgSrCCja
	BCLOCMGM7sVGlZPIwsQculHPnRImmIlBnLr6ttSGvIxZTIQaSxp3dDuC6+MHtblZEc2VxgQZXas
	cuxHsHChGOOEuGk2UHTk9bCkTE
X-Google-Smtp-Source: AGHT+IHB5MtrJAqU3/C/wmwEIkAHtPuLEZoAmq62FNy9N8emT0ESiZaJyuOKGeU5iyFsHOJDDJj9ww==
X-Received: by 2002:a05:6a20:9389:b0:32b:5ec7:1408 with SMTP id adf61e73a8af0-32da8516807mr26793038637.48.1760363725378;
        Mon, 13 Oct 2025 06:55:25 -0700 (PDT)
Received: from [192.168.50.102] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0c349csm11780346b3a.50.2025.10.13.06.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:55:24 -0700 (PDT)
Message-ID: <006ae40b-b2e6-441a-b2d3-296d1e166787@gmail.com>
Date: Mon, 13 Oct 2025 21:55:18 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
 fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Carlos Maiolino <cmaiolino@redhat.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
 <20251013080759.295348-4-johannes.thumshirn@wdc.com>
Content-Language: en-GB
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251013080759.295348-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Johannes,

The test case is failing with XFS. For some reason, the mkfs error 
wasn't captured in the output, so I had to modify the test slightly. 
Errors and the diff is below.

Thanks, Anand

-------
SECTION       -- generic-config
RECREATING    -- xfs on /dev/sde
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 feddev 6.16.10-100.fc41.x86_64 #1 SMP 
PREEMPT_DYNAMIC Thu Oct  2 18:19:14 UTC 2025
MKFS_OPTIONS  -- -f /dev/sda
MOUNT_OPTIONS -- /dev/sda /mnt/scratch

generic/772       [not run] cannot mkfs zoned filesystem
Ran: generic/772
Not run: generic/772
Passed all 1 tests

SECTION       -- generic-config
=========================
Ran: generic/772
Not run: generic/772
Passed all 1 tests
--------------

$ dmesg

[ 2089.280926] XFS (sda): Ending clean mount
[ 2089.786335] zloop: Added device 0: 64 zones of 256 MB, 4096 B block size
[ 2089.848065] zloop: Zone 63: unaligned write: sect 33554176, wp 33030144
[ 2089.848081] zloop: Zone 63: failed write sector 33554176, 256 sectors
[ 2089.848086] I/O error, dev zloop0, sector 33554176 op 0x1:(WRITE) 
flags 0x8800 phys_seg 32 prio class 2
[ 2089.862921] zloop: Zone 32: unaligned write: sect 16777296, wp 16777216
[ 2089.862934] zloop: Zone 32: failed write sector 16777296, 1024 sectors
[ 2089.862939] I/O error, dev zloop0, sector 16777296 op 0x1:(WRITE) 
flags 0x4000 phys_seg 128 prio class 2

-----------------

$ cat ./results/generic-config/generic/772.full

echo '1' 2>&1 > /sys/fs/xfs/sda/error/fail_at_unmount
echo '0' 2>&1 > /sys/fs/xfs/sda/error/metadata/EIO/max_retries
echo '0' 2>&1 > /sys/fs/xfs/sda/error/metadata/EIO/retry_timeout_seconds
mkfs.xfs: pwrite failed: Input/output error
libxfs_bwrite: write failed on (unknown) bno 0x1ffff00/0x100, err=5
mkfs.xfs: Releasing dirty buffer to free list!
found dirty buffer (bulk) on free list!
mkfs.xfs: libxfs_device_zero write failed: Input/output error
meta-data=/dev/zloop0            isize=512    agcount=4, agsize=1048576 blks
          =                       sectsz=4096  attr=2, projid32bit=1
          =                       crc=1        finobt=1, sparse=1, rmapbt=1
          =                       reflink=1    bigtime=1 inobtcount=1 
nrext64=1
data     =                       bsize=4096   blocks=4194304, imaxpct=25
          =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
          =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0



$ git diff
diff --git a/tests/generic/772 b/tests/generic/772
index d9b84614da3d..54da97fdd00f 100755
--- a/tests/generic/772
+++ b/tests/generic/772
@@ -36,8 +36,9 @@ mkdir -p $mnt
  _create_zloop $ID $zloopdir 256 2
  zloop="/dev/zloop$ID"

-_try_mkfs_dev $zloop 2>&1 >> $seqres.full ||\
+if ! _try_mkfs_dev $zloop >> $seqres.full 2>&1; then
         _notrun "cannot mkfs zoned filesystem"
+fi
  _mount $zloop $mnt

  $FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
root@feddev:/Volumes/work/ws/fstests$
----------------------------




On 13-Oct-25 4:07 PM, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 conventional and 62 sequential zones,
> mounts it and then runs fsx on it.
> 
> Currently this tests supports BTRFS, F2FS and XFS.
> 
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   tests/generic/772     | 49 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/772.out |  2 ++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/generic/772
>   create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..d9b84614
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 772
> +#
> +# Smoke test for FSes with ZBD support on zloop
> +#
> +. ./common/preamble
> +_begin_fstest auto zone quick
> +
> +_cleanup()
> +{
> +	if test -b /dev/zloop$ID; then
> +		echo "remove id=$ID" > /dev/zloop-control
> +	fi
> +}
> +
> +. ./common/zoned
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_scratch_size $((16 * 1024 * 1024)) #kB
> +_require_zloop
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +ID=$(_find_next_zloop)
> +
> +mnt="$SCRATCH_MNT/mnt"
> +zloopdir="$SCRATCH_MNT/zloop"
> +
> +mkdir -p "$zloopdir/$ID"
> +mkdir -p $mnt
> +_create_zloop $ID $zloopdir 256 2
> +zloop="/dev/zloop$ID"
> +
> +_try_mkfs_dev $zloop 2>&1 >> $seqres.full ||\
> +	_notrun "cannot mkfs zoned filesystem"
> +_mount $zloop $mnt
> +
> +$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
> +
> +umount $mnt
> +
> +echo Silence is golden
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/772.out b/tests/generic/772.out
> new file mode 100644
> index 00000000..98c13968
> --- /dev/null
> +++ b/tests/generic/772.out
> @@ -0,0 +1,2 @@
> +QA output created by 772
> +Silence is golden

