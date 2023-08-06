Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A7C0015E
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Aug 2023 14:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjHFOMm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Aug 2023 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHFOMm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Aug 2023 10:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F84F11D
        for <fstests@vger.kernel.org>; Sun,  6 Aug 2023 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691331112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HyszTzSrAagDw5fEHd5v7FNE3cVrJQuFwvVrojBFXA=;
        b=DRp4ULggLTWDVb0NpFqn0KXYpHTrB8gB+ffr1tOzEiOIxObCk4uGuknMv8iJGQMP521zqG
        AvJxeaDP0FnnHCUiHRjfDUOpuIHqlCndYv5M/ABoKbzZEWpwkPe5+aidNZreqvyBJSG0vU
        SgTH2f0G5TVG54kzCFkJbwetmuuFTaQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-3jGBYgC6OgmzxH2h-B3wnw-1; Sun, 06 Aug 2023 10:11:51 -0400
X-MC-Unique: 3jGBYgC6OgmzxH2h-B3wnw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bc5b36a5f2so5456255ad.1
        for <fstests@vger.kernel.org>; Sun, 06 Aug 2023 07:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691331110; x=1691935910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HyszTzSrAagDw5fEHd5v7FNE3cVrJQuFwvVrojBFXA=;
        b=Rq9PJ2iKFWNJ8PSI6jhGMgFTQ6Fj70T7xVAdcVJ9g+HsdYNnDrN/cK7bXsEWg7uh05
         BiTs4UqC/30CgOw3TofLOugwI15+nYq7OGkgXDm66lUi24mkVzVwutI4gCxaXuZCnrDA
         1WEWqU4ZhaPgSLT26HfHj+S3WEwHhLxeYslF8X3CGHxK5RAAWi4i3r2xXzR8NMg9FEd3
         W1usBuqEaOMI7pbVSSXDz6nop9hgn9lrsrn+0rtmhigHLqU3U3jlGrFHLexnM3VH7pdX
         7Nk2fzIYcJpgnaEit/8yhqaHtOlm9uBwoy0INZFXfOaeQI/TBgvEf2Y4yQTcIRepWGIE
         rqQw==
X-Gm-Message-State: AOJu0Yw2sZ+KqCy34+wcaeUuAxaqqxxRkqb1P3QbXDLREY3YyIMqu6fP
        KbGkHEQJIKiVklO9bB/W/5TfsZth7IO0brbWrO4j/6Z52vT4sRA0sSBHQ6O5asLeqHkbhlTqE6n
        l5HGdCdkcGKQ47ogpeMv0jIW2lQiy
X-Received: by 2002:a17:902:b606:b0:1b3:fb76:215b with SMTP id b6-20020a170902b60600b001b3fb76215bmr5860311pls.48.1691331109648;
        Sun, 06 Aug 2023 07:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsE/Yg2jtYdrDkQ6v123dApdVC325kQO8dVhlnBUAUEwKcpL2PPJzYSHVLXhRKw20JKg9pDw==
X-Received: by 2002:a17:902:b606:b0:1b3:fb76:215b with SMTP id b6-20020a170902b60600b001b3fb76215bmr5860293pls.48.1691331109260;
        Sun, 06 Aug 2023 07:11:49 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001bb9aadfb04sm4958506plx.220.2023.08.06.07.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 07:11:48 -0700 (PDT)
Date:   Sun, 6 Aug 2023 22:11:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230806141145.2lpntvfn7kqglads@zlang-mailbox>
References: <20230724152927.33094-1-hch@lst.de>
 <20230724152927.33094-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724152927.33094-2-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 08:29:26AM -0700, Christoph Hellwig wrote:
> Test the removal of the underlying device when the file system still
> has dirty data.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

After I merge this case, it always hit a kernel warning about a "possible
circular locking dependency detected", no matter on ext4 [1] or xfs. This
test isn't hang actually. But it always fail this test (got a .dmesg file).
Any ideas about that?

Thanks,
Zorro

[1]
[58395.957612] run fstests generic/730 at 2023-08-05 10:48:20
[58400.113881] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
[58400.114840] scsi host1: scsi_debug: version 0191 [20210520]
                 dev_size_mb=256, opts=0x0, submit_queues=1, statistics=0
[58400.123190] scsi 1:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
[58400.127198] scsi 1:0:0:0: Power-on or device reset occurred
[58400.139241] sd 1:0:0:0: Attached scsi generic sg2 type 0
[58400.141245] sd 1:0:0:0: [sdb] 524288 512-byte logical blocks: (268 MB/256 MiB)
[58400.143486] sd 1:0:0:0: [sdb] Write Protect is off
[58400.144248] sd 1:0:0:0: [sdb] Mode Sense: 73 00 10 08
[58400.146650] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[58400.151277] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[58400.152203] sd 1:0:0:0: [sdb] Optimal transfer size 524288 bytes
[58400.189056] sd 1:0:0:0: [sdb] Attached SCSI disk
[58401.481505] EXT4-fs (sdb): mounted filesystem c387e859-8bb8-4da9-80a3-7fce381c3b66 r/w with ordered data mode. Quota mode: none.

[58401.685373] ======================================================
[58401.686080] WARNING: possible circular locking dependency detected
[58401.686823] 6.5.0-rc4+ #1 Tainted: G        W         
[58401.687111] ------------------------------------------------------
[58401.687927] 730/1784445 is trying to acquire lock:
[58401.688583] ffff88815bd820e8 (&type->s_umount_key#66){++++}-{3:3}, at: get_super+0x104/0x1f0
[58401.689502] 
               but task is already holding lock:
[58401.690204] ffff888104b90528 (&disk->open_mutex){+.+.}-{3:3}, at: del_gendisk+0x166/0x940
[58401.690675] 
               which lock already depends on the new lock.

[58401.691079] 
               the existing dependency chain (in reverse order) is:
[58401.691868] 
               -> #1 (&disk->open_mutex){+.+.}-{3:3}:
[58401.692592]        __lock_acquire+0xbd6/0x1c00
[58401.693222]        lock_acquire+0x1da/0x5e0
[58401.693477]        __mutex_lock+0x154/0x1490
[58401.694125]        blkdev_put+0x99/0x830
[58401.694334]        ext4_put_super+0x560/0xce0 [ext4]
[58401.694839]        generic_shutdown_super+0x13e/0x420
[58401.695125]        kill_block_super+0x60/0xb0
[58401.695767]        deactivate_locked_super+0x85/0x130
[58401.696055]        cleanup_mnt+0x258/0x370
[58401.696271]        task_work_run+0x132/0x220
[58401.696919]        exit_to_user_mode_loop+0x14f/0x160
[58401.697211]        exit_to_user_mode_prepare+0x142/0x150
[58401.697523]        syscall_exit_to_user_mode+0x19/0x50
[58401.697807]        do_syscall_64+0x69/0x90
[58401.698022]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[58401.698330] 
               -> #0 (&type->s_umount_key#66){++++}-{3:3}:
[58401.698697]        check_prev_add+0x1bd/0x23a0
[58401.699341]        validate_chain+0xb02/0xf30
[58401.699972]        __lock_acquire+0xbd6/0x1c00
[58401.700595]        lock_acquire+0x1da/0x5e0
[58401.700813]        down_read+0xa1/0x4c0
[58401.701029]        get_super+0x104/0x1f0
[58401.701270]        fsync_bdev+0x11/0xc0
[58401.701594]        del_gendisk+0x1f8/0x940
[58401.701815]        sd_remove+0x85/0xf0 [sd_mod]
[58401.702473]        device_release_driver_internal+0x36d/0x530
[58401.703208]        bus_remove_device+0x1ed/0x3f0
[58401.703883]        device_del+0x342/0x910
[58401.704114]        __scsi_remove_device+0x26b/0x330
[58401.705040]        sdev_store_delete+0x83/0x120
[58401.705688]        kernfs_fop_write_iter+0x358/0x530
[58401.705981]        vfs_write+0x7c0/0xc40
[58401.706197]        ksys_write+0xf1/0x1d0
[58401.706400]        do_syscall_64+0x5c/0x90
[58401.706617]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[58401.706899] 
               other info that might help us debug this:

[58401.707320]  Possible unsafe locking scenario:

[58401.708016]        CPU0                    CPU1
[58401.708652]        ----                    ----
[58401.765786]   lock(&disk->open_mutex);
[58401.879949]                                lock(&type->s_umount_key#66);
[58402.051096]                                lock(&disk->open_mutex);
[58402.209171]   rlock(&type->s_umount_key#66);
[58402.209962] 
                *** DEADLOCK ***

[58402.210683] 5 locks held by 730/1784445:
[58402.210912]  #0: ffff88811827a430 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xf1/0x1d0
[58402.211345]  #1: ffff888267d52c90 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x21a/0x530
[58402.212222]  #2: ffff8881ff2060f0 (&shost->scan_mutex){+.+.}-{3:3}, at: sdev_store_delete+0x7b/0x120
[58402.212818]  #3: ffff8881f73d6398 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x8d/0x530
[58402.213385]  #4: ffff888104b90528 (&disk->open_mutex){+.+.}-{3:3}, at: del_gendisk+0x166/0x940
[58402.214240] 
               stack backtrace:
[58402.214900] CPU: 7 PID: 1784445 Comm: 730 Kdump: loaded Tainted: G        W          6.5.0-rc4+ #1
[58402.215768] Hardware name: HP ProLiant DL360 Gen9, BIOS P89 03/05/2015
[58402.216121] Call Trace:
[58402.216266]  <TASK>
[58402.216780]  dump_stack_lvl+0x60/0xb0
[58402.216998]  check_noncircular+0x2f9/0x3e0
[58402.217219]  ? __pfx_check_noncircular+0x10/0x10
[58402.274370]  ? check_path.constprop.0+0x24/0x50
[58402.417227]  ? check_path.constprop.0+0x24/0x50
[58402.560177]  ? alloc_chain_hlocks+0x1de/0x520
[58402.702879]  check_prev_add+0x1bd/0x23a0
[58402.717964]  validate_chain+0xb02/0xf30
[58402.718193]  ? __pfx_validate_chain+0x10/0x10
[58402.718881]  ? validate_chain+0x7eb/0xf30
[58402.719109]  __lock_acquire+0xbd6/0x1c00
[58402.719365]  lock_acquire+0x1da/0x5e0
[58402.719588]  ? get_super+0x104/0x1f0
[58402.719809]  ? __pfx_lock_acquire+0x10/0x10
[58402.720038]  down_read+0xa1/0x4c0
[58402.720603]  ? get_super+0x104/0x1f0
[58402.720830]  ? do_raw_spin_trylock+0xb5/0x180
[58402.721457]  ? __pfx_down_read+0x10/0x10
[58402.721679]  ? get_super+0xfc/0x1f0
[58402.722252]  get_super+0x104/0x1f0
[58402.723046]  fsync_bdev+0x11/0xc0
[58402.723633]  del_gendisk+0x1f8/0x940
[58402.723861]  ? __pfx_del_gendisk+0x10/0x10
[58402.724079]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[58402.724354]  ? __pm_runtime_resume+0x83/0x120
[58402.724994]  sd_remove+0x85/0xf0 [sd_mod]
[58402.725243]  device_release_driver_internal+0x36d/0x530
[58402.725564]  ? klist_put+0xf7/0x170
[58402.726151]  bus_remove_device+0x1ed/0x3f0
[58402.726412]  device_del+0x342/0x910
[58402.726993]  ? __pfx_device_del+0x10/0x10
[58402.812754]  ? __pfx_sysfs_kf_write+0x10/0x10
[58402.955456]  __scsi_remove_device+0x26b/0x330
[58402.988906] blk_print_req_error: 48 callbacks suppressed
[58402.988917] device offline error, dev sdb, sector 262148 op 0x0:(READ) flags 0x83700 phys_seg 1 prio class 2
[58403.098495]  sdev_store_delete+0x83/0x120
[58403.098510]  kernfs_fop_write_iter+0x358/0x530
[58403.098523]  vfs_write+0x7c0/0xc40
[58403.098532]  ? __pfx_vfs_write+0x10/0x10
[58403.098549]  ? __pfx___lock_release+0x10/0x10
[58403.098559]  ? __fget_light+0x51/0x220
[58403.227415] device offline error, dev sdb, sector 262176 op 0x0:(READ) flags 0x83700 phys_seg 1 prio class 2
[58403.228292]  ? count_memcg_event_mm.part.0+0xbd/0x1f0
[58403.228308]  ksys_write+0xf1/0x1d0
[58403.228667] device offline error, dev sdb, sector 262176 op 0x0:(READ) flags 0x3000 phys_seg 1 prio class 2
[58403.229369]  ? __pfx_ksys_write+0x10/0x10
[58403.229375]  ? ktime_get_coarse_real_ts64+0x130/0x170
[58403.229391]  do_syscall_64+0x5c/0x90
[58403.230022] EXT4-fs error (device sdb): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 31, block_bitmap = 131088
[58403.230215]  ? asm_exc_page_fault+0x22/0x30
[58403.231343] device offline error, dev sdb, sector 262146 op 0x0:(READ) flags 0x3000 phys_seg 1 prio class 2
[58403.232005]  ? lockdep_hardirqs_on+0x79/0x100
[58403.232017]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[58403.232025] RIP: 0033:0x7fe57853eb97
[58403.232033] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[58403.232365] device offline error, dev sdb, sector 262148 op 0x0:(READ) flags 0x3000 phys_seg 1 prio class 2
[58403.232368] EXT4-fs error (device sdb): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 16, block_bitmap = 131073
[58403.232910] RSP: 002b:00007ffd44273f88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[58403.232920] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe57853eb97
[58403.233502] EXT4-fs error (device sdb): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 17, block_bitmap = 131074
[58403.233655] RDX: 0000000000000002 RSI: 000055e91f842090 RDI: 0000000000000001
[58403.234142] device offline error, dev sdb, sector 590 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
[58403.234815] RBP: 000055e91f842090 R08: 0000000000000000 R09: 00007fe5785b14e0
[58403.234821] R10: 00007fe5785b13e0 R11: 0000000000000246 R12: 0000000000000002
[58403.234825] R13: 00007fe5785fb780 R14: 0000000000000002 R15: 00007fe5785f69e0
[58403.234842]  </TASK>
[58403.237507] device offline error, dev sdb, sector 491522 op 0x1:(WRITE) flags 0x4000 phys_seg 128 prio class 2
[58403.292737] device offline error, dev sdb, sector 590 op 0x1:(WRITE) flags 0x800 phys_seg 128 prio class 2
[58403.435617] device offline error, dev sdb, sector 492546 op 0x1:(WRITE) flags 0x0 phys_seg 128 prio class 2
[58404.245619] EXT4-fs warning (device sdb): ext4_end_bio:343: I/O error 17 writing to inode 12 starting block 246273)
[58404.246595] Buffer I/O error on device sdb, logical block 245761
[58404.247309] Buffer I/O error on device sdb, logical block 245762
[58404.248033] Buffer I/O error on device sdb, logical block 245763
[58404.248737] Buffer I/O error on device sdb, logical block 245764
[58404.249663] Buffer I/O error on device sdb, logical block 245765
[58404.250419] Buffer I/O error on device sdb, logical block 245766
[58404.251133] Buffer I/O error on device sdb, logical block 245767
[58404.251880] Buffer I/O error on device sdb, logical block 245768
[58404.252614] Buffer I/O error on device sdb, logical block 245769
[58404.253389] Buffer I/O error on device sdb, logical block 245770
[58404.255576] device offline error, dev sdb, sector 229378 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 2
[58404.256152] buffer_io_error: 23 callbacks suppressed
[58404.256157] Buffer I/O error on dev sdb, logical block 114689, lost sync page write
[58404.570222] JBD2: I/O error when updating journal superblock for sdb-8.
[58404.741452] Aborting journal on device sdb-8.
[58404.757264] Buffer I/O error on dev sdb, logical block 114689, lost sync page write
[58404.758189] JBD2: I/O error when updating journal superblock for sdb-8.
[58404.758803] JBD2: Detected IO errors while flushing file data on sdb-8
[58404.761560] EXT4-fs (sdb): shut down requested (2)
[58404.787528] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[58404.889094] EXT4-fs (sdb): unmounting filesystem c387e859-8bb8-4da9-80a3-7fce381c3b66.
[58405.895121] EXT4-fs (sda3): unmounting filesystem 1fff3774-c594-4880-b940-900d39bc18b9.
[58409.403411] EXT4-fs (sda3): mounted filesystem 1fff3774-c594-4880-b940-900d39bc18b9 r/w with ordered data mode. Quota mode: none.


>  tests/generic/730     | 57 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/730.out |  2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/generic/730
>  create mode 100644 tests/generic/730.out
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> new file mode 100755
> index 00000000..11308cda
> --- /dev/null
> +++ b/tests/generic/730
> @@ -0,0 +1,57 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
> +# Copyright (c) 2023 Christoph Hellwig
> +#
> +# Test proper file system shut down when the block device is removed underneath
> +# and there is dirty data.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	cd /
> +	$UMOUNT_PROG $SCSI_DEBUG_MNT >>$seqres.full 2>&1
> +	_put_scsi_debug_dev
> +	rm -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/scsi_debug
> +
> +_supported_fs generic
> +
> +# We don't actually use the test device, but we need a block based fs
> +_require_test
> +_require_block_device $TEST_DEV
> +_require_scsi_debug
> +
> +SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 256`
> +test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> +echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
> +
> +run_check _mkfs_dev $SCSI_DEBUG_DEV
> +
> +SCSI_DEBUG_MNT="$TEST_DIR/scsi_debug_$seq"
> +rm -rf $SCSI_DEBUG_MNT
> +mkdir $SCSI_DEBUG_MNT
> +run_check _mount $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
> +
> +# create a test file
> +$XFS_IO_PROG -f -c "pwrite 0 1M" $SCSI_DEBUG_MNT/testfile >>$seqres.full
> +
> +# open a file descriptor for reading the file
> +exec 3< $SCSI_DEBUG_MNT/testfile
> +
> +# delete the scsi debug device while it still has dirty data
> +echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> +
> +# try to read from the file, which should give us -EIO
> +cat <&3 > /dev/null
> +
> +# close the file descriptor to not block unmount
> +exec 3<&-
> +
> +status=0
> +exit
> diff --git a/tests/generic/730.out b/tests/generic/730.out
> new file mode 100644
> index 00000000..79e96db8
> --- /dev/null
> +++ b/tests/generic/730.out
> @@ -0,0 +1,2 @@
> +QA output created by 730
> +cat: -: Input/output error
> -- 
> 2.39.2
> 

